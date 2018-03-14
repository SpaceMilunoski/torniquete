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
 function cambiarColor(acceso,visitas){//esta funcion cambia el color en caso que el cliente este autorizado
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

//Esta funcion limita al cliente a que introduzca valores que no sean numeros
var nav4 = window.Event ? true : false;
function acceptNum(evt){
     // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57
     var key = nav4 ? evt.which : evt.keyCode;
     return (key <= 13 || (key >= 48 && key <= 57) || key <= 8);
}//fin funcion
function visitas(visitas){
      document.getElementById("visitasmensaje").textContent=visitas;
}
