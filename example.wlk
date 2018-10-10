

object falconArmor {
	var potencia= 25
	var resistencia= 10
	
		method potencia(){
			return potencia
		}
		method resistencia(){
			return resistencia
		}
		method bonificacionDanio() {
			return (potencia+resistencia)/2
		}
		
		method entrenamiento(minutos){
			if (resistencia < minutos){ //La resistencia nunca puede ser negativa*/
				resistencia= 0
				potencia += 10
				}
			else{
			resistencia -= minutos 
			potencia += 10
			}
		}
}


//method entrenar(tiempo) {
//           potencia = potencia + 10
//       resistencia = 0.max(resistencia - tiempo)  !!La resistencia nunca puede ser negativa*/
//   }



/*
 * Modelar a X, que inicialmente tiene como armadura a la Falcon Armor. 
 * Se desea conocer la fuerza de X: ésta es igual al daño que causa su X-Buster
 *  (el cual es 10 inicialmente) sumado a 
 * la bonificación de daño de la armadura que lleva.
 */
 
 /*X es un cazador de Mavericks, encargado de mantener 
  * la paz en la tierra. Este lleva consigo su X-Buster y una armadura.*/
 
 object x{
	var lleva= xBuster
	var armadura= falconArmor
 		method armadura(){
 			return armadura
 		}
 		method fuerza(){
 			return lleva.danio() + armadura.bonificacionDanio()
 			
 		}
 		method entrenamiento(tiempo){
 		lleva.danio() + (2*tiempo)
 		armadura.entrenamiento(tiempo)
 		}
 		method lleva(){
 			return lleva
 		}
 		
 		method cambiarArmadura(nueva){
 			armadura= nueva
 		}
 	}
 	
 	
 /*Se desea que X pueda entrenar un tiempo. Esto provoca que su X-Buster 
 aumente el daño base en 2 puntos por cada minuto entrenado,
  y provoque los efectos correspondientes en la armadura. 
 */
 object xBuster{
 	method danio(){
 		return 10
 	}
 }
 
 object shadowArmor{
 	var nivelDesgaste= 0
 	
 	method nivelDesgaste(){
 		return nivelDesgaste
 	}
 	method entrenar(tiempo){
 		nivelDesgaste += xBuster.danio()
 	}
 	method bonificacionDanio(){
 		return self.nivelDesgaste()/80
 	}
 	
 	
 }
 
 /*Modelar lo siguiente: A lo largo de sus batallas X cambia su armadura por una nueva, 
  * la Shadow Armor. Esta sombría armadura tiene un nivel de desgaste. Cada vez que 
  X entrena con ella este desgaste aumenta tantos puntos como el daño que causa el X-Buster, 
  independientemente del tiempo entrenado. 
  * La bonificación de daño que proporciona esta armadura es 80 dividido el desgaste. */