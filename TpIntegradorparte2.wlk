//---------------------------------------SEGUNDA ENTREGA PARTE 2
  
//----------------------------------------OBJETOS QUE SIGUEN EXISTIENDO:    
//-------------------------HECHIZOS
object hechizoBasico{
	var poder = 10
	method esPoderoso(){
		return false
	}
	method poder(){
		return poder
	}
	method precio(){
		return 10
	}
}

object fuerzaOscura{
	var fuerza = 5
	method fuerza(){
		return fuerza
	}
	method nuevaFuerza(_fuerza){
		fuerza = _fuerza
	}
	method eclipse(){
		fuerza*=2
	}
}

//    --------------------------ARTEFACTOS
object collarDivino{
	var perlas = 5
	method poderArtefacto(duenio){
		return perlas
	}
	method cambiarPerlas(_perlas){
		perlas = _perlas
	}	
	method precio(){
		return 2 * perlas
	}
}

//-----------------------------REFUERZOS

object bendicion{
	method poder(duenio){ //poderRefuerzo(duenio)
		return duenio.nivelDeHechiceria()
	}
	method precioRefuerzo(unidadLucha){
		return unidadLucha
	}
}

class Hechizos{
	var hechizoMisterioso
	
	method cambiarHechizo(_hechizoMisterioso){
		hechizoMisterioso = _hechizoMisterioso
	}
	method poder(duenio){
		return hechizoMisterioso.poder()
	}
	method precioRefuerzo(unidadLucha){
		return unidadLucha + hechizoMisterioso.precio()
	}
}

object ninguno{
	method poder(){  //capaz es poderArtefacto()
		return 0
	}
}

object feria{
	method precioCanjeo(hechizoPreferido,nuevoHechizo){
		return nuevoHechizo.precioDeLista() - (hechizoPreferido.precioDeLista() /2).max(0)
	}
}


//---------------------------------------CLASES:
class SinPlataException inherits Exception{}

class Logos{
	var nombre
	var multiplicador = 1
	method poder(){
		return multiplicador * nombre.length() //El poder de hechicería es un múltiplo de la cantidad de letras de su nombre, donde el valor por el cual se 
	}										//multiplica puede variar de hechizo en hechizo
	method esPoderoso(){
		return nombre.length()>15  //La forma de saber si es poderoso sigue siendo si su poder es mayor a 15. 
	}
	method cambiarNombre(_nombre){
		nombre = _nombre
	}
	method cambiarMultiplicador(_multiplicador){
		multiplicador = _multiplicador
	}
	method precio(){
		return self.poder()
	}
}

class Personaje{
	var hechizoPreferido  //se deja vacio porque dice que cada personaje puede tener un hechizo preferido distinto
	var valorBaseDeLucha = 1
	var artefactos = []
	var oro = 100

	method nivelDeHechiceria(){
		return 3 * hechizoPreferido.poder() + fuerzaOscura.fuerza()
	}
	method cambiarHechizoPreferido(_hechizoPreferido){
		hechizoPreferido = _hechizoPreferido
	}
	method creePoderoso(){
		return hechizoPreferido.poderoso()
	}
	method lucha(){
		return valorBaseDeLucha + artefactos.sum({unArtefacto=>unArtefacto.poderArtefacto(self)})
	}
	method agregarArtefacto(_artefacto){
		artefactos.add(_artefacto)
	}
	method removerArtefacto(_artefacto){
		artefactos.remove(_artefacto)
	}
	method cambiarValorBaseLucha(_valorBaseDeLucha){
		valorBaseDeLucha = _valorBaseDeLucha
	}
	method esMejorLuchador(){
		return self.lucha() > self.nivelDeHechiceria()
	}
	method removerArtefactos(){
		artefactos.clear()
	}
	method listaArtefactos(){
		return artefactos
	}
	method estaCargado(){
		return artefactos.size()>=5
	}
	method puedeGastarOro(precioHechizo){
		if(oro>=precioHechizo){
			oro-=precioHechizo
		}
		else{
			throw new SinPlataException("Dinero Insuficiente")
		}
	}

	method canjearNuevoHechizo(nuevoHechizo){
		var precioHechizo = feria.precioCanjeo(hechizoPreferido,nuevoHechizo)
		self.puedeGastarOro(precioHechizo)
		hechizoPreferido = nuevoHechizo	
	}

	method comprarArtefacto(_artefacto){
		var costo = _artefacto.precioDeLista()
		if(oro>=costo) 
		oro -= costo
		self.agregarArtefacto(_artefacto)		
	}
	method cumplirObjetivo(){
		oro += 10
	}
}


class Arma{
	var uniLucha = 3
	method poderArtefacto(duenio){
		return uniLucha
	}
	method precio(){
		return 5 * uniLucha
	}
}

class Mascara{
	var indice
	var minimo = 4
	
	method poderArtefacto(duenio){
	return minimo.max((fuerzaOscura.fuerza() / 2) * indice)
  //return (fuerzaOscura.valor().div(2) * oscuridad).max(minimo)
	}
		
	method cambiarIndice(_indice){
		indice = _indice
	}
	method cambiarMinimo(_minimo){
		minimo = _minimo
	}
	method precio(){
		return 0
	}
}

class Armadura{
	var refuerzo = null
	var valorBase = 2
	method poderArtefacto(duenio){
		if(refuerzo!=null)
		return valorBase + refuerzo.poder(duenio)
		else{return valorBase}
	}
	method cambiarRefuerzo(_refuerzo){
		refuerzo = _refuerzo
	}
	method quitarRefuerzo(){
		refuerzo = null
	}
	method precio(){
		if(refuerzo!=null){return refuerzo.precioRefuerzo(valorBase)}
		else{return 2}	
	}
	//	method precio(){
	//	if(refuerzo != null){
	//		return valorBase +refuerzo.precioRefuerzo(unidadLucha)
	//	}else{
	//		return 2
    //
	//	}
	//}
}

//-----------------------------REFUERZOS:

class CotaDeMalla{
	var unidad = 1
	method poder(duenio){
		return unidad
	}
	method cambiarUnidad(_unidad){
		unidad = _unidad
	}
	method precioRefuerzo(unidadLucha){
		return unidad / 2
	}
}

//----------------------------ESPEJO

class EspejoFantastico{
	method poderArtefacto(duenio){
	var lista = duenio.listaArtefactos().filter({unArtefacto=>unArtefacto!=self})
	if(lista.isEmpty()){
		return 0
	}
	else{
		return lista.map({artefacto=>artefacto.lucha()}).max()
	}
  }
  method precio(){
  	return 90
  }
}


//---------------------------LIBRO DE HECHIZOS

class LibroDeHechizos{
	var hechizos = []
	method poder(){
	 	var hechizosPoderosos = hechizos.filter({unHechizo=>unHechizo.poderoso()})
	 	return hechizosPoderosos.sum({unHechizo=>unHechizo.poder()})
	}
	method agregarHechizos(_hechizo){
		if(_hechizo!=self)
		hechizos.add(_hechizo)
	}
	method removerHechizos(hechizo){
		hechizos.remove(hechizo)
	}
	method poderoso(){
		return hechizos.any({unHechizo=>unHechizo.poderoso()})
	}
	method precio(){
		return 10 * hechizos.size() + hechizos.sum({unHechizo => unHechizo.esPoderoso()})
 		//return 10 * hechizos.size() + self.poder()
	}
}

//En cuanto a los espejos, es indistinto que sean muchos en cuanto a funcionalidad ya que todos
//hacen lo mismo. Lo unico que cambiaría sería el identificador del objeto.
//En cuanto a los libros de hechizos, sirve para guardar distintos hechizos dentro de cada libro
//esto permite tener libros de hechizos dentro de otros libros de hechizos.
//Si el libro esta dentro de sí mismo entonces el caso es igual al de la primera entrega

