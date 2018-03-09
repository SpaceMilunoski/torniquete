/* Creacion y uso de la DB */

CREATE DATABASE `library`;
USE `library`;

/* Aqui finaliza la creacion y uso de la DB */


/* Creacion de tablas en la DB library */

-- -----------------------------------------------------
-- Tabla status_People
-- En esta tabla muestra el estado de la persona
-- NOTAS:
-- *Activo si la persona esta activa dentro de la instituccion
-- *Inactivo la persona 
-- *Bloqueado tiene algun adeudo con la biblioteca
-- -----------------------------------------------------
CREATE TABLE `status_People`(
	`id` INT(1) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `status` ENUM('Activo','Inactivo','Bloqueado') NOT NULL DEFAULT 'Inactivo'
);

-- -----------------------------------------------------
-- Tabla user
-- En esta tabla se muetran los usuarios que pueden manipular el sistema
-- -----------------------------------------------------
CREATE TABLE `user`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `name` VARCHAR(30) NOT NULL,
    `lastname` VARCHAR(30) NOT NULL,
    `username` VARCHAR(20) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `password` VARCHAR(32) NOT NULL,
	`status_People_id` INT(1) unsigned NOT NULL,
    FOREIGN KEY (`status_People_id`) REFERENCES `status_People` (`id`)
);

-- -----------------------------------------------------
-- Tabla client
-- En esta tabla se muetran los clientes es decir alumnos, administrativos y docentes
-- NOTAS:
-- *identification_Number es la matricula
-- *area es ya sea la carrera en el que se ejerce o area de trabajo del administrativo
-- *already_entered es una variable auxiliar para saber si el cliente ya habia entrado en ese dia y asi contar solo
--  una entrada en el reporte (Tabla visits)
-- -----------------------------------------------------
CREATE TABLE `client`(
	`id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `identification_Number` VARCHAR(10) NOT NULL,
    `name` VARCHAR(60) NOT NULL,
    `area` VARCHAR(100) NOT NULL,
    `already_Entered` ENUM('true','false') NOT NULL DEFAULT 'false',
    `status_People_id` INT(1) UNSIGNED NOT NULL,
    PRIMARY KEY(`id`,`identification_Number`),
    FOREIGN KEY (`status_People_id`) REFERENCES `status_People`(`id`)
);

-- -----------------------------------------------------
-- Tabla visit_client
-- En esta tabla muestra la fecha y tiempo en el que el alumno entro a la biblioteca en esta se registraran todas
-- las entradas sin excepcion.
-- -----------------------------------------------------
CREATE TABLE `visit_client`(
	`id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`client_id` INT(10) UNSIGNED NOT NULL,
	`client_identification_Number` VARCHAR(10) NOT NULL,
    `date` DATETIME NOT NULL,
    FOREIGN KEY (`client_id` , `client_identification_Number`) REFERENCES `client` (`id` , `identification_Number`)
);

