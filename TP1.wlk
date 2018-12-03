/** First Wollok example */
class Archivo{
	var nombreArchivo
	var contenido= []
	var carpeta
}

class Carpeta inherits Archivo{
	var listaDeArchivos= []
	var nombreCarpeta
	method agrupar(archivo){
		if (self.contieneArchivo(archivo)){
			return "la carpeta ya contiene un archivo con nombre igual"
		}
		else{
			return listaDeArchivos.add(archivo)
		}
		}
			
	method contieneArchivo(archivo){
		return listaDeArchivos.contains(archivo)
	}	
	
	method sacarArchivo(archivo){
		listaDeArchivos.remove(archivo)
	}
	
	method agregarArchivo(archivo){
		listaDeArchivos.add(archivo)
	}

}

//consola
//var matematicas= new Archivo(nombreArchivo="matematicas",carpeta="facultad")
// var facultad= new Carpeta(nombreArchivo="matematicas",carpeta="facultad",listaDeArchivos=[matematicas],nombreCarpeta="facultad")