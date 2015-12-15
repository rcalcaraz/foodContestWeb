-- MySQL Script generated by MySQL Workbench
-- Mon Nov  9 19:45:23 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema clickapincho
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clickapincho
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clickapincho` DEFAULT CHARACTER SET utf32 ;
USE `clickapincho` ;

GRANT ALL PRIVILEGES ON clickapincho.* TO 'admin'@'localhost' IDENTIFIED by 'admin';

/*
grant all privileges on clickapincho.* to root@localhost identified by "root";
*/

-- -----------------------------------------------------
-- Table `clickapincho`.`concurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`concurso` (
  `idconcurso` INT(1) NOT NULL AUTO_INCREMENT,
  `comienzovotacion` DATE NOT NULL,
  `finalvotacionpopular` DATE NOT NULL,
  `finalvotacionprofesional` DATE NOT NULL,
  `comienzovotacionfinalistas` DATE NOT NULL,
  `finalvotacionfinalistas` DATE NOT NULL,
  `folleto` VARCHAR(100) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `elegidosfinalistas` INT(1) NOT NULL DEFAULT 0,  
  `repartidospinchos` INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idconcurso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`administrador` (
  `idadministrador` INT(2) NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(10) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `concurso_idconcurso` INT(1) NOT NULL,
  PRIMARY KEY (`idadministrador`),
  UNIQUE INDEX `idadministrador_UNIQUE` (`idadministrador` ASC),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  INDEX `fk_administrador_concurso1_idx` (`concurso_idconcurso` ASC),
  CONSTRAINT `fk_administrador_concurso1`
    FOREIGN KEY (`concurso_idconcurso`)
    REFERENCES `clickapincho`.`concurso` (`idconcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`establecimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`establecimiento` (
  `idestablecimiento` INT(4) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` VARCHAR(255) COLLATE utf8_spanish_ci NOT NULL,
  `localizacion` VARCHAR(50) NOT NULL,
  `confirmado` INT(1) NOT NULL DEFAULT 0,
  `descripcion` LONGTEXT COLLATE utf8_spanish_ci NOT NULL,
  `login` VARCHAR(10) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `concurso_idconcurso` INT(1) NOT NULL,
  `administrador_idadministrador` INT(2) NOT NULL,
  PRIMARY KEY (`idestablecimiento`),
  UNIQUE INDEX `idestablecimiento_UNIQUE` (`idestablecimiento` ASC),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC),
  INDEX `fk_establecimiento_administrador1_idx` (`administrador_idadministrador` ASC),
  INDEX `fk_establecimiento_concurso_idx` (`concurso_idconcurso` ASC),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  CONSTRAINT `fk_establecimiento_concurso`
    FOREIGN KEY (`concurso_idconcurso`)
    REFERENCES `clickapincho`.`concurso` (`idconcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_establecimiento_administrador1`
    FOREIGN KEY (`administrador_idadministrador`)
    REFERENCES `clickapincho`.`administrador` (`idadministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`juradopopular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`juradopopular` (
  `idjuradopopular` INT(7) NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(10) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `concurso_idconcurso` INT(1) NOT NULL,
  PRIMARY KEY (`idjuradopopular`),
  UNIQUE INDEX `idjuradopopular_UNIQUE` (`idjuradopopular` ASC),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_juradopopular_concurso1_idx` (`concurso_idconcurso` ASC),
  CONSTRAINT `fk_juradopopular_concurso1`
    FOREIGN KEY (`concurso_idconcurso`)
    REFERENCES `clickapincho`.`concurso` (`idconcurso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`juradoprofesional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`juradoprofesional` (
  `idjuradoprofesional` INT(4) NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(45) COLLATE utf8_spanish_ci NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `foto` VARCHAR(100) NOT NULL,
  `descripcion` LONGTEXT COLLATE utf8_spanish_ci NULL,
  `telefono` VARCHAR(20) NULL,
  `concurso_idconcurso` INT(1) NOT NULL,
  `administrador_idadministrador` INT(2) NOT NULL,
  PRIMARY KEY (`idjuradoprofesional`),
  UNIQUE INDEX `idjuradoprofesional_UNIQUE` (`idjuradoprofesional` ASC),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC),
  INDEX `fk_juradoprofesional_concurso1_idx` (`concurso_idconcurso` ASC),
  INDEX `fk_juradoprofesional_administrador1_idx` (`administrador_idadministrador` ASC),
  CONSTRAINT `fk_juradoprofesional_concurso1`
    FOREIGN KEY (`concurso_idconcurso`)
    REFERENCES `clickapincho`.`concurso` (`idconcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_juradoprofesional_administrador1`
    FOREIGN KEY (`administrador_idadministrador`)
    REFERENCES `clickapincho`.`administrador` (`idadministrador`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`pincho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`pincho` (
  `idpincho` INT(4) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) COLLATE utf8_spanish_ci NOT NULL,
  `precio` DECIMAL(3,2) NOT NULL,
  `foto` VARCHAR(100) NOT NULL,
  `finalista` INT(1) NOT NULL DEFAULT 0,
  `establecimiento_idestablecimiento` INT(4) NOT NULL,
  PRIMARY KEY (`idpincho`),
  UNIQUE INDEX `idpincho_UNIQUE` (`idpincho` ASC),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC),
  INDEX `fk_pincho_establecimiento1_idx` (`establecimiento_idestablecimiento` ASC),
  CONSTRAINT `fk_pincho_establecimiento1`
    FOREIGN KEY (`establecimiento_idestablecimiento`)
    REFERENCES `clickapincho`.`establecimiento` (`idestablecimiento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`codigo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`codigo` (
  `idcodigo` VARCHAR(10) NOT NULL,
  `pincho_idpincho` INT(4) NOT NULL,
  PRIMARY KEY (`idcodigo`),
  UNIQUE INDEX `idcodigo_UNIQUE` (`idcodigo` ASC),
  INDEX `fk_codigo_pincho1_idx` (`pincho_idpincho` ASC),
  CONSTRAINT `fk_codigo_pincho1`
    FOREIGN KEY (`pincho_idpincho`)
    REFERENCES `clickapincho`.`pincho` (`idpincho`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`votacionpopular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`votacionpopular` (
  `juradopopular_idjuradopopular` INT(7) NOT NULL,
  `pincho_idpincho` INT(4) NOT NULL,
  `codigo_idcodigo` VARCHAR(10) NOT NULL,
  `votado` INT(1) NOT NULL,
  INDEX `fk_votacionpopular_juradopopular1_idx` (`juradopopular_idjuradopopular` ASC),
  INDEX `fk_votacionpopular_pincho1_idx` (`pincho_idpincho` ASC),
  PRIMARY KEY (`juradopopular_idjuradopopular`, `pincho_idpincho`, `codigo_idcodigo`),
  INDEX `fk_votacionpopular_codigo1_idx` (`codigo_idcodigo` ASC),
  CONSTRAINT `fk_votacionpopular_juradopopular1`
    FOREIGN KEY (`juradopopular_idjuradopopular`)
    REFERENCES `clickapincho`.`juradopopular` (`idjuradopopular`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_votacionpopular_pincho1`
    FOREIGN KEY (`pincho_idpincho`)
    REFERENCES `clickapincho`.`pincho` (`idpincho`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`votacionprofesional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`votacionprofesional` (
  `votacionfinalista` INT(1) NOT NULL,
  `notavotoprofesional` INT(1) NULL,
  `pincho_idpincho` INT(4) NOT NULL,
  `juradoprofesional_idjuradoprofesional` INT(4) NOT NULL,
  INDEX `fk_votacionprofesional_pincho1_idx` (`pincho_idpincho` ASC),
  INDEX `fk_votacionprofesional_juradoprofesional1_idx` (`juradoprofesional_idjuradoprofesional` ASC),
  PRIMARY KEY (`juradoprofesional_idjuradoprofesional`, `votacionfinalista`, `pincho_idpincho`),
  CONSTRAINT `fk_votacionprofesional_pincho1`
    FOREIGN KEY (`pincho_idpincho`)
    REFERENCES `clickapincho`.`pincho` (`idpincho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_votacionprofesional_juradoprofesional1`
    FOREIGN KEY (`juradoprofesional_idjuradoprofesional`)
    REFERENCES `clickapincho`.`juradoprofesional` (`idjuradoprofesional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`enlace`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`enlace` (
  `idenlace` INT(5) NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(255) NULL,
  `establecimiento_idestablecimiento` INT(4) NOT NULL,
  PRIMARY KEY (`idenlace`),
  UNIQUE INDEX `idenlace_UNIQUE` (`idenlace` ASC),
  INDEX `fk_enlace_establecimiento1_idx` (`establecimiento_idestablecimiento` ASC),
  CONSTRAINT `fk_enlace_establecimiento1`
    FOREIGN KEY (`establecimiento_idestablecimiento`)
    REFERENCES `clickapincho`.`establecimiento` (`idestablecimiento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`ingrediente` (
  `idingrediente` INT(5) COLLATE utf8_spanish_ci NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idingrediente`),
  UNIQUE INDEX `idingrediente_UNIQUE` (`idingrediente` ASC),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`alergeno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`alergeno` (
  `idalergeno` INT(2) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(40) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idalergeno`),
  UNIQUE INDEX `idalergeno_UNIQUE` (`idalergeno` ASC),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`ingrediente_has_alergeno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`ingrediente_has_alergeno` (
  `ingrediente_idingrediente` INT(5) NOT NULL,
  `alergeno_idalergeno` INT(2) NOT NULL,
  PRIMARY KEY (`ingrediente_idingrediente`, `alergeno_idalergeno`),
  INDEX `fk_ingrediente_has_alergeno_alergeno1_idx` (`alergeno_idalergeno` ASC),
  INDEX `fk_ingrediente_has_alergeno_ingrediente1_idx` (`ingrediente_idingrediente` ASC),
  CONSTRAINT `fk_ingrediente_has_alergeno_ingrediente1`
    FOREIGN KEY (`ingrediente_idingrediente`)
    REFERENCES `clickapincho`.`ingrediente` (`idingrediente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ingrediente_has_alergeno_alergeno1`
    FOREIGN KEY (`alergeno_idalergeno`)
    REFERENCES `clickapincho`.`alergeno` (`idalergeno`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clickapincho`.`pincho_has_ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clickapincho`.`pincho_has_ingrediente` (
  `ingrediente_idingrediente` INT(5) NOT NULL,
  `pincho_idpincho` INT(4) NOT NULL,
  PRIMARY KEY (`ingrediente_idingrediente`, `pincho_idpincho`),
  INDEX `fk_ingrediente_has_pincho_pincho1_idx` (`pincho_idpincho` ASC),
  INDEX `fk_ingrediente_has_pincho_ingrediente1_idx` (`ingrediente_idingrediente` ASC),
  CONSTRAINT `fk_ingrediente_has_pincho_ingrediente1`
    FOREIGN KEY (`ingrediente_idingrediente`)
    REFERENCES `clickapincho`.`ingrediente` (`idingrediente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ingrediente_has_pincho_pincho1`
    FOREIGN KEY (`pincho_idpincho`)
    REFERENCES `clickapincho`.`pincho` (`idpincho`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data
-- -----------------------------------------------------


/*
INSERT INTO concurso (comienzovotacion,finalvotacionpopular,finalvotacionprofesional,comienzovotacionfinalistas,finalvotacionfinalistas,folleto,nombre) VALUES ("2015-12-18 00:48:38","2016-08-09 16:04:26","2016-08-11 09:53:59","2016-09-20 05:51:34","2015-04-04 06:43:12","ENE38VDU5LI","Donovan");

INSERT INTO administrador (login,password,concurso_idconcurso) VALUES ("Admin","AdminPass",1);


INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Natoque Penatibus Incorporated","3285 Nibh. C/","74.19341, 3.54347","1","2","cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Tempus Corporation","Apdo.:562-3038 Velit. Ctra.","18.9677, 162.78146","1","2","justo. Proin non massa non ante bibendum ullamcorper. Duis cursus, diam at pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor dolor, tempus non, lacinia at, iaculis quis,");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Lorem Sit Amet Incorporated","3798 Proin C.","-76.85494, 131.20926","1","2","gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac mattis velit justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Arcu Sed Inc.","Apdo.:953-6044 Sit Av.","4.73321, -147.02192","1","2","elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Vitae Corporation","Apartado núm.: 176, 8162 Justo. Avenida","-81.27231, 142.99757","1","2","Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Lacinia At Institute","803-2399 Purus C.","43.69576, -93.93808","1","2","sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit,");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Semper Pretium Company","456-6921 Mauris Avenida","-83.97377, 112.82996","1","2","et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Urna Institute","Apdo.:111-3102 Montes, Calle","-74.39228, 136.71114","1","2","elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu");

INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Delicia deliciosa","2.5","CCR17GSE6XM","1");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Puntillas con N","3.3","KYF18RQX4KW","2");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Atun con pan","3.25","PXF31UUN2YK","3");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Bomba de berberecho","2","CQB99SSY8QT","4");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Chistorra de chiste","1.5","MNF78XJW3EH","5");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Cacahuetes majetes","2","UHS27HOT2MU","6");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Rabo de toro","3.5","XML74FQJ9CC","7");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Solomillo de cerda","4.2","XML74FQJ9CC","8");

-- concurso
INSERT INTO `concurso` (`comienzovotacion`,`finalvotacionpopular`,`finalvotacionprofesional`,`comienzovotacionfinalistas`,`finalvotacionfinalistas`,`folleto`,`nombre`) VALUES ("2015-11-26 17:01:02","2015-12-22 20:44:33","2015-11-17 14:59:02","2016-01-24 18:07:43","2016-02-27 18:34:22","DHB31QMH2AM","imperdiet");

-- administrador
INSERT INTO `administrador` (`login`,`password`,`concurso_idconcurso`) VALUES ("Ray","UCM93HXL7MQ",0);

-- establecimiento
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Natoque Penatibus Incorporated","3285 Nibh. C/","74.19341, 3.54347","1","1","cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Tempus Corporation","Apdo.:562-3038 Velit. Ctra.","18.9677, 162.78146","1","1","justo. Proin non massa non ante bibendum ullamcorper. Duis cursus, diam at pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor dolor, tempus non, lacinia at, iaculis quis,");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Lorem Sit Amet Incorporated","3798 Proin C.","-76.85494, 131.20926","1","1","gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac mattis velit justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Arcu Sed Inc.","Apdo.:953-6044 Sit Av.","4.73321, -147.02192","1","1","elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Vitae Corporation","Apartado núm.: 176, 8162 Justo. Avenida","-81.27231, 142.99757","1","1","Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Lacinia At Institute","803-2399 Purus C.","43.69576, -93.93808","1","1","sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit,");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Semper Pretium Company","456-6921 Mauris Avenida","-83.97377, 112.82996","1","1","et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris");
INSERT INTO `establecimiento` (`nombre`,`direccion`,`localizacion`,`concurso_idconcurso`,`administrador_idadministrador`,`descripcion`) VALUES ("Urna Institute","Apdo.:111-3102 Montes, Calle","-74.39228, 136.71114","1","1","elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu");

-- juradopopular
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Zahir","tempor.arcu.Vestibulum@penatibusetmagnis.com","MAS03AUA6RQ","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Neville","ultrices.mauris@elit.co.uk","RCK04USI9LX","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Lillian","neque.sed@lectus.ca","DWR53FDR5HF","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Dylan","ultricies@risus.co.uk","RFT14YAX5XE","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Yen","mauris.sit@purusgravidasagittis.ca","WPH86SDB7MJ","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Buffy","luctus@sagittisDuis.ca","XVY73WIK3QD","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Lunea","nec.imperdiet.nec@Nullamenim.ca","FMQ23CDA9LK","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Igor","amet@nonummyut.edu","FMA57HTG4FT","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Laura","Donec.non@iaculisenimsit.co.uk","KJS58TBC4LP","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Kiara","semper@Innecorci.com","DRY40YBJ1ZY","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Julie","in@montesnasceturridiculus.co.uk","BHG20PIO7RN","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Macaulay","tincidunt.dui@libero.net","BMF68ZBP2KC","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Aimee","egestas@euenim.org","FIZ92OTW8WT","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Quynn","vulputate@lectus.edu","BUW78KSG4GB","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Sigourney","feugiat@ligulaAliquam.edu","YTC94GHJ7JT","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Uma","neque@Mauris.edu","GSB91MOL0IW","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Jade","congue@Integer.edu","UZC89PHU1JX","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Raphael","Nullam.vitae@ultriciesadipiscing.co.uk","VFP91TEX9CO","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Zachery","taciti@aliquetvelvulputate.co.uk","NRW61DHK7LO","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Thor","Vivamus.rhoncus.Donec@erategetipsum.org","LUV26MAD9AU","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Evangeline","ut@venenatislacusEtiam.org","JMW18QQV3TI","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Daria","tristique@sitametmetus.co.uk","XBQ14TVK3RQ","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Charissa","Mauris.molestie.pharetra@acmattisornare.org","EFN77KSQ9UK","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Judah","amet.dapibus.id@arcuVestibulum.ca","CTG27YDA3MY","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Allen","Suspendisse.aliquet.sem@loremtristique.edu","JOH74BHQ6BX","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Kaye","orci.Phasellus.dapibus@fringillami.ca","KLC51ORW5SU","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Kellie","tristique.pellentesque@est.com","FNX44YSJ1GT","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Galvin","arcu.Vestibulum@nislMaecenasmalesuada.org","FRV31FIL4ON","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Declan","mauris@loremvitae.co.uk","QMW72DDA5FC","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Sopoline","rutrum.magna.Cras@Morbi.co.uk","VGZ32YLX1WL","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Aphrodite","tempor.est@adipiscing.org","FDV74CMV2GM","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Samson","accumsan@DonecnibhQuisque.com","DDR54CCR5QG","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Flavia","ipsum@diamDuismi.edu","QJQ38XDI6VG","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Uriel","hymenaeos.Mauris@vulputate.com","JOJ76KLP6ST","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Adam","a.enim@purus.com","VTD30KJK2UO","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Carolyn","ipsum@magnaDuis.edu","FVL48HER4GM","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Michelle","Fusce.dolor@mollislectus.net","JQQ96LGJ5BM","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Wyoming","mollis.Integer@infaucibus.org","FBI83FJJ4RL","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Desiree","eget.massa.Suspendisse@pede.com","KFD32WJD6GS","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Zelda","convallis@enimEtiam.co.uk","TCR79RMX0IB","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Karyn","Curabitur.vel.lectus@noncursusnon.com","LUS61KTN4EO","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Stuart","parturient.montes.nascetur@nec.net","ZRP00DUK1XJ","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Winifred","aliquet@loremfringilla.co.uk","IGT74HRA7TU","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Dora","purus@laciniaatiaculis.net","VQS00RJL6AS","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Jada","leo@velitCras.ca","RFH72CMP0ZR","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Quemby","sed@temporarcu.co.uk","XFD30TOZ1AW","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Jin","consectetuer.adipiscing@tinciduntdui.com","WPA93YNH1KJ","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Eve","Mauris.vestibulum.neque@Fuscefermentum.com","JRQ20EXH6RD","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Benjamin","leo.elementum.sem@ut.ca","NAV61RQM4PV","1");
INSERT INTO `juradopopular` (`usuario`,`email`,`password`,`concurso_idconcurso`) VALUES ("Cathleen","tellus.justo@vitaealiquam.net","VDW64NVH6KC","1");

-- juradoprofesional
INSERT INTO `juradoprofesional` (`usuario`,`nombre`,`email`,`password`,`foto`,`descripcion`,`telefono`,`concurso_idconcurso`,`administrador_idadministrador`) VALUES ("Lance","Keiko","nisi@tincidunt.ca","YII10MEZ1QG","TSO04YLF5AB","Phasellus dolor elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim diam vel","05 03 88 06 15","1","1");
INSERT INTO `juradoprofesional` (`usuario`,`nombre`,`email`,`password`,`foto`,`descripcion`,`telefono`,`concurso_idconcurso`,`administrador_idadministrador`) VALUES ("Dillon","Neil","sem.Pellentesque@anunc.net","ZVD85SRO9KU","MZE41YRI0JM","lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit","01 40 59 66 17","1","1");
INSERT INTO `juradoprofesional` (`usuario`,`nombre`,`email`,`password`,`foto`,`descripcion`,`telefono`,`concurso_idconcurso`,`administrador_idadministrador`) VALUES ("Ethan","Kasimir","pede.ultrices@urna.ca","HOP52ZLD5QO","MGR97GYE5UT","nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec dignissim magna","06 54 59 46 74","1","1");
INSERT INTO `juradoprofesional` (`usuario`,`nombre`,`email`,`password`,`foto`,`descripcion`,`telefono`,`concurso_idconcurso`,`administrador_idadministrador`) VALUES ("Damon","Janna","Donec@et.org","JDT11YNN0RS","XPN45FRP3KI","Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas, urna justo faucibus lectus, a sollicitudin orci sem eget","04 41 94 47 79","1","1");
INSERT INTO `juradoprofesional` (`usuario`,`nombre`,`email`,`password`,`foto`,`descripcion`,`telefono`,`concurso_idconcurso`,`administrador_idadministrador`) VALUES ("Courtney","Ivan","sapien.Aenean.massa@egetmagna.org","HIH38SHI8KS","IFR94AEK5YA","vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate eu, odio. Phasellus at augue","01 56 93 15 45","1","1");
INSERT INTO `juradoprofesional` (`usuario`,`nombre`,`email`,`password`,`foto`,`descripcion`,`telefono`,`concurso_idconcurso`,`administrador_idadministrador`) VALUES ("Cailin","Kieran","sem.elit.pharetra@Vivamuseuismod.ca","KYQ81XAG6XA","HTP87HFO9CG","ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor eros nec tellus. Nunc lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing","04 35 40 45 28","1","1");
INSERT INTO `juradoprofesional` (`usuario`,`nombre`,`email`,`password`,`foto`,`descripcion`,`telefono`,`concurso_idconcurso`,`administrador_idadministrador`) VALUES ("Summer","Kameko","nonummy.ipsum@ipsumdolor.com","HGT16QQS8HJ","BKE60DPH8TI","nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum","02 66 10 06 97","1","1");
INSERT INTO `juradoprofesional` (`usuario`,`nombre`,`email`,`password`,`foto`,`descripcion`,`telefono`,`concurso_idconcurso`,`administrador_idadministrador`) VALUES ("Caesar","Denton","pellentesque.massa.lobortis@facilisiseget.org","ZAX22QIH3FH","VPV21HUW2MK","senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci.","09 28 11 06 59","1","1");

-- pincho 
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Delicia deliciosa","1","CCR17GSE6XM","1");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Puntillas con N","8","KYF18RQX4KW","2");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Atun con pan","6","PXF31UUN2YK","3");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Bomba de berberecho","9","CQB99SSY8QT","4");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Chistorra de chiste","0","MNF78XJW3EH","5");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Cacahuetes majetes","8","UHS27HOT2MU","6");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Rabo de toro","6","XML74FQJ9CC","7");
INSERT INTO `pincho` (`nombre`,`precio`,`foto`,`establecimiento_idestablecimiento`) VALUES ("Solomillo de cerda","6","XML74FQJ9CC","8");
*/