-- -----------------------------------------------------
-- Tabla author
-- En esta tabla se muestran los autores de los libros
-- -----------------------------------------------------
CREATE TABLE `author`(
	`id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    `name_Author` VARCHAR(150) NOT NULL
);

-- -----------------------------------------------------
-- Tabla editorial
-- En esta tabla se muetran las editoriales de los libros
-- -----------------------------------------------------
CREATE TABLE `editorial`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `name_Editorial` VARCHAR(100) NOT NULL
);

-- -----------------------------------------------------
-- Tabla category
-- En esta tabla se muetran las categorias de los libros
-- -----------------------------------------------------
CREATE TABLE `category`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `name_Category` VARCHAR(50) NOT NULL
);

-- -----------------------------------------------------
-- Tabla book
-- En esta tabla se muetra la informacion esencial los libros que se tienen en la biblioteca
-- NOTAS:
-- *classification es laseccion en la que el libro sera encontrado en las estanterias
-- -----------------------------------------------------
CREATE TABLE `book`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `isbn` VARCHAR(13) NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `inventory_Number` VARCHAR(12) NOT NULL,
    `classification` VARCHAR(100) NOT NULL,
    `author_id` INT UNSIGNED NOT NULL,
    `editorial_id` INT UNSIGNED NOT NULL,
    `category_id` INT UNSIGNED NOT NULL,
    FOREIGN KEY (`author_id`) REFERENCES `author` (`id`),
    FOREIGN KEY (`editorial_id`) REFERENCES `editorial` (`id`),
    FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
);

-- -----------------------------------------------------
-- Tabla book_status
-- En esta tabla se muestra la disponibilidad de un libro
-- -----------------------------------------------------
CREATE TABLE `book_status`(
	`id` INT(1) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `name_Status` ENUM('Disponble','Ocupado','Inactivo') NOT NULL
);

-- -----------------------------------------------------
-- Tabla item
-- En esta tabla se almacenan las copias de los libros 
-- NOTAS:
-- *book_id es el numero de inventario que tienen en la parte frontal
-- -----------------------------------------------------
CREATE TABLE `item`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `code_item` VARCHAR(12) NOT NULL,
    `book_status_id` INT(1) UNSIGNED NOT NULL,
    `book_id` INT UNSIGNED NOT NULL,
    FOREIGN KEY (`book_status_id`) REFERENCES `book_status` (`id`),
    FOREIGN KEY (`book_id`) REFERENCES `book` (`id`)
);

-- -----------------------------------------------------
-- Tabla operation
-- En esta tabla se muetran las operaciones (reservaciones) que se ha hecho
-- NOTAS:
-- *start_at es la fecha en la que fue prestado
-- *finish_at es la fecha en la que debe ser entregado
-- *returned_at es la fecha en la que fue realmente devuelto
-- *user_id es el usuario que hizo el prestamo
-- *receptor_id es el usuario que recibio el libro
-- -----------------------------------------------------
CREATE TABLE `operation`(
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `item_id` INT UNSIGNED NOT NULL,
    `client_id` INT UNSIGNED NOT NULL,
    `start_at` DATE NOT NULL,
    `finish_at` DATE NOT NULL,
    `returned_at` DATE NOT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    `receptor_id` INT UNSIGNED NOT NULL,
    FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
    FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
    FOREIGN KEY (`receptor_id`) REFERENCES `user` (`id`)
);

-- -----------------------------------------------------
-- Tabla visits
-- En esta tabla se muetran las visitas por dia de cada area (carreras o areas de trabajo) y un conteo total
-- en esta ocasion solo se registrara una ves por persona, por eso esta el campo "already_Entered" en el cual una
-- vez haya pasado el clienteeste cambiara para que ya en las siguientes entradas no cuente en esta tabla su entrada
-- -----------------------------------------------------
CREATE TABLE `visits`(
    `id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `ingenieria_Biomedica` INT UNSIGNED NOT NULL DEFAULT 0,
    `ingenieria_Biotecnologia` INT UNSIGNED NOT NULL DEFAULT 0,
    `ingenieria_Software` INT UNSIGNED NOT NULL DEFAULT 0,
    `ingenieria_Telematica` INT UNSIGNED NOT NULL DEFAULT 0,
    `ingenieria_Financiera` INT UNSIGNED NOT NULL DEFAULT 0,
    `ingenieria_Automotriz` INT UNSIGNED NOT NULL DEFAULT 0,
    `ingenieria_Mecatronica` INT UNSIGNED NOT NULL DEFAULT 0,
    `licenciatura_Medico` INT UNSIGNED NOT NULL DEFAULT 0,
    `licenciatura_Terapia` INT UNSIGNED NOT NULL DEFAULT 0,
    `maestria_Biotecnologia` INT UNSIGNED NOT NULL DEFAULT 0,
    `maestria_Ciencias` INT UNSIGNED NOT NULL DEFAULT 0,
    `maestria_Mecatronica` INT UNSIGNED NOT NULL DEFAULT 0,
    `maestria_Tics` INT UNSIGNED NOT NULL DEFAULT 0,
    `doctorado_Biotecnologia` INT UNSIGNED NOT NULL DEFAULT 0,
    `especialidad_Biotecnologia` INT UNSIGNED NOT NULL DEFAULT 0,
    `especialidad_Mecatronica` INT UNSIGNED NOT NULL DEFAULT 0,
    `especialidad_Seguridad` INT UNSIGNED  NOT NULL DEFAULT 0,
    `administrativos` INT UNSIGNED NOT NULL DEFAULT 0,
    `visits_Number` INT UNSIGNED NOT NULL DEFAULT 0,
    `date_Day` DATETIME NOT NULL
);

