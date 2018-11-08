//Fecha
object hoy{
	var property fecha = new Date(18,10,2018)
	
}
//Minimo
object minimo {
	var property importe = 5
	
}
//WKO
object fuerzaOscura {
	var poder = 5
	method poderOscuro(){
		return poder
	}
	method eclipse(){
		poder *= 2
	}
}
object collarDivino inherits Objeto{
	var perlas = 5
	var duenio
	method lucha(){
		return perlas
	}
	override method pesoTotal(){
		return super() +perlas*0.5
	}
	method cambiarPerlas(cantPerlas){
		perlas = cantPerlas
	}
	method precioDeLista(){
		return 2*perlas
	}
	method asignarDuenio(_duenio){
		duenio = _duenio
	}
}
object hechizoBasico inherits Hechizo{
	override method poder(){
		return 10
	}
	method precioRefuerzo(valorBase){
		return valorBase + self.precioDeLista()
	}
	method asignarDuenio(_duenio){
	}
}
object bendicion{
	var duenio
	method poder(){
		return duenio.nivelDeHechiceria()
	}
	method asignarDuenio(_duenio){
		duenio = _duenio
	}
	method precioRefuerzo(unidadLucha){
		return unidadLucha
	}
	method pesoRefuerzo(){
		return 0
	}
}

 object ninguno {
	method poder(){
		return 0
	}
	method precioRefuerzo(valorBase){
		return 2
	}
	method asignarDuenio(_duenio){
	}
	method pesoRefuerzo(){
		return 0
	}
}
//Personajes
class Personaje {
	var hechizoPreferido
	var luchaBase = 1
	var artefactos = []
	var property oro = 100
	var capacidadCarga
	method nivelDeHechiceria(){
		return 3 * hechizoPreferido.poder() + fuerzaOscura.poderOscuro()
	}
		
	method cambiarHechizo(unHechizo){
		hechizoPreferido = unHechizo
	}
	
	method soyPoderoso(){
		return hechizoPreferido.esPoderoso()
	}
	 	
	
	method valorBaseDeLucha(plusValor){
		luchaBase = plusValor
	}
	
	method agregarArtefacto(unArtefacto){
		self.chequearCapacidad(unArtefacto.pesoTotal())
		artefactos.add(unArtefacto)
		unArtefacto.asignarDuenio(self)
	}
	
	method removerArtefacto(unArtefacto){
		artefactos.remove(unArtefacto)
	}
	method nivelDeLucha(){
		return luchaBase + artefactos.sum({unArtefacto => unArtefacto.lucha()})
	}
	
	method esMejorLuchador(){
		return self.nivelDeLucha() > self.nivelDeHechiceria()
	}
	
