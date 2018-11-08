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
object collarDivino{
	var perlas = 5
	var duenio
	method lucha(){
		return perlas
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
object hechizoBasico{
	method poder(){
		return 10
	}
	
	method esPoderoso(){
		return false
	}
	method precioDeLista(){
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
}

//Clases
class Personaje {
	var hechizoPreferido
	var luchaBase = 1
	var artefactos = []
	var oro = 100
	
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
	method oro(){
		return oro
	}
//	method canjearHechizo(nuevoHechi){
//		var costo = nuevoHechi.precioDeLista() - hechizoPreferido.precioDeLista()/2
//		if(oro >= costo){
//			oro -= costo.max(0)
//		hechizoPreferido = nuevoHechi
//		}
//	}
	method comprarArtefacto(nuevoArtefacto){
		var costo = nuevoArtefacto.precioDeLista()
		if(oro >= costo){
			oro -= costo
			self.agregarArtefacto(nuevoArtefacto)
		
		}
	}
}



class Logos {
	var nombre 
	var multiplier
	method poder(){
		return multiplier * nombre.length()
	}
	method cambiarNombre(_nombre){
		nombre = _nombre
	}
	method cambiarMultiplier(_multiplier){
		multiplier = _multiplier
	}
	method esPoderoso(){
		return nombre.length() > 15
	}
	method precioDeLista(){
		return self.poder()
	}
	method precioRefuerzo(valorBase){
		return valorBase + self.precioDeLista()
	}
	method asignarDuenio(_duenio){
	}
}
class Arma {
	var duenio
	method lucha(){
		return 3
	}
	method asignarDuenio(_duenio){
		duenio = _duenio
	}
	method precioDeLista(){
		return 5 * self.lucha()
	}
}
class Mascara {
	var duenio
	var minimo = 4
	var indiceOscuro
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
		return 5*self.lucha()
	}
}
class Armadura {
	var valorBase = 2
	var duenio
	var refuerzo = null
	method asignarDuenio(_duenio){
		duenio = _duenio
		refuerzo.asignarDuenio(duenio)
	}
	method ponerRefuerzo(_refuerzo){
		refuerzo = _refuerzo
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
}

class Cota {
	var unidadLucha = 1
	method poder(){
		return unidadLucha
	}
	method precioRefuerzo(valorBase){
		return unidadLucha/2
	}
	method asignarDuenio(_duenio){
	}
}
class Espejo{
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
class Libro {
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
}
//En cuanto a los espejos, es indistinto que sean muchos en cuanto a funcionalidad ya que todos
//hacen lo mismo. Lo unico que cambiaría sería el identificador del objeto.
//En cuanto a los libros de hechizos, sirve para guardar distintos hechizos dentro de cada libro
//esto permite tener libros de hechizos dentro de otros libros de hechizos.
//Si el libro esta dentro de sí mismo entonces el caso es igual al de la primera entrega
