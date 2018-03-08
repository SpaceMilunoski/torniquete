<?php
require_once "conexion.php";
 class Torniquete extends Conexion{
   private $matricula;
   private $resultado;
   private  $fila;
   private $fecha;
   private $cont=0;
   public function Validar(){
    $this->conectar();
    $this->matricula=$_POST['Matricula'];//$_POST['Matricula'];
    $this->resultado = $this->con->query("Select * from client where identification_Number = '".$this->matricula."';");
    $this->fila = $this->resultado->fetch_array();
    if($this->resultado!=NULL&&$this->matricula == $this->fila['identification_Number']){
        //header("Location: ../index.php");
        echo ("Se ha encontrado");
        $this->desconectar();
        $this->insertarAlumno();
    }else{
        header("Location: ../index.php");
      $this->desconectar();
    }
  } 
  public function insertarAlumno(){
    $this->conectar();
    $this->cont = $this->cont +1;
    $this->con->query("INSERT INTO `library`.`visit_client` (`id`, `date`, `client_id`) VALUES ('0', '1001-01-01 00:00:01', '1531111634');");
    $this->desconectar();
  }
 }
$torniquete = new Torniquete();
$torniquete->Validar();
?>