/* Aqui finaliza la creacion de tablas */


/* Creacion de Funciones */

-- -----------------------------------------------------
-- Funcion getName
-- EN esta se obtiene el nombre del usuario que quiere ingresar
-- NOTAS:
-- *como parametros se pide el numero de identificacion o matricula del cliente (enrolment) para despues hacer
--  la consulta y obtener el nombre y retornarlo.
-- -----------------------------------------------------
DELIMITER //
CREATE FUNCTION `getName`(`enrolment` VARCHAR(10)) RETURNS VARCHAR(60)
BEGIN
	#Declaracion de variables
	DECLARE `nameReturn` VARCHAR(60);
	#Asignacion de la consulta a la variable
	SET `nameReturn`= (SELECT `name` FROM `client` WHERE `identification_Number`= `enrolment`);
	#Rotorno de la variable
	RETURN `nameReturn`;
END//
DELIMITER;

-- -----------------------------------------------------
-- Funcion validarCliente
-- En esta funcion se valida si el cliente esta e la DB
-- NOTAS:
-- *como parametros se pide el numero de identificacion o matricula del cliente (enrolment) para despues hacer
--  la consulta y verificar si existe el cliente en la DB y asi retornar un verdadero o falso (1 o 0).
-- *ademas se inserta la visita individual del cliente en la DB y si se llama el procedimiento almacenado para 
-- insertar la visita general (solo si este no ha entrado con anterioridad) 
-- -----------------------------------------------------
DELIMITER //

CREATE  FUNCTION `validate_Client`(`enrolment` VARCHAR(10)) RETURNS tinyint(1)
BEGIN
	#Declaracion de las variables a utilizar
	DECLARE `identification` VARCHAR(10);
	DECLARE `client_id` INT;
	DECLARE `access` VARCHAR(1);
    DECLARE `bloqueado` int(1);
    #Asignacion de las consultas a las variables
	SET `identification`= (SELECT `identification_Number` FROM `client` WHERE `identification_Number`= `enrolment`);
	SET `client_id` = (SELECT `id` FROM `client` WHERE `identification_Number`= `enrolment`);
    SET `bloqueado` = (SELECT `status_People_id` FROM `client` WHERE `identification_Number`= `enrolment`);
	#Condicion para saber si coinciden las matriculas
    IF `identification` = `enrolment` and `bloqueado` = 1
		THEN 
		SET `access` = TRUE;
        #Se inserta la visita individual del cliente
		INSERT INTO `visit_client` VALUES(DEFAULT,`client_id`,`enrolment`,NOW());
		#Se manda llamar al procedimiento para insertar la visita en el area que le corresponde 
        CALL `visits_Update`(`enrolment`);
	ELSE 
		SET `access` = FALSE;
	END IF;
    #Devuelve un 0 o 1 (verdadero o false) dependiendo del resultado de la condicion
	RETURN `access`;
END

DELIMITER ;

/* Aqui finalizan las Funciones */


/* Creacion de Procedimientos almacenados */

