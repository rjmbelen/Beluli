class YaExisteException inherits Exception{}
class NoExisteException inherits Exception{}

object parcial {
	
	method nota() = 10
}

class Archivo {
	var property nombre
	var property contenido
	
	method nombreEs(unNombre){
		return nombre==unNombre
	}
	method cambiarNombre(nuevoNombre){
		nombre=nuevoNombre
	}
	
	method agregarContenido (contenidoAAgregar){
		contenido+=contenidoAAgregar
	}
	
	method sacarContenido(contenidoASacar){
		var nuevoTamanio =contenido.size()-contenidoASacar.size()
		contenido=contenido.take(nuevoTamanio)
	}
	}

class Carpeta{
	var nombre
	var archivos=[]
	
	method contiene (unNombre) {
		return archivos.any({a =>(a.nombreEs(unNombre))})
		}
		
	method agregarArchivo(archivo){
		self.verificarInexistencia(archivo)
		archivos.add(archivo)
	}
	method verificarInexistencia(nombreArchivo){
		if(self.contiene(nombreArchivo))
			throw new YaExisteException("Ya existe El archivo")
	}
	
	method verificarExistencia(nombreArchivo){
		if(self.contiene(nombreArchivo).negate())
			throw new NoExisteException("El Archivo no existe")
	}
	
	method archivo(nombreArchivo){
		self.verificarExistencia(nombreArchivo)
		return archivos.find({a=>a.nombreEs(nombreArchivo)})
	}
	
	method removerArchivo(nombreArchivo){
		var archivo = self.archivo (nombreArchivo)
		archivos.remove(archivo)
		
	}
	method reemplazarArchivo(archivo,nombreArchivo){
		var archivoViejo = self.archivo(nombreArchivo)
		self.removerArchivo(archivoViejo)
		self.agregarArchivo(archivo)
	}
	method estaVacia(){
		return archivos.isEmpty()
	}
}


