<!--
(*************************************************)
(*        Autor1: Juan Daniel Soto Dimas         *)
(*        Autor2: José Elias Lopéz Duran         *)
(*      Version: 1.0                             *)
(* Fecha inicio: 14/02/2018                      *)
(* Fecha modif.: 02/03/2018                      *)
(*      Fichero: torniquete.php	                 *)
(*************************************************)
-->
<?php
    require_once "conexion.php";//incluimos la conexion con la bd
    session_start();//iniciamos la session
    session_unset();//vaciamos la session
    session_destroy();//destruimos la session
    class Torniquete extends Conexion {//esta clase hereda de Conexion
          public $matricula;//se declararon las variables a utilizar
          private $resultado;//contendra lo que se obtiene de la interacion con la bd
          private  $fila;//contiene la primer campo de lo que arroja el resultado
          protected $nombre;//contendra el nombre de la persona que ingrese
          public $mensaje;//contiene el mensaje de acceso autorizado y y acceso no autorizado
          public $acceso;//es boleano e indica si puede o no pasar la persona
          public $visitas;
        public function Validar($valormatricula){//con esta funcion se valida que este registrada la persona a ingresar
          $this->conectar();//se llama al metodo conectar de la clase conexion
          $this->matricula=$valormatricula;//obtenemos la matricula de el formulario
          $this->resultado = $this->con->query("Select library.validate_Client('".$this->matricula."');");//mandamos llamar a la funcion en la bd que verifica si el cliente existe
          $this->fila = mysqli_fetch_row($this->resultado);//guardamos el resultado en un arreglo segun en filas
          if($this->fila[0]!=false){//validamos si el resultado  que nos dio la bd es verdadero
              $this->resultado = $this->con->query("Select library.getName('".$this->matricula."');");//obtenemos el nombre de el usuario
              $this->nombre = mysqli_fetch_row($this->resultado);//
              $this->acceso=true;//asignamos el valor de true al acceso
              $this->mensaje=$this->nombre[0]."<br/>"."Acceso Autorizado";//este mensaje es el que aparecera en la pantalla de inicio incluye el nombre y el mensaje
              $this->resultado=$this->con->query("Select library.counter();");
              $this->visitas=mysqli_fetch_row($this->resultado);              
              $this->desconectar();//nos desconectamos de la bd
          }else{
              $this->mensaje="Acceso No Autorizado";//este es el mensaje que se mostrara en la pantalla de inicio
              $this->acceso=false;//negamos el acceso
              $this->desconectar();//desconectamos de la bd
           }//fin if-else
        }//fin funcion
    }//fin clase
    $torniquete = new Torniquete();//instanciamos la clase torniquete
    $torniquete->Validar($_POST['Matricula']);//llamamos la funcion validar
    if($torniquete->acceso==false){//si el acceso es falso se verificara quitando ceros de uno en uno
        $revalidacio =2;//esto es para que el while solo funcione 2 veces
        while($revalidacio!=0&&$torniquete->acceso==false){//aqui es para que si es iguala cero o verdadero termine
            if($torniquete->acceso==false){//si el acceso en falso
                $valorsinceros=substr($torniquete->matricula,1);//quitamos un el caracter que se encuentra al pricipio del string
                $torniquete->Validar($valorsinceros);//llamamos la funcion y le mandamos la matricula sin el primer caracter
            }//fin if
            $revalidacio--;//disminuimos en uno la variable
        }//fin while
    }//fin if
    session_start();//iniciamos la sesion
    $_SESSION['mensaje']=$torniquete->mensaje;// almacenamos el valor que tiene el la clase en su atributo mensaje dentro de session mensaje
    $_SESSION['acceso']=$torniquete->acceso;// almacenamos el valor que tiene el la clase en su atributo acceso dentro de session acceso
    $_SESSION['visitas']=$torniquete->visitas[0];
    header("Location: ../index.php");//nos redireccionamos a la pantalla principal
?>
