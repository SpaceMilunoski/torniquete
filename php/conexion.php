<!--
(*************************************************)
(*        Autor1: Juan Daniel Soto Dimas         *) 
(*        Autor2: José Elias Lopéz Duran         *) 
(*      Version: 1.0                             *) 
(* Fecha inicio: 14/02/2018                      *) 
(* Fecha modif.: 02/03/2018                      *) 
(*      Fichero: conexion.php	                 *) 
(*************************************************)
-->

<?php
	class Conexion{//iniciamos la clase con la que nos conectaremos a la bd
		protected $con;//declaramos las variables
		private	$server="192.168.137.1";//direccion del servidor
		private $username="Daniel";//usuario
	 	private $password="1234";//contraseña
		private $db='library';//base de datos
		public function conectar(){//esta funcion es la que conecta con la bd (abrimos la conexion)
			$this->con = new mysqli($this->server,$this->username,$this->password,$this->db);//aqui se almacena la conexion en la variable con
			if($this->con->connect_errno){//si la conexion nos devuelve un error entonces
				echo("Error al conectar con la base de datos") .$this->con->connect_error;//mostrar mensaje incluyendo el error
			}//fin if
		}//fin funcion
		public function desconectar(){//en esta funcion cerramos la conexion
			$this->con->close();//a qui cerramos la conexion
		}//fin de funcion
	}//fin de clase
?>