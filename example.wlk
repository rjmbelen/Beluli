object pepe{
	//var sueldo
	var categorias = gerentes
	var faltas= 55
	method faltas(){
		return faltas
	}
	/*method sueldo(){
		 sueldo = categorias.neto() // + //bono x presentismo + bono x resultados.
	}
	* */
	
	method categorias(_categoria){
		categorias = _categoria
	}
}

object gerentes{
	var neto = 15000
	method neto(){
		return neto
	}
}

object cadetes{
	var neto = 20000
	method neto(){
		return neto
	}
}

object bonoxResultados{
	method porcentaje(){
		return 0.1
	}
	method fijo(){
		return 800
	}
	method nulo(){
		return null
	}
}

object bonoxPresentismo{
	method normal(persona){
		if (persona.faltas() == 0) {
		return 2000
		}
		else if ((persona.faltas() == 1)){
			return 1000
		}
		else {
			return 0
		}
	}
}






  
  
  
  