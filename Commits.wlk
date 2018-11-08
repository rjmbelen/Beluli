import parcial.*

class TextoException inherits Exception{}
class Commit{
	var property autor
	var descripcion
	var tareas = []

	
	method aplicar(carpeta){
		tareas.forEach({t=>t.realizarSobre(carpeta)})
	}
	
	method afeactaA(archivo){
		return tareas.any({t=>t.nombreArchivo()==archivo})
	}
	
	method revert(){
		return tareas.map({t=>t.revertTarea()}).reverse()
	}
}



class Tarea {
	var property nombreArchivo
	method realizarSobre(carpeta)
	method revertTarea()
}

class Crear inherits Tarea{
	override method realizarSobre(carpeta){
		var archivo = new Archivo(nombre=nombreArchivo,contenido ="")
		carpeta.agregarArchivo(archivo)
	}
	
	override method revertTarea(){
		return new Eliminar(nombreArchivo=nombreArchivo)
	}
	
}
class Eliminar inherits Tarea{
	
	override method realizarSobre(carpeta){
		carpeta.removerArchivo(nombreArchivo)
	}
	override method revertTarea(){
		return new Crear(nombreArchivo=nombreArchivo)
	}
}
class Agregar inherits Tarea{
	
	var texto
	override method realizarSobre(carpeta){
		var archivo = carpeta.archivo(nombreArchivo)
		archivo.agregarContenido (texto)
		carpeta.reemplazarArchivo(archivo,nombreArchivo)
	}
	
	override method revertTarea(){
		return new Sacar(nombreArchivo=nombreArchivo,texto=texto)
	}
}
class Sacar inherits Tarea{
	
	var texto
	override method realizarSobre(carpeta){
		var archivo = carpeta.archivo(nombreArchivo)
		archivo.sacarContenido(texto)
		carpeta.reemplazarArchivo(archivo,nombreArchivo)
	}
	override method revertTarea(){
		return new Agregar(nombreArchivo=nombreArchivo,texto=texto)
	}

}

