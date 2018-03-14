<!--
(*************************************************)
(*        Autor1: Juan Daniel Soto Dimas         *)
(*        Autor2: José Elias Lopéz Duran         *)
(*      Version: 1.0                             *)
(* Fecha inicio: 14/02/2018                      *)
(* Fecha modif.: 02/03/2018                      *)
(*      Fichero: index.php	                     *)
(*************************************************)
-->
<!Doctype>
<html>
  <head>
    <link rel="stylesheet" href="css/style.css"/>
    <script type="text/javascript" src="js/iniciar.js"></script>
    <script type="text/javascript">
        window.onload =function llamada(){
                          <?php session_start();
                            $acceso=$_SESSION['acceso'];
                            $mensaje=$_SESSION['mensaje'];
                            session_destroy();
                          echo 'cambiarColor('.$acceso.');  '; ?>
                        }
    </script>
  </head>
  <body>
    <div id="cont">
        <div id="cambio"></div>
        <div id="formulario">
            <form id="acceso" action="php/torniquete.php" autocomplete="off" method="post">
                <label class="matricula">Matricula</label>
                <hr>
                <input class="cajaDeTexto" type="text" maxlength="10" name="Matricula" autofocus placeholder="Introduce tu matricula" onKeyPress="return acceptNum(event)"/>
                <hr>
                <center><div id="registrado" name="registrado"><label class="nombre"><div id="mensaje"><?php echo $mensaje;?></div></label></div></center>
            </form>
        </div>
        <div id="logo"></div>
    </div>
   
      <div id="visitas">
      Visitas:<div id="Visitas mensaje">asdajkhdgshdgshgdhsgdhsgdhsgdhsdqqqqqqqqqq</div>
    </div>
  </body>
</html>