-- -----------------------------------------------------
-- Procedimiento visits_Update
-- Este se encarga de actualizar el registro de las vsitas generales del dia 
-- NOTAS:
-- *Si el usuario entro anteriormente ya no contara la visita
-- *Se pide la el numero de indentificacion o matricula (enrolment) para asi hacer una consulta y poder saber si esa
-- persona ya habia entrado o no
-- *Si es la primera vez que entra el cliente se procede a obtener el area del que procede y con un comodin (LIKE)
--  se hacen las comparaciones dentro de un CASE para asi poder hacer el incremento de las visitas en el area que
--  corresponda
-- *Al finalizar esto se actualiza el campo already_Entered del cliente para que asi despues ya no cuente su ingreso
-- -----------------------------------------------------
DELIMITER //
CREATE PROCEDURE `visits_Update` (IN `enrolment` VARCHAR(10))
BEGIN
	#Variables a utilizar
	DECLARE `is_already_entered` ENUM('true','false');
    DECLARE `area_client` VARCHAR (100);
    DECLARE `max_id` INT;
    #Se inicializa en falso
    SET `is_already_entered` = 'false';
    #Obtiene el dato de si ya entro el cliente
    SET `is_already_entered` = (SELECT `already_Entered` FROM `client` WHERE `identification_Number`=`enrolment`);
    #Verifica si es la primera vez que entra
    IF `is_already_entered` = 'false' THEN
        #Obtiene el area del cliente que entrara
        SET `area_client` =  (SELECT `area` FROM `client` WHERE `identification_Number`=`enrolment`);
		#Ultimo registro
        SET `max_id` = (SELECT MAX(`id`) FROM `visits`);
        #Empieza esl CASE para hacer la busqueda don el comidin
        CASE
			#Conteo de Biomedica
            WHEN (`area_client` LIKE '%BIOMEDICA%' OR `area_client` LIKE '%BIOINGENIERIA%' ) THEN
				UPDATE `visits` SET `ingenieria_Biomedica`=`ingenieria_Biomedica`+1 WHERE `id` = `max_id`;
			#Conteo de Biotecnologia
            WHEN (`area_client` LIKE '%INGENIERIA%' AND `area_client` LIKE '%BIOTECNOLOGIA%') THEN
				UPDATE `visits` SET `ingenieria_Biotecnologia`=`ingenieria_Biotecnologia`+1 WHERE `id` = `max_id`;
			#Conteo de Software
            WHEN (`area_client` LIKE '%SOFTWARE%') THEN
				UPDATE `visits` SET `ingenieria_Software`=`ingenieria_Software`+1 WHERE `id` = `max_id`;
			#Conteo de Telematica
            WHEN (`area_client` LIKE '%TELEMATICA%') THEN
				UPDATE `visits` SET `ingenieria_Telematica`=`ingenieria_Telematica`+1 WHERE `id` = `max_id`;
			#Conteo de Financiera
            WHEN (`area_client` LIKE '%FINANCIERA%') THEN
				UPDATE `visits` SET `ingenieria_Financiera`=`ingenieria_Financiera`+1 WHERE `id` = `max_id`;
			#Conteo de Automotriz
            WHEN (`area_client` LIKE '%AUTOMOTRIZ%') THEN
				UPDATE `visits` SET `ingenieria_Automotriz`=`ingenieria_Automotriz`+1 WHERE `id` = `max_id`;
			#Conteo de Mecatronica
            WHEN (`area_client` LIKE '%INGENIERIA%' AND `area_client` LIKE '%MECATRONICA%' ) THEN
				UPDATE `visits` SET `ingenieria_Mecatronica`=`ingenieria_Mecatronica`+1 WHERE `id` = `max_id`;
			#Conteo de Medico
            WHEN (`area_client` LIKE '%CIRUJANO%') THEN
				UPDATE `visits` SET `licenciatura_Medico`=`licenciatura_Medico`+1 WHERE `id` = `max_id`;
			#Conteo de Teraia
            WHEN (`area_client` LIKE '%TERAPIA%') THEN
				UPDATE `visits` SET `licenciatura_Terapia`=`licenciatura_Terapia`+1 WHERE `id` = `max_id`;
			#Conteo de Maestria_Biotecnologia
            WHEN (`area_client` LIKE '%MAESTRIA%' AND `area_client` LIKE '%BIOTECNOLOGIA%' ) THEN
				UPDATE `visits` SET `maestria_Biotecnologia`=`maestria_Biotecnologia`+1 WHERE `id` = `max_id`;
			#Conteo de Maestia_Ciencias
            WHEN (`area_client` LIKE '%ENSEÑANZA%') THEN
				UPDATE `visits` SET `maestria_Ciencias`=`maestria_Ciencias`+1 WHERE `id` = `max_id`;
			#Conteo de Maestria_Mecatronica
            WHEN (`area_client` LIKE '%MAESTRIA%' AND `area_client` LIKE '%MECATRONICA%') THEN
				UPDATE `visits` SET `maestria_Mecatronica`=`maestria_Mecatronica`+1 WHERE `id` = `max_id`;
			#Conteo de Maestria_Tics
			WHEN (`area_client` LIKE '%COMUNICACIONES%') THEN
				UPDATE `visits` SET `maestria_Tics`=`maestria_Tics`+1 WHERE `id` = `max_id`;
			#Conteo de Doctorado_Biotecnologia
            WHEN (`area_client` LIKE '%DOCTORADO%' AND `area_client` LIKE '%BIOTECNOLOGIA%') THEN
				UPDATE `visits` SET `doctorado_Biotecnologia`=`doctorado_Biotecnologia`+1 WHERE `id` = `max_id`;
			#Conteo de Especialidad_Biotecnologia
            WHEN (`area_client` LIKE '%AMBIENTAL%') THEN
				UPDATE `visits` SET `especialidad_Biotecnologia`=`especialidad_Biotecnologia`+1 WHERE `id` = `max_id`;
			#Conteo de Especialidad_Mecatronica
            WHEN (`area_client` LIKE '%MECATRONICA%' AND (`area_client` NOT LIKE '%INGENIERIA%' OR `area_client` NOT LIKE '%MAESTRIA%')) THEN
				UPDATE `visits` SET `especialidad_Mecatronica`=`especialidad_Mecatronica`+1 WHERE `id` = `max_id`;
			#Conteo de Especialidad_Seguridad
            WHEN (`area_client` LIKE '%SEGURIDAD%') THEN
				UPDATE `visits` SET `especialidad_Seguridad`=`especialidad_Seguridad`+1 WHERE `id` = `max_id`;
			#Si no esalguno de los anteriores significa que es un administrativo
            ELSE 
				UPDATE `visits` SET `administrativos`=`administrativos`+1 WHERE `id` = `max_id`;				
        END CASE; 
        
        #Suma total de entradas por dia
        UPDATE `visits` SET `visits_Number` = (
			`ingenieria_Biomedica` +
			`ingenieria_Biotecnologia` +
			`ingenieria_Software` +
			`ingenieria_Telematica` +
			`ingenieria_Financiera` +
			`ingenieria_Automotriz` +
			`ingenieria_Mecatronica` +
			`licenciatura_Medico` +
			`licenciatura_Terapia` +
			`maestria_Biotecnologia` +
			`maestria_Ciencias` +
			`maestria_Mecatronica` +
			`maestria_Tics` +
			`doctorado_Biotecnologia` +
			`especialidad_Biotecnologia` +
			`especialidad_Mecatronica` +
			`especialidad_Seguridad` +
			`administrativos`
        ) WHERE `id` = `max_id`;  
        
        #Actualizar estado de entrada del cliente 
        SET `SQL_SAFE_UPDATES` = 0;
        UPDATE `client` SET `already_Entered`=true WHERE `identification_Number`=`enrolment`;
        SET `SQL_SAFE_UPDATES` = 1;
    END IF;
