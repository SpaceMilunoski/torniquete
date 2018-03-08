 /*
(*************************************************)
(*        Autor1: Juan Daniel Soto Dimas         *) 
(*        Autor2: José Elias Lopéz Duran         *) 
(*      Version: 1.0                             *) 
(* Fecha inicio: 14/02/2018                      *) 
(* Fecha modif.: 02/03/2018                      *) 
(*      Fichero: iniciar.js	                   *) 
(*************************************************)
*/
 function cambiarColor(acceso){//esta funcion cambia el color en caso que el cliente este autorizado
      if(acceso==true){//si el acceso es verdadero 
            document.getElementById("cambio").style.backgroundColor = "white";//cambiamos el color de el div a color blanco
           // window.setTimeout(cambio, 1000);//con esto lo regresaremos a color negro una ves pasados 4 segundos
      }
      window.setTimeout(cambio, 1000);
      
      
 }//fin funcion
 function cambio(){//esta funcion devuelve el div a color negro
    document.getElementById("cambio").style.backgroundColor = "black"; //cambiamos el color de el div a negro
    document.getElementById("mensaje").textContent="Bienvenido";
 }//fin funcion