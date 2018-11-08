import parcial.*
import Commits.*
import Branches.*

class SinPermisosException inherits Exception{}

class Usuario {
	
	var tipoUsuario
	method crearBranch(){
		return new Branch(duenio=self,colaboradores=[self])

	}
	
	method comitear(commit,branch){
		tipoUsuario.puedeComitear(branch)
		branch.agragarComit(commit)
	}
	
	method agregarColaborador(branch,colaborador){
		tipoUsuario.puedeAgregar(branch)
		branch.agregarColaborador(colaborador)
	}
	
	method convertirUsuarioA(usuario,tipoDeUsuario){
		tipoUsuario.convertirUsuario(usuario,tipoDeUsuario)
	}
	method CambiarTipo(tipoDeUsuario){
		tipoUsuario=tipoDeUsuario
	}
	

}

object tipoAdministrador{
	method puedeAgregar(branch,usuario){}
	method puedeComitear(branch,usuario){}
	method convertirUsuario(usuario,tipoDeUsuario){
		usuario.cambiarTipo(tipoDeUsuario)
	}
}

object tipoNormal{
	method puedeAgregar(branch,usuario){
		if(!branch.permisoParaAgregar(usuario))
			throw new SinPermisosException("No tiene permisos para agregar colaboradores a esta Branch")
	}
	
	method puedeComitear(branch,usuario){
		if(!branch.permisoParaComitear(usuario))
			throw new SinPermisosException("No tiene permisos para comitear en esta Branch")
	}
	method convertirUsuario(usuario,tipoDeUsuario){
			throw new SinPermisosException("No tiene permiso para cambiar el tipo de usuario")
	}
}

