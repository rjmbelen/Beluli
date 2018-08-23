//RODRIGUEZ BELEN - PARADIGMAS - CURSO K2104 - TP1 OBJETOS

//Desarrollar y probar un programa que me permita saber si el paquete misterioso puede ser entregado por un mensajero. 
//Ese paquete puede entregarse cuando el mensajero puede llegar al destino del paquete y además el paquete está pago.

object paqueteMisterioso {
	
	var mensajero = roberto
	var destino = matrix
	var pago = false
	method puedeEntregarse() {
		return destino.dejaEntrar(mensajero) && pago
	}
	method estaPagadoPaquete(){
		pago = true
	}
}

//Puente de Brooklyn: deja pasar a todo lo que pese hasta una tonelada.
//La Matrix: deja entrar a quien pueda hacer una llamada.


object puenteDeBrooklyn {
	
	method dejaEntrar(mensajero){
		return (mensajero.peso()) < 1000
	}
}

object matrix {
	
	method dejaEntrar(mensajero){
		return mensajero.hacerLlamada()
	}
}

//Roberto: Roberto viaja en su bici Jenny ó en su camión Mack. Si viaja con Jenny, el peso que cuenta es el suyo propio. 
//Si viaja con Mack, su peso más media tonelada por cada acoplado que le ponga. Roberto no tiene un mango (gracias que tiene cubiertas...),
// y no puede llamar a nadie.

object roberto {
	var transporte = jenny
	var pesoPropio = 90
	method peso() {
		return transporte.pesoAgregado() + pesoPropio
	}
	method hacerLlamada(){
		return false
	}
	
	method cambiarTransporte(nuevoTransporte){
		transporte = nuevoTransporte
	}
}

object jenny {
	method pesoAgregado(){
		return 0
	}
}
object mack {
	var acoplados = 1
	method pesoAgregado(){
		return 500 * acoplados
	}
	method agregarAcoplado(){
		acoplados += 1
	}
}

//Chuck Norris: Chuck norris pesa 900 kg y puede llamar a cualquier persona del universo con sólo llevarse el pulgar al oído y el meñique a la boca
//Neo vuela, así que no pesa nada. Y anda con celular, el muy canchero. El tema es que a veces no tiene crédito.

object chuckNorris {
	
	method peso(){
		return 900
	}
	method hacerLlamada(){
		return true
	}
}

object neo{
	var tieneCredito = true
	method peso(){
		return 0
	}
	method hacerLlamada(){
		return tieneCredito
	}
	method cargarCelular(){
		tieneCredito = true
	}
	method sinCargarCelular(){
		tieneCredito = false
	}
}