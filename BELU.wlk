/** First Wollok example */
/*
var numerosDeLaSuerte = [2, 5, 8]
numerosDeLaSuerte.add(9) //ahora la lista contiene también al 9
numerosDeLaSuerte.remove(8) //ahora la lista no contiene más al 8
numerosDeLaSuerte.contains(5) //devuelve true, porque lo contiene`
numerosDeLaSuerte.size() //devuelve 3, porque contiene al 2, 5 y 9

var algunosNumeros = [1, 2, 3, 4, 5]
var mayoresA3 = algunosNumeros.filter({unNumero => unNumero > 3}) 
* // en vez de var mayoresA3 PONGO return
* 
* 
var algunosNumeros = [1, 2, 3, 4, 5]
algunosNumeros.find({unNumero => unNumero > 3})
// va a devolvernos el 4,
// porque es el primero que cumple la condición. 
* find devuelvo SOLO UN ELEMENTO, NO UNA COLECCIN.
* 
* alumnos.all({unAlumno => unAlumno.aprobo()})
alumnos.any({unAlumno => unAlumno.aprobo()})      ---TRUE O FALSE
* 

MAP
Cuando queremos a partir de una colección obtener otra colección con 
cada uno de los resultados que retorna un envío de mensaje a cada elemento.
 El resultado de mapear una lista siempre va a ser una lista nueva con tantos
  elementos como la que recibió el mensaje map.

Si por ejemplo queremos averiguar cuál es la nota más alta de cada uno de los alumnos,
 podemos hacer:

misAlumnos.map({unAlumno => unAlumno.notaMasAlta()})
* 
* 
* 


Ahora como sabemos que no todos nuestros alumnos aprobaron, pero que alguno/s 
si lo hicieron, la pregunta es, ¿Cuántos?, lo cual se responde fácilmente:

alumnos.count({unAlumno => unAlumno.aprobo()})
 Copiar

Es decir, el count sirve para saber cuantos elementos de mi colección cumplen
 la condición. En cambio, si queremos calcular la sumatoria del resultado de 
 evaluar el bloque contra cada elemento de la colección, tenemos el mensaje sum. 
 Por ejemplo, para conocer la suma de todas las notas de los alumnos podemos hacer:

alumnos.sum({unAlumno => unAlumno.notaEnFinal()}

* 
* 
* 
pero qué pasa cuando queremos hacer algo con cada elemento, o sea, no obtener 
los resultados de enviar el mismo mensaje a cada uno (lo que haríamos con un map)
 sino mandarles un mensaje a 
cada uno con la intentención de producir un efecto.
* 
Por ejemplo, si queremos que todos los alumnos que 
hayan aprobado una materia (asumamos que sabe calcularlo a
 partir de sus notas) firmen la materia (lo cual actualiza el
  estado de cursada del alumno de alguna forma), podríamos hacer:

misAlumnos
  .filter({unAlumno => unAlumno.aprobo(pdep)})
  .forEach({unAlumno => unAlumno.firmar(pdep)})
*/




// PROTAGONISTA
object rolando{
	
	
   	
	var property hechizoPreferido= espectroMalefico
	var artefactos= [espadaDelDestino,collarDivino]
	var property valorBaseDeLucha= 1
	var armadura= 1
	
	method artefactos(){
		return artefactos
	}
	method nivelDeHechiceria(){
		return (3 * hechizoPreferido.poder()) + fuerzaOscura.valor()
	}
	
	method seCreePoderoso(){
		return hechizoPreferido.esPoderoso()
	}
	
	method lucha(){
		return valorBaseDeLucha + artefactos.sum({unArtefacto=>unArtefacto.lucha()}) + armadura
	}
	
	
 //Saber si Rolando está cargado. Eso significa que tiene 5 ó más artefactos. 
 
 method estaCargado(){
 	return artefactos.size() >= 5
 }
	
	
	
	method addArtefactos(_artefacto){
		artefactos.add(_artefacto)
	}
	method removeArtefactos(_artefacto){
		artefactos.remove(_artefacto)
	}
	method esMayorHabilidad(){
		return self.lucha() > self.nivelDeHechiceria()
	}
	
}

//HECHIZOS
object espectroMalefico{ 
	var property nombre=  'espectro Malefico' // si quiero cambiar nombre
								/// en consola: >>> espectroMalefico.nombre('esp')
								/// para verlo: >>> espectroMalefico.nombre()
								///					"esp"

	method poder(){
		return nombre.length()
	}
	method esPoderoso(){
		return nombre.length()>15
	}
}

object hechizoBasico{
	
	method poder(){
		return 10
		}
	method esPoderoso(){
		return false
	}
	
}


//ARTEFACTOS

object espadaDelDestino{
	
	method lucha(){
		return 3
	}
}

object collarDivino{
	var property perlas= 10
	
	method lucha(){
	 return perlas
	 }
	 }
/*
Punto 2: Lucha 
La habilidad para la lucha de Rolando es 
* un número que se debe calcular como un valor base 
* que comienza en 1 al que se le suma lo que aportan 
* todos los artefactos que posea, que pueden ser los siguientes:

Espada del destino: Aporta 3 unidades de lucha
* 
* 
* Collar divino: Suma tantas unidades de lucha como perlas tenga.
Máscara oscura: Da la mitad de unidades de la fuerza oscura,
*  pero nunca menos de 4 unidades (es decir que con la fuerza 
* oscura inicial en 5 son 4, pero si hubiera un eclipse y la fuerza oscura
*  se duplicará a 10, pasarían a ser 5).
 
 
 */	
	
	
object mascaraOscura{
	method lucha(){
	return 4.max(fuerzaOscura.valor()/2)
	}
}

///// fuerza de la oscuridad
object fuerzaOscura{
	var property valor= 5 // getter y setter
	method eclipse(){
	 valor*= 2
	}	
}


object armadura{
	var property refuerzo= cotaDeMalla
	method lucha(){
		return 2 + refuerzo.valor()
	}
}
//REFUERZOS	
object cotaDeMalla{
	method valor(){
		return 1
	}
}	
object bendicion{
	method valor(){
		return rolando.nivelDeHechiceria()
	}
}

object hechizo{
	var property hechizo= espectroMalefico
	method valor(){
		return hechizo.poder()
	}
}

object nulo{
	method valor(){
		return 0
	}
}
/*

* 
ESPEJO
Rolando también puede poseer al espejo fantástico, 
* que se comporta de la misma manera que la mejor de
*  sus restantes pertenencias. Se considera la mejor 
pertenencia a la que aporta más puntos de lucha. Si sólo tuviera 
* como pertenencia al espejo fantástico, su aporte a la lucha sería nulo.

 */
 
 
 object espejo{
 	
 	method mejor(){
 	return rolando.artefactos().filter({mejores=>mejores.lucha()}).max()// MAX PONERLO AFUERA
 	// filter si es condicion 
 	//true/false, distinto, mayor o menor y Map con los numeros

 	}
 	
 	
 	
 	/*object espejoFantastico{
 method lucha(){
 var lista = rolando.listaArtefactos().filter({unArtefacto=>unArtefacto!=self})
 if(lista.isEmpty()){
  return 0
 }
 else{
  return lista.map({artefacto=>artefacto.lucha()}).max()
 }
  }
} */
 	//method otros(){
 	//	self.mejor().map({mejores=>mejores.max()})
 	//}
 
}



/*LIBRO DE HECHIZOS
Por otra parte, puede suceder que Rolando en vez de tener un simple hechizo preferido, 
* adopte como preferido un libro de hechizos, en el que están detallados varios hechizos.
*  En este caso, el poder de hechicería que aporta es la sumatoria del poder de todos los 
* hechizos poderosos que contenga. Sabemos que el libro es poderoso, si es que tiene al menos
*  un hechizo poderoso.

 */
 

 object libroDeHechizos{
 	var contiene= [hechizoBasico, espectroMalefico]
 	method poder(){
 		var x= contiene.filter({unPoderoso=>unPoderoso.esPoderoso()})
 		return x.sum({unPoderoso=>unPoderoso.poder()})
 		
 		}
	method esPoderoso(){
		return contiene.any({unPoderoso=>unPoderoso.esPoderoso()})
	}
 			
 	
 }
 
 
 object belen{
 	var algunosNumeros = [1, 2, 3, 4, 5]
   method a(){
   	return algunosNumeros.filter({unNumero => unNumero > 3})
   	} 
 }