END //
DELIMITER ;

/* Aqui finalizan los procedimientos almacenados */


/* Creacion de Funciones */

#Se activa la opcion de generar eventos en MySQL
SET GLOBAL `event_scheduler` = ON;

-- -----------------------------------------------------
-- Evento insert_Day
-- Este nos peritira insertar cada dia un registro para poder tener el contador de cauntos alumnos entran cada dia
-- NOTAS:
-- *Cambiar NOW() por la fecha en que se lanzara por primera vez el programa para que desde ahi tenga el dia del primer
-- reporte
-- -----------------------------------------------------
DELIMITER //
CREATE EVENT `insert_Day` #creamos el evento insertar dia
	ON SCHEDULE #en la fecha prevista
	EVERY 1 DAY #cada dia
    STARTS NOW()
	ON COMPLETION NOT PRESERVE ENABLE 
    DO #hacer
    BEGIN #iniciar lo que se hara
		INSERT INTO `visits` VALUES (DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,NOW()); #insertamos un nuevo registro
		SET `sql_safe_updates` = 0; #desactivamos la actualización segura para que nos permita actualizar todos los alumnos
		UPDATE `client` set `already_Entered` = 'false'; #actualizamos el valor de a entrado a falso
		SET `sql_safe_updates` = 1; #activamos la actualización segura
	END // #terminamos el evento
DELIMITER ;

/* Aqui finaliza la creacion de Eventos*/