	method listaArtefactos (){
		return artefactos
	}
	method estaCargado(){
		return artefactos.size()>=5
	}
	method desequiparse(){
		artefactos.clear()
	}
	method cumplirObjetivo(){
		oro+=10
	}
	method canjearHechizo(nuevoHechi){
		var costo = nuevoHechi.precioDeLista() - hechizoPreferido.precioDeLista()/2
		if(oro >= costo){
			oro -= costo.max(0)
			hechizoPreferido = nuevoHechi
		
		}
	}
	method comprarArtefacto(nuevoArtefacto,comerciante){
		var costo = comerciante.vender(nuevoArtefacto)
		if(oro >= costo){
			self.agregarArtefacto(nuevoArtefacto)
			oro -= costo			
		}
	}
	method pesoPersonaje(){
		return artefactos.sum({objeto => objeto.pesoTotal()})
	}
	method chequearCapacidad(pesoObjeto){
		if(capacidadCarga <(self.pesoPersonaje()+pesoObjeto)){
			throw new CargaException("No puede llevar mas objetos")
		}
	}
}
class NPC inherits Personaje {
	var property nivel
	override method nivelDeLucha(){
		return super()*nivel.multiplicador()
	}
}
class Nivel {
	var property nombre
	var property multiplicador 
	constructor(_nombre,_multiplicador){
		nombre = _nombre
		multiplicador = _multiplicador
	}
}
//-----------------------------------------------------------------------------------------------
//Hechizos
class Hechizo {
	method poder()
	method esPoderoso(){
		return self.poder()>15
	}
	method pesoRefuerzo(){
		if(self.poder().even()){
			return 2
		}
		else{
			return 1
		}
	}
	method precioDeLista(){
		return self.poder()
	}
}
class Logos inherits Hechizo{
	var nombre 
	var multiplier
	override method poder(){
		return multiplier * nombre.length()
	}
	method cambiarNombre(_nombre){
		nombre = _nombre
	}
	method cambiarMultiplier(_multiplier){
		multiplier = _multiplier
	}
	method precioRefuerzo(valorBase){
		return valorBase + self.precioDeLista()
	}
	method asignarDuenio(_duenio){
	}
}
class Comercial inherits Hechizo {
	var property porcentaje = 0.2
	var property multiplicador = 2
	var nombre = "el hechizo comercial"
	override method poder(){
		return nombre.length()*porcentaje*multiplicador
	}
}
//Objetos
class Objeto {
	var diaDeCompra = hoy.fecha()
	var peso = 0	
	method pesoTotal (){
		return (peso - self.desgaste()).max(0)
	}
	method desgaste (){
		return ((hoy.fecha()-diaDeCompra)/1000).min(1)
	}
}
class Arma inherits Objeto{
	var duenio
	method lucha(){
		return 3
	}
	method asignarDuenio(_duenio){
		duenio = _duenio
	}
	method precioDeLista(){
		return 5 * self.pesoTotal()
	}
}
class Mascara inherits Objeto{
	var duenio
	var minimo = 4
	var indiceOscuro
	override method pesoTotal(){
		return super() + (self.lucha()-3).max(0)
	}
	method asignarIndice(_indice){
		indiceOscuro = _indice
	}
	method lucha(){
		return minimo.max((fuerzaOscura.poderOscuro()/2) * indiceOscuro)
	}
	method cambiarMinimo(_minimo){
		minimo = _minimo
	}
	method asignarDuenio(_duenio){
		duenio = _duenio
	}
	method precioDeLista(){
		return 10*indiceOscuro
	}
}
class Armadura inherits Objeto{
	var valorBase = 2
	var duenio
	var refuerzo = null
	method asignarDuenio(_duenio){
		duenio = _duenio
		refuerzo.asignarDuenio(duenio)
	}
	method ponerRefuerzo(_refuerzo){
		refuerzo = _refuerzo
		refuerzo.asignarDuenio(duenio)
	}
	method quitarRefuerzo(){
		refuerzo = null
	}
	method lucha(){
		return valorBase + refuerzo.poder()
	}
	method precioDeLista(){
		return refuerzo.precioRefuerzo(valorBase)
	}
	override method pesoTotal(){
		return super() + refuerzo.pesoRefuerzo()
	}
}
class Cota inherits Objeto{
	var unidadLucha = 1
	method poder(){
		return unidadLucha
	}
	method precioRefuerzo(valorBase){
		return unidadLucha/2
	}
	method asignarDuenio(_duenio){
	}
	method pesoRefuerzo(){
		return 1
	}
}
class Espejo inherits Objeto{
	var duenio
	method lucha(){
		var lista = duenio.listaArtefactos().filter({artefacto => artefacto != self})
		if(lista.isEmpty()){
			return 0
		}
		else{
			return lista.map({artefacto => artefacto.lucha()}).max()
		}
	}
	method asignarDuenio(_duenio){
		duenio = _duenio
	}
	method precioDeLista(){
		return 90
	}
}
class Libro inherits Objeto{
	var hechizos = []
	method poder() {
		var poderosos = hechizos.filter({hechizo =>hechizo.esPoderoso()})
		return poderosos.sum({hechizo => hechizo.poder()})
	}
	method esPoderoso(){
		return hechizos.first().esPoderoso()
	}
	method agregarHechizos(nuevoHechi) {
		if (nuevoHechi != self)
			hechizos.add(nuevoHechi)
	}
	method removerHechizos(hechizo) {
		hechizos.remove(hechizo)
	}
	method precioDeLista(){
		return 10*hechizos.size() + hechizos.sum({hechizo=>hechizo.poder()})
	}
	override method pesoTotal(){
		return 0
	}
}
class CargaException inherits Exception {}

class Comerciante {
	var impuesto
	var ganancias
	method recategorizar(){
		if(impuesto == 0.21){
			ganancias = true
			impuesto = 0.35
		}
		else if(impuesto != 0.35){
			impuesto = (impuesto *2).min(0.21)
		}
	}
	method vender(artefacto) {
		var precio = artefacto.precioDeLista()
		if(ganancias){
			if(precio > minimo.importe()){
				return impuesto*(precio-minimo.importe()) + precio
			}
			else{
				return precio
			}
		}
		else{
			return impuesto*precio + precio
		}
	}
	method estado(){
		if(impuesto == 0.21){
			return "Registrado"
		}
		else if(ganancias){
			return "Comerciante con impuesto a ganancias"
		}
		else{
			return "Independiente"
		}
	}
}