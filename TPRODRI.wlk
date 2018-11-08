import feria.*

class Personaje {

	var nivelHechiceriaBase = 3
	var nivelLuchaBase = 1
	var hechizoPreferido
	var artefactos = []
	
	var oro = 100

	method cambiarHechizoPreferido(nuevoHechizo) {
		hechizoPreferido = nuevoHechizo
	}

	method cambiarNivelLuchaBase(nuevoNivel) {
		nivelLuchaBase = nuevoNivel
	}

	method agregarArtefacto(artefacto) {
		artefactos.add(artefacto)
	}

	method removerArtefacto(artefacto) {
		artefactos.remove(artefacto)
	}

	method removerTodosLosArtefactos() {
		artefactos.clear()
	}

	method artefactos() {
		return artefactos
	}

	method nivelHechiceria() {
		return nivelHechiceriaBase * hechizoPreferido.poderHechizo() + fuerzaOscura.valor()
	}

	method nivelLucha() {
		return nivelLuchaBase + artefactos.sum({ artefacto => artefacto.poderArtefacto(self) })
	}

	method seCreePoderoso() {
		return hechizoPreferido.esPoderoso()
	}

	method estaReFuerte() {
		return self.nivelLucha() > self.nivelHechiceria()
	}

	method estaCargado() {
		return artefactos.size() >= 5
	}
	
	method noSoloEspejo(){
		return artefactos.any({ x => x != espejo })
	}
	
	method artefactosSinEspejo(){
		return artefactos.filter({ x => x != espejo })
	}
	method maximoSinEspejo(){
		return self.artefactosSinEspejo().max({ a => a.poderArtefacto(self) }).poderArtefacto(self)
	}
	
	//////////////////////////////////////
	
	method completarObjetivo(){
		oro += 10
	}

	method gastarOro(gasto){
		oro -=gasto
	}
	
	method canjearHechizo(nuevoHechizo){
		if(feria.puedeCanjear(hechizoPreferido,nuevoHechizo,oro)){
			self.gastarOro(feria.canjear(hechizoPreferido,nuevoHechizo))
			hechizoPreferido = nuevoHechizo
		}else
			error.throwWithMessage("Dinero insuficiente")
	}

	method comprarArtefacto(nuevoArtefacto){
		if(feria.puedeComprar(nuevoArtefacto,oro)){
			self.gastarOro(nuevoArtefacto.precio())
			self.agregarArtefacto(nuevoArtefacto)
		}else
			error.throwWithMessage("Dinero insuficiente")
	}
	
	method monedas()
	{
		return oro
	}
}

object fuerzaOscura {

	var valor = 5

	method valor() {
		return valor
	}

	method eclipse() {
		valor *= 2
	}

}

//	HECHIZOS
class Logo {

	var nombre
	var multiplo = 1

	method poderHechizo() {
		return multiplo * nombre.length()
	}

	method esPoderoso() {
		return self.poderHechizo() > 15
	}

	method cambiarNombre(nuevoNombre) {
		nombre = nuevoNombre
	}
	///////////////////////////
	method precio(){
		return self.poderHechizo()
	}
	

}

object hechizoBasico {

	const poder = 10

	method poderHechizo() {
		return poder
	}

	method esPoderoso() {
		return false
	}
	///////////////////////////
	method precio(){
		return 10
	}

}

class LibroDeHechizos {

	var listaDeHechizos = []

	method poderHechizo() {
		return listaDeHechizos.filter({ h => h.esPoderoso() }).sum({ h => h.poderHechizo() })
	}

	method agregarHechizos(nuevoHechizo) {
		if (nuevoHechizo != self)
			listaDeHechizos.add(nuevoHechizo)
	}
//No puede contenerse a si mismo, pero puede contener otros libros de hechizos

	method removerHechizos(hechizo) {
		listaDeHechizos.remove(hechizo)
	}
	///////////////////////////
	method precio(){
		return listaDeHechizos.size()*10 + self.poderHechizo()
	}

}

//new libroDeRolando = new LibroDeHechizos()
//Cada personaje puede tener su propio libro de hechizos con su propia colección de hechizos

//	ARTEFACTOS
class Arma {

	const unidadLucha = 3

	method poderArtefacto(duenio) {
		return unidadLucha
	}
	///////////////////////////
	method precio(){
		return 5 * unidadLucha
	}
	

}

//var espadaDelDestino = new Arma()

class CollarDivino {

	var perlas = 0

	method poderArtefacto(duenio) {
		return perlas
	}

	method perlas(cantidad) {
		perlas = cantidad
	}
	///////////////////////////
	method precio(){
		return 2*perlas
	}
}
//Es una clase para que todos puedan tener collares con diferente cantidad de perlas

class Mascara {
	
	var oscuridad = 4
	var minimo = 4

	method poderArtefacto(duenio) {
		return (fuerzaOscura.valor().div(2) * oscuridad).max(minimo)
	}
	///////////////////////////
	method precio(){
		return 0
	}

}

//var mascaraOscura = new Mascara(oscuridad = 4)

class Armadura {

	const unidadLucha = 2
	var refuerzo = null

	method poderArtefacto(duenio) {
		if(refuerzo != null){
		
			return unidadLucha + refuerzo.valor(duenio)
		}else{
			return unidadLucha

		}
	}

	method cambiarRefuerzo(nuevoRefuerzo) {
		refuerzo = nuevoRefuerzo
	}
	method quitarRefuerzo(){
		refuerzo = null
	}
///////////////////////////
	method precio(){
		if(refuerzo != null){
			return refuerzo.precioRefuerzo(unidadLucha)
		}else{
			return 2

		}
	}

}

//var armaduraDeRolando = new Armaduras()

class CotaDeMalla {
	
	var unidadDeLucha = 1
	method valor(duenio) {
		return unidadDeLucha
	}
	///////////////////////////
	method precioRefuerzo(unidadLucha){
		return unidadDeLucha/(2)
	}
	

}

//new CotaDeMalla(unidadDeLucha = 1)

object bendicion {


	method valor(duenio) {
		return duenio.nivelHechiceria()
	}
	///////////////////////////
	method precioRefuerzo(unidadLucha){
		return unidadLucha
	}
	

}

class Hechizos {

	var hechizoMisterioso

	method valor(duenio) {
		return hechizoMisterioso.poderHechizo()
	}

	method cambiarHechizoMisterioso(nuevoHechizoMisterioso) {
		hechizoMisterioso = nuevoHechizoMisterioso
	}
	///////////////////////////
	method precioRefuerzo(unidadLucha){
		return unidadLucha+hechizoMisterioso.precio()
	}
	

}

//var hechizoRefuerzo = new Hechizos(hechizoMisterioso = hechizoBasico)


object espejo {

	method poderArtefacto(duenio) {
		if (duenio.noSoloEspejo()) {
			return duenio.maximoSinEspejo()
		} else {
			return 0
		}
	}
	///////////////////////////
	method precio(){
		return 90
	}
}
//Puesto que lo único que se utiliza del espejo es su efecto, todos los personajes pueden compartir el mismo espejo

