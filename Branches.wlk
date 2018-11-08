import parcial.*
import Commits.*

class Branch {
	var duenio
	var colaboradores =[]
	var commits =[]
	
	method agregarColaborador(colaborador){
		colaboradores+=colaborador
	}
	method agragarComit(commit){
		commits+=commit
	}
	method ckeckout(carpeta){
		commits.forEach({c=>c.aplicar(carpeta)})
	}
	
	method log (nombreArchivo){
		return commits.filter({c=>c.afectaA(nombreArchivo)})
	}
	
	method permisoParaAgregar(usuario){
		return usuario==duenio
	}
	method permisoParaComitear(usuario){
		return colaboradores.contains(usuario)		
	}
	
	method blame(archivo){
		commits.filter({c=>c.afectaA(archivo)}).map({c=>c.autor()})
	}
}
