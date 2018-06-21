% J.M.BELEN RODRIGUEZ - K2104

% Quien mata es porque odia a su víctima y no es más rico que ella. Además, quien mata debe vivir en la mansión Dreadbury.
% Tía Agatha, el carnicero y Charles son las únicas personas que viven en la mansión Dreadbury.
% Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
%  Agatha odia a todos los que viven en la mansión, excepto al carnicero.
% Quien no es odiado por el carnicero y vive en la mansión, es más rico que tía Agatha
% El carnicero odia a las mismas personas que odia tía Agatha.

% HECHOS
viveMansionDreadbury(agatha).
viveMansionDreadbury(carnicero).
viveMansionDreadbury(charles).

odia(agatha,charles).
odia(charles,carnicero). 
odia(charles,agatha).
odia(carnicero,charles).


% REGLAS
mata(Asesino,Victima):- odia(Asesino,Victima),not(esMasRico(Asesino,Victima)),viveMansionDreadbury(Asesino).

% mata(agatha,charles). :- True  , True , True



esMasRico(Asesino,Victima):- not(odia(Asesino,Victima)),viveMansionDreadbury(Asesino).

% esMasRico(agatha,charles). :- False, True = False

% esMasRico(agatha,carnicero). :-      True , True

% esMasRico(carnicero,charles). :-  False  , True = False



% 2_a)

% Agregar los mínimos hechos y reglas necesarios para poder saber:
% - Si existe alguien que odie a milhouse.
% - A quién odia charles.
% - El nombre de quien odia a agatha.
% - Todos los odiadores y sus odiados.
% - Si es cierto que el carnicero odia a alguien.
% Mostrar las consultas utilizadas para conseguir lo anterior, junto con las respuestas obtenidas.

/*
?- odia(Alguien,milhouse).
false.

 ?- odia(charles,Quien).
Quien = carnicero ;
Quien = agatha.

?- odia(Alguien,agatha).
Alguien = charles.

?- odia(Odiadores,Odiados).
Odiadores = agatha,
Odiados = charles ;
Odiadores = charles,
Odiados = carnicero ;
Odiadores = charles,
Odiados = agatha ;
Odiadores = carnicero,
Odiados = charles.

?- odia(carnicero,Odiados).
Odiados = charles.

*/