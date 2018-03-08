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
            <form id="acceso" action="php/torniquete.php" method="post">
                <label>Matricula</label>
                <input type="number" name="Matricula"  autofocus min="0" max="9999999999"/>
                <!--  <button type="submit" >Enviar</button> -->
            </form>
        <center><div id="registrado" name="registrado"><h1><div id="mensaje"><?php echo $mensaje;?></div></h1></div></center> 
        </div>
    </div>
  </body>
</html>
