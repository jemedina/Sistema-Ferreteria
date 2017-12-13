-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-12-2017 a las 06:41:38
-- Versión del servidor: 10.1.28-MariaDB
-- Versión de PHP: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_ferreteria`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_ventas_por_fecha` (IN `f` DATE)  begin
		SELECT venta.*,empleado.nombre FROM venta,empleado WHERE venta.id_empleado = empleado.id_empleado and venta.fecha = f;
	end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ultimo_no_venta` ()  begin
	set @no_venta = (Select count(no_venta) as cont from venta where fecha=curdate());
	select @no_venta as no_venta;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `abono_ferre`
--

CREATE TABLE `abono_ferre` (
  `no_mov` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `no_cta` int(11) NOT NULL,
  `monto` float NOT NULL,
  `no_folio` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `abono_prov`
--

CREATE TABLE `abono_prov` (
  `no_mov` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `no_cta` int(11) NOT NULL,
  `monto` float NOT NULL,
  `no_folio` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja`
--

CREATE TABLE `caja` (
  `no_caja` int(11) NOT NULL,
  `no_seccion` int(11) NOT NULL,
  `no_estante` int(11) NOT NULL,
  `nivel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `caja`
--

INSERT INTO `caja` (`no_caja`, `no_seccion`, `no_estante`, `nivel`) VALUES
(1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo_ferre`
--

CREATE TABLE `cargo_ferre` (
  `no_mov` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `no_cta` int(11) NOT NULL,
  `no_folio` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo_prov`
--

CREATE TABLE `cargo_prov` (
  `no_mov` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `no_cta` int(11) NOT NULL,
  `no_folio` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo`
--

CREATE TABLE `catalogo` (
  `no_catalogo` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `id_prov` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `catalogo`
--

INSERT INTO `catalogo` (`no_catalogo`, `anio`, `nombre`, `id_prov`) VALUES
(123, 2017, 'pruebita', '9090');

--
-- Disparadores `catalogo`
--
DELIMITER $$
CREATE TRIGGER `delete_producto_on_delete_catalogo` BEFORE DELETE ON `catalogo` FOR EACH ROW begin
		delete from producto where no_catalogo = OLD.no_catalogo;
	end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `RFC` varchar(13) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `a_paterno` varchar(20) DEFAULT NULL,
  `a_materno` varchar(20) DEFAULT NULL,
  `correo` varchar(20) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `calle` varchar(40) DEFAULT NULL,
  `colonia` varchar(40) DEFAULT NULL,
  `num_domicilio_int` varchar(5) DEFAULT NULL,
  `num_domicilio_ext` varchar(5) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `cve_mun` varchar(3) NOT NULL,
  `cve_ent` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`RFC`, `nombre`, `a_paterno`, `a_materno`, `correo`, `telefono`, `calle`, `colonia`, `num_domicilio_int`, `num_domicilio_ext`, `cp`, `cve_mun`, `cve_ent`) VALUES
('123', 'johny', 'bravo', 'test', 'test@yo.com', 'test', 'et', 't', 't', 't', 'ewe', '001', '01'),
('qa', 'qa', 'qa', 'qa', 'qa@qa', 'qa', 'qa', 'qa', 'qa', 'qa', 'qa', '014', '22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobante`
--

CREATE TABLE `comprobante` (
  `no_folio` varchar(20) NOT NULL,
  `no_venta` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cta_credito_ferre`
--

CREATE TABLE `cta_credito_ferre` (
  `no_cta` int(11) NOT NULL,
  `RFC` varchar(13) NOT NULL,
  `saldo` float NOT NULL,
  `dias_pago` varchar(20) NOT NULL,
  `limite_credito` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cta_credito_prov`
--

CREATE TABLE `cta_credito_prov` (
  `no_cta` int(11) NOT NULL,
  `id_prov` varchar(13) NOT NULL,
  `saldo` float NOT NULL,
  `dias_pago` varchar(60) NOT NULL,
  `limite_credito` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devolucion`
--

CREATE TABLE `devolucion` (
  `no_devolucion` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `no_venta` int(11) NOT NULL,
  `fecha_venta` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devolucion_producto`
--

CREATE TABLE `devolucion_producto` (
  `codigo` int(11) NOT NULL,
  `marca` varchar(40) NOT NULL,
  `no_devolucion` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `cantidad` float NOT NULL,
  `unidades` varchar(30) NOT NULL,
  `motivo` varchar(30) NOT NULL,
  `descripcion_motivo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `a_paterno` varchar(20) DEFAULT NULL,
  `a_materno` varchar(20) DEFAULT NULL,
  `correo` varchar(30) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `f_nac` date DEFAULT NULL,
  `f_ingreso` date DEFAULT NULL,
  `puesto` varchar(30) DEFAULT NULL,
  `calle` varchar(30) DEFAULT NULL,
  `colonia` varchar(30) DEFAULT NULL,
  `num_domicilio_int` varchar(5) DEFAULT NULL,
  `num_domicilio_ext` varchar(5) DEFAULT NULL,
  `cp` varchar(15) DEFAULT NULL,
  `cve_mun` varchar(3) NOT NULL,
  `cve_ent` varchar(2) NOT NULL,
  `pass` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_empleado`, `nombre`, `a_paterno`, `a_materno`, `correo`, `telefono`, `f_nac`, `f_ingreso`, `puesto`, `calle`, `colonia`, `num_domicilio_int`, `num_domicilio_ext`, `cp`, `cve_mun`, `cve_ent`, `pass`) VALUES
(0, 'ADMINISTRADOR', 'ADMINISTRADOR', 'ADMINISTRADOR', 'admin@gmail.com', 'ADMIN', '2017-11-01', '2017-11-01', 'ADMINISTRADOR', 'ADMINISTRADOR', 'ADMINISTRADOR', '22', '22', 'ADMINISTRADOR', '001', '01', 'hola'),
(1, 'admin', 'admin', 'admin', 'admin@admin.com', 'admin', '2017-11-01', '2017-11-01', 'ADMINISTRADOR', 'admin', 'admin', 'admin', 'admin', 'admin', '001', '01', 'admin'),
(2, 'ADMINISTRADOR', 'ADMINISTRADOR', 'ADMINISTRADOR', 'admin@gmail.com', 'ADMIN', '2017-11-01', '2017-11-01', 'ADMINISTRADOR', 'ADMINISTRADOR', 'ADMINISTRADOR', '22', '22', 'ADMINISTRADOR', '001', '01', 'hola');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entidad`
--

CREATE TABLE `entidad` (
  `cve_ent` varchar(2) NOT NULL,
  `nom_ent` varchar(50) NOT NULL,
  `nom_abr` varchar(10) NOT NULL,
  `fechaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_pais` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `entidad`
--

INSERT INTO `entidad` (`cve_ent`, `nom_ent`, `nom_abr`, `fechaModificacion`, `id_pais`) VALUES
('01', 'Aguascalientes', 'Ags.', '2017-10-17 15:54:55', 'MX'),
('02', 'Baja California', 'BC', '2017-10-17 15:54:56', 'MX'),
('03', 'Baja California Sur', 'BCS', '2017-10-17 15:54:56', 'MX'),
('04', 'Campeche', 'Camp.', '2017-10-17 15:54:56', 'MX'),
('05', 'Coahuila de Zaragoza', 'Coah.', '2017-10-17 15:54:56', 'MX'),
('06', 'Colima', 'Col.', '2017-10-17 15:54:56', 'MX'),
('07', 'Chiapas', 'Chis.', '2017-10-17 15:54:56', 'MX'),
('08', 'Chihuahua', 'Chih.', '2017-10-17 15:54:56', 'MX'),
('09', 'Distrito Federal', 'DF', '2017-10-17 15:54:56', 'MX'),
('10', 'Durango', 'Dgo.', '2017-10-17 15:54:56', 'MX'),
('11', 'Guanajuato', 'Gto.', '2017-10-17 15:54:56', 'MX'),
('12', 'Guerrero', 'Gro.', '2017-10-17 15:54:56', 'MX'),
('13', 'Hidalgo', 'Hgo.', '2017-10-17 15:54:56', 'MX'),
('14', 'Jalisco', 'Jal.', '2017-10-17 15:54:56', 'MX'),
('15', 'México', 'Mex.', '2017-10-17 15:54:56', 'MX'),
('16', 'Michoacán de Ocampo', 'Mich.', '2017-10-17 15:54:56', 'MX'),
('17', 'Morelos', 'Mor.', '2017-10-17 15:54:56', 'MX'),
('18', 'Nayarit', 'Nay.', '2017-10-17 15:54:56', 'MX'),
('19', 'Nuevo León', 'NL', '2017-10-17 15:54:56', 'MX'),
('20', 'Oaxaca', 'Oax.', '2017-10-17 15:54:56', 'MX'),
('21', 'Puebla', 'Pue.', '2017-10-17 15:54:56', 'MX'),
('22', 'Querétaro', 'Qro.', '2017-10-17 15:54:56', 'MX'),
('23', 'Quintana Roo', 'Q. Roo', '2017-10-17 15:54:56', 'MX'),
('24', 'San Luis Potosí', 'SLP', '2017-10-17 15:54:57', 'MX'),
('25', 'Sinaloa', 'Sin.', '2017-10-17 15:54:57', 'MX'),
('26', 'Sonora', 'Son.', '2017-10-17 15:54:57', 'MX'),
('27', 'Tabasco', 'Tab.', '2017-10-17 15:54:57', 'MX'),
('28', 'Tamaulipas', 'Tamps.', '2017-10-17 15:54:57', 'MX'),
('29', 'Tlaxcala', 'Tlax.', '2017-10-17 15:54:57', 'MX'),
('30', 'Veracruz de Ignacio de la Llave', 'Ver.', '2017-10-17 15:54:57', 'MX'),
('31', 'Yucatán', 'Yuc.', '2017-10-17 15:54:57', 'MX'),
('32', 'Zacatecas', 'Zac.', '2017-10-17 15:54:57', 'MX');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `no_folio` varchar(20) NOT NULL,
  `fecha_factura` date NOT NULL,
  `monto` float NOT NULL,
  `fecha_limite_pago` date DEFAULT NULL,
  `no_orden` int(11) NOT NULL,
  `fecha_orden` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historia_empleado`
--

CREATE TABLE `historia_empleado` (
  `id_empleado` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `descripcion_accion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipio`
--

CREATE TABLE `municipio` (
  `cve_mun` varchar(3) NOT NULL,
  `nom_mun` varchar(50) NOT NULL,
  `cve_cab` varchar(4) NOT NULL,
  `nom_cab` varchar(50) NOT NULL,
  `fechaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cve_ent` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `municipio`
--

INSERT INTO `municipio` (`cve_mun`, `nom_mun`, `cve_cab`, `nom_cab`, `fechaModificacion`, `cve_ent`) VALUES
('001', 'Aguascalientes', '0001', 'Aguascalientes', '2017-10-17 15:55:28', '01'),
('001', 'Ensenada', '0001', 'Ensenada', '2017-10-17 15:55:29', '02'),
('001', 'Comondú', '0001', 'Ciudad Constitución', '2017-10-17 15:55:29', '03'),
('001', 'Calkiní', '0001', 'Calkiní', '2017-10-17 15:55:29', '04'),
('001', 'Abasolo', '0001', 'Abasolo', '2017-10-17 15:55:30', '05'),
('001', 'Armería', '0001', 'Ciudad de Armería', '2017-10-17 15:55:31', '06'),
('001', 'Acacoyagua', '0001', 'Acacoyagua', '2017-10-17 15:55:31', '07'),
('001', 'Ahumada', '0001', 'Miguel Ahumada', '2017-10-17 15:55:36', '08'),
('001', 'Canatlán', '0001', 'Canatlán', '2017-10-17 15:55:39', '10'),
('001', 'Abasolo', '0001', 'Abasolo', '2017-10-17 15:55:41', '11'),
('001', 'Acapulco de Juárez', '0001', 'Acapulco de Juárez', '2017-10-17 15:55:42', '12'),
('001', 'Acatlán', '0001', 'Acatlán', '2017-10-17 15:55:45', '13'),
('001', 'Acatic', '0001', 'Acatic', '2017-10-17 15:55:49', '14'),
('001', 'Acambay de Ruíz Castañeda', '0001', 'Villa de Acambay de Ruíz Castañeda', '2017-10-17 15:55:53', '15'),
('001', 'Acuitzio', '0001', 'Acuitzio del Canje', '2017-10-17 15:55:58', '16'),
('001', 'Amacuzac', '0001', 'Amacuzac', '2017-10-17 15:56:02', '17'),
('001', 'Acaponeta', '0001', 'Acaponeta', '2017-10-17 15:56:04', '18'),
('001', 'Abasolo', '0001', 'Abasolo', '2017-10-17 15:56:04', '19'),
('001', 'Abejones', '0001', 'Abejones', '2017-10-17 15:56:06', '20'),
('001', 'Acajete', '0001', 'Acajete', '2017-10-17 15:56:30', '21'),
('001', 'Amealco de Bonfil', '0001', 'Amealco de Bonfil', '2017-10-17 15:56:39', '22'),
('001', 'Cozumel', '0001', 'Cozumel', '2017-10-17 15:56:40', '23'),
('001', 'Ahualulco', '0001', 'Ahualulco del Sonido 13', '2017-10-17 15:56:40', '24'),
('001', 'Ahome', '0001', 'Los Mochis', '2017-10-17 15:56:43', '25'),
('001', 'Aconchi', '0001', 'Aconchi', '2017-10-17 15:56:43', '26'),
('001', 'Balancán', '0001', 'Balancán', '2017-10-17 15:56:46', '27'),
('001', 'Abasolo', '0001', 'Abasolo', '2017-10-17 15:56:47', '28'),
('001', 'Amaxac de Guerrero', '0001', 'Amaxac de Guerrero', '2017-10-17 15:56:49', '29'),
('001', 'Acajete', '0001', 'Acajete', '2017-10-17 15:56:51', '30'),
('001', 'Abalá', '0001', 'Abalá', '2017-10-17 15:57:00', '31'),
('001', 'Apozol', '0001', 'Apozol', '2017-10-17 15:57:04', '32'),
('002', 'Asientos', '0001', 'Asientos', '2017-10-17 15:55:28', '01'),
('002', 'Mexicali', '0001', 'Mexicali', '2017-10-17 15:55:29', '02'),
('002', 'Mulegé', '0001', 'Santa Rosalía', '2017-10-17 15:55:29', '03'),
('002', 'Campeche', '0001', 'San Francisco de Campeche', '2017-10-17 15:55:29', '04'),
('002', 'Acuña', '0001', 'Ciudad Acuña', '2017-10-17 15:55:30', '05'),
('002', 'Colima', '0001', 'Colima', '2017-10-17 15:55:31', '06'),
('002', 'Acala', '0001', 'Acala', '2017-10-17 15:55:31', '07'),
('002', 'Aldama', '0001', 'Juan Aldama', '2017-10-17 15:55:36', '08'),
('002', 'Azcapotzalco', '----', '', '2017-10-17 15:55:39', '09'),
('002', 'Canelas', '0001', 'Canelas', '2017-10-17 15:55:39', '10'),
('002', 'Acámbaro', '0001', 'Acámbaro', '2017-10-17 15:55:41', '11'),
('002', 'Ahuacuotzingo', '0001', 'Ahuacuotzingo', '2017-10-17 15:55:43', '12'),
('002', 'Acaxochitlán', '0001', 'Acaxochitlán', '2017-10-17 15:55:46', '13'),
('002', 'Acatlán de Juárez', '0001', 'Acatlán de Juárez', '2017-10-17 15:55:49', '14'),
('002', 'Acolman', '0001', 'Acolman de Nezahualcóyotl', '2017-10-17 15:55:53', '15'),
('002', 'Aguililla', '0001', 'Aguililla', '2017-10-17 15:55:58', '16'),
('002', 'Atlatlahucan', '0001', 'Atlatlahucan', '2017-10-17 15:56:02', '17'),
('002', 'Ahuacatlán', '0001', 'Ahuacatlán', '2017-10-17 15:56:04', '18'),
('002', 'Agualeguas', '0001', 'Agualeguas', '2017-10-17 15:56:04', '19'),
('002', 'Acatlán de Pérez Figueroa', '0001', 'Acatlán de Pérez Figueroa', '2017-10-17 15:56:06', '20'),
('002', 'Acateno', '0001', 'San José Acateno', '2017-10-17 15:56:30', '21'),
('002', 'Pinal de Amoles', '0001', 'Pinal de Amoles', '2017-10-17 15:56:39', '22'),
('002', 'Felipe Carrillo Puerto', '0001', 'Felipe Carrillo Puerto', '2017-10-17 15:56:40', '23'),
('002', 'Alaquines', '0001', 'Alaquines', '2017-10-17 15:56:40', '24'),
('002', 'Angostura', '0001', 'Angostura', '2017-10-17 15:56:43', '25'),
('002', 'Agua Prieta', '0001', 'Agua Prieta', '2017-10-17 15:56:43', '26'),
('002', 'Cárdenas', '0001', 'Cárdenas', '2017-10-17 15:56:46', '27'),
('002', 'Aldama', '0001', 'Aldama', '2017-10-17 15:56:47', '28'),
('002', 'Apetatitlán de Antonio Carvajal', '0001', 'Apetatitlán', '2017-10-17 15:56:49', '29'),
('002', 'Acatlán', '0001', 'Acatlán', '2017-10-17 15:56:51', '30'),
('002', 'Acanceh', '0001', 'Acanceh', '2017-10-17 15:57:00', '31'),
('002', 'Apulco', '0001', 'Apulco', '2017-10-17 15:57:04', '32'),
('003', 'Calvillo', '0001', 'Calvillo', '2017-10-17 15:55:28', '01'),
('003', 'Tecate', '0001', 'Tecate', '2017-10-17 15:55:29', '02'),
('003', 'La Paz', '0001', 'La Paz', '2017-10-17 15:55:29', '03'),
('003', 'Carmen', '0001', 'Ciudad del Carmen', '2017-10-17 15:55:29', '04'),
('003', 'Allende', '0001', 'Allende', '2017-10-17 15:55:30', '05'),
('003', 'Comala', '0001', 'Comala', '2017-10-17 15:55:31', '06'),
('003', 'Acapetahua', '0001', 'Acapetahua', '2017-10-17 15:55:31', '07'),
('003', 'Allende', '0001', 'Valle de Ignacio Allende', '2017-10-17 15:55:36', '08'),
('003', 'Coyoacán', '----', '', '2017-10-17 15:55:39', '09'),
('003', 'Coneto de Comonfort', '0001', 'Coneto de Comonfort', '2017-10-17 15:55:39', '10'),
('003', 'San Miguel de Allende', '0001', 'San Miguel de Allende', '2017-10-17 15:55:41', '11'),
('003', 'Ajuchitlán del Progreso', '0001', 'Ajuchitlán del Progreso', '2017-10-17 15:55:43', '12'),
('003', 'Actopan', '0001', 'Actopan', '2017-10-17 15:55:46', '13'),
('003', 'Ahualulco de Mercado', '0001', 'Ahualulco de Mercado', '2017-10-17 15:55:49', '14'),
('003', 'Aculco', '0001', 'Aculco de Espinoza', '2017-10-17 15:55:53', '15'),
('003', 'Álvaro Obregón', '0001', 'Álvaro Obregón', '2017-10-17 15:55:58', '16'),
('003', 'Axochiapan', '0001', 'Axochiapan', '2017-10-17 15:56:02', '17'),
('003', 'Amatlán de Cañas', '0001', 'Amatlán de Cañas', '2017-10-17 15:56:04', '18'),
('003', 'Los Aldamas', '0001', 'Los Aldamas', '2017-10-17 15:56:04', '19'),
('003', 'Asunción Cacalotepec', '0001', 'Asunción Cacalotepec', '2017-10-17 15:56:06', '20'),
('003', 'Acatlán', '0001', 'Acatlán de Osorio', '2017-10-17 15:56:30', '21'),
('003', 'Arroyo Seco', '0001', 'Arroyo Seco', '2017-10-17 15:56:39', '22'),
('003', 'Isla Mujeres', '0001', 'Isla Mujeres', '2017-10-17 15:56:40', '23'),
('003', 'Aquismón', '0001', 'Aquismón', '2017-10-17 15:56:40', '24'),
('003', 'Badiraguato', '0001', 'Badiraguato', '2017-10-17 15:56:43', '25'),
('003', 'Alamos', '0001', 'Alamos', '2017-10-17 15:56:43', '26'),
('003', 'Centla', '0001', 'Frontera', '2017-10-17 15:56:46', '27'),
('003', 'Altamira', '0001', 'Altamira', '2017-10-17 15:56:47', '28'),
('003', 'Atlangatepec', '0001', 'Atlangatepec', '2017-10-17 15:56:49', '29'),
('003', 'Acayucan', '0001', 'Acayucan', '2017-10-17 15:56:51', '30'),
('003', 'Akil', '0001', 'Akil', '2017-10-17 15:57:00', '31'),
('003', 'Atolinga', '0001', 'Atolinga', '2017-10-17 15:57:04', '32'),
('004', 'Cosío', '0001', 'Cosío', '2017-10-17 15:55:29', '01'),
('004', 'Tijuana', '0001', 'Tijuana', '2017-10-17 15:55:29', '02'),
('004', 'Champotón', '0001', 'Champotón', '2017-10-17 15:55:29', '04'),
('004', 'Arteaga', '0001', 'Arteaga', '2017-10-17 15:55:30', '05'),
('004', 'Coquimatlán', '0001', 'Coquimatlán', '2017-10-17 15:55:31', '06'),
('004', 'Altamirano', '0001', 'Altamirano', '2017-10-17 15:55:32', '07'),
('004', 'Aquiles Serdán', '0001', 'Santa Eulalia', '2017-10-17 15:55:36', '08'),
('004', 'Cuajimalpa de Morelos', '----', '', '2017-10-17 15:55:39', '09'),
('004', 'Cuencamé', '0001', 'Cuencamé de Ceniceros', '2017-10-17 15:55:39', '10'),
('004', 'Apaseo el Alto', '0001', 'Apaseo el Alto', '2017-10-17 15:55:41', '11'),
('004', 'Alcozauca de Guerrero', '0001', 'Alcozauca de Guerrero', '2017-10-17 15:55:43', '12'),
('004', 'Agua Blanca de Iturbide', '0001', 'Agua Blanca Iturbide', '2017-10-17 15:55:46', '13'),
('004', 'Amacueca', '0001', 'Amacueca', '2017-10-17 15:55:49', '14'),
('004', 'Almoloya de Alquisiras', '0001', 'Almoloya de Alquisiras', '2017-10-17 15:55:53', '15'),
('004', 'Angamacutiro', '0001', 'Angamacutiro de la Unión', '2017-10-17 15:55:58', '16'),
('004', 'Ayala', '0001', 'Ciudad Ayala', '2017-10-17 15:56:02', '17'),
('004', 'Compostela', '0001', 'Compostela', '2017-10-17 15:56:04', '18'),
('004', 'Allende', '0001', 'Ciudad de Allende', '2017-10-17 15:56:04', '19'),
('004', 'Asunción Cuyotepeji', '0001', 'Asunción Cuyotepeji', '2017-10-17 15:56:06', '20'),
('004', 'Acatzingo', '0001', 'Acatzingo de Hidalgo', '2017-10-17 15:56:30', '21'),
('004', 'Cadereyta de Montes', '0001', 'Cadereyta de Montes', '2017-10-17 15:56:39', '22'),
('004', 'Othón P. Blanco', '0001', 'Chetumal', '2017-10-17 15:56:40', '23'),
('004', 'Armadillo de los Infante', '0001', 'Armadillo de los Infante', '2017-10-17 15:56:40', '24'),
('004', 'Concordia', '0001', 'Concordia', '2017-10-17 15:56:43', '25'),
('004', 'Altar', '0001', 'Altar', '2017-10-17 15:56:43', '26'),
('004', 'Centro', '0001', 'Villahermosa', '2017-10-17 15:56:46', '27'),
('004', 'Antiguo Morelos', '0001', 'Antiguo Morelos', '2017-10-17 15:56:47', '28'),
('004', 'Atltzayanca', '0001', 'Atlzayanca', '2017-10-17 15:56:49', '29'),
('004', 'Actopan', '0001', 'Actopan', '2017-10-17 15:56:51', '30'),
('004', 'Baca', '0001', 'Baca', '2017-10-17 15:57:00', '31'),
('004', 'Benito Juárez', '0001', 'Florencia', '2017-10-17 15:57:04', '32'),
('005', 'Jesús María', '0001', 'Jesús María', '2017-10-17 15:55:29', '01'),
('005', 'Playas de Rosarito', '0001', 'Playas de Rosarito', '2017-10-17 15:55:29', '02'),
('005', 'Hecelchakán', '0001', 'Hecelchakán', '2017-10-17 15:55:29', '04'),
('005', 'Candela', '0001', 'Candela', '2017-10-17 15:55:30', '05'),
('005', 'Cuauhtémoc', '0001', 'Cuauhtémoc', '2017-10-17 15:55:31', '06'),
('005', 'Amatán', '0001', 'Amatán', '2017-10-17 15:55:32', '07'),
('005', 'Ascensión', '0001', 'Ascensión', '2017-10-17 15:55:36', '08'),
('005', 'Gustavo A. Madero', '----', '', '2017-10-17 15:55:39', '09'),
('005', 'Durango', '0001', 'Victoria de Durango', '2017-10-17 15:55:39', '10'),
('005', 'Apaseo el Grande', '0001', 'Apaseo el Grande', '2017-10-17 15:55:41', '11'),
('005', 'Alpoyeca', '0001', 'Alpoyeca', '2017-10-17 15:55:43', '12'),
('005', 'Ajacuba', '0001', 'Ajacuba', '2017-10-17 15:55:46', '13'),
('005', 'Amatitán', '0001', 'Amatitán', '2017-10-17 15:55:49', '14'),
('005', 'Almoloya de Juárez', '0001', 'Villa de Almoloya de Juárez', '2017-10-17 15:55:53', '15'),
('005', 'Angangueo', '0001', 'Mineral de Angangueo', '2017-10-17 15:55:58', '16'),
('005', 'Coatlán del Río', '0001', 'Coatlán del Río', '2017-10-17 15:56:03', '17'),
('005', 'Huajicori', '0001', 'Huajicori', '2017-10-17 15:56:04', '18'),
('005', 'Anáhuac', '0001', 'Anáhuac', '2017-10-17 15:56:05', '19'),
('005', 'Asunción Ixtaltepec', '0001', 'Asunción Ixtaltepec', '2017-10-17 15:56:06', '20'),
('005', 'Acteopan', '0001', 'Acteopan', '2017-10-17 15:56:30', '21'),
('005', 'Colón', '0001', 'Colón', '2017-10-17 15:56:39', '22'),
('005', 'Benito Juárez', '0001', 'Cancún', '2017-10-17 15:56:40', '23'),
('005', 'Cárdenas', '0001', 'Cárdenas', '2017-10-17 15:56:40', '24'),
('005', 'Cosalá', '0001', 'Cosalá', '2017-10-17 15:56:43', '25'),
('005', 'Arivechi', '0001', 'Arivechi', '2017-10-17 15:56:44', '26'),
('005', 'Comalcalco', '0001', 'Comalcalco', '2017-10-17 15:56:46', '27'),
('005', 'Burgos', '0001', 'Burgos', '2017-10-17 15:56:47', '28'),
('005', 'Apizaco', '0001', 'Ciudad de Apizaco', '2017-10-17 15:56:49', '29'),
('005', 'Acula', '0001', 'Acula', '2017-10-17 15:56:51', '30'),
('005', 'Bokobá', '0001', 'Bokobá', '2017-10-17 15:57:00', '31'),
('005', 'Calera', '0001', 'Víctor Rosales', '2017-10-17 15:57:04', '32'),
('006', 'Pabellón de Arteaga', '0001', 'Pabellón de Arteaga', '2017-10-17 15:55:29', '01'),
('006', 'Hopelchén', '0001', 'Hopelchén', '2017-10-17 15:55:29', '04'),
('006', 'Castaños', '0001', 'Castaños', '2017-10-17 15:55:30', '05'),
('006', 'Ixtlahuacán', '0001', 'Ixtlahuacán', '2017-10-17 15:55:31', '06'),
('006', 'Amatenango de la Frontera', '0001', 'Amatenango de la Frontera', '2017-10-17 15:55:32', '07'),
('006', 'Bachíniva', '0001', 'Bachíniva', '2017-10-17 15:55:36', '08'),
('006', 'Iztacalco', '----', '', '2017-10-17 15:55:39', '09'),
('006', 'General Simón Bolívar', '0001', 'General Simón Bolívar', '2017-10-17 15:55:39', '10'),
('006', 'Atarjea', '0001', 'Atarjea', '2017-10-17 15:55:41', '11'),
('006', 'Apaxtla', '0001', 'Ciudad Apaxtla de Castrejón', '2017-10-17 15:55:43', '12'),
('006', 'Alfajayucan', '0001', 'Alfajayucan', '2017-10-17 15:55:46', '13'),
('006', 'Ameca', '0001', 'Ameca', '2017-10-17 15:55:49', '14'),
('006', 'Almoloya del Río', '0001', 'Almoloya del Río', '2017-10-17 15:55:53', '15'),
('006', 'Apatzingán', '0001', 'Apatzingán de la Constitución', '2017-10-17 15:55:58', '16'),
('006', 'Cuautla', '0001', 'Cuautla', '2017-10-17 15:56:03', '17'),
('006', 'Ixtlán del Río', '0001', 'Ixtlán del Río', '2017-10-17 15:56:04', '18'),
('006', 'Apodaca', '0001', 'Ciudad Apodaca', '2017-10-17 15:56:05', '19'),
('006', 'Asunción Nochixtlán', '0001', 'Asunción Nochixtlán', '2017-10-17 15:56:06', '20'),
('006', 'Ahuacatlán', '0001', 'Ahuacatlán', '2017-10-17 15:56:30', '21'),
('006', 'Corregidora', '0001', 'El Pueblito', '2017-10-17 15:56:39', '22'),
('006', 'José María Morelos', '0069', 'José María Morelos', '2017-10-17 15:56:40', '23'),
('006', 'Catorce', '0001', 'Real de Catorce', '2017-10-17 15:56:41', '24'),
('006', 'Culiacán', '0001', 'Culiacán Rosales', '2017-10-17 15:56:43', '25'),
('006', 'Arizpe', '0001', 'Arizpe', '2017-10-17 15:56:44', '26'),
('006', 'Cunduacán', '0001', 'Cunduacán', '2017-10-17 15:56:47', '27'),
('006', 'Bustamante', '0001', 'Bustamante', '2017-10-17 15:56:47', '28'),
('006', 'Calpulalpan', '0001', 'Calpulalpan', '2017-10-17 15:56:49', '29'),
('006', 'Acultzingo', '0001', 'Acultzingo', '2017-10-17 15:56:52', '30'),
('006', 'Buctzotz', '0001', 'Buctzotz', '2017-10-17 15:57:00', '31'),
('006', 'Cañitas de Felipe Pescador', '0001', 'Cañitas de Felipe Pescador', '2017-10-17 15:57:04', '32'),
('007', 'Rincón de Romos', '0001', 'Rincón de Romos', '2017-10-17 15:55:29', '01'),
('007', 'Palizada', '0001', 'Palizada', '2017-10-17 15:55:30', '04'),
('007', 'Cuatro Ciénegas', '0001', 'Cuatro Ciénegas de Carranza', '2017-10-17 15:55:30', '05'),
('007', 'Manzanillo', '0001', 'Manzanillo', '2017-10-17 15:55:31', '06'),
('007', 'Amatenango del Valle', '0001', 'Amatenango del Valle', '2017-10-17 15:55:32', '07'),
('007', 'Balleza', '0001', 'Mariano Balleza', '2017-10-17 15:55:36', '08'),
('007', 'Iztapalapa', '----', '', '2017-10-17 15:55:39', '09'),
('007', 'Gómez Palacio', '0001', 'Gómez Palacio', '2017-10-17 15:55:40', '10'),
('007', 'Celaya', '0001', 'Celaya', '2017-10-17 15:55:41', '11'),
('007', 'Arcelia', '0001', 'Arcelia', '2017-10-17 15:55:43', '12'),
('007', 'Almoloya', '0001', 'Almoloya', '2017-10-17 15:55:46', '13'),
('007', 'San Juanito de Escobedo', '0001', 'San Juanito de Escobedo', '2017-10-17 15:55:49', '14'),
('007', 'Amanalco', '0001', 'Amanalco de Becerra', '2017-10-17 15:55:53', '15'),
('007', 'Aporo', '0001', 'Aporo', '2017-10-17 15:55:58', '16'),
('007', 'Cuernavaca', '0001', 'Cuernavaca', '2017-10-17 15:56:03', '17'),
('007', 'Jala', '0001', 'Jala', '2017-10-17 15:56:04', '18'),
('007', 'Aramberri', '0001', 'Aramberri', '2017-10-17 15:56:05', '19'),
('007', 'Asunción Ocotlán', '0001', 'Asunción Ocotlán', '2017-10-17 15:56:07', '20'),
('007', 'Ahuatlán', '0001', 'Ahuatlán', '2017-10-17 15:56:31', '21'),
('007', 'Ezequiel Montes', '0001', 'Ezequiel Montes', '2017-10-17 15:56:39', '22'),
('007', 'Lázaro Cárdenas', '0001', 'Kantunilkín', '2017-10-17 15:56:40', '23'),
('007', 'Cedral', '0001', 'Cedral', '2017-10-17 15:56:41', '24'),
('007', 'Choix', '0001', 'Choix', '2017-10-17 15:56:43', '25'),
('007', 'Atil', '0001', 'Atil', '2017-10-17 15:56:44', '26'),
('007', 'Emiliano Zapata', '0001', 'Emiliano Zapata', '2017-10-17 15:56:47', '27'),
('007', 'Camargo', '0001', 'Ciudad Camargo', '2017-10-17 15:56:47', '28'),
('007', 'El Carmen Tequexquitla', '0001', 'Villa de El Carmen Tequexquitla', '2017-10-17 15:56:49', '29'),
('007', 'Camarón de Tejeda', '0001', 'Camarón de Tejeda', '2017-10-17 15:56:52', '30'),
('007', 'Cacalchén', '0001', 'Cacalchén', '2017-10-17 15:57:00', '31'),
('007', 'Concepción del Oro', '0001', 'Concepción del Oro', '2017-10-17 15:57:04', '32'),
('008', 'San José de Gracia', '0001', 'San José de Gracia', '2017-10-17 15:55:29', '01'),
('008', 'Los Cabos', '0001', 'San José del Cabo', '2017-10-17 15:55:29', '03'),
('008', 'Tenabo', '0001', 'Tenabo', '2017-10-17 15:55:30', '04'),
('008', 'Escobedo', '0001', 'Escobedo', '2017-10-17 15:55:30', '05'),
('008', 'Minatitlán', '0001', 'Minatitlán', '2017-10-17 15:55:31', '06'),
('008', 'Angel Albino Corzo', '0001', 'Jaltenango de la Paz (Angel Albino Corzo)', '2017-10-17 15:55:32', '07'),
('008', 'Batopilas', '0001', 'Batopilas', '2017-10-17 15:55:36', '08'),
('008', 'La Magdalena Contreras', '----', '', '2017-10-17 15:55:39', '09'),
('008', 'Guadalupe Victoria', '0001', 'Guadalupe Victoria', '2017-10-17 15:55:40', '10'),
('008', 'Manuel Doblado', '0001', 'Ciudad Manuel Doblado', '2017-10-17 15:55:41', '11'),
('008', 'Atenango del Río', '0001', 'Atenango del Río', '2017-10-17 15:55:43', '12'),
('008', 'Apan', '0001', 'Apan', '2017-10-17 15:55:46', '13'),
('008', 'Arandas', '0001', 'Arandas', '2017-10-17 15:55:49', '14'),
('008', 'Amatepec', '0001', 'Amatepec', '2017-10-17 15:55:53', '15'),
('008', 'Aquila', '0001', 'Aquila', '2017-10-17 15:55:58', '16'),
('008', 'Emiliano Zapata', '0001', 'Emiliano Zapata', '2017-10-17 15:56:03', '17'),
('008', 'Xalisco', '0001', 'Xalisco', '2017-10-17 15:56:04', '18'),
('008', 'Bustamante', '0001', 'Bustamante', '2017-10-17 15:56:05', '19'),
('008', 'Asunción Tlacolulita', '0001', 'Asunción Tlacolulita', '2017-10-17 15:56:07', '20'),
('008', 'Ahuazotepec', '0001', 'Ahuazotepec', '2017-10-17 15:56:31', '21'),
('008', 'Huimilpan', '0001', 'Huimilpan', '2017-10-17 15:56:39', '22'),
('008', 'Solidaridad', '0001', 'Playa del Carmen', '2017-10-17 15:56:40', '23'),
('008', 'Cerritos', '0001', 'Cerritos', '2017-10-17 15:56:41', '24'),
('008', 'Elota', '0001', 'La Cruz', '2017-10-17 15:56:43', '25'),
('008', 'Bacadéhuachi', '0001', 'Bacadéhuachi', '2017-10-17 15:56:44', '26'),
('008', 'Huimanguillo', '0001', 'Huimanguillo', '2017-10-17 15:56:47', '27'),
('008', 'Casas', '0001', 'Casas', '2017-10-17 15:56:47', '28'),
('008', 'Cuapiaxtla', '0001', 'Cuapiaxtla', '2017-10-17 15:56:49', '29'),
('008', 'Alpatláhuac', '0001', 'Alpatláhuac', '2017-10-17 15:56:52', '30'),
('008', 'Calotmul', '0001', 'Calotmul', '2017-10-17 15:57:00', '31'),
('008', 'Cuauhtémoc', '0001', 'San Pedro Piedra Gorda', '2017-10-17 15:57:04', '32'),
('009', 'Tepezalá', '0001', 'Tepezalá', '2017-10-17 15:55:29', '01'),
('009', 'Loreto', '0001', 'Loreto', '2017-10-17 15:55:29', '03'),
('009', 'Escárcega', '0001', 'Escárcega', '2017-10-17 15:55:30', '04'),
('009', 'Francisco I. Madero', '0001', 'Francisco I. Madero (Chávez)', '2017-10-17 15:55:30', '05'),
('009', 'Tecomán', '0001', 'Tecomán', '2017-10-17 15:55:31', '06'),
('009', 'Arriaga', '0001', 'Arriaga', '2017-10-17 15:55:32', '07'),
('009', 'Bocoyna', '0001', 'Bocoyna', '2017-10-17 15:55:36', '08'),
('009', 'Milpa Alta', '----', '', '2017-10-17 15:55:39', '09'),
('009', 'Guanaceví', '0001', 'Guanaceví', '2017-10-17 15:55:40', '10'),
('009', 'Comonfort', '0001', 'Comonfort', '2017-10-17 15:55:41', '11'),
('009', 'Atlamajalcingo del Monte', '0001', 'Atlamajalcingo del Monte', '2017-10-17 15:55:43', '12'),
('009', 'El Arenal', '0001', 'El Arenal', '2017-10-17 15:55:46', '13'),
('009', 'El Arenal', '0001', 'El Arenal', '2017-10-17 15:55:49', '14'),
('009', 'Amecameca', '0001', 'Amecameca de Juárez', '2017-10-17 15:55:54', '15'),
('009', 'Ario', '0001', 'Ario de Rosales', '2017-10-17 15:55:58', '16'),
('009', 'Huitzilac', '0001', 'Huitzilac', '2017-10-17 15:56:03', '17'),
('009', 'Del Nayar', '0001', 'Jesús María', '2017-10-17 15:56:04', '18'),
('009', 'Cadereyta Jiménez', '0001', 'Cadereyta Jiménez', '2017-10-17 15:56:05', '19'),
('009', 'Ayotzintepec', '0001', 'Ayotzintepec', '2017-10-17 15:56:07', '20'),
('009', 'Ahuehuetitla', '0001', 'Ahuehuetitla', '2017-10-17 15:56:31', '21'),
('009', 'Jalpan de Serra', '0001', 'Jalpan de Serra', '2017-10-17 15:56:39', '22'),
('009', 'Tulum', '0001', 'Tulum', '2017-10-17 15:56:40', '23'),
('009', 'Cerro de San Pedro', '0001', 'Cerro de San Pedro', '2017-10-17 15:56:41', '24'),
('009', 'Escuinapa', '0001', 'Escuinapa de Hidalgo', '2017-10-17 15:56:43', '25'),
('009', 'Bacanora', '0001', 'Bacanora', '2017-10-17 15:56:44', '26'),
('009', 'Jalapa', '0001', 'Jalapa', '2017-10-17 15:56:47', '27'),
('009', 'Ciudad Madero', '0001', 'Ciudad Madero', '2017-10-17 15:56:47', '28'),
('009', 'Cuaxomulco', '0001', 'Cuaxomulco', '2017-10-17 15:56:49', '29'),
('009', 'Alto Lucero de Gutiérrez Barrios', '0001', 'Alto Lucero', '2017-10-17 15:56:52', '30'),
('009', 'Cansahcab', '0001', 'Cansahcab', '2017-10-17 15:57:00', '31'),
('009', 'Chalchihuites', '0001', 'Chalchihuites', '2017-10-17 15:57:05', '32'),
('010', 'El Llano', '0001', 'Palo Alto', '2017-10-17 15:55:29', '01'),
('010', 'Calakmul', '0001', 'Xpujil', '2017-10-17 15:55:30', '04'),
('010', 'Frontera', '0001', 'Frontera', '2017-10-17 15:55:30', '05'),
('010', 'Villa de Álvarez', '0001', 'Ciudad de Villa de Álvarez', '2017-10-17 15:55:31', '06'),
('010', 'Bejucal de Ocampo', '0001', 'Bejucal de Ocampo', '2017-10-17 15:55:32', '07'),
('010', 'Buenaventura', '0001', 'San Buenaventura', '2017-10-17 15:55:36', '08'),
('010', 'Álvaro Obregón', '----', '', '2017-10-17 15:55:39', '09'),
('010', 'Hidalgo', '0001', 'Villa Hidalgo', '2017-10-17 15:55:40', '10'),
('010', 'Coroneo', '0001', 'Coroneo', '2017-10-17 15:55:41', '11'),
('010', 'Atlixtac', '0001', 'Atlixtac', '2017-10-17 15:55:43', '12'),
('010', 'Atitalaquia', '0001', 'Atitalaquia', '2017-10-17 15:55:46', '13'),
('010', 'Atemajac de Brizuela', '0001', 'Atemajac de Brizuela', '2017-10-17 15:55:49', '14'),
('010', 'Apaxco', '0001', 'Apaxco de Ocampo', '2017-10-17 15:55:54', '15'),
('010', 'Arteaga', '0001', 'Arteaga', '2017-10-17 15:55:58', '16'),
('010', 'Jantetelco', '0001', 'Jantetelco', '2017-10-17 15:56:03', '17'),
('010', 'Rosamorada', '0001', 'Rosamorada', '2017-10-17 15:56:04', '18'),
('010', 'El Carmen', '0001', 'Carmen', '2017-10-17 15:56:05', '19'),
('010', 'El Barrio de la Soledad', '0001', 'El Barrio de la Soledad', '2017-10-17 15:56:07', '20'),
('010', 'Ajalpan', '0001', 'Ciudad de Ajalpan', '2017-10-17 15:56:31', '21'),
('010', 'Landa de Matamoros', '0001', 'Landa de Matamoros', '2017-10-17 15:56:40', '22'),
('010', 'Bacalar', '0001', 'Bacalar', '2017-10-17 15:56:40', '23'),
('010', 'Ciudad del Maíz', '0001', 'Ciudad del Maíz', '2017-10-17 15:56:41', '24'),
('010', 'El Fuerte', '0001', 'El Fuerte', '2017-10-17 15:56:43', '25'),
('010', 'Bacerac', '0001', 'Bacerac', '2017-10-17 15:56:44', '26'),
('010', 'Jalpa de Méndez', '0001', 'Jalpa de Méndez', '2017-10-17 15:56:47', '27'),
('010', 'Cruillas', '0001', 'Cruillas', '2017-10-17 15:56:47', '28'),
('010', 'Chiautempan', '0001', 'Santa Ana Chiautempan', '2017-10-17 15:56:49', '29'),
('010', 'Altotonga', '0001', 'Altotonga', '2017-10-17 15:56:52', '30'),
('010', 'Cantamayec', '0001', 'Cantamayec', '2017-10-17 15:57:00', '31'),
('010', 'Fresnillo', '0001', 'Fresnillo', '2017-10-17 15:57:05', '32'),
('011', 'San Francisco de los Romo', '0001', 'San Francisco de los Romo', '2017-10-17 15:55:29', '01'),
('011', 'Candelaria', '0001', 'Candelaria', '2017-10-17 15:55:30', '04'),
('011', 'General Cepeda', '0001', 'General Cepeda', '2017-10-17 15:55:30', '05'),
('011', 'Bella Vista', '0001', 'Bella Vista', '2017-10-17 15:55:32', '07'),
('011', 'Camargo', '0001', 'Santa Rosalía de Camargo', '2017-10-17 15:55:36', '08'),
('011', 'Tláhuac', '----', '', '2017-10-17 15:55:39', '09'),
('011', 'Indé', '0001', 'Indé', '2017-10-17 15:55:40', '10'),
('011', 'Cortazar', '0001', 'Cortazar', '2017-10-17 15:55:41', '11'),
('011', 'Atoyac de Álvarez', '0001', 'Atoyac de Álvarez', '2017-10-17 15:55:43', '12'),
('011', 'Atlapexco', '0001', 'Atlapexco', '2017-10-17 15:55:46', '13'),
('011', 'Atengo', '0001', 'Atengo', '2017-10-17 15:55:49', '14'),
('011', 'Atenco', '0001', 'San Salvador Atenco', '2017-10-17 15:55:54', '15'),
('011', 'Briseñas', '0001', 'Briseñas de Matamoros', '2017-10-17 15:55:58', '16'),
('011', 'Jiutepec', '0001', 'Jiutepec', '2017-10-17 15:56:03', '17'),
('011', 'Ruíz', '0001', 'Ruíz', '2017-10-17 15:56:04', '18'),
('011', 'Cerralvo', '0001', 'Ciudad Cerralvo', '2017-10-17 15:56:05', '19'),
('011', 'Calihualá', '0001', 'Calihualá', '2017-10-17 15:56:07', '20'),
('011', 'Albino Zertuche', '0001', 'Acaxtlahuacán de Albino Zertuche', '2017-10-17 15:56:31', '21'),
('011', 'El Marqués', '0001', 'La Cañada', '2017-10-17 15:56:40', '22'),
('011', 'Ciudad Fernández', '0001', 'Ciudad Fernández', '2017-10-17 15:56:41', '24'),
('011', 'Guasave', '0001', 'Guasave', '2017-10-17 15:56:43', '25'),
('011', 'Bacoachi', '0001', 'Bacoachi', '2017-10-17 15:56:44', '26'),
('011', 'Jonuta', '0001', 'Jonuta', '2017-10-17 15:56:47', '27'),
('011', 'Gómez Farías', '0036', 'Gómez Farías', '2017-10-17 15:56:47', '28'),
('011', 'Muñoz de Domingo Arenas', '0001', 'Muñoz', '2017-10-17 15:56:49', '29'),
('011', 'Alvarado', '0001', 'Alvarado', '2017-10-17 15:56:52', '30'),
('011', 'Celestún', '0001', 'Celestún', '2017-10-17 15:57:00', '31'),
('011', 'Trinidad García de la Cadena', '0001', 'Trinidad García de la Cadena', '2017-10-17 15:57:05', '32'),
('012', 'Guerrero', '0001', 'Guerrero', '2017-10-17 15:55:30', '05'),
('012', 'Berriozábal', '0001', 'Berriozábal', '2017-10-17 15:55:32', '07'),
('012', 'Carichí', '0001', 'Carichí', '2017-10-17 15:55:36', '08'),
('012', 'Tlalpan', '----', '', '2017-10-17 15:55:39', '09'),
('012', 'Lerdo', '0001', 'Lerdo', '2017-10-17 15:55:40', '10'),
('012', 'Cuerámaro', '0001', 'Cuerámaro', '2017-10-17 15:55:41', '11'),
('012', 'Ayutla de los Libres', '0001', 'Ayutla de los Libres', '2017-10-17 15:55:43', '12'),
('012', 'Atotonilco el Grande', '0001', 'Atotonilco el Grande', '2017-10-17 15:55:46', '13'),
('012', 'Atenguillo', '0001', 'Atenguillo', '2017-10-17 15:55:49', '14'),
('012', 'Atizapán', '0001', 'Santa Cruz Atizapán', '2017-10-17 15:55:54', '15'),
('012', 'Buenavista', '0001', 'Buenavista Tomatlán', '2017-10-17 15:55:58', '16'),
('012', 'Jojutla', '0001', 'Jojutla', '2017-10-17 15:56:03', '17'),
('012', 'San Blas', '0001', 'San Blas', '2017-10-17 15:56:04', '18'),
('012', 'Ciénega de Flores', '0001', 'Ciénega de Flores', '2017-10-17 15:56:05', '19'),
('012', 'Candelaria Loxicha', '0001', 'Candelaria Loxicha', '2017-10-17 15:56:07', '20'),
('012', 'Aljojuca', '0001', 'Aljojuca', '2017-10-17 15:56:31', '21'),
('012', 'Pedro Escobedo', '0001', 'Pedro Escobedo', '2017-10-17 15:56:40', '22'),
('012', 'Tancanhuitz', '0001', 'Tancanhuitz', '2017-10-17 15:56:41', '24'),
('012', 'Mazatlán', '0001', 'Mazatlán', '2017-10-17 15:56:43', '25'),
('012', 'Bácum', '0001', 'Bácum', '2017-10-17 15:56:44', '26'),
('012', 'Macuspana', '0001', 'Macuspana', '2017-10-17 15:56:47', '27'),
('012', 'González', '0001', 'González', '2017-10-17 15:56:47', '28'),
('012', 'Españita', '0001', 'Españita', '2017-10-17 15:56:49', '29'),
('012', 'Amatitlán', '0001', 'Amatitlán', '2017-10-17 15:56:52', '30'),
('012', 'Cenotillo', '0001', 'Cenotillo', '2017-10-17 15:57:00', '31'),
('012', 'Genaro Codina', '0001', 'Genaro Codina', '2017-10-17 15:57:05', '32'),
('013', 'Hidalgo', '0001', 'Hidalgo', '2017-10-17 15:55:30', '05'),
('013', 'Bochil', '0001', 'Bochil', '2017-10-17 15:55:32', '07'),
('013', 'Casas Grandes', '0001', 'Casas Grandes', '2017-10-17 15:55:36', '08'),
('013', 'Xochimilco', '----', '', '2017-10-17 15:55:39', '09'),
('013', 'Mapimí', '0001', 'Mapimí', '2017-10-17 15:55:40', '10'),
('013', 'Doctor Mora', '0001', 'Doctor Mora', '2017-10-17 15:55:41', '11'),
('013', 'Azoyú', '0001', 'Azoyú', '2017-10-17 15:55:43', '12'),
('013', 'Atotonilco de Tula', '0001', 'Atotonilco de Tula', '2017-10-17 15:55:46', '13'),
('013', 'Atotonilco el Alto', '0001', 'Atotonilco el Alto', '2017-10-17 15:55:49', '14'),
('013', 'Atizapán de Zaragoza', '0001', 'Ciudad López Mateos', '2017-10-17 15:55:54', '15'),
('013', 'Carácuaro', '0001', 'Carácuaro de Morelos', '2017-10-17 15:55:58', '16'),
('013', 'Jonacatepec', '0001', 'Jonacatepec', '2017-10-17 15:56:03', '17'),
('013', 'San Pedro Lagunillas', '0001', 'San Pedro Lagunillas', '2017-10-17 15:56:04', '18'),
('013', 'China', '0001', 'China', '2017-10-17 15:56:05', '19'),
('013', 'Ciénega de Zimatlán', '0001', 'Ciénega de Zimatlán', '2017-10-17 15:56:07', '20'),
('013', 'Altepexi', '0001', 'Altepexi', '2017-10-17 15:56:31', '21'),
('013', 'Peñamiller', '0001', 'Peñamiller', '2017-10-17 15:56:40', '22'),
('013', 'Ciudad Valles', '0001', 'Ciudad Valles', '2017-10-17 15:56:41', '24'),
('013', 'Mocorito', '0001', 'Mocorito', '2017-10-17 15:56:43', '25'),
('013', 'Banámichi', '0001', 'Banámichi', '2017-10-17 15:56:44', '26'),
('013', 'Nacajuca', '0001', 'Nacajuca', '2017-10-17 15:56:47', '27'),
('013', 'Güémez', '0001', 'Güémez', '2017-10-17 15:56:48', '28'),
('013', 'Huamantla', '0001', 'Huamantla', '2017-10-17 15:56:49', '29'),
('013', 'Naranjos Amatlán', '0001', 'Naranjos', '2017-10-17 15:56:52', '30'),
('013', 'Conkal', '0001', 'Conkal', '2017-10-17 15:57:00', '31'),
('013', 'General Enrique Estrada', '0001', 'General Enrique Estrada', '2017-10-17 15:57:05', '32'),
('014', 'Jiménez', '0001', 'Jiménez', '2017-10-17 15:55:30', '05'),
('014', 'El Bosque', '0001', 'El Bosque', '2017-10-17 15:55:32', '07'),
('014', 'Coronado', '0001', 'José Esteban Coronado', '2017-10-17 15:55:36', '08'),
('014', 'Benito Juárez', '----', '', '2017-10-17 15:55:39', '09'),
('014', 'Mezquital', '0001', 'San Francisco del Mezquital', '2017-10-17 15:55:40', '10'),
('014', 'Dolores Hidalgo Cuna de la Independencia Nacional', '0001', 'Dolores Hidalgo Cuna de la Independencia Nacional', '2017-10-17 15:55:41', '11'),
('014', 'Benito Juárez', '0001', 'San Jerónimo de Juárez', '2017-10-17 15:55:43', '12'),
('014', 'Calnali', '0001', 'Calnali', '2017-10-17 15:55:46', '13'),
('014', 'Atoyac', '0001', 'Atoyac', '2017-10-17 15:55:49', '14'),
('014', 'Atlacomulco', '0001', 'Atlacomulco de Fabela', '2017-10-17 15:55:54', '15'),
('014', 'Coahuayana', '0001', 'Coahuayana de Hidalgo', '2017-10-17 15:55:58', '16'),
('014', 'Mazatepec', '0001', 'Mazatepec', '2017-10-17 15:56:03', '17'),
('014', 'Santa María del Oro', '0001', 'Santa María del Oro', '2017-10-17 15:56:04', '18'),
('014', 'Doctor Arroyo', '0001', 'Doctor Arroyo', '2017-10-17 15:56:05', '19'),
('014', 'Ciudad Ixtepec', '0001', 'Ciudad Ixtepec', '2017-10-17 15:56:07', '20'),
('014', 'Amixtlán', '0001', 'Amixtlán', '2017-10-17 15:56:31', '21'),
('014', 'Querétaro', '0001', 'Santiago de Querétaro', '2017-10-17 15:56:40', '22'),
('014', 'Coxcatlán', '0001', 'Coxcatlán', '2017-10-17 15:56:41', '24'),
('014', 'Rosario', '0001', 'El Rosario', '2017-10-17 15:56:43', '25'),
('014', 'Baviácora', '0001', 'Baviácora', '2017-10-17 15:56:44', '26'),
('014', 'Paraíso', '0001', 'Paraíso', '2017-10-17 15:56:47', '27'),
('014', 'Guerrero', '0001', 'Nueva Ciudad Guerrero', '2017-10-17 15:56:48', '28'),
('014', 'Hueyotlipan', '0001', 'Hueyotlipan', '2017-10-17 15:56:49', '29'),
('014', 'Amatlán de los Reyes', '0001', 'Amatlán de los Reyes', '2017-10-17 15:56:52', '30'),
('014', 'Cuncunul', '0001', 'Cuncunul', '2017-10-17 15:57:00', '31'),
('014', 'General Francisco R. Murguía', '0001', 'Nieves', '2017-10-17 15:57:05', '32'),
('015', 'Juárez', '0001', 'Juárez', '2017-10-17 15:55:30', '05'),
('015', 'Cacahoatán', '0001', 'Cacahoatán', '2017-10-17 15:55:32', '07'),
('015', 'Coyame del Sotol', '0001', 'Santiago de Coyame', '2017-10-17 15:55:36', '08'),
('015', 'Cuauhtémoc', '----', '', '2017-10-17 15:55:39', '09'),
('015', 'Nazas', '0001', 'Nazas', '2017-10-17 15:55:40', '10'),
('015', 'Guanajuato', '0001', 'Guanajuato', '2017-10-17 15:55:41', '11'),
('015', 'Buenavista de Cuéllar', '0001', 'Buenavista de Cuéllar', '2017-10-17 15:55:43', '12'),
('015', 'Cardonal', '0001', 'Cardonal', '2017-10-17 15:55:46', '13'),
('015', 'Autlán de Navarro', '0001', 'Autlán de Navarro', '2017-10-17 15:55:49', '14'),
('015', 'Atlautla', '0001', 'Atlautla de Victoria', '2017-10-17 15:55:54', '15'),
('015', 'Coalcomán de Vázquez Pallares', '0001', 'Coalcomán de Vázquez Pallares', '2017-10-17 15:55:58', '16'),
('015', 'Miacatlán', '0001', 'Miacatlán', '2017-10-17 15:56:03', '17'),
('015', 'Santiago Ixcuintla', '0001', 'Santiago Ixcuintla', '2017-10-17 15:56:04', '18'),
('015', 'Doctor Coss', '0001', 'Doctor Coss', '2017-10-17 15:56:05', '19'),
('015', 'Coatecas Altas', '0001', 'Coatecas Altas', '2017-10-17 15:56:07', '20'),
('015', 'Amozoc', '0001', 'Amozoc de Mota', '2017-10-17 15:56:31', '21'),
('015', 'San Joaquín', '0001', 'San Joaquín', '2017-10-17 15:56:40', '22'),
('015', 'Charcas', '0001', 'Charcas', '2017-10-17 15:56:41', '24'),
('015', 'Salvador Alvarado', '0001', 'Guamúchil', '2017-10-17 15:56:43', '25'),
('015', 'Bavispe', '0001', 'Bavispe', '2017-10-17 15:56:44', '26'),
('015', 'Tacotalpa', '0001', 'Tacotalpa', '2017-10-17 15:56:47', '27'),
('015', 'Gustavo Díaz Ordaz', '0001', 'Ciudad Gustavo Díaz Ordaz', '2017-10-17 15:56:48', '28'),
('015', 'Ixtacuixtla de Mariano Matamoros', '0001', 'Villa Mariano Matamoros', '2017-10-17 15:56:49', '29'),
('015', 'Angel R. Cabada', '0001', 'Ángel R. Cabada', '2017-10-17 15:56:52', '30'),
('015', 'Cuzamá', '0001', 'Cuzamá', '2017-10-17 15:57:00', '31'),
('015', 'El Plateado de Joaquín Amaro', '0001', 'El Plateado de Joaquín Amaro', '2017-10-17 15:57:05', '32'),
('016', 'Lamadrid', '0001', 'Lamadrid', '2017-10-17 15:55:30', '05'),
('016', 'Catazajá', '0001', 'Catazajá', '2017-10-17 15:55:32', '07'),
('016', 'La Cruz', '0001', 'La Cruz', '2017-10-17 15:55:36', '08'),
('016', 'Miguel Hidalgo', '----', '', '2017-10-17 15:55:39', '09'),
('016', 'Nombre de Dios', '0001', 'Nombre de Dios', '2017-10-17 15:55:40', '10'),
('016', 'Huanímaro', '0001', 'Huanímaro', '2017-10-17 15:55:41', '11'),
('016', 'Coahuayutla de José María Izazaga', '0001', 'Coahuayutla de Guerrero', '2017-10-17 15:55:43', '12'),
('016', 'Cuautepec de Hinojosa', '0001', 'Cuautepec de Hinojosa', '2017-10-17 15:55:46', '13'),
('016', 'Ayotlán', '0001', 'Ayotlán', '2017-10-17 15:55:49', '14'),
('016', 'Axapusco', '0001', 'Axapusco', '2017-10-17 15:55:54', '15'),
('016', 'Coeneo', '0001', 'Coeneo de la Libertad', '2017-10-17 15:55:58', '16'),
('016', 'Ocuituco', '0001', 'Ocuituco', '2017-10-17 15:56:03', '17'),
('016', 'Tecuala', '0001', 'Tecuala', '2017-10-17 15:56:04', '18'),
('016', 'Doctor González', '0001', 'Doctor González', '2017-10-17 15:56:05', '19'),
('016', 'Coicoyán de las Flores', '0001', 'Coicoyán de las Flores', '2017-10-17 15:56:07', '20'),
('016', 'Aquixtla', '0001', 'Aquixtla', '2017-10-17 15:56:31', '21'),
('016', 'San Juan del Río', '0001', 'San Juan del Río', '2017-10-17 15:56:40', '22'),
('016', 'Ebano', '0001', 'Ebano', '2017-10-17 15:56:41', '24'),
('016', 'San Ignacio', '0001', 'San Ignacio', '2017-10-17 15:56:43', '25'),
('016', 'Benjamín Hill', '0001', 'Benjamín Hill', '2017-10-17 15:56:44', '26'),
('016', 'Teapa', '0001', 'Teapa', '2017-10-17 15:56:47', '27'),
('016', 'Hidalgo', '0001', 'Hidalgo', '2017-10-17 15:56:48', '28'),
('016', 'Ixtenco', '0001', 'Ixtenco', '2017-10-17 15:56:49', '29'),
('016', 'La Antigua', '0001', 'José Cardel', '2017-10-17 15:56:52', '30'),
('016', 'Chacsinkín', '0001', 'Chacsinkín', '2017-10-17 15:57:00', '31'),
('016', 'General Pánfilo Natera', '0001', 'General Pánfilo Natera', '2017-10-17 15:57:05', '32'),
('017', 'Matamoros', '0001', 'Matamoros', '2017-10-17 15:55:30', '05'),
('017', 'Cintalapa', '0001', 'Cintalapa de Figueroa', '2017-10-17 15:55:32', '07'),
('017', 'Cuauhtémoc', '0001', 'Cuauhtémoc', '2017-10-17 15:55:36', '08'),
('017', 'Venustiano Carranza', '----', '', '2017-10-17 15:55:39', '09'),
('017', 'Ocampo', '0001', 'Villa Ocampo', '2017-10-17 15:55:40', '10'),
('017', 'Irapuato', '0001', 'Irapuato', '2017-10-17 15:55:41', '11'),
('017', 'Cocula', '0001', 'Cocula', '2017-10-17 15:55:43', '12'),
('017', 'Chapantongo', '0001', 'Chapantongo', '2017-10-17 15:55:46', '13'),
('017', 'Ayutla', '0001', 'Ayutla', '2017-10-17 15:55:49', '14'),
('017', 'Ayapango', '0001', 'Ayapango de Gabriel Ramos M.', '2017-10-17 15:55:54', '15'),
('017', 'Contepec', '0001', 'Contepec', '2017-10-17 15:55:58', '16'),
('017', 'Puente de Ixtla', '0001', 'Puente de Ixtla', '2017-10-17 15:56:03', '17'),
('017', 'Tepic', '0001', 'Tepic', '2017-10-17 15:56:04', '18'),
('017', 'Galeana', '0001', 'Galeana', '2017-10-17 15:56:05', '19'),
('017', 'La Compañía', '0001', 'La Compañía', '2017-10-17 15:56:07', '20'),
('017', 'Atempan', '0001', 'Atempan', '2017-10-17 15:56:31', '21'),
('017', 'Tequisquiapan', '0001', 'Tequisquiapan', '2017-10-17 15:56:40', '22'),
('017', 'Guadalcázar', '0001', 'Guadalcázar', '2017-10-17 15:56:41', '24'),
('017', 'Sinaloa', '0001', 'Sinaloa de Leyva', '2017-10-17 15:56:43', '25'),
('017', 'Caborca', '0001', 'Heroica Caborca', '2017-10-17 15:56:44', '26'),
('017', 'Tenosique', '0001', 'Tenosique de Pino Suárez', '2017-10-17 15:56:47', '27'),
('017', 'Jaumave', '0001', 'Jaumave', '2017-10-17 15:56:48', '28'),
('017', 'Mazatecochco de José María Morelos', '0001', 'Mazatecochco', '2017-10-17 15:56:49', '29'),
('017', 'Apazapan', '0001', 'Apazapan', '2017-10-17 15:56:52', '30'),
('017', 'Chankom', '0001', 'Chankom', '2017-10-17 15:57:01', '31'),
('017', 'Guadalupe', '0001', 'Guadalupe', '2017-10-17 15:57:05', '32'),
('018', 'Monclova', '0001', 'Monclova', '2017-10-17 15:55:30', '05'),
('018', 'Coapilla', '0001', 'Coapilla', '2017-10-17 15:55:32', '07'),
('018', 'Cusihuiriachi', '0001', 'Cusihuiriachi', '2017-10-17 15:55:36', '08'),
('018', 'El Oro', '0001', 'Santa María del Oro', '2017-10-17 15:55:40', '10'),
('018', 'Jaral del Progreso', '0001', 'Jaral del Progreso', '2017-10-17 15:55:41', '11'),
('018', 'Copala', '0001', 'Copala', '2017-10-17 15:55:43', '12'),
('018', 'Chapulhuacán', '0001', 'Chapulhuacán', '2017-10-17 15:55:46', '13'),
('018', 'La Barca', '0001', 'La Barca', '2017-10-17 15:55:49', '14'),
('018', 'Calimaya', '0001', 'Calimaya de Díaz González', '2017-10-17 15:55:54', '15'),
('018', 'Copándaro', '0001', 'Copándaro de Galeana', '2017-10-17 15:55:58', '16'),
('018', 'Temixco', '0001', 'Temixco', '2017-10-17 15:56:03', '17'),
('018', 'Tuxpan', '0001', 'Tuxpan', '2017-10-17 15:56:04', '18'),
('018', 'García', '0001', 'García', '2017-10-17 15:56:05', '19'),
('018', 'Concepción Buenavista', '0001', 'Concepción Buenavista', '2017-10-17 15:56:07', '20'),
('018', 'Atexcal', '0001', 'San Martín Atexcal', '2017-10-17 15:56:31', '21'),
('018', 'Tolimán', '0001', 'Tolimán', '2017-10-17 15:56:40', '22'),
('018', 'Huehuetlán', '0001', 'Huehuetlán', '2017-10-17 15:56:41', '24'),
('018', 'Navolato', '0001', 'Navolato', '2017-10-17 15:56:43', '25'),
('018', 'Cajeme', '0001', 'Ciudad Obregón', '2017-10-17 15:56:44', '26'),
('018', 'Jiménez', '0001', 'Santander Jiménez', '2017-10-17 15:56:48', '28'),
('018', 'Contla de Juan Cuamatzi', '0001', 'Contla', '2017-10-17 15:56:49', '29'),
('018', 'Aquila', '0001', 'Aquila', '2017-10-17 15:56:52', '30'),
('018', 'Chapab', '0001', 'Chapab', '2017-10-17 15:57:01', '31'),
('018', 'Huanusco', '0001', 'Huanusco', '2017-10-17 15:57:05', '32'),
('019', 'Morelos', '0001', 'Morelos', '2017-10-17 15:55:30', '05'),
('019', 'Comitán de Domínguez', '0001', 'Comitán de Domínguez', '2017-10-17 15:55:32', '07'),
('019', 'Chihuahua', '0001', 'Chihuahua', '2017-10-17 15:55:36', '08'),
('019', 'Otáez', '0001', 'Otáez', '2017-10-17 15:55:40', '10'),
('019', 'Jerécuaro', '0001', 'Jerécuaro', '2017-10-17 15:55:41', '11'),
('019', 'Copalillo', '0001', 'Copalillo', '2017-10-17 15:55:43', '12'),
('019', 'Chilcuautla', '0001', 'Chilcuautla', '2017-10-17 15:55:46', '13'),
('019', 'Bolaños', '0001', 'Bolaños', '2017-10-17 15:55:49', '14'),
('019', 'Capulhuac', '0001', 'Capulhuac de Mirafuentes', '2017-10-17 15:55:54', '15'),
('019', 'Cotija', '0001', 'Cotija de la Paz', '2017-10-17 15:55:58', '16'),
('019', 'Tepalcingo', '0001', 'Tepalcingo', '2017-10-17 15:56:03', '17'),
('019', 'La Yesca', '0001', 'La Yesca', '2017-10-17 15:56:04', '18'),
('019', 'San Pedro Garza García', '0001', 'San Pedro Garza García', '2017-10-17 15:56:05', '19'),
('019', 'Concepción Pápalo', '0001', 'Concepción Pápalo', '2017-10-17 15:56:07', '20'),
('019', 'Atlixco', '0001', 'Atlixco', '2017-10-17 15:56:31', '21'),
('019', 'Lagunillas', '0001', 'Lagunillas', '2017-10-17 15:56:41', '24'),
('019', 'Cananea', '0001', 'Heroica Ciudad de Cananea', '2017-10-17 15:56:44', '26'),
('019', 'Llera', '0001', 'Llera de Canales', '2017-10-17 15:56:48', '28'),
('019', 'Tepetitla de Lardizábal', '0001', 'Tepetitla', '2017-10-17 15:56:50', '29'),
('019', 'Astacinga', '0001', 'Astacinga', '2017-10-17 15:56:52', '30'),
('019', 'Chemax', '0001', 'Chemax', '2017-10-17 15:57:01', '31'),
('019', 'Jalpa', '0001', 'Jalpa', '2017-10-17 15:57:05', '32'),
('020', 'Múzquiz', '0001', 'Ciudad Melchor Múzquiz', '2017-10-17 15:55:30', '05'),
('020', 'La Concordia', '0001', 'La Concordia', '2017-10-17 15:55:32', '07'),
('020', 'Chínipas', '0001', 'Chínipas de Almada', '2017-10-17 15:55:36', '08'),
('020', 'Pánuco de Coronado', '0001', 'Francisco I. Madero', '2017-10-17 15:55:40', '10'),
('020', 'León', '0001', 'León de los Aldama', '2017-10-17 15:55:41', '11'),
('020', 'Copanatoyac', '0001', 'Copanatoyac', '2017-10-17 15:55:43', '12'),
('020', 'Eloxochitlán', '0001', 'Eloxochitlán', '2017-10-17 15:55:46', '13'),
('020', 'Cabo Corrientes', '0001', 'El Tuito', '2017-10-17 15:55:49', '14'),
('020', 'Coacalco de Berriozábal', '0001', 'San Francisco Coacalco', '2017-10-17 15:55:54', '15'),
('020', 'Cuitzeo', '0001', 'Cuitzeo del Porvenir', '2017-10-17 15:55:58', '16'),
('020', 'Tepoztlán', '0001', 'Tepoztlán', '2017-10-17 15:56:03', '17'),
('020', 'Bahía de Banderas', '0001', 'Valle de Banderas', '2017-10-17 15:56:04', '18'),
('020', 'General Bravo', '0001', 'General Bravo', '2017-10-17 15:56:05', '19'),
('020', 'Constancia del Rosario', '0001', 'Constancia del Rosario', '2017-10-17 15:56:07', '20'),
('020', 'Atoyatempan', '0001', 'Atoyatempan', '2017-10-17 15:56:31', '21'),
('020', 'Matehuala', '0001', 'Matehuala', '2017-10-17 15:56:41', '24'),
('020', 'Carbó', '0001', 'Carbó', '2017-10-17 15:56:44', '26'),
('020', 'Mainero', '0001', 'Villa Mainero', '2017-10-17 15:56:48', '28'),
('020', 'Sanctórum de Lázaro Cárdenas', '0001', 'Sanctórum', '2017-10-17 15:56:50', '29'),
('020', 'Atlahuilco', '0001', 'Atlahuilco', '2017-10-17 15:56:52', '30'),
('020', 'Chicxulub Pueblo', '0001', 'Chicxulub Pueblo', '2017-10-17 15:57:01', '31'),
('020', 'Jerez', '0001', 'Jerez de García Salinas', '2017-10-17 15:57:05', '32'),
('021', 'Nadadores', '0001', 'Nadadores', '2017-10-17 15:55:30', '05'),
('021', 'Copainalá', '0001', 'Copainalá', '2017-10-17 15:55:32', '07'),
('021', 'Delicias', '0001', 'Delicias', '2017-10-17 15:55:36', '08'),
('021', 'Peñón Blanco', '0001', 'Peñón Blanco', '2017-10-17 15:55:40', '10'),
('021', 'Moroleón', '0001', 'Moroleón', '2017-10-17 15:55:41', '11'),
('021', 'Coyuca de Benítez', '0001', 'Coyuca de Benítez', '2017-10-17 15:55:43', '12'),
('021', 'Emiliano Zapata', '0001', 'Emiliano Zapata', '2017-10-17 15:55:46', '13'),
('021', 'Casimiro Castillo', '0001', 'La Resolana', '2017-10-17 15:55:49', '14'),
('021', 'Coatepec Harinas', '0001', 'Coatepec Harinas', '2017-10-17 15:55:54', '15'),
('021', 'Charapan', '0001', 'Charapan', '2017-10-17 15:55:59', '16'),
('021', 'Tetecala', '0001', 'Tetecala', '2017-10-17 15:56:03', '17'),
('021', 'General Escobedo', '0001', 'Ciudad General Escobedo', '2017-10-17 15:56:05', '19'),
('021', 'Cosolapa', '0001', 'Cosolapa', '2017-10-17 15:56:07', '20'),
('021', 'Atzala', '0001', 'Atzala', '2017-10-17 15:56:31', '21'),
('021', 'Mexquitic de Carmona', '0001', 'Mexquitic de Carmona', '2017-10-17 15:56:41', '24'),
('021', 'La Colorada', '0001', 'La Colorada', '2017-10-17 15:56:44', '26'),
('021', 'El Mante', '0001', 'Ciudad Mante', '2017-10-17 15:56:48', '28'),
('021', 'Nanacamilpa de Mariano Arista', '0001', 'Ciudad de Nanacamilpa', '2017-10-17 15:56:50', '29'),
('021', 'Atoyac', '0001', 'Atoyac', '2017-10-17 15:56:52', '30'),
('021', 'Chichimilá', '0001', 'Chichimilá', '2017-10-17 15:57:01', '31'),
('021', 'Jiménez del Teul', '0001', 'Jiménez del Teul', '2017-10-17 15:57:05', '32'),
('022', 'Nava', '0001', 'Nava', '2017-10-17 15:55:30', '05'),
('022', 'Chalchihuitán', '0001', 'Chalchihuitán', '2017-10-17 15:55:32', '07'),
('022', 'Dr. Belisario Domínguez', '0001', 'San Lorenzo', '2017-10-17 15:55:37', '08'),
('022', 'Poanas', '0001', 'Villa Unión', '2017-10-17 15:55:40', '10'),
('022', 'Ocampo', '0001', 'Ocampo', '2017-10-17 15:55:41', '11'),
('022', 'Coyuca de Catalán', '0001', 'Coyuca de Catalán', '2017-10-17 15:55:43', '12'),
('022', 'Epazoyucan', '0001', 'Epazoyucan', '2017-10-17 15:55:46', '13'),
('022', 'Cihuatlán', '0001', 'Cihuatlán', '2017-10-17 15:55:49', '14'),
('022', 'Cocotitlán', '0001', 'Cocotitlán', '2017-10-17 15:55:54', '15'),
('022', 'Charo', '0001', 'Charo', '2017-10-17 15:55:59', '16'),
('022', 'Tetela del Volcán', '0001', 'Tetela del Volcán', '2017-10-17 15:56:03', '17'),
('022', 'General Terán', '0001', 'Ciudad General Terán', '2017-10-17 15:56:05', '19'),
('022', 'Cosoltepec', '0001', 'Cosoltepec', '2017-10-17 15:56:07', '20'),
('022', 'Atzitzihuacán', '0001', 'Santiago Atzitzihuacán', '2017-10-17 15:56:31', '21'),
('022', 'Moctezuma', '0001', 'Moctezuma', '2017-10-17 15:56:41', '24'),
('022', 'Cucurpe', '0001', 'Cucurpe', '2017-10-17 15:56:44', '26'),
('022', 'Matamoros', '0001', 'Heroica Matamoros', '2017-10-17 15:56:48', '28'),
('022', 'Acuamanala de Miguel Hidalgo', '0001', 'Acuamanala', '2017-10-17 15:56:50', '29'),
('022', 'Atzacan', '0001', 'Atzacan', '2017-10-17 15:56:52', '30'),
('022', 'Chikindzonot', '0001', 'Chikindzonot', '2017-10-17 15:57:01', '31'),
('022', 'Juan Aldama', '0001', 'Juan Aldama', '2017-10-17 15:57:05', '32'),
('023', 'Ocampo', '0001', 'Ocampo', '2017-10-17 15:55:30', '05'),
('023', 'Chamula', '0001', 'Chamula', '2017-10-17 15:55:32', '07'),
('023', 'Galeana', '0001', 'Hermenegildo Galeana', '2017-10-17 15:55:37', '08'),
('023', 'Pueblo Nuevo', '0001', 'El Salto', '2017-10-17 15:55:40', '10'),
('023', 'Pénjamo', '0001', 'Pénjamo', '2017-10-17 15:55:41', '11'),
('023', 'Cuajinicuilapa', '0001', 'Cuajinicuilapa', '2017-10-17 15:55:43', '12'),
('023', 'Francisco I. Madero', '0001', 'Tepatepec', '2017-10-17 15:55:46', '13'),
('023', 'Zapotlán el Grande', '0001', 'Ciudad Guzmán', '2017-10-17 15:55:50', '14'),
('023', 'Coyotepec', '0001', 'Coyotepec', '2017-10-17 15:55:54', '15'),
('023', 'Chavinda', '0001', 'Chavinda', '2017-10-17 15:55:59', '16'),
('023', 'Tlalnepantla', '0001', 'Tlalnepantla', '2017-10-17 15:56:03', '17'),
('023', 'General Treviño', '0001', 'General Treviño', '2017-10-17 15:56:05', '19'),
('023', 'Cuilápam de Guerrero', '0001', 'Cuilápam de Guerrero', '2017-10-17 15:56:07', '20'),
('023', 'Atzitzintla', '0001', 'Atzitzintla', '2017-10-17 15:56:31', '21'),
('023', 'Rayón', '0001', 'Rayón', '2017-10-17 15:56:41', '24'),
('023', 'Cumpas', '0001', 'Cumpas', '2017-10-17 15:56:44', '26'),
('023', 'Méndez', '0001', 'Méndez', '2017-10-17 15:56:48', '28'),
('023', 'Natívitas', '0001', 'Natívitas', '2017-10-17 15:56:50', '29'),
('023', 'Atzalan', '0001', 'Atzalan', '2017-10-17 15:56:52', '30'),
('023', 'Chocholá', '0001', 'Chocholá', '2017-10-17 15:57:01', '31'),
('023', 'Juchipila', '0001', 'Juchipila', '2017-10-17 15:57:05', '32'),
('024', 'Parras', '0001', 'Parras de la Fuente', '2017-10-17 15:55:31', '05'),
('024', 'Chanal', '0001', 'Chanal', '2017-10-17 15:55:32', '07'),
('024', 'Santa Isabel', '0001', 'Santa Isabel', '2017-10-17 15:55:37', '08'),
('024', 'Rodeo', '0001', 'Rodeo', '2017-10-17 15:55:40', '10'),
('024', 'Pueblo Nuevo', '0001', 'Pueblo Nuevo', '2017-10-17 15:55:42', '11'),
('024', 'Cualác', '0001', 'Cualác', '2017-10-17 15:55:43', '12'),
('024', 'Huasca de Ocampo', '0001', 'Huasca de Ocampo', '2017-10-17 15:55:46', '13'),
('024', 'Cocula', '0001', 'Cocula', '2017-10-17 15:55:50', '14'),
('024', 'Cuautitlán', '0001', 'Cuautitlán', '2017-10-17 15:55:54', '15'),
('024', 'Cherán', '0001', 'Cherán', '2017-10-17 15:55:59', '16'),
('024', 'Tlaltizapán de Zapata', '0001', 'Tlaltizapán', '2017-10-17 15:56:03', '17'),
('024', 'General Zaragoza', '0001', 'General Zaragoza', '2017-10-17 15:56:05', '19'),
('024', 'Cuyamecalco Villa de Zaragoza', '0001', 'Cuyamecalco Villa de Zaragoza', '2017-10-17 15:56:07', '20'),
('024', 'Axutla', '0001', 'Axutla', '2017-10-17 15:56:31', '21'),
('024', 'Rioverde', '0001', 'Rioverde', '2017-10-17 15:56:41', '24'),
('024', 'Divisaderos', '0001', 'Divisaderos', '2017-10-17 15:56:44', '26'),
('024', 'Mier', '0001', 'Mier', '2017-10-17 15:56:48', '28'),
('024', 'Panotla', '0001', 'Panotla', '2017-10-17 15:56:50', '29'),
('024', 'Tlaltetela', '0001', 'Tlaltetela', '2017-10-17 15:56:52', '30'),
('024', 'Chumayel', '0001', 'Chumayel', '2017-10-17 15:57:01', '31'),
('024', 'Loreto', '0001', 'Loreto', '2017-10-17 15:57:05', '32'),
('025', 'Piedras Negras', '0001', 'Piedras Negras', '2017-10-17 15:55:31', '05'),
('025', 'Chapultenango', '0001', 'Chapultenango', '2017-10-17 15:55:32', '07'),
('025', 'Gómez Farías', '0001', 'Valentín Gómez Farías', '2017-10-17 15:55:37', '08'),
('025', 'San Bernardo', '0001', 'San Bernardo', '2017-10-17 15:55:40', '10'),
('025', 'Purísima del Rincón', '0001', 'Purísima de Bustos', '2017-10-17 15:55:42', '11'),
('025', 'Cuautepec', '0001', 'Cuautepec', '2017-10-17 15:55:43', '12'),
('025', 'Huautla', '0001', 'Huautla', '2017-10-17 15:55:46', '13'),
('025', 'Colotlán', '0001', 'Colotlán', '2017-10-17 15:55:50', '14'),
('025', 'Chalco', '0001', 'Chalco de Díaz Covarrubias', '2017-10-17 15:55:54', '15'),
('025', 'Chilchota', '0001', 'Chilchota', '2017-10-17 15:55:59', '16'),
('025', 'Tlaquiltenango', '0001', 'Tlaquiltenango', '2017-10-17 15:56:03', '17'),
('025', 'General Zuazua', '0001', 'General Zuazua', '2017-10-17 15:56:05', '19'),
('025', 'Chahuites', '0001', 'Chahuites', '2017-10-17 15:56:07', '20'),
('025', 'Ayotoxco de Guerrero', '0001', 'Ayotoxco de Guerrero', '2017-10-17 15:56:31', '21'),
('025', 'Salinas', '0001', 'Salinas de Hidalgo', '2017-10-17 15:56:41', '24'),
('025', 'Empalme', '0001', 'Empalme', '2017-10-17 15:56:44', '26'),
('025', 'Miguel Alemán', '0001', 'Ciudad Miguel Alemán', '2017-10-17 15:56:48', '28'),
('025', 'San Pablo del Monte', '0001', 'Villa Vicente Guerrero', '2017-10-17 15:56:50', '29'),
('025', 'Ayahualulco', '0001', 'Ayahualulco', '2017-10-17 15:56:52', '30'),
('025', 'Dzán', '0001', 'Dzán', '2017-10-17 15:57:01', '31'),
('025', 'Luis Moya', '0001', 'Luis Moya', '2017-10-17 15:57:05', '32');
INSERT INTO `municipio` (`cve_mun`, `nom_mun`, `cve_cab`, `nom_cab`, `fechaModificacion`, `cve_ent`) VALUES
('026', 'Progreso', '0001', 'Progreso', '2017-10-17 15:55:31', '05'),
('026', 'Chenalhó', '0001', 'Chenalhó', '2017-10-17 15:55:32', '07'),
('026', 'Gran Morelos', '0001', 'San Nicolás de Carretas', '2017-10-17 15:55:37', '08'),
('026', 'San Dimas', '0001', 'Tayoltita', '2017-10-17 15:55:40', '10'),
('026', 'Romita', '0001', 'Romita', '2017-10-17 15:55:42', '11'),
('026', 'Cuetzala del Progreso', '0001', 'Cuetzala del Progreso', '2017-10-17 15:55:43', '12'),
('026', 'Huazalingo', '0001', 'Huazalingo', '2017-10-17 15:55:46', '13'),
('026', 'Concepción de Buenos Aires', '0001', 'Concepción de Buenos Aires', '2017-10-17 15:55:50', '14'),
('026', 'Chapa de Mota', '0001', 'Chapa de Mota', '2017-10-17 15:55:54', '15'),
('026', 'Chinicuila', '0001', 'Villa Victoria', '2017-10-17 15:55:59', '16'),
('026', 'Tlayacapan', '0001', 'Tlayacapan', '2017-10-17 15:56:03', '17'),
('026', 'Guadalupe', '0001', 'Guadalupe', '2017-10-17 15:56:05', '19'),
('026', 'Chalcatongo de Hidalgo', '0001', 'Chalcatongo de Hidalgo', '2017-10-17 15:56:07', '20'),
('026', 'Calpan', '0001', 'San Andrés Calpan', '2017-10-17 15:56:31', '21'),
('026', 'San Antonio', '0001', 'San Antonio', '2017-10-17 15:56:41', '24'),
('026', 'Etchojoa', '0001', 'Etchojoa', '2017-10-17 15:56:44', '26'),
('026', 'Miquihuana', '0001', 'Miquihuana', '2017-10-17 15:56:48', '28'),
('026', 'Santa Cruz Tlaxcala', '0001', 'Santa Cruz Tlaxcala', '2017-10-17 15:56:50', '29'),
('026', 'Banderilla', '0001', 'Banderilla', '2017-10-17 15:56:52', '30'),
('026', 'Dzemul', '0001', 'Dzemul', '2017-10-17 15:57:01', '31'),
('026', 'Mazapil', '0001', 'Mazapil', '2017-10-17 15:57:05', '32'),
('027', 'Ramos Arizpe', '0001', 'Ramos Arizpe', '2017-10-17 15:55:31', '05'),
('027', 'Chiapa de Corzo', '0001', 'Chiapa de Corzo', '2017-10-17 15:55:32', '07'),
('027', 'Guachochi', '0001', 'Guachochi', '2017-10-17 15:55:37', '08'),
('027', 'San Juan de Guadalupe', '0001', 'San Juan de Guadalupe', '2017-10-17 15:55:40', '10'),
('027', 'Salamanca', '0001', 'Salamanca', '2017-10-17 15:55:42', '11'),
('027', 'Cutzamala de Pinzón', '0001', 'Cutzamala de Pinzón', '2017-10-17 15:55:43', '12'),
('027', 'Huehuetla', '0001', 'Huehuetla', '2017-10-17 15:55:46', '13'),
('027', 'Cuautitlán de García Barragán', '0001', 'Cuautitlán de García Barragán', '2017-10-17 15:55:50', '14'),
('027', 'Chapultepec', '0001', 'Chapultepec', '2017-10-17 15:55:54', '15'),
('027', 'Chucándiro', '0001', 'Chucándiro', '2017-10-17 15:55:59', '16'),
('027', 'Totolapan', '0001', 'Totolapan', '2017-10-17 15:56:03', '17'),
('027', 'Los Herreras', '0001', 'Los Herreras', '2017-10-17 15:56:05', '19'),
('027', 'Chiquihuitlán de Benito Juárez', '0001', 'Chiquihuitlán de Benito Juárez', '2017-10-17 15:56:07', '20'),
('027', 'Caltepec', '0001', 'Caltepec', '2017-10-17 15:56:31', '21'),
('027', 'San Ciro de Acosta', '0001', 'San Ciro de Acosta', '2017-10-17 15:56:41', '24'),
('027', 'Fronteras', '0001', 'Fronteras', '2017-10-17 15:56:44', '26'),
('027', 'Nuevo Laredo', '0001', 'Nuevo Laredo', '2017-10-17 15:56:48', '28'),
('027', 'Tenancingo', '0001', 'Tenancingo', '2017-10-17 15:56:50', '29'),
('027', 'Benito Juárez', '0001', 'Benito Juárez', '2017-10-17 15:56:52', '30'),
('027', 'Dzidzantún', '0001', 'Dzidzantún', '2017-10-17 15:57:01', '31'),
('027', 'Melchor Ocampo', '0001', 'Melchor Ocampo', '2017-10-17 15:57:05', '32'),
('028', 'Sabinas', '0001', 'Sabinas', '2017-10-17 15:55:31', '05'),
('028', 'Chiapilla', '0001', 'Chiapilla', '2017-10-17 15:55:32', '07'),
('028', 'Guadalupe', '0001', 'Guadalupe', '2017-10-17 15:55:37', '08'),
('028', 'San Juan del Río', '0001', 'San Juan del Río del Centauro del Norte', '2017-10-17 15:55:40', '10'),
('028', 'Salvatierra', '0001', 'Salvatierra', '2017-10-17 15:55:42', '11'),
('028', 'Chilapa de Álvarez', '0001', 'Chilapa de Álvarez', '2017-10-17 15:55:44', '12'),
('028', 'Huejutla de Reyes', '0001', 'Huejutla de Reyes', '2017-10-17 15:55:47', '13'),
('028', 'Cuautla', '0001', 'Cuautla', '2017-10-17 15:55:50', '14'),
('028', 'Chiautla', '0001', 'Chiautla', '2017-10-17 15:55:54', '15'),
('028', 'Churintzio', '0001', 'Churintzio', '2017-10-17 15:55:59', '16'),
('028', 'Xochitepec', '0001', 'Xochitepec', '2017-10-17 15:56:03', '17'),
('028', 'Higueras', '0001', 'Higueras', '2017-10-17 15:56:05', '19'),
('028', 'Heroica Ciudad de Ejutla de Crespo', '0001', 'Heroica Ciudad de Ejutla de Crespo', '2017-10-17 15:56:07', '20'),
('028', 'Camocuautla', '0001', 'Camocuautla', '2017-10-17 15:56:31', '21'),
('028', 'San Luis Potosí', '0001', 'San Luis Potosí', '2017-10-17 15:56:41', '24'),
('028', 'Granados', '0001', 'Granados', '2017-10-17 15:56:44', '26'),
('028', 'Nuevo Morelos', '0001', 'Nuevo Morelos', '2017-10-17 15:56:48', '28'),
('028', 'Teolocholco', '0001', 'Teolocholco', '2017-10-17 15:56:50', '29'),
('028', 'Boca del Río', '0001', 'Boca del Río', '2017-10-17 15:56:52', '30'),
('028', 'Dzilam de Bravo', '0001', 'Dzilam de Bravo', '2017-10-17 15:57:01', '31'),
('028', 'Mezquital del Oro', '0001', 'Mezquital del Oro', '2017-10-17 15:57:05', '32'),
('029', 'Sacramento', '0001', 'Sacramento', '2017-10-17 15:55:31', '05'),
('029', 'Chicoasén', '0001', 'Chicoasén', '2017-10-17 15:55:32', '07'),
('029', 'Guadalupe y Calvo', '0001', 'Guadalupe y Calvo', '2017-10-17 15:55:37', '08'),
('029', 'San Luis del Cordero', '0001', 'San Luis del Cordero', '2017-10-17 15:55:40', '10'),
('029', 'San Diego de la Unión', '0001', 'San Diego de la Unión', '2017-10-17 15:55:42', '11'),
('029', 'Chilpancingo de los Bravo', '0001', 'Chilpancingo de los Bravo', '2017-10-17 15:55:44', '12'),
('029', 'Huichapan', '0001', 'Huichapan', '2017-10-17 15:55:47', '13'),
('029', 'Cuquío', '0001', 'Cuquío', '2017-10-17 15:55:50', '14'),
('029', 'Chicoloapan', '0001', 'Chicoloapan de Juárez', '2017-10-17 15:55:54', '15'),
('029', 'Churumuco', '0001', 'Churumuco de Morelos', '2017-10-17 15:55:59', '16'),
('029', 'Yautepec', '0001', 'Yautepec de Zaragoza', '2017-10-17 15:56:03', '17'),
('029', 'Hualahuises', '0001', 'Hualahuises', '2017-10-17 15:56:05', '19'),
('029', 'Eloxochitlán de Flores Magón', '0001', 'Eloxochitlán de Flores Magón', '2017-10-17 15:56:07', '20'),
('029', 'Caxhuacan', '0001', 'Caxhuacan', '2017-10-17 15:56:31', '21'),
('029', 'San Martín Chalchicuautla', '0001', 'San Martín Chalchicuautla', '2017-10-17 15:56:41', '24'),
('029', 'Guaymas', '0001', 'Heroica Guaymas', '2017-10-17 15:56:44', '26'),
('029', 'Ocampo', '0001', 'Ocampo', '2017-10-17 15:56:48', '28'),
('029', 'Tepeyanco', '0001', 'Tepeyanco', '2017-10-17 15:56:50', '29'),
('029', 'Calcahualco', '0001', 'Calcahualco', '2017-10-17 15:56:52', '30'),
('029', 'Dzilam González', '0001', 'Dzilam González', '2017-10-17 15:57:01', '31'),
('029', 'Miguel Auza', '0001', 'Miguel Auza', '2017-10-17 15:57:05', '32'),
('030', 'Saltillo', '0001', 'Saltillo', '2017-10-17 15:55:31', '05'),
('030', 'Chicomuselo', '0001', 'Chicomuselo', '2017-10-17 15:55:32', '07'),
('030', 'Guazapares', '0001', 'Témoris', '2017-10-17 15:55:37', '08'),
('030', 'San Pedro del Gallo', '0001', 'San Pedro del Gallo', '2017-10-17 15:55:40', '10'),
('030', 'San Felipe', '0001', 'San Felipe', '2017-10-17 15:55:42', '11'),
('030', 'Florencio Villarreal', '0001', 'Cruz Grande', '2017-10-17 15:55:44', '12'),
('030', 'Ixmiquilpan', '0001', 'Ixmiquilpan', '2017-10-17 15:55:47', '13'),
('030', 'Chapala', '0001', 'Chapala', '2017-10-17 15:55:50', '14'),
('030', 'Chiconcuac', '0001', 'Chiconcuac de Juárez', '2017-10-17 15:55:54', '15'),
('030', 'Ecuandureo', '0001', 'Ecuandureo', '2017-10-17 15:55:59', '16'),
('030', 'Yecapixtla', '0001', 'Yecapixtla', '2017-10-17 15:56:03', '17'),
('030', 'Iturbide', '0001', 'Iturbide', '2017-10-17 15:56:05', '19'),
('030', 'El Espinal', '0001', 'El Espinal', '2017-10-17 15:56:07', '20'),
('030', 'Coatepec', '0001', 'Coatepec', '2017-10-17 15:56:31', '21'),
('030', 'San Nicolás Tolentino', '0001', 'San Nicolás Tolentino', '2017-10-17 15:56:41', '24'),
('030', 'Hermosillo', '0001', 'Hermosillo', '2017-10-17 15:56:44', '26'),
('030', 'Padilla', '0001', 'Nueva Villa de Padilla', '2017-10-17 15:56:48', '28'),
('030', 'Terrenate', '0001', 'Terrenate', '2017-10-17 15:56:50', '29'),
('030', 'Camerino Z. Mendoza', '0001', 'Ciudad Mendoza', '2017-10-17 15:56:52', '30'),
('030', 'Dzitás', '0001', 'Dzitás', '2017-10-17 15:57:01', '31'),
('030', 'Momax', '0001', 'Momax', '2017-10-17 15:57:05', '32'),
('031', 'San Buenaventura', '0001', 'San Buenaventura', '2017-10-17 15:55:31', '05'),
('031', 'Chilón', '0001', 'Chilón', '2017-10-17 15:55:33', '07'),
('031', 'Guerrero', '0001', 'Vicente Guerrero', '2017-10-17 15:55:37', '08'),
('031', 'Santa Clara', '0001', 'Santa Clara', '2017-10-17 15:55:40', '10'),
('031', 'San Francisco del Rincón', '0001', 'San Francisco del Rincón', '2017-10-17 15:55:42', '11'),
('031', 'General Canuto A. Neri', '0001', 'Acapetlahuaya', '2017-10-17 15:55:44', '12'),
('031', 'Jacala de Ledezma', '0001', 'Jacala', '2017-10-17 15:55:47', '13'),
('031', 'Chimaltitán', '0001', 'Chimaltitán', '2017-10-17 15:55:50', '14'),
('031', 'Chimalhuacán', '0001', 'Chimalhuacán', '2017-10-17 15:55:54', '15'),
('031', 'Epitacio Huerta', '0001', 'Epitacio Huerta', '2017-10-17 15:55:59', '16'),
('031', 'Zacatepec', '0001', 'Zacatepec de Hidalgo', '2017-10-17 15:56:04', '17'),
('031', 'Juárez', '0001', 'Ciudad Benito Juárez', '2017-10-17 15:56:05', '19'),
('031', 'Tamazulápam del Espíritu Santo', '0001', 'Tamazulápam del Espíritu Santo', '2017-10-17 15:56:07', '20'),
('031', 'Coatzingo', '0001', 'Coatzingo', '2017-10-17 15:56:32', '21'),
('031', 'Santa Catarina', '0001', 'Santa Catarina', '2017-10-17 15:56:42', '24'),
('031', 'Huachinera', '0001', 'Huachinera', '2017-10-17 15:56:44', '26'),
('031', 'Palmillas', '0001', 'Palmillas', '2017-10-17 15:56:48', '28'),
('031', 'Tetla de la Solidaridad', '0001', 'Tetla', '2017-10-17 15:56:50', '29'),
('031', 'Carrillo Puerto', '0001', 'Tamarindo', '2017-10-17 15:56:53', '30'),
('031', 'Dzoncauich', '0001', 'Dzoncauich', '2017-10-17 15:57:01', '31'),
('031', 'Monte Escobedo', '0001', 'Monte Escobedo', '2017-10-17 15:57:05', '32'),
('032', 'San Juan de Sabinas', '0014', 'Nueva Rosita', '2017-10-17 15:55:31', '05'),
('032', 'Escuintla', '0001', 'Escuintla', '2017-10-17 15:55:33', '07'),
('032', 'Hidalgo del Parral', '0001', 'Hidalgo del Parral', '2017-10-17 15:55:37', '08'),
('032', 'Santiago Papasquiaro', '0001', 'Santiago Papasquiaro', '2017-10-17 15:55:40', '10'),
('032', 'San José Iturbide', '0001', 'San José Iturbide', '2017-10-17 15:55:42', '11'),
('032', 'General Heliodoro Castillo', '0001', 'Tlacotepec', '2017-10-17 15:55:44', '12'),
('032', 'Jaltocán', '0001', 'Jaltocán', '2017-10-17 15:55:47', '13'),
('032', 'Chiquilistlán', '0001', 'Chiquilistlán', '2017-10-17 15:55:50', '14'),
('032', 'Donato Guerra', '0001', 'Villa Donato Guerra', '2017-10-17 15:55:54', '15'),
('032', 'Erongarícuaro', '0001', 'Erongarícuaro', '2017-10-17 15:55:59', '16'),
('032', 'Zacualpan de Amilpas', '0001', 'Zacualpan de Amilpas', '2017-10-17 15:56:04', '17'),
('032', 'Lampazos de Naranjo', '0001', 'Lampazos de Naranjo', '2017-10-17 15:56:06', '19'),
('032', 'Fresnillo de Trujano', '0001', 'Fresnillo de Trujano', '2017-10-17 15:56:07', '20'),
('032', 'Cohetzala', '0001', 'Santa María Cohetzala', '2017-10-17 15:56:32', '21'),
('032', 'Santa María del Río', '0001', 'Santa María del Río', '2017-10-17 15:56:42', '24'),
('032', 'Huásabas', '0001', 'Huásabas', '2017-10-17 15:56:44', '26'),
('032', 'Reynosa', '0001', 'Reynosa', '2017-10-17 15:56:48', '28'),
('032', 'Tetlatlahuca', '0001', 'Tetlatlahuca', '2017-10-17 15:56:50', '29'),
('032', 'Catemaco', '0001', 'Catemaco', '2017-10-17 15:56:53', '30'),
('032', 'Espita', '0001', 'Espita', '2017-10-17 15:57:01', '31'),
('032', 'Morelos', '0001', 'Morelos', '2017-10-17 15:57:05', '32'),
('033', 'San Pedro', '0001', 'San Pedro', '2017-10-17 15:55:31', '05'),
('033', 'Francisco León', '0042', 'Rivera el Viejo Carmen', '2017-10-17 15:55:33', '07'),
('033', 'Huejotitán', '0001', 'Huejotitán', '2017-10-17 15:55:37', '08'),
('033', 'Súchil', '0001', 'Súchil', '2017-10-17 15:55:40', '10'),
('033', 'San Luis de la Paz', '0001', 'San Luis de la Paz', '2017-10-17 15:55:42', '11'),
('033', 'Huamuxtitlán', '0001', 'Huamuxtitlán', '2017-10-17 15:55:44', '12'),
('033', 'Juárez Hidalgo', '0001', 'Juárez', '2017-10-17 15:55:47', '13'),
('033', 'Degollado', '0001', 'Degollado', '2017-10-17 15:55:50', '14'),
('033', 'Ecatepec de Morelos', '0001', 'Ecatepec de Morelos', '2017-10-17 15:55:54', '15'),
('033', 'Gabriel Zamora', '0001', 'Lombardía', '2017-10-17 15:55:59', '16'),
('033', 'Temoac', '0001', 'Temoac', '2017-10-17 15:56:04', '17'),
('033', 'Linares', '0001', 'Linares', '2017-10-17 15:56:06', '19'),
('033', 'Guadalupe Etla', '0001', 'Guadalupe Etla', '2017-10-17 15:56:07', '20'),
('033', 'Cohuecan', '0001', 'Cohuecan', '2017-10-17 15:56:32', '21'),
('033', 'Santo Domingo', '0001', 'Santo Domingo', '2017-10-17 15:56:42', '24'),
('033', 'Huatabampo', '0001', 'Huatabampo', '2017-10-17 15:56:45', '26'),
('033', 'Río Bravo', '0001', 'Ciudad Río Bravo', '2017-10-17 15:56:48', '28'),
('033', 'Tlaxcala', '0001', 'Tlaxcala de Xicohténcatl', '2017-10-17 15:56:50', '29'),
('033', 'Cazones de Herrera', '0001', 'Cazones de Herrera', '2017-10-17 15:56:53', '30'),
('033', 'Halachó', '0001', 'Halachó', '2017-10-17 15:57:01', '31'),
('033', 'Moyahua de Estrada', '0001', 'Moyahua de Estrada', '2017-10-17 15:57:05', '32'),
('034', 'Sierra Mojada', '0001', 'Sierra Mojada', '2017-10-17 15:55:31', '05'),
('034', 'Frontera Comalapa', '0001', 'Frontera Comalapa', '2017-10-17 15:55:33', '07'),
('034', 'Ignacio Zaragoza', '0001', 'Ignacio Zaragoza', '2017-10-17 15:55:37', '08'),
('034', 'Tamazula', '0001', 'Tamazula de Victoria', '2017-10-17 15:55:40', '10'),
('034', 'Santa Catarina', '0001', 'Santa Catarina', '2017-10-17 15:55:42', '11'),
('034', 'Huitzuco de los Figueroa', '0001', 'Ciudad de Huitzuco', '2017-10-17 15:55:44', '12'),
('034', 'Lolotla', '0001', 'Lolotla', '2017-10-17 15:55:47', '13'),
('034', 'Ejutla', '0001', 'Ejutla', '2017-10-17 15:55:50', '14'),
('034', 'Ecatzingo', '0001', 'Ecatzingo de Hidalgo', '2017-10-17 15:55:54', '15'),
('034', 'Hidalgo', '0001', 'Ciudad Hidalgo', '2017-10-17 15:55:59', '16'),
('034', 'Marín', '0001', 'Marín', '2017-10-17 15:56:06', '19'),
('034', 'Guadalupe de Ramírez', '0001', 'Guadalupe de Ramírez', '2017-10-17 15:56:07', '20'),
('034', 'Coronango', '0001', 'Santa María Coronango', '2017-10-17 15:56:32', '21'),
('034', 'San Vicente Tancuayalab', '0001', 'San Vicente Tancuayalab', '2017-10-17 15:56:42', '24'),
('034', 'Huépac', '0001', 'Huépac', '2017-10-17 15:56:45', '26'),
('034', 'San Carlos', '0001', 'San Carlos', '2017-10-17 15:56:48', '28'),
('034', 'Tlaxco', '0001', 'Tlaxco', '2017-10-17 15:56:50', '29'),
('034', 'Cerro Azul', '0001', 'Cerro Azul', '2017-10-17 15:56:53', '30'),
('034', 'Hocabá', '0001', 'Hocabá', '2017-10-17 15:57:01', '31'),
('034', 'Nochistlán de Mejía', '0001', 'Nochistlán de Mejía', '2017-10-17 15:57:06', '32'),
('035', 'Torreón', '0001', 'Torreón', '2017-10-17 15:55:31', '05'),
('035', 'Frontera Hidalgo', '0001', 'Frontera Hidalgo', '2017-10-17 15:55:33', '07'),
('035', 'Janos', '0001', 'Janos', '2017-10-17 15:55:37', '08'),
('035', 'Tepehuanes', '0001', 'Santa Catarina de Tepehuanes', '2017-10-17 15:55:41', '10'),
('035', 'Santa Cruz de Juventino Rosas', '0001', 'Juventino Rosas', '2017-10-17 15:55:42', '11'),
('035', 'Iguala de la Independencia', '0001', 'Iguala de la Independencia', '2017-10-17 15:55:44', '12'),
('035', 'Metepec', '0001', 'Metepec', '2017-10-17 15:55:47', '13'),
('035', 'Encarnación de Díaz', '0001', 'Encarnación de Díaz', '2017-10-17 15:55:50', '14'),
('035', 'Huehuetoca', '0001', 'Huehuetoca', '2017-10-17 15:55:54', '15'),
('035', 'La Huacana', '0001', 'La Huacana', '2017-10-17 15:55:59', '16'),
('035', 'Melchor Ocampo', '0001', 'Melchor Ocampo', '2017-10-17 15:56:06', '19'),
('035', 'Guelatao de Juárez', '0001', 'Guelatao de Juárez', '2017-10-17 15:56:07', '20'),
('035', 'Coxcatlán', '0001', 'Coxcatlán', '2017-10-17 15:56:32', '21'),
('035', 'Soledad de Graciano Sánchez', '0001', 'Soledad de Graciano Sánchez', '2017-10-17 15:56:42', '24'),
('035', 'Imuris', '0001', 'Imuris', '2017-10-17 15:56:45', '26'),
('035', 'San Fernando', '0001', 'San Fernando', '2017-10-17 15:56:48', '28'),
('035', 'Tocatlán', '0001', 'Tocatlán', '2017-10-17 15:56:50', '29'),
('035', 'Citlaltépetl', '0001', 'Citlaltépec', '2017-10-17 15:56:53', '30'),
('035', 'Hoctún', '0001', 'Hoctún', '2017-10-17 15:57:01', '31'),
('035', 'Noria de Ángeles', '0001', 'Noria de Ángeles', '2017-10-17 15:57:06', '32'),
('036', 'Viesca', '0001', 'Viesca', '2017-10-17 15:55:31', '05'),
('036', 'La Grandeza', '0001', 'La Grandeza', '2017-10-17 15:55:33', '07'),
('036', 'Jiménez', '0001', 'José Mariano Jiménez', '2017-10-17 15:55:37', '08'),
('036', 'Tlahualilo', '0001', 'Tlahualilo de Zaragoza', '2017-10-17 15:55:41', '10'),
('036', 'Santiago Maravatío', '0001', 'Santiago Maravatío', '2017-10-17 15:55:42', '11'),
('036', 'Igualapa', '0001', 'Igualapa', '2017-10-17 15:55:44', '12'),
('036', 'San Agustín Metzquititlán', '0001', 'Mezquititlán', '2017-10-17 15:55:47', '13'),
('036', 'Etzatlán', '0001', 'Etzatlán', '2017-10-17 15:55:50', '14'),
('036', 'Hueypoxtla', '0001', 'Hueypoxtla', '2017-10-17 15:55:55', '15'),
('036', 'Huandacareo', '0001', 'Huandacareo', '2017-10-17 15:55:59', '16'),
('036', 'Mier y Noriega', '0001', 'Mier y Noriega', '2017-10-17 15:56:06', '19'),
('036', 'Guevea de Humboldt', '0001', 'Guevea de Humboldt', '2017-10-17 15:56:08', '20'),
('036', 'Coyomeapan', '0001', 'Santa María Coyomeapan', '2017-10-17 15:56:32', '21'),
('036', 'Tamasopo', '0001', 'Tamasopo', '2017-10-17 15:56:42', '24'),
('036', 'Magdalena', '0001', 'Magdalena de Kino', '2017-10-17 15:56:45', '26'),
('036', 'San Nicolás', '0001', 'San Nicolás', '2017-10-17 15:56:48', '28'),
('036', 'Totolac', '0001', 'San Juan Totolac', '2017-10-17 15:56:50', '29'),
('036', 'Coacoatzintla', '0001', 'Coacoatzintla', '2017-10-17 15:56:53', '30'),
('036', 'Homún', '0001', 'Homún', '2017-10-17 15:57:01', '31'),
('036', 'Ojocaliente', '0001', 'Ojocaliente', '2017-10-17 15:57:06', '32'),
('037', 'Villa Unión', '0001', 'Villa Unión', '2017-10-17 15:55:31', '05'),
('037', 'Huehuetán', '0001', 'Huehuetán', '2017-10-17 15:55:33', '07'),
('037', 'Juárez', '0001', 'Juárez', '2017-10-17 15:55:37', '08'),
('037', 'Topia', '0001', 'Topia', '2017-10-17 15:55:41', '10'),
('037', 'Silao de la Victoria', '0001', 'Silao de la Victoria', '2017-10-17 15:55:42', '11'),
('037', 'Ixcateopan de Cuauhtémoc', '0001', 'Ixcateopan de Cuauhtémoc', '2017-10-17 15:55:44', '12'),
('037', 'Metztitlán', '0001', 'Metztitlán', '2017-10-17 15:55:47', '13'),
('037', 'El Grullo', '0001', 'El Grullo', '2017-10-17 15:55:50', '14'),
('037', 'Huixquilucan', '0001', 'Huixquilucan de Degollado', '2017-10-17 15:55:55', '15'),
('037', 'Huaniqueo', '0001', 'Huaniqueo de Morales', '2017-10-17 15:55:59', '16'),
('037', 'Mina', '0001', 'Mina', '2017-10-17 15:56:06', '19'),
('037', 'Mesones Hidalgo', '0001', 'Mesones Hidalgo', '2017-10-17 15:56:08', '20'),
('037', 'Coyotepec', '0001', 'San Vicente Coyotepec', '2017-10-17 15:56:32', '21'),
('037', 'Tamazunchale', '0001', 'Tamazunchale', '2017-10-17 15:56:42', '24'),
('037', 'Mazatán', '0001', 'Mazatán', '2017-10-17 15:56:45', '26'),
('037', 'Soto la Marina', '0001', 'Soto la Marina', '2017-10-17 15:56:48', '28'),
('037', 'Ziltlaltépec de Trinidad Sánchez Santos', '0001', 'Zitlaltépec', '2017-10-17 15:56:50', '29'),
('037', 'Coahuitlán', '0001', 'Progreso de Zaragoza', '2017-10-17 15:56:53', '30'),
('037', 'Huhí', '0001', 'Huhí', '2017-10-17 15:57:01', '31'),
('037', 'Pánuco', '0001', 'Pánuco', '2017-10-17 15:57:06', '32'),
('038', 'Zaragoza', '0001', 'Zaragoza', '2017-10-17 15:55:31', '05'),
('038', 'Huixtán', '0001', 'Huixtán', '2017-10-17 15:55:33', '07'),
('038', 'Julimes', '0001', 'Julimes', '2017-10-17 15:55:37', '08'),
('038', 'Vicente Guerrero', '0001', 'Vicente Guerrero', '2017-10-17 15:55:41', '10'),
('038', 'Tarandacuao', '0001', 'Tarandacuao', '2017-10-17 15:55:42', '11'),
('038', 'Zihuatanejo de Azueta', '0001', 'Zihuatanejo', '2017-10-17 15:55:44', '12'),
('038', 'Mineral del Chico', '0001', 'Mineral del Chico', '2017-10-17 15:55:47', '13'),
('038', 'Guachinango', '0001', 'Guachinango', '2017-10-17 15:55:50', '14'),
('038', 'Isidro Fabela', '0001', 'Tlazala de Fabela', '2017-10-17 15:55:55', '15'),
('038', 'Huetamo', '0001', 'Huetamo de Núñez', '2017-10-17 15:55:59', '16'),
('038', 'Montemorelos', '0001', 'Montemorelos', '2017-10-17 15:56:06', '19'),
('038', 'Villa Hidalgo', '0001', 'Villa Hidalgo', '2017-10-17 15:56:08', '20'),
('038', 'Cuapiaxtla de Madero', '0001', 'Cuapiaxtla de Madero', '2017-10-17 15:56:32', '21'),
('038', 'Tampacán', '0001', 'Tampacán', '2017-10-17 15:56:42', '24'),
('038', 'Moctezuma', '0001', 'Moctezuma', '2017-10-17 15:56:45', '26'),
('038', 'Tampico', '0001', 'Tampico', '2017-10-17 15:56:49', '28'),
('038', 'Tzompantepec', '0001', 'Tzompantepec', '2017-10-17 15:56:50', '29'),
('038', 'Coatepec', '0001', 'Coatepec', '2017-10-17 15:56:53', '30'),
('038', 'Hunucmá', '0001', 'Hunucmá', '2017-10-17 15:57:01', '31'),
('038', 'Pinos', '0001', 'Pinos', '2017-10-17 15:57:06', '32'),
('039', 'Huitiupán', '0001', 'Huitiupán', '2017-10-17 15:55:33', '07'),
('039', 'López', '0001', 'Octaviano López', '2017-10-17 15:55:37', '08'),
('039', 'Nuevo Ideal', '0001', 'Nuevo Ideal', '2017-10-17 15:55:41', '10'),
('039', 'Tarimoro', '0001', 'Tarimoro', '2017-10-17 15:55:42', '11'),
('039', 'Juan R. Escudero', '0001', 'Tierra Colorada', '2017-10-17 15:55:44', '12'),
('039', 'Mineral del Monte', '0001', 'Mineral del Monte', '2017-10-17 15:55:47', '13'),
('039', 'Guadalajara', '0001', 'Guadalajara', '2017-10-17 15:55:50', '14'),
('039', 'Ixtapaluca', '0001', 'Ixtapaluca', '2017-10-17 15:55:55', '15'),
('039', 'Huiramba', '0001', 'Huiramba', '2017-10-17 15:55:59', '16'),
('039', 'Monterrey', '0001', 'Monterrey', '2017-10-17 15:56:06', '19'),
('039', 'Heroica Ciudad de Huajuapan de León', '0001', 'Heroica Ciudad de Huajuapan de León', '2017-10-17 15:56:08', '20'),
('039', 'Cuautempan', '0001', 'San Esteban Cuautempan', '2017-10-17 15:56:32', '21'),
('039', 'Tampamolón Corona', '0001', 'Tampamolón Corona', '2017-10-17 15:56:42', '24'),
('039', 'Naco', '0001', 'Naco', '2017-10-17 15:56:45', '26'),
('039', 'Tula', '0001', 'Ciudad Tula', '2017-10-17 15:56:49', '28'),
('039', 'Xaloztoc', '0001', 'Xaloztoc', '2017-10-17 15:56:50', '29'),
('039', 'Coatzacoalcos', '0001', 'Coatzacoalcos', '2017-10-17 15:56:53', '30'),
('039', 'Ixil', '0001', 'Ixil', '2017-10-17 15:57:01', '31'),
('039', 'Río Grande', '0001', 'Río Grande', '2017-10-17 15:57:06', '32'),
('040', 'Huixtla', '0001', 'Huixtla', '2017-10-17 15:55:33', '07'),
('040', 'Madera', '0001', 'Madera', '2017-10-17 15:55:37', '08'),
('040', 'Tierra Blanca', '0001', 'Tierra Blanca', '2017-10-17 15:55:42', '11'),
('040', 'Leonardo Bravo', '0001', 'Chichihualco', '2017-10-17 15:55:44', '12'),
('040', 'La Misión', '0001', 'La Misión', '2017-10-17 15:55:47', '13'),
('040', 'Hostotipaquillo', '0001', 'Hostotipaquillo', '2017-10-17 15:55:50', '14'),
('040', 'Ixtapan de la Sal', '0001', 'Ixtapan de la Sal', '2017-10-17 15:55:55', '15'),
('040', 'Indaparapeo', '0001', 'Indaparapeo', '2017-10-17 15:55:59', '16'),
('040', 'Parás', '0001', 'Parás', '2017-10-17 15:56:06', '19'),
('040', 'Huautepec', '0001', 'Huautepec', '2017-10-17 15:56:08', '20'),
('040', 'Cuautinchán', '0001', 'Cuautinchán', '2017-10-17 15:56:32', '21'),
('040', 'Tamuín', '0001', 'Tamuín', '2017-10-17 15:56:42', '24'),
('040', 'Nácori Chico', '0001', 'Nácori Chico', '2017-10-17 15:56:45', '26'),
('040', 'Valle Hermoso', '0001', 'Valle Hermoso', '2017-10-17 15:56:49', '28'),
('040', 'Xaltocan', '0001', 'Xaltocan', '2017-10-17 15:56:50', '29'),
('040', 'Coatzintla', '0001', 'Coatzintla', '2017-10-17 15:56:53', '30'),
('040', 'Izamal', '0001', 'Izamal', '2017-10-17 15:57:01', '31'),
('040', 'Sain Alto', '0001', 'Sain Alto', '2017-10-17 15:57:06', '32'),
('041', 'La Independencia', '0001', 'La Independencia', '2017-10-17 15:55:33', '07'),
('041', 'Maguarichi', '0001', 'Maguarichi', '2017-10-17 15:55:37', '08'),
('041', 'Uriangato', '0001', 'Uriangato', '2017-10-17 15:55:42', '11'),
('041', 'Malinaltepec', '0001', 'Malinaltepec', '2017-10-17 15:55:44', '12'),
('041', 'Mixquiahuala de Juárez', '0001', 'Mixquiahuala', '2017-10-17 15:55:47', '13'),
('041', 'Huejúcar', '0001', 'Huejúcar', '2017-10-17 15:55:50', '14'),
('041', 'Ixtapan del Oro', '0001', 'Ixtapan del Oro', '2017-10-17 15:55:55', '15'),
('041', 'Irimbo', '0001', 'Irimbo', '2017-10-17 15:55:59', '16'),
('041', 'Pesquería', '0001', 'Pesquería', '2017-10-17 15:56:06', '19'),
('041', 'Huautla de Jiménez', '0001', 'Huautla de Jiménez', '2017-10-17 15:56:08', '20'),
('041', 'Cuautlancingo', '0001', 'San Juan Cuautlancingo', '2017-10-17 15:56:32', '21'),
('041', 'Tanlajás', '0001', 'Tanlajás', '2017-10-17 15:56:42', '24'),
('041', 'Nacozari de García', '0001', 'Nacozari de García', '2017-10-17 15:56:45', '26'),
('041', 'Victoria', '0001', 'Ciudad Victoria', '2017-10-17 15:56:49', '28'),
('041', 'Papalotla de Xicohténcatl', '0001', 'Papalotla', '2017-10-17 15:56:50', '29'),
('041', 'Coetzala', '0001', 'Coetzala', '2017-10-17 15:56:53', '30'),
('041', 'Kanasín', '0001', 'Kanasín', '2017-10-17 15:57:01', '31'),
('041', 'El Salvador', '0001', 'El Salvador', '2017-10-17 15:57:06', '32'),
('042', 'Ixhuatán', '0001', 'Ixhuatán', '2017-10-17 15:55:33', '07'),
('042', 'Manuel Benavides', '0001', 'Manuel Benavides', '2017-10-17 15:55:37', '08'),
('042', 'Valle de Santiago', '0001', 'Valle de Santiago', '2017-10-17 15:55:42', '11'),
('042', 'Mártir de Cuilapan', '0001', 'Apango', '2017-10-17 15:55:44', '12'),
('042', 'Molango de Escamilla', '0001', 'Molango', '2017-10-17 15:55:47', '13'),
('042', 'Huejuquilla el Alto', '0001', 'Huejuquilla el Alto', '2017-10-17 15:55:50', '14'),
('042', 'Ixtlahuaca', '0001', 'Ixtlahuaca de Rayón', '2017-10-17 15:55:55', '15'),
('042', 'Ixtlán', '0001', 'Ixtlán de los Hervores', '2017-10-17 15:55:59', '16'),
('042', 'Los Ramones', '0001', 'Los Ramones', '2017-10-17 15:56:06', '19'),
('042', 'Ixtlán de Juárez', '0001', 'Ixtlán de Juárez', '2017-10-17 15:56:08', '20'),
('042', 'Cuayuca de Andrade', '0001', 'San Pedro Cuayuca', '2017-10-17 15:56:32', '21'),
('042', 'Tanquián de Escobedo', '0001', 'Tanquián de Escobedo', '2017-10-17 15:56:42', '24'),
('042', 'Navojoa', '0001', 'Navojoa', '2017-10-17 15:56:45', '26'),
('042', 'Villagrán', '0001', 'Villagrán', '2017-10-17 15:56:49', '28'),
('042', 'Xicohtzinco', '0001', 'Xicohtzinco', '2017-10-17 15:56:51', '29'),
('042', 'Colipa', '0001', 'Colipa', '2017-10-17 15:56:53', '30'),
('042', 'Kantunil', '0001', 'Kantunil', '2017-10-17 15:57:01', '31'),
('042', 'Sombrerete', '0001', 'Sombrerete', '2017-10-17 15:57:06', '32'),
('043', 'Ixtacomitán', '0001', 'Ixtacomitán', '2017-10-17 15:55:33', '07'),
('043', 'Matachí', '0001', 'Matachí', '2017-10-17 15:55:37', '08'),
('043', 'Victoria', '0001', 'Victoria', '2017-10-17 15:55:42', '11'),
('043', 'Metlatónoc', '0001', 'Metlatónoc', '2017-10-17 15:55:44', '12'),
('043', 'Nicolás Flores', '0001', 'Nicolás Flores', '2017-10-17 15:55:47', '13'),
('043', 'La Huerta', '0001', 'La Huerta', '2017-10-17 15:55:50', '14'),
('043', 'Xalatlaco', '0001', 'Xalatlaco', '2017-10-17 15:55:55', '15'),
('043', 'Jacona', '0001', 'Jacona de Plancarte', '2017-10-17 15:55:59', '16'),
('043', 'Rayones', '0001', 'Rayones', '2017-10-17 15:56:06', '19'),
('043', 'Heroica Ciudad de Juchitán de Zaragoza', '0001', 'Heroica Ciudad de Juchitán de Zaragoza', '2017-10-17 15:56:08', '20'),
('043', 'Cuetzalan del Progreso', '0001', 'Ciudad de Cuetzalan', '2017-10-17 15:56:32', '21'),
('043', 'Tierra Nueva', '0001', 'Tierra Nueva', '2017-10-17 15:56:42', '24'),
('043', 'Nogales', '0001', 'Heroica Nogales', '2017-10-17 15:56:45', '26'),
('043', 'Xicoténcatl', '0001', 'Xicoténcatl', '2017-10-17 15:56:49', '28'),
('043', 'Yauhquemehcan', '0001', 'San Dionisio Yauhquemehcan', '2017-10-17 15:56:51', '29'),
('043', 'Comapa', '0001', 'Comapa', '2017-10-17 15:56:53', '30'),
('043', 'Kaua', '0001', 'Kaua', '2017-10-17 15:57:01', '31'),
('043', 'Susticacán', '0001', 'Susticacán', '2017-10-17 15:57:06', '32'),
('044', 'Ixtapa', '0001', 'Ixtapa', '2017-10-17 15:55:33', '07'),
('044', 'Matamoros', '0001', 'Mariano Matamoros', '2017-10-17 15:55:37', '08'),
('044', 'Villagrán', '0001', 'Villagrán', '2017-10-17 15:55:42', '11'),
('044', 'Mochitlán', '0001', 'Mochitlán', '2017-10-17 15:55:44', '12'),
('044', 'Nopala de Villagrán', '0001', 'Nopala', '2017-10-17 15:55:47', '13'),
('044', 'Ixtlahuacán de los Membrillos', '0001', 'Ixtlahuacán de los Membrillos', '2017-10-17 15:55:50', '14'),
('044', 'Jaltenco', '0001', 'Jaltenco', '2017-10-17 15:55:55', '15'),
('044', 'Jiménez', '0001', 'Villa Jiménez', '2017-10-17 15:55:59', '16'),
('044', 'Sabinas Hidalgo', '0001', 'Ciudad Sabinas Hidalgo', '2017-10-17 15:56:06', '19'),
('044', 'Loma Bonita', '0001', 'Loma Bonita', '2017-10-17 15:56:08', '20'),
('044', 'Cuyoaco', '0001', 'Cuyoaco', '2017-10-17 15:56:32', '21'),
('044', 'Vanegas', '0001', 'Vanegas', '2017-10-17 15:56:42', '24'),
('044', 'Onavas', '0001', 'Onavas', '2017-10-17 15:56:45', '26'),
('044', 'Zacatelco', '0001', 'Zacatelco', '2017-10-17 15:56:51', '29'),
('044', 'Córdoba', '0001', 'Córdoba', '2017-10-17 15:56:53', '30'),
('044', 'Kinchil', '0001', 'Kinchil', '2017-10-17 15:57:02', '31'),
('044', 'Tabasco', '0001', 'Tabasco', '2017-10-17 15:57:06', '32'),
('045', 'Ixtapangajoya', '0001', 'Ixtapangajoya', '2017-10-17 15:55:33', '07'),
('045', 'Meoqui', '0001', 'Pedro Meoqui', '2017-10-17 15:55:37', '08'),
('045', 'Xichú', '0001', 'Xichú', '2017-10-17 15:55:42', '11'),
('045', 'Olinalá', '0001', 'Olinalá', '2017-10-17 15:55:44', '12'),
('045', 'Omitlán de Juárez', '0001', 'Omitlán de Juárez', '2017-10-17 15:55:47', '13'),
('045', 'Ixtlahuacán del Río', '0001', 'Ixtlahuacán del Río', '2017-10-17 15:55:50', '14'),
('045', 'Jilotepec', '0001', 'Jilotepec de Molina Enríquez', '2017-10-17 15:55:55', '15'),
('045', 'Jiquilpan', '0001', 'Jiquilpan de Juárez', '2017-10-17 15:55:59', '16'),
('045', 'Salinas Victoria', '0001', 'Salinas Victoria', '2017-10-17 15:56:06', '19'),
('045', 'Magdalena Apasco', '0001', 'Magdalena Apasco', '2017-10-17 15:56:08', '20'),
('045', 'Chalchicomula de Sesma', '0001', 'Ciudad Serdán', '2017-10-17 15:56:32', '21'),
('045', 'Venado', '0001', 'Venado', '2017-10-17 15:56:42', '24'),
('045', 'Opodepe', '0001', 'Opodepe', '2017-10-17 15:56:45', '26'),
('045', 'Benito Juárez', '0001', 'Benito Juárez', '2017-10-17 15:56:51', '29'),
('045', 'Cosamaloapan de Carpio', '0001', 'Cosamaloapan', '2017-10-17 15:56:53', '30'),
('045', 'Kopomá', '0001', 'Kopomá', '2017-10-17 15:57:02', '31'),
('045', 'Tepechitlán', '0001', 'Tepechitlán', '2017-10-17 15:57:06', '32'),
('046', 'Jiquipilas', '0001', 'Jiquipilas', '2017-10-17 15:55:33', '07'),
('046', 'Morelos', '0001', 'Morelos', '2017-10-17 15:55:37', '08'),
('046', 'Yuriria', '0001', 'Yuriria', '2017-10-17 15:55:42', '11'),
('046', 'Ometepec', '0001', 'Ometepec', '2017-10-17 15:55:44', '12'),
('046', 'San Felipe Orizatlán', '0001', 'Orizatlán', '2017-10-17 15:55:47', '13'),
('046', 'Jalostotitlán', '0001', 'Jalostotitlán', '2017-10-17 15:55:50', '14'),
('046', 'Jilotzingo', '0001', 'Santa Ana Jilotzingo', '2017-10-17 15:55:55', '15'),
('046', 'Juárez', '0001', 'Benito Juárez', '2017-10-17 15:55:59', '16'),
('046', 'San Nicolás de los Garza', '0001', 'San Nicolás de los Garza', '2017-10-17 15:56:06', '19'),
('046', 'Magdalena Jaltepec', '0001', 'Magdalena Jaltepec', '2017-10-17 15:56:08', '20'),
('046', 'Chapulco', '0001', 'Chapulco', '2017-10-17 15:56:32', '21'),
('046', 'Villa de Arriaga', '0001', 'Villa de Arriaga', '2017-10-17 15:56:42', '24'),
('046', 'Oquitoa', '0001', 'Oquitoa', '2017-10-17 15:56:45', '26'),
('046', 'Emiliano Zapata', '0001', 'Emiliano Zapata', '2017-10-17 15:56:51', '29'),
('046', 'Cosautlán de Carvajal', '0001', 'Cosautlán de Carvajal', '2017-10-17 15:56:53', '30'),
('046', 'Mama', '0001', 'Mama', '2017-10-17 15:57:02', '31'),
('046', 'Tepetongo', '0001', 'Tepetongo', '2017-10-17 15:57:06', '32'),
('047', 'Jitotol', '0001', 'Jitotol', '2017-10-17 15:55:33', '07'),
('047', 'Moris', '0001', 'Moris', '2017-10-17 15:55:37', '08'),
('047', 'Pedro Ascencio Alquisiras', '0001', 'Ixcapuzalco', '2017-10-17 15:55:44', '12'),
('047', 'Pacula', '0001', 'Pacula', '2017-10-17 15:55:47', '13'),
('047', 'Jamay', '0001', 'Jamay', '2017-10-17 15:55:51', '14'),
('047', 'Jiquipilco', '0001', 'Jiquipilco', '2017-10-17 15:55:55', '15'),
('047', 'Jungapeo', '0001', 'Jungapeo de Juárez', '2017-10-17 15:56:00', '16'),
('047', 'Hidalgo', '0001', 'Hidalgo', '2017-10-17 15:56:06', '19'),
('047', 'Santa Magdalena Jicotlán', '0001', 'Santa Magdalena Jicotlán', '2017-10-17 15:56:08', '20'),
('047', 'Chiautla', '0001', 'Ciudad de Chiautla de Tapia', '2017-10-17 15:56:32', '21'),
('047', 'Villa de Guadalupe', '0001', 'Villa de Guadalupe', '2017-10-17 15:56:42', '24'),
('047', 'Pitiquito', '0001', 'Pitiquito', '2017-10-17 15:56:45', '26'),
('047', 'Lázaro Cárdenas', '0001', 'Lázaro Cárdenas', '2017-10-17 15:56:51', '29'),
('047', 'Coscomatepec', '0001', 'Coscomatepec de Bravo', '2017-10-17 15:56:53', '30'),
('047', 'Maní', '0001', 'Maní', '2017-10-17 15:57:02', '31'),
('047', 'Teúl de González Ortega', '0001', 'Teúl de González Ortega', '2017-10-17 15:57:06', '32'),
('048', 'Juárez', '0001', 'Juárez', '2017-10-17 15:55:33', '07'),
('048', 'Namiquipa', '0001', 'Namiquipa', '2017-10-17 15:55:37', '08'),
('048', 'Petatlán', '0001', 'Petatlán', '2017-10-17 15:55:44', '12'),
('048', 'Pachuca de Soto', '0001', 'Pachuca de Soto', '2017-10-17 15:55:47', '13'),
('048', 'Jesús María', '0001', 'Jesús María', '2017-10-17 15:55:51', '14'),
('048', 'Jocotitlán', '0001', 'Ciudad de Jocotitlán', '2017-10-17 15:55:55', '15'),
('048', 'Lagunillas', '0001', 'Lagunillas', '2017-10-17 15:56:00', '16'),
('048', 'Santa Catarina', '0001', 'Ciudad Santa Catarina', '2017-10-17 15:56:06', '19'),
('048', 'Magdalena Mixtepec', '0001', 'Magdalena Mixtepec', '2017-10-17 15:56:08', '20'),
('048', 'Chiautzingo', '0001', 'San Lorenzo Chiautzingo', '2017-10-17 15:56:32', '21'),
('048', 'Villa de la Paz', '0001', 'Villa de la Paz', '2017-10-17 15:56:42', '24'),
('048', 'Puerto Peñasco', '0001', 'Puerto Peñasco', '2017-10-17 15:56:45', '26'),
('048', 'La Magdalena Tlaltelulco', '0001', 'La Magdalena Tlaltelulco', '2017-10-17 15:56:51', '29'),
('048', 'Cosoleacaque', '0001', 'Cosoleacaque', '2017-10-17 15:56:53', '30'),
('048', 'Maxcanú', '0001', 'Maxcanú', '2017-10-17 15:57:02', '31'),
('048', 'Tlaltenango de Sánchez Román', '0001', 'Tlaltenango de Sánchez Román', '2017-10-17 15:57:06', '32'),
('049', 'Larráinzar', '0001', 'Larráinzar', '2017-10-17 15:55:33', '07'),
('049', 'Nonoava', '0001', 'Nonoava', '2017-10-17 15:55:37', '08'),
('049', 'Pilcaya', '0001', 'Pilcaya', '2017-10-17 15:55:44', '12'),
('049', 'Pisaflores', '0001', 'Pisaflores', '2017-10-17 15:55:47', '13'),
('049', 'Jilotlán de los Dolores', '0001', 'Jilotlán de los Dolores', '2017-10-17 15:55:51', '14'),
('049', 'Joquicingo', '0001', 'Joquicingo de León Guzmán', '2017-10-17 15:55:55', '15'),
('049', 'Madero', '0001', 'Villa Madero', '2017-10-17 15:56:00', '16'),
('049', 'Santiago', '0001', 'Santiago', '2017-10-17 15:56:06', '19'),
('049', 'Magdalena Ocotlán', '0001', 'Magdalena Ocotlán', '2017-10-17 15:56:08', '20'),
('049', 'Chiconcuautla', '0001', 'Chiconcuautla', '2017-10-17 15:56:32', '21'),
('049', 'Villa de Ramos', '0001', 'Villa de Ramos', '2017-10-17 15:56:42', '24'),
('049', 'Quiriego', '0001', 'Quiriego', '2017-10-17 15:56:45', '26'),
('049', 'San Damián Texóloc', '0001', 'San Damián Texóloc', '2017-10-17 15:56:51', '29'),
('049', 'Cotaxtla', '0001', 'Cotaxtla', '2017-10-17 15:56:53', '30'),
('049', 'Mayapán', '0001', 'Mayapán', '2017-10-17 15:57:02', '31'),
('049', 'Valparaíso', '0001', 'Valparaíso', '2017-10-17 15:57:06', '32'),
('050', 'La Libertad', '0001', 'La Libertad', '2017-10-17 15:55:33', '07'),
('050', 'Nuevo Casas Grandes', '0001', 'Nuevo Casas Grandes', '2017-10-17 15:55:38', '08'),
('050', 'Pungarabato', '0001', 'Ciudad Altamirano', '2017-10-17 15:55:44', '12'),
('050', 'Progreso de Obregón', '0001', 'Progreso', '2017-10-17 15:55:47', '13'),
('050', 'Jocotepec', '0001', 'Jocotepec', '2017-10-17 15:55:51', '14'),
('050', 'Juchitepec', '0001', 'Juchitepec de Mariano Rivapalacio', '2017-10-17 15:55:55', '15'),
('050', 'Maravatío', '0001', 'Maravatío de Ocampo', '2017-10-17 15:56:00', '16'),
('050', 'Vallecillo', '0001', 'Vallecillo', '2017-10-17 15:56:06', '19'),
('050', 'Magdalena Peñasco', '0001', 'Magdalena Peñasco', '2017-10-17 15:56:08', '20'),
('050', 'Chichiquila', '0001', 'Chichiquila', '2017-10-17 15:56:32', '21'),
('050', 'Villa de Reyes', '0001', 'Villa de Reyes', '2017-10-17 15:56:42', '24'),
('050', 'Rayón', '0001', 'Rayón', '2017-10-17 15:56:45', '26'),
('050', 'San Francisco Tetlanohcan', '0001', 'San Francisco Tetlanohcan', '2017-10-17 15:56:51', '29'),
('050', 'Coxquihui', '0001', 'Coxquihui', '2017-10-17 15:56:53', '30'),
('050', 'Mérida', '0001', 'Mérida', '2017-10-17 15:57:02', '31'),
('050', 'Vetagrande', '0001', 'Vetagrande', '2017-10-17 15:57:06', '32'),
('051', 'Mapastepec', '0001', 'Mapastepec', '2017-10-17 15:55:33', '07'),
('051', 'Ocampo', '0001', 'Melchor Ocampo', '2017-10-17 15:55:38', '08'),
('051', 'Quechultenango', '0001', 'Quechultenango', '2017-10-17 15:55:44', '12'),
('051', 'Mineral de la Reforma', '0001', 'Pachuquilla', '2017-10-17 15:55:47', '13'),
('051', 'Juanacatlán', '0001', 'Juanacatlán', '2017-10-17 15:55:51', '14'),
('051', 'Lerma', '0001', 'Lerma de Villada', '2017-10-17 15:55:55', '15'),
('051', 'Marcos Castellanos', '0001', 'San José de Gracia', '2017-10-17 15:56:00', '16'),
('051', 'Villaldama', '0001', 'Ciudad de Villaldama', '2017-10-17 15:56:06', '19'),
('051', 'Magdalena Teitipac', '0001', 'Magdalena Teitipac', '2017-10-17 15:56:08', '20'),
('051', 'Chietla', '0001', 'Chietla', '2017-10-17 15:56:33', '21'),
('051', 'Villa Hidalgo', '0001', 'Villa Hidalgo', '2017-10-17 15:56:42', '24'),
('051', 'Rosario', '0001', 'Rosario', '2017-10-17 15:56:45', '26'),
('051', 'San Jerónimo Zacualpan', '0001', 'San Jerónimo Zacualpan', '2017-10-17 15:56:51', '29'),
('051', 'Coyutla', '0001', 'Coyutla', '2017-10-17 15:56:53', '30'),
('051', 'Mocochá', '0001', 'Mocochá', '2017-10-17 15:57:02', '31'),
('051', 'Villa de Cos', '0001', 'Villa de Cos', '2017-10-17 15:57:06', '32'),
('052', 'Las Margaritas', '0001', 'Las Margaritas', '2017-10-17 15:55:33', '07'),
('052', 'Ojinaga', '0001', 'Manuel Ojinaga', '2017-10-17 15:55:38', '08'),
('052', 'San Luis Acatlán', '0001', 'San Luis Acatlán', '2017-10-17 15:55:44', '12'),
('052', 'San Agustín Tlaxiaca', '0001', 'San Agustín Tlaxiaca', '2017-10-17 15:55:47', '13'),
('052', 'Juchitlán', '0001', 'Juchitlán', '2017-10-17 15:55:51', '14'),
('052', 'Malinalco', '0001', 'Malinalco', '2017-10-17 15:55:55', '15'),
('052', 'Lázaro Cárdenas', '0001', 'Ciudad Lázaro Cárdenas', '2017-10-17 15:56:00', '16'),
('052', 'Magdalena Tequisistlán', '0001', 'Magdalena Tequisistlán', '2017-10-17 15:56:08', '20'),
('052', 'Chigmecatitlán', '0001', 'Chigmecatitlán', '2017-10-17 15:56:33', '21'),
('052', 'Villa Juárez', '0001', 'Villa Juárez', '2017-10-17 15:56:42', '24'),
('052', 'Sahuaripa', '0001', 'Sahuaripa', '2017-10-17 15:56:45', '26'),
('052', 'San José Teacalco', '0001', 'San José Teacalco', '2017-10-17 15:56:51', '29'),
('052', 'Cuichapa', '0001', 'Cuichapa', '2017-10-17 15:56:53', '30'),
('052', 'Motul', '0001', 'Motul de Carrillo Puerto', '2017-10-17 15:57:02', '31'),
('052', 'Villa García', '0001', 'Villa García', '2017-10-17 15:57:06', '32'),
('053', 'Mazapa de Madero', '0001', 'Mazapa de Madero', '2017-10-17 15:55:33', '07'),
('053', 'Praxedis G. Guerrero', '0001', 'Praxedis G. Guerrero', '2017-10-17 15:55:38', '08'),
('053', 'San Marcos', '0001', 'San Marcos', '2017-10-17 15:55:44', '12'),
('053', 'San Bartolo Tutotepec', '0001', 'San Bartolo Tutotepec', '2017-10-17 15:55:47', '13'),
('053', 'Lagos de Moreno', '0001', 'Lagos de Moreno', '2017-10-17 15:55:51', '14'),
('053', 'Melchor Ocampo', '0001', 'Melchor Ocampo', '2017-10-17 15:55:55', '15'),
('053', 'Morelia', '0001', 'Morelia', '2017-10-17 15:56:00', '16'),
('053', 'Magdalena Tlacotepec', '0001', 'Magdalena Tlacotepec', '2017-10-17 15:56:08', '20'),
('053', 'Chignahuapan', '0001', 'Ciudad de Chignahuapan', '2017-10-17 15:56:33', '21'),
('053', 'Axtla de Terrazas', '0001', 'Axtla de Terrazas', '2017-10-17 15:56:42', '24'),
('053', 'San Felipe de Jesús', '0001', 'San Felipe de Jesús', '2017-10-17 15:56:45', '26'),
('053', 'San Juan Huactzinco', '0001', 'San Juan Huactzinco', '2017-10-17 15:56:51', '29'),
('053', 'Cuitláhuac', '0001', 'Cuitláhuac', '2017-10-17 15:56:53', '30'),
('053', 'Muna', '0001', 'Muna', '2017-10-17 15:57:02', '31'),
('053', 'Villa González Ortega', '0001', 'Villa González Ortega', '2017-10-17 15:57:06', '32'),
('054', 'Mazatán', '0001', 'Mazatán', '2017-10-17 15:55:33', '07'),
('054', 'Riva Palacio', '0001', 'San Andrés', '2017-10-17 15:55:38', '08'),
('054', 'San Miguel Totolapan', '0001', 'San Miguel Totolapan', '2017-10-17 15:55:44', '12'),
('054', 'San Salvador', '0001', 'San Salvador', '2017-10-17 15:55:47', '13'),
('054', 'El Limón', '0001', 'El Limón', '2017-10-17 15:55:51', '14'),
('054', 'Metepec', '0001', 'Metepec', '2017-10-17 15:55:55', '15'),
('054', 'Morelos', '0001', 'Villa Morelos', '2017-10-17 15:56:00', '16'),
('054', 'Magdalena Zahuatlán', '0001', 'Magdalena Zahuatlán', '2017-10-17 15:56:08', '20'),
('054', 'Chignautla', '0001', 'Chignautla', '2017-10-17 15:56:33', '21'),
('054', 'Xilitla', '0001', 'Xilitla', '2017-10-17 15:56:42', '24'),
('054', 'San Javier', '0001', 'San Javier', '2017-10-17 15:56:45', '26'),
('054', 'San Lorenzo Axocomanitla', '0001', 'San Lorenzo Axocomanitla', '2017-10-17 15:56:51', '29'),
('054', 'Chacaltianguis', '0001', 'Chacaltianguis', '2017-10-17 15:56:53', '30'),
('054', 'Muxupip', '0001', 'Muxupip', '2017-10-17 15:57:02', '31'),
('054', 'Villa Hidalgo', '0001', 'Villa Hidalgo', '2017-10-17 15:57:06', '32'),
('055', 'Metapa', '0001', 'Metapa de Domínguez', '2017-10-17 15:55:33', '07'),
('055', 'Rosales', '0001', 'Santa Cruz de Rosales', '2017-10-17 15:55:38', '08'),
('055', 'Taxco de Alarcón', '0001', 'Taxco de Alarcón', '2017-10-17 15:55:44', '12'),
('055', 'Santiago de Anaya', '0001', 'Santiago de Anaya', '2017-10-17 15:55:47', '13'),
('055', 'Magdalena', '0001', 'Magdalena', '2017-10-17 15:55:51', '14'),
('055', 'Mexicaltzingo', '0001', 'San Mateo Mexicaltzingo', '2017-10-17 15:55:55', '15'),
('055', 'Múgica', '0001', 'Nueva Italia de Ruiz', '2017-10-17 15:56:00', '16'),
('055', 'Mariscala de Juárez', '0001', 'Mariscala de Juárez', '2017-10-17 15:56:08', '20'),
('055', 'Chila', '0001', 'Chila', '2017-10-17 15:56:33', '21'),
('055', 'Zaragoza', '0001', 'Villa de Zaragoza', '2017-10-17 15:56:42', '24'),
('055', 'San Luis Río Colorado', '0001', 'San Luis Río Colorado', '2017-10-17 15:56:45', '26'),
('055', 'San Lucas Tecopilco', '0001', 'San Lucas Tecopilco', '2017-10-17 15:56:51', '29'),
('055', 'Chalma', '0001', 'Chalma', '2017-10-17 15:56:53', '30'),
('055', 'Opichén', '0001', 'Opichén', '2017-10-17 15:57:02', '31'),
('055', 'Villanueva', '0001', 'Villanueva', '2017-10-17 15:57:06', '32'),
('056', 'Mitontic', '0001', 'Mitontic', '2017-10-17 15:55:33', '07'),
('056', 'Rosario', '0001', 'Valle del Rosario', '2017-10-17 15:55:38', '08'),
('056', 'Tecoanapa', '0001', 'Tecoanapa', '2017-10-17 15:55:44', '12'),
('056', 'Santiago Tulantepec de Lugo Guerrero', '0001', 'Santiago Tulantepec', '2017-10-17 15:55:48', '13'),
('056', 'Santa María del Oro', '0001', 'Santa María del Oro', '2017-10-17 15:55:51', '14'),
('056', 'Morelos', '0001', 'San Bartolo Morelos', '2017-10-17 15:55:55', '15'),
('056', 'Nahuatzen', '0001', 'Nahuatzen', '2017-10-17 15:56:00', '16'),
('056', 'Mártires de Tacubaya', '0001', 'Mártires de Tacubaya', '2017-10-17 15:56:08', '20'),
('056', 'Chila de la Sal', '0001', 'Chila de la Sal', '2017-10-17 15:56:33', '21'),
('056', 'Villa de Arista', '0002', 'Villa de Arista', '2017-10-17 15:56:43', '24'),
('056', 'San Miguel de Horcasitas', '0001', 'San Miguel de Horcasitas', '2017-10-17 15:56:46', '26'),
('056', 'Santa Ana Nopalucan', '0001', 'Santa Ana Nopalucan', '2017-10-17 15:56:51', '29'),
('056', 'Chiconamel', '0001', 'Chiconamel', '2017-10-17 15:56:53', '30'),
('056', 'Oxkutzcab', '0001', 'Oxkutzcab', '2017-10-17 15:57:02', '31'),
('056', 'Zacatecas', '0001', 'Zacatecas', '2017-10-17 15:57:06', '32'),
('057', 'Motozintla', '0001', 'Motozintla de Mendoza', '2017-10-17 15:55:34', '07'),
('057', 'San Francisco de Borja', '0001', 'San Francisco de Borja', '2017-10-17 15:55:38', '08'),
('057', 'Técpan de Galeana', '0001', 'Técpan de Galeana', '2017-10-17 15:55:45', '12'),
('057', 'Singuilucan', '0001', 'Singuilucan', '2017-10-17 15:55:48', '13'),
('057', 'La Manzanilla de la Paz', '0001', 'La Manzanilla de la Paz', '2017-10-17 15:55:51', '14'),
('057', 'Naucalpan de Juárez', '0001', 'Naucalpan de Juárez', '2017-10-17 15:55:55', '15'),
('057', 'Nocupétaro', '0001', 'Nocupétaro de Morelos', '2017-10-17 15:56:00', '16'),
('057', 'Matías Romero Avendaño', '0001', 'Matías Romero Avendaño', '2017-10-17 15:56:08', '20'),
('057', 'Honey', '0001', 'Honey', '2017-10-17 15:56:33', '21'),
('057', 'Matlapa', '0001', 'Matlapa', '2017-10-17 15:56:43', '24'),
('057', 'San Pedro de la Cueva', '0001', 'San Pedro de la Cueva', '2017-10-17 15:56:46', '26'),
('057', 'Santa Apolonia Teacalco', '0001', 'Santa Apolonia Teacalco', '2017-10-17 15:56:51', '29'),
('057', 'Chiconquiaco', '0001', 'Chiconquiaco', '2017-10-17 15:56:53', '30'),
('057', 'Panabá', '0001', 'Panabá', '2017-10-17 15:57:02', '31'),
('057', 'Trancoso', '0001', 'Trancoso', '2017-10-17 15:57:07', '32'),
('058', 'Nicolás Ruíz', '0001', 'Nicolás Ruíz', '2017-10-17 15:55:34', '07'),
('058', 'San Francisco de Conchos', '0001', 'San Francisco de Conchos', '2017-10-17 15:55:38', '08'),
('058', 'Teloloapan', '0001', 'Teloloapan', '2017-10-17 15:55:45', '12'),
('058', 'Tasquillo', '0001', 'Tasquillo', '2017-10-17 15:55:48', '13'),
('058', 'Mascota', '0001', 'Mascota', '2017-10-17 15:55:51', '14'),
('058', 'Nezahualcóyotl', '0001', 'Ciudad Nezahualcóyotl', '2017-10-17 15:55:55', '15'),
('058', 'Nuevo Parangaricutiro', '0001', 'Nuevo San Juan Parangaricutiro', '2017-10-17 15:56:00', '16'),
('058', 'Mazatlán Villa de Flores', '0001', 'Mazatlán Villa de Flores', '2017-10-17 15:56:08', '20'),
('058', 'Chilchotla', '0001', 'Rafael J. García', '2017-10-17 15:56:33', '21'),
('058', 'El Naranjo', '0001', 'El Naranjo', '2017-10-17 15:56:43', '24'),
('058', 'Santa Ana', '0001', 'Santa Ana', '2017-10-17 15:56:46', '26'),
('058', 'Santa Catarina Ayometla', '0001', 'Santa Catarina Ayometla', '2017-10-17 15:56:51', '29'),
('058', 'Chicontepec', '0001', 'Chicontepec de Tejeda', '2017-10-17 15:56:53', '30'),
('058', 'Peto', '0001', 'Peto', '2017-10-17 15:57:02', '31'),
('058', 'Santa María de la Paz', '0001', 'Santa María de la Paz', '2017-10-17 15:57:07', '32'),
('059', 'Ocosingo', '0001', 'Ocosingo', '2017-10-17 15:55:34', '07'),
('059', 'San Francisco del Oro', '0001', 'San Francisco del Oro', '2017-10-17 15:55:38', '08'),
('059', 'Tepecoacuilco de Trujano', '0001', 'Tepecoacuilco de Trujano', '2017-10-17 15:55:45', '12'),
('059', 'Tecozautla', '0001', 'Tecozautla', '2017-10-17 15:55:48', '13'),
('059', 'Mazamitla', '0001', 'Mazamitla', '2017-10-17 15:55:51', '14'),
('059', 'Nextlalpan', '0001', 'Santa Ana Nextlalpan', '2017-10-17 15:55:55', '15'),
('059', 'Nuevo Urecho', '0001', 'Nuevo Urecho', '2017-10-17 15:56:00', '16'),
('059', 'Miahuatlán de Porfirio Díaz', '0001', 'Miahuatlán de Porfirio Díaz', '2017-10-17 15:56:08', '20'),
('059', 'Chinantla', '0001', 'Chinantla', '2017-10-17 15:56:33', '21'),
('059', 'Santa Cruz', '0001', 'Santa Cruz', '2017-10-17 15:56:46', '26'),
('059', 'Santa Cruz Quilehtla', '0001', 'Santa Cruz Quilehtla', '2017-10-17 15:56:51', '29'),
('059', 'Chinameca', '0001', 'Chinameca', '2017-10-17 15:56:54', '30'),
('059', 'Progreso', '0001', 'Progreso', '2017-10-17 15:57:02', '31'),
('060', 'Ocotepec', '0001', 'Ocotepec', '2017-10-17 15:55:34', '07'),
('060', 'Santa Bárbara', '0001', 'Santa Bárbara', '2017-10-17 15:55:38', '08'),
('060', 'Tetipac', '0001', 'Tetipac', '2017-10-17 15:55:45', '12'),
('060', 'Tenango de Doria', '0001', 'Tenango de Doria', '2017-10-17 15:55:48', '13'),
('060', 'Mexticacán', '0001', 'Mexticacán', '2017-10-17 15:55:51', '14'),
('060', 'Nicolás Romero', '0001', 'Ciudad Nicolás Romero', '2017-10-17 15:55:55', '15'),
('060', 'Numarán', '0001', 'Numarán', '2017-10-17 15:56:00', '16'),
('060', 'Mixistlán de la Reforma', '0001', 'Mixistlán de la Reforma', '2017-10-17 15:56:08', '20'),
('060', 'Domingo Arenas', '0001', 'Domingo Arenas', '2017-10-17 15:56:33', '21'),
('060', 'Sáric', '0001', 'Sáric', '2017-10-17 15:56:46', '26'),
('060', 'Santa Isabel Xiloxoxtla', '0001', 'Santa Isabel Xiloxoxtla', '2017-10-17 15:56:51', '29'),
('060', 'Chinampa de Gorostiza', '0001', 'Chinampa de Gorostiza', '2017-10-17 15:56:54', '30'),
('060', 'Quintana Roo', '0001', 'Quintana Roo', '2017-10-17 15:57:02', '31'),
('061', 'Ocozocoautla de Espinosa', '0001', 'Ocozocoautla de Espinosa', '2017-10-17 15:55:34', '07'),
('061', 'Satevó', '0001', 'San Francisco Javier de Satevó', '2017-10-17 15:55:38', '08'),
('061', 'Tixtla de Guerrero', '0001', 'Tixtla de Guerrero', '2017-10-17 15:55:45', '12'),
('061', 'Tepeapulco', '0001', 'Tepeapulco', '2017-10-17 15:55:48', '13'),
('061', 'Mezquitic', '0001', 'Mezquitic', '2017-10-17 15:55:51', '14'),
('061', 'Nopaltepec', '0001', 'Nopaltepec', '2017-10-17 15:55:55', '15'),
('061', 'Ocampo', '0001', 'Ocampo', '2017-10-17 15:56:00', '16'),
('061', 'Monjas', '0001', 'Monjas', '2017-10-17 15:56:08', '20'),
('061', 'Eloxochitlán', '0001', 'Eloxochitlán', '2017-10-17 15:56:33', '21'),
('061', 'Soyopa', '0001', 'Soyopa', '2017-10-17 15:56:46', '26'),
('061', 'Las Choapas', '0001', 'Las Choapas', '2017-10-17 15:56:54', '30'),
('061', 'Río Lagartos', '0001', 'Río Lagartos', '2017-10-17 15:57:02', '31'),
('062', 'Ostuacán', '0001', 'Ostuacán', '2017-10-17 15:55:34', '07'),
('062', 'Saucillo', '0001', 'Saucillo', '2017-10-17 15:55:38', '08'),
('062', 'Tlacoachistlahuaca', '0001', 'Tlacoachistlahuaca', '2017-10-17 15:55:45', '12'),
('062', 'Tepehuacán de Guerrero', '0001', 'Tepehuacán de Guerrero', '2017-10-17 15:55:48', '13'),
('062', 'Mixtlán', '0001', 'Mixtlán', '2017-10-17 15:55:51', '14'),
('062', 'Ocoyoacac', '0001', 'Ocoyoacac', '2017-10-17 15:55:55', '15'),
('062', 'Pajacuarán', '0001', 'Pajacuarán', '2017-10-17 15:56:00', '16'),
('062', 'Natividad', '0001', 'Natividad', '2017-10-17 15:56:08', '20'),
('062', 'Epatlán', '0001', 'San Juan Epatlán', '2017-10-17 15:56:33', '21'),
('062', 'Suaqui Grande', '0001', 'Suaqui Grande', '2017-10-17 15:56:46', '26'),
('062', 'Chocamán', '0001', 'Chocamán', '2017-10-17 15:56:54', '30');
INSERT INTO `municipio` (`cve_mun`, `nom_mun`, `cve_cab`, `nom_cab`, `fechaModificacion`, `cve_ent`) VALUES
('062', 'Sacalum', '0001', 'Sacalum', '2017-10-17 15:57:02', '31'),
('063', 'Osumacinta', '0001', 'Osumacinta', '2017-10-17 15:55:34', '07'),
('063', 'Temósachic', '0001', 'Temósachic', '2017-10-17 15:55:38', '08'),
('063', 'Tlacoapa', '0001', 'Tlacoapa', '2017-10-17 15:55:45', '12'),
('063', 'Tepeji del Río de Ocampo', '0001', 'Tepeji del Río de Ocampo', '2017-10-17 15:55:48', '13'),
('063', 'Ocotlán', '0001', 'Ocotlán', '2017-10-17 15:55:51', '14'),
('063', 'Ocuilan', '0001', 'Ocuilan de Arteaga', '2017-10-17 15:55:56', '15'),
('063', 'Panindícuaro', '0001', 'Panindícuaro', '2017-10-17 15:56:00', '16'),
('063', 'Nazareno Etla', '0001', 'Nazareno Etla', '2017-10-17 15:56:09', '20'),
('063', 'Esperanza', '0001', 'Esperanza', '2017-10-17 15:56:33', '21'),
('063', 'Tepache', '0001', 'Tepache', '2017-10-17 15:56:46', '26'),
('063', 'Chontla', '0001', 'Chontla', '2017-10-17 15:56:54', '30'),
('063', 'Samahil', '0001', 'Samahil', '2017-10-17 15:57:02', '31'),
('064', 'Oxchuc', '0001', 'Oxchuc', '2017-10-17 15:55:34', '07'),
('064', 'El Tule', '0001', 'El Tule', '2017-10-17 15:55:38', '08'),
('064', 'Tlalchapa', '0001', 'Tlalchapa', '2017-10-17 15:55:45', '12'),
('064', 'Tepetitlán', '0001', 'Tepetitlán', '2017-10-17 15:55:48', '13'),
('064', 'Ojuelos de Jalisco', '0001', 'Ojuelos de Jalisco', '2017-10-17 15:55:51', '14'),
('064', 'El Oro', '0001', 'El Oro de Hidalgo', '2017-10-17 15:55:56', '15'),
('064', 'Parácuaro', '0001', 'Parácuaro', '2017-10-17 15:56:00', '16'),
('064', 'Nejapa de Madero', '0001', 'Nejapa de Madero', '2017-10-17 15:56:09', '20'),
('064', 'Francisco Z. Mena', '0001', 'Metlaltoyuca', '2017-10-17 15:56:33', '21'),
('064', 'Trincheras', '0001', 'Trincheras', '2017-10-17 15:56:46', '26'),
('064', 'Chumatlán', '0001', 'Chumatlán', '2017-10-17 15:56:54', '30'),
('064', 'Sanahcat', '0001', 'Sanahcat', '2017-10-17 15:57:03', '31'),
('065', 'Palenque', '0001', 'Palenque', '2017-10-17 15:55:34', '07'),
('065', 'Urique', '0001', 'Urique', '2017-10-17 15:55:38', '08'),
('065', 'Tlalixtaquilla de Maldonado', '0001', 'Tlalixtaquilla', '2017-10-17 15:55:45', '12'),
('065', 'Tetepango', '0001', 'Tetepango', '2017-10-17 15:55:48', '13'),
('065', 'Pihuamo', '0001', 'Pihuamo', '2017-10-17 15:55:51', '14'),
('065', 'Otumba', '0001', 'Otumba de Gómez Farías', '2017-10-17 15:55:56', '15'),
('065', 'Paracho', '0001', 'Paracho de Verduzco', '2017-10-17 15:56:00', '16'),
('065', 'Ixpantepec Nieves', '0001', 'Ixpantepec Nieves', '2017-10-17 15:56:09', '20'),
('065', 'General Felipe Ángeles', '0001', 'San Pablo de las Tunas', '2017-10-17 15:56:33', '21'),
('065', 'Tubutama', '0001', 'Tubutama', '2017-10-17 15:56:46', '26'),
('065', 'Emiliano Zapata', '0001', 'Dos Ríos', '2017-10-17 15:56:54', '30'),
('065', 'San Felipe', '0001', 'San Felipe', '2017-10-17 15:57:03', '31'),
('066', 'Pantelhó', '0001', 'Pantelhó', '2017-10-17 15:55:34', '07'),
('066', 'Uruachi', '0001', 'Uruachi', '2017-10-17 15:55:39', '08'),
('066', 'Tlapa de Comonfort', '0001', 'Tlapa de Comonfort', '2017-10-17 15:55:45', '12'),
('066', 'Villa de Tezontepec', '0001', 'Tezontepec', '2017-10-17 15:55:48', '13'),
('066', 'Poncitlán', '0001', 'Poncitlán', '2017-10-17 15:55:51', '14'),
('066', 'Otzoloapan', '0001', 'Otzoloapan', '2017-10-17 15:55:56', '15'),
('066', 'Pátzcuaro', '0001', 'Pátzcuaro', '2017-10-17 15:56:00', '16'),
('066', 'Santiago Niltepec', '0001', 'Santiago Niltepec', '2017-10-17 15:56:09', '20'),
('066', 'Guadalupe', '0001', 'Guadalupe', '2017-10-17 15:56:33', '21'),
('066', 'Ures', '0001', 'Heroica Ciudad de Ures', '2017-10-17 15:56:46', '26'),
('066', 'Espinal', '0001', 'Espinal', '2017-10-17 15:56:54', '30'),
('066', 'Santa Elena', '0001', 'Santa Elena', '2017-10-17 15:57:03', '31'),
('067', 'Pantepec', '0001', 'Pantepec', '2017-10-17 15:55:34', '07'),
('067', 'Valle de Zaragoza', '0001', 'Valle de Zaragoza', '2017-10-17 15:55:39', '08'),
('067', 'Tlapehuala', '0001', 'Tlapehuala', '2017-10-17 15:55:45', '12'),
('067', 'Tezontepec de Aldama', '0001', 'Tezontepec de Aldama', '2017-10-17 15:55:48', '13'),
('067', 'Puerto Vallarta', '0001', 'Puerto Vallarta', '2017-10-17 15:55:51', '14'),
('067', 'Otzolotepec', '0001', 'Villa Cuauhtémoc', '2017-10-17 15:55:56', '15'),
('067', 'Penjamillo', '0001', 'Penjamillo de Degollado', '2017-10-17 15:56:00', '16'),
('067', 'Oaxaca de Juárez', '0001', 'Oaxaca de Juárez', '2017-10-17 15:56:09', '20'),
('067', 'Guadalupe Victoria', '0001', 'Guadalupe Victoria', '2017-10-17 15:56:33', '21'),
('067', 'Villa Hidalgo', '0001', 'Villa Hidalgo', '2017-10-17 15:56:46', '26'),
('067', 'Filomeno Mata', '0001', 'Filomeno Mata', '2017-10-17 15:56:54', '30'),
('067', 'Seyé', '0001', 'Seyé', '2017-10-17 15:57:03', '31'),
('068', 'Pichucalco', '0001', 'Pichucalco', '2017-10-17 15:55:34', '07'),
('068', 'La Unión de Isidoro Montes de Oca', '0001', 'La Unión', '2017-10-17 15:55:45', '12'),
('068', 'Tianguistengo', '0001', 'Tianguistengo', '2017-10-17 15:55:48', '13'),
('068', 'Villa Purificación', '0001', 'Villa Purificación', '2017-10-17 15:55:51', '14'),
('068', 'Ozumba', '0001', 'Ozumba de Alzate', '2017-10-17 15:55:56', '15'),
('068', 'Peribán', '0001', 'Peribán de Ramos', '2017-10-17 15:56:00', '16'),
('068', 'Ocotlán de Morelos', '0001', 'Ocotlán de Morelos', '2017-10-17 15:56:09', '20'),
('068', 'Hermenegildo Galeana', '0001', 'Bienvenido', '2017-10-17 15:56:33', '21'),
('068', 'Villa Pesqueira', '0001', 'Villa Pesqueira (Mátape)', '2017-10-17 15:56:46', '26'),
('068', 'Fortín', '0001', 'Fortín de las Flores', '2017-10-17 15:56:54', '30'),
('068', 'Sinanché', '0001', 'Sinanché', '2017-10-17 15:57:03', '31'),
('069', 'Pijijiapan', '0001', 'Pijijiapan', '2017-10-17 15:55:34', '07'),
('069', 'Xalpatláhuac', '0001', 'Xalpatláhuac', '2017-10-17 15:55:45', '12'),
('069', 'Tizayuca', '0001', 'Tizayuca', '2017-10-17 15:55:48', '13'),
('069', 'Quitupan', '0001', 'Quitupan', '2017-10-17 15:55:51', '14'),
('069', 'Papalotla', '0001', 'Papalotla', '2017-10-17 15:55:56', '15'),
('069', 'La Piedad', '0001', 'La Piedad de Cabadas', '2017-10-17 15:56:00', '16'),
('069', 'La Pe', '0001', 'La Pe', '2017-10-17 15:56:09', '20'),
('069', 'Huaquechula', '0001', 'Huaquechula', '2017-10-17 15:56:33', '21'),
('069', 'Yécora', '0001', 'Yécora', '2017-10-17 15:56:46', '26'),
('069', 'Gutiérrez Zamora', '0001', 'Gutiérrez Zamora', '2017-10-17 15:56:54', '30'),
('069', 'Sotuta', '0001', 'Sotuta', '2017-10-17 15:57:03', '31'),
('070', 'El Porvenir', '0001', 'El Porvenir de Velasco Suárez', '2017-10-17 15:55:34', '07'),
('070', 'Xochihuehuetlán', '0001', 'Xochihuehuetlán', '2017-10-17 15:55:45', '12'),
('070', 'Tlahuelilpan', '0001', 'Tlahuelilpan', '2017-10-17 15:55:48', '13'),
('070', 'El Salto', '0001', 'El Salto', '2017-10-17 15:55:51', '14'),
('070', 'La Paz', '0001', 'Los Reyes Acaquilpan', '2017-10-17 15:55:56', '15'),
('070', 'Purépero', '0001', 'Purépero de Echáiz', '2017-10-17 15:56:00', '16'),
('070', 'Pinotepa de Don Luis', '0001', 'Pinotepa de Don Luis', '2017-10-17 15:56:09', '20'),
('070', 'Huatlatlauca', '0001', 'Huatlatlauca', '2017-10-17 15:56:33', '21'),
('070', 'General Plutarco Elías Calles', '0001', 'Sonoita', '2017-10-17 15:56:46', '26'),
('070', 'Hidalgotitlán', '0001', 'Hidalgotitlán', '2017-10-17 15:56:54', '30'),
('070', 'Sucilá', '0001', 'Sucilá', '2017-10-17 15:57:03', '31'),
('071', 'Villa Comaltitlán', '0001', 'Villa Comaltitlán', '2017-10-17 15:55:34', '07'),
('071', 'Xochistlahuaca', '0001', 'Xochistlahuaca', '2017-10-17 15:55:45', '12'),
('071', 'Tlahuiltepa', '0001', 'Tlahuiltepa', '2017-10-17 15:55:48', '13'),
('071', 'San Cristóbal de la Barranca', '0001', 'San Cristóbal de la Barranca', '2017-10-17 15:55:51', '14'),
('071', 'Polotitlán', '0001', 'Polotitlán de la Ilustración', '2017-10-17 15:55:56', '15'),
('071', 'Puruándiro', '0001', 'Puruándiro', '2017-10-17 15:56:00', '16'),
('071', 'Pluma Hidalgo', '0001', 'Pluma Hidalgo', '2017-10-17 15:56:09', '20'),
('071', 'Huauchinango', '0001', 'Huauchinango', '2017-10-17 15:56:33', '21'),
('071', 'Benito Juárez', '0001', 'Villa Juárez', '2017-10-17 15:56:46', '26'),
('071', 'Huatusco', '0001', 'Huatusco de Chicuellar', '2017-10-17 15:56:54', '30'),
('071', 'Sudzal', '0001', 'Sudzal', '2017-10-17 15:57:03', '31'),
('072', 'Pueblo Nuevo Solistahuacán', '0001', 'Pueblo Nuevo Solistahuacán', '2017-10-17 15:55:34', '07'),
('072', 'Zapotitlán Tablas', '0001', 'Zapotitlán Tablas', '2017-10-17 15:55:45', '12'),
('072', 'Tlanalapa', '0001', 'Tlanalapa', '2017-10-17 15:55:48', '13'),
('072', 'San Diego de Alejandría', '0001', 'San Diego de Alejandría', '2017-10-17 15:55:51', '14'),
('072', 'Rayón', '0001', 'Santa María Rayón', '2017-10-17 15:55:56', '15'),
('072', 'Queréndaro', '0001', 'Queréndaro', '2017-10-17 15:56:00', '16'),
('072', 'San José del Progreso', '0001', 'San José del Progreso', '2017-10-17 15:56:09', '20'),
('072', 'Huehuetla', '0001', 'Huehuetla', '2017-10-17 15:56:33', '21'),
('072', 'San Ignacio Río Muerto', '0001', 'San Ignacio Río Muerto', '2017-10-17 15:56:46', '26'),
('072', 'Huayacocotla', '0001', 'Huayacocotla', '2017-10-17 15:56:54', '30'),
('072', 'Suma', '0001', 'Suma', '2017-10-17 15:57:03', '31'),
('073', 'Rayón', '0001', 'Rayón', '2017-10-17 15:55:34', '07'),
('073', 'Zirándaro', '0001', 'Zirándaro de los Chávez', '2017-10-17 15:55:45', '12'),
('073', 'Tlanchinol', '0001', 'Tlanchinol', '2017-10-17 15:55:48', '13'),
('073', 'San Juan de los Lagos', '0001', 'San Juan de los Lagos', '2017-10-17 15:55:51', '14'),
('073', 'San Antonio la Isla', '0001', 'San Antonio la Isla', '2017-10-17 15:55:56', '15'),
('073', 'Quiroga', '0001', 'Quiroga', '2017-10-17 15:56:01', '16'),
('073', 'Putla Villa de Guerrero', '0001', 'Putla Villa de Guerrero', '2017-10-17 15:56:09', '20'),
('073', 'Huehuetlán el Chico', '0001', 'Huehuetlán el Chico', '2017-10-17 15:56:34', '21'),
('073', 'Hueyapan de Ocampo', '0001', 'Hueyapan de Ocampo', '2017-10-17 15:56:54', '30'),
('073', 'Tahdziú', '0001', 'Tahdziú', '2017-10-17 15:57:03', '31'),
('074', 'Reforma', '0001', 'Reforma', '2017-10-17 15:55:34', '07'),
('074', 'Zitlala', '0001', 'Zitlala', '2017-10-17 15:55:45', '12'),
('074', 'Tlaxcoapan', '0001', 'Tlaxcoapan', '2017-10-17 15:55:48', '13'),
('074', 'San Julián', '0001', 'San Julián', '2017-10-17 15:55:51', '14'),
('074', 'San Felipe del Progreso', '0001', 'San Felipe del Progreso', '2017-10-17 15:55:56', '15'),
('074', 'Cojumatlán de Régules', '0001', 'Cojumatlán de Régules', '2017-10-17 15:56:01', '16'),
('074', 'Santa Catarina Quioquitani', '0001', 'Santa Catarina Quioquitani', '2017-10-17 15:56:09', '20'),
('074', 'Huejotzingo', '0001', 'Huejotzingo', '2017-10-17 15:56:34', '21'),
('074', 'Huiloapan de Cuauhtémoc', '0001', 'Huiloapan de Cuauhtémoc', '2017-10-17 15:56:54', '30'),
('074', 'Tahmek', '0001', 'Tahmek', '2017-10-17 15:57:03', '31'),
('075', 'Las Rosas', '0001', 'Las Rosas', '2017-10-17 15:55:34', '07'),
('075', 'Eduardo Neri', '0001', 'Zumpango del Río', '2017-10-17 15:55:45', '12'),
('075', 'Tolcayuca', '0001', 'Tolcayuca', '2017-10-17 15:55:48', '13'),
('075', 'San Marcos', '0001', 'San Marcos', '2017-10-17 15:55:51', '14'),
('075', 'San Martín de las Pirámides', '0001', 'San Martín de las Pirámides', '2017-10-17 15:55:56', '15'),
('075', 'Los Reyes', '0001', 'Los Reyes de Salgado', '2017-10-17 15:56:01', '16'),
('075', 'Reforma de Pineda', '0001', 'Reforma de Pineda', '2017-10-17 15:56:09', '20'),
('075', 'Hueyapan', '0001', 'Hueyapan', '2017-10-17 15:56:34', '21'),
('075', 'Ignacio de la Llave', '0001', 'Ignacio de la Llave', '2017-10-17 15:56:54', '30'),
('075', 'Teabo', '0001', 'Teabo', '2017-10-17 15:57:03', '31'),
('076', 'Sabanilla', '0001', 'Sabanilla', '2017-10-17 15:55:34', '07'),
('076', 'Acatepec', '0001', 'Acatepec', '2017-10-17 15:55:45', '12'),
('076', 'Tula de Allende', '0001', 'Tula de Allende', '2017-10-17 15:55:48', '13'),
('076', 'San Martín de Bolaños', '0001', 'San Martín de Bolaños', '2017-10-17 15:55:52', '14'),
('076', 'San Mateo Atenco', '0001', 'San Mateo Atenco', '2017-10-17 15:55:56', '15'),
('076', 'Sahuayo', '0001', 'Sahuayo de Morelos', '2017-10-17 15:56:01', '16'),
('076', 'La Reforma', '0001', 'La Reforma', '2017-10-17 15:56:09', '20'),
('076', 'Hueytamalco', '0001', 'Hueytamalco', '2017-10-17 15:56:34', '21'),
('076', 'Ilamatlán', '0001', 'Ilamatlán', '2017-10-17 15:56:54', '30'),
('076', 'Tecoh', '0001', 'Tecoh', '2017-10-17 15:57:03', '31'),
('077', 'Salto de Agua', '0001', 'Salto de Agua', '2017-10-17 15:55:34', '07'),
('077', 'Marquelia', '0001', 'Marquelia', '2017-10-17 15:55:45', '12'),
('077', 'Tulancingo de Bravo', '0001', 'Tulancingo', '2017-10-17 15:55:48', '13'),
('077', 'San Martín Hidalgo', '0001', 'San Martín Hidalgo', '2017-10-17 15:55:52', '14'),
('077', 'San Simón de Guerrero', '0001', 'San Simón de Guerrero', '2017-10-17 15:55:56', '15'),
('077', 'San Lucas', '0001', 'San Lucas', '2017-10-17 15:56:01', '16'),
('077', 'Reyes Etla', '0001', 'Reyes Etla', '2017-10-17 15:56:09', '20'),
('077', 'Hueytlalpan', '0001', 'Hueytlalpan', '2017-10-17 15:56:34', '21'),
('077', 'Isla', '0001', 'Isla', '2017-10-17 15:56:54', '30'),
('077', 'Tekal de Venegas', '0001', 'Tekal de Venegas', '2017-10-17 15:57:03', '31'),
('078', 'San Cristóbal de las Casas', '0001', 'San Cristóbal de las Casas', '2017-10-17 15:55:34', '07'),
('078', 'Cochoapa el Grande', '0001', 'Cochoapa el Grande', '2017-10-17 15:55:45', '12'),
('078', 'Xochiatipan', '0001', 'Xochiatipan', '2017-10-17 15:55:48', '13'),
('078', 'San Miguel el Alto', '0001', 'San Miguel el Alto', '2017-10-17 15:55:52', '14'),
('078', 'Santo Tomás', '0001', 'Santo Tomás de los Plátanos', '2017-10-17 15:55:56', '15'),
('078', 'Santa Ana Maya', '0001', 'Santa Ana Maya', '2017-10-17 15:56:01', '16'),
('078', 'Rojas de Cuauhtémoc', '0001', 'Rojas de Cuauhtémoc', '2017-10-17 15:56:09', '20'),
('078', 'Huitzilan de Serdán', '0001', 'Huitzilan', '2017-10-17 15:56:34', '21'),
('078', 'Ixcatepec', '0001', 'Ixcatepec', '2017-10-17 15:56:54', '30'),
('078', 'Tekantó', '0001', 'Tekantó', '2017-10-17 15:57:03', '31'),
('079', 'San Fernando', '0001', 'San Fernando', '2017-10-17 15:55:34', '07'),
('079', 'José Joaquín de Herrera', '0001', 'Hueycantenango', '2017-10-17 15:55:45', '12'),
('079', 'Xochicoatlán', '0001', 'Xochicoatlán', '2017-10-17 15:55:48', '13'),
('079', 'Gómez Farías', '0001', 'San Sebastián del Sur', '2017-10-17 15:55:52', '14'),
('079', 'Soyaniquilpan de Juárez', '0001', 'San Francisco Soyaniquilpan', '2017-10-17 15:55:56', '15'),
('079', 'Salvador Escalante', '0001', 'Santa Clara del Cobre', '2017-10-17 15:56:01', '16'),
('079', 'Salina Cruz', '0001', 'Salina Cruz', '2017-10-17 15:56:09', '20'),
('079', 'Huitziltepec', '0001', 'Santa Clara Huitziltepec', '2017-10-17 15:56:34', '21'),
('079', 'Ixhuacán de los Reyes', '0001', 'Ixhuacán de los Reyes', '2017-10-17 15:56:54', '30'),
('079', 'Tekax', '0001', 'Tekax de Álvaro Obregón', '2017-10-17 15:57:03', '31'),
('080', 'Siltepec', '0001', 'Siltepec', '2017-10-17 15:55:34', '07'),
('080', 'Juchitán', '0001', 'Juchitán', '2017-10-17 15:55:45', '12'),
('080', 'Yahualica', '0001', 'Yahualica', '2017-10-17 15:55:48', '13'),
('080', 'San Sebastián del Oeste', '0001', 'San Sebastián del Oeste', '2017-10-17 15:55:52', '14'),
('080', 'Sultepec', '0001', 'Sultepec de Pedro Ascencio de Alquisiras', '2017-10-17 15:55:56', '15'),
('080', 'Senguio', '0001', 'Senguio', '2017-10-17 15:56:01', '16'),
('080', 'San Agustín Amatengo', '0001', 'San Agustín Amatengo', '2017-10-17 15:56:09', '20'),
('080', 'Atlequizayan', '0001', 'Atlequizayan', '2017-10-17 15:56:34', '21'),
('080', 'Ixhuatlán del Café', '0001', 'Ixhuatlán del Café', '2017-10-17 15:56:54', '30'),
('080', 'Tekit', '0001', 'Tekit', '2017-10-17 15:57:03', '31'),
('081', 'Simojovel', '0001', 'Simojovel de Allende', '2017-10-17 15:55:34', '07'),
('081', 'Iliatenco', '0001', 'Iliatenco', '2017-10-17 15:55:45', '12'),
('081', 'Zacualtipán de Ángeles', '0001', 'Zacualtipán', '2017-10-17 15:55:48', '13'),
('081', 'Santa María de los Ángeles', '0001', 'Santa María de los Ángeles', '2017-10-17 15:55:52', '14'),
('081', 'Tecámac', '0001', 'Tecámac de Felipe Villanueva', '2017-10-17 15:55:56', '15'),
('081', 'Susupuato', '0001', 'Susupuato de Guerrero', '2017-10-17 15:56:01', '16'),
('081', 'San Agustín Atenango', '0001', 'San Agustín Atenango', '2017-10-17 15:56:09', '20'),
('081', 'Ixcamilpa de Guerrero', '0001', 'Ixcamilpa', '2017-10-17 15:56:34', '21'),
('081', 'Ixhuatlancillo', '0001', 'Ixhuatlancillo', '2017-10-17 15:56:54', '30'),
('081', 'Tekom', '0001', 'Tekom', '2017-10-17 15:57:03', '31'),
('082', 'Sitalá', '0001', 'Sitalá', '2017-10-17 15:55:34', '07'),
('082', 'Zapotlán de Juárez', '0001', 'Zapotlán de Juárez', '2017-10-17 15:55:48', '13'),
('082', 'Sayula', '0001', 'Sayula', '2017-10-17 15:55:52', '14'),
('082', 'Tejupilco', '0001', 'Tejupilco de Hidalgo', '2017-10-17 15:55:56', '15'),
('082', 'Tacámbaro', '0001', 'Tacámbaro de Codallos', '2017-10-17 15:56:01', '16'),
('082', 'San Agustín Chayuco', '0001', 'San Agustín Chayuco', '2017-10-17 15:56:09', '20'),
('082', 'Ixcaquixtla', '0001', 'San Juan Ixcaquixtla', '2017-10-17 15:56:34', '21'),
('082', 'Ixhuatlán del Sureste', '0001', 'Ixhuatlán del Sureste', '2017-10-17 15:56:54', '30'),
('082', 'Telchac Pueblo', '0001', 'Telchac', '2017-10-17 15:57:03', '31'),
('083', 'Socoltenango', '0001', 'Socoltenango', '2017-10-17 15:55:34', '07'),
('083', 'Zempoala', '0001', 'Zempoala', '2017-10-17 15:55:49', '13'),
('083', 'Tala', '0001', 'Tala', '2017-10-17 15:55:52', '14'),
('083', 'Temamatla', '0001', 'Temamatla', '2017-10-17 15:55:56', '15'),
('083', 'Tancítaro', '0001', 'Tancítaro', '2017-10-17 15:56:01', '16'),
('083', 'San Agustín de las Juntas', '0001', 'San Agustín de las Juntas', '2017-10-17 15:56:09', '20'),
('083', 'Ixtacamaxtitlán', '0001', 'Ixtacamaxtitlán', '2017-10-17 15:56:34', '21'),
('083', 'Ixhuatlán de Madero', '0001', 'Ixhuatlán de Madero', '2017-10-17 15:56:54', '30'),
('083', 'Telchac Puerto', '0001', 'Telchac Puerto', '2017-10-17 15:57:03', '31'),
('084', 'Solosuchiapa', '0001', 'Solosuchiapa', '2017-10-17 15:55:35', '07'),
('084', 'Zimapán', '0001', 'Zimapán', '2017-10-17 15:55:49', '13'),
('084', 'Talpa de Allende', '0001', 'Talpa de Allende', '2017-10-17 15:55:52', '14'),
('084', 'Temascalapa', '0001', 'Temascalapa', '2017-10-17 15:55:56', '15'),
('084', 'Tangamandapio', '0001', 'Santiago Tangamandapio', '2017-10-17 15:56:01', '16'),
('084', 'San Agustín Etla', '0001', 'San Agustín Etla', '2017-10-17 15:56:09', '20'),
('084', 'Ixtepec', '0001', 'Ixtepec', '2017-10-17 15:56:34', '21'),
('084', 'Ixmatlahuacan', '0001', 'Ixmatlahuacan', '2017-10-17 15:56:54', '30'),
('084', 'Temax', '0001', 'Temax', '2017-10-17 15:57:03', '31'),
('085', 'Soyaló', '0001', 'Soyaló', '2017-10-17 15:55:35', '07'),
('085', 'Tamazula de Gordiano', '0001', 'Tamazula de Gordiano', '2017-10-17 15:55:52', '14'),
('085', 'Temascalcingo', '0001', 'Temascalcingo de José María Velasco', '2017-10-17 15:55:56', '15'),
('085', 'Tangancícuaro', '0001', 'Tangancícuaro de Arista', '2017-10-17 15:56:01', '16'),
('085', 'San Agustín Loxicha', '0001', 'San Agustín Loxicha', '2017-10-17 15:56:09', '20'),
('085', 'Izúcar de Matamoros', '0001', 'Izúcar de Matamoros', '2017-10-17 15:56:34', '21'),
('085', 'Ixtaczoquitlán', '0001', 'Ixtaczoquitlán', '2017-10-17 15:56:54', '30'),
('085', 'Temozón', '0001', 'Temozón', '2017-10-17 15:57:03', '31'),
('086', 'Suchiapa', '0001', 'Suchiapa', '2017-10-17 15:55:35', '07'),
('086', 'Tapalpa', '0001', 'Tapalpa', '2017-10-17 15:55:52', '14'),
('086', 'Temascaltepec', '0001', 'Temascaltepec de González', '2017-10-17 15:55:56', '15'),
('086', 'Tanhuato', '0001', 'Tanhuato de Guerrero', '2017-10-17 15:56:01', '16'),
('086', 'San Agustín Tlacotepec', '0001', 'San Agustín Tlacotepec', '2017-10-17 15:56:09', '20'),
('086', 'Jalpan', '0001', 'Jalpan', '2017-10-17 15:56:34', '21'),
('086', 'Jalacingo', '0001', 'Jalacingo', '2017-10-17 15:56:55', '30'),
('086', 'Tepakán', '0001', 'Tepakán', '2017-10-17 15:57:03', '31'),
('087', 'Suchiate', '0001', 'Ciudad Hidalgo', '2017-10-17 15:55:35', '07'),
('087', 'Tecalitlán', '0001', 'Tecalitlán', '2017-10-17 15:55:52', '14'),
('087', 'Temoaya', '0001', 'Temoaya', '2017-10-17 15:55:56', '15'),
('087', 'Taretan', '0001', 'Taretan', '2017-10-17 15:56:01', '16'),
('087', 'San Agustín Yatareni', '0001', 'San Agustín Yatareni', '2017-10-17 15:56:09', '20'),
('087', 'Jolalpan', '0001', 'Jolalpan', '2017-10-17 15:56:34', '21'),
('087', 'Xalapa', '0001', 'Xalapa-Enríquez', '2017-10-17 15:56:55', '30'),
('087', 'Tetiz', '0001', 'Tetiz', '2017-10-17 15:57:03', '31'),
('088', 'Sunuapa', '0001', 'Sunuapa', '2017-10-17 15:55:35', '07'),
('088', 'Tecolotlán', '0001', 'Tecolotlán', '2017-10-17 15:55:52', '14'),
('088', 'Tenancingo', '0001', 'Tenancingo de Degollado', '2017-10-17 15:55:56', '15'),
('088', 'Tarímbaro', '0001', 'Tarímbaro', '2017-10-17 15:56:01', '16'),
('088', 'San Andrés Cabecera Nueva', '0001', 'San Andrés Cabecera Nueva', '2017-10-17 15:56:09', '20'),
('088', 'Jonotla', '0001', 'Jonotla', '2017-10-17 15:56:34', '21'),
('088', 'Jalcomulco', '0001', 'Jalcomulco', '2017-10-17 15:56:55', '30'),
('088', 'Teya', '0001', 'Teya', '2017-10-17 15:57:03', '31'),
('089', 'Tapachula', '0001', 'Tapachula de Córdova y Ordóñez', '2017-10-17 15:55:35', '07'),
('089', 'Techaluta de Montenegro', '0001', 'Techaluta de Montenegro', '2017-10-17 15:55:52', '14'),
('089', 'Tenango del Aire', '0001', 'Tenango del Aire', '2017-10-17 15:55:56', '15'),
('089', 'Tepalcatepec', '0001', 'Tepalcatepec', '2017-10-17 15:56:01', '16'),
('089', 'San Andrés Dinicuiti', '0001', 'San Andrés Dinicuiti', '2017-10-17 15:56:09', '20'),
('089', 'Jopala', '0001', 'Jopala', '2017-10-17 15:56:34', '21'),
('089', 'Jáltipan', '0001', 'Jáltipan de Morelos', '2017-10-17 15:56:55', '30'),
('089', 'Ticul', '0001', 'Ticul', '2017-10-17 15:57:03', '31'),
('090', 'Tapalapa', '0001', 'Tapalapa', '2017-10-17 15:55:35', '07'),
('090', 'Tenamaxtlán', '0001', 'Tenamaxtlán', '2017-10-17 15:55:52', '14'),
('090', 'Tenango del Valle', '0001', 'Tenango de Arista', '2017-10-17 15:55:56', '15'),
('090', 'Tingambato', '0001', 'Tingambato', '2017-10-17 15:56:01', '16'),
('090', 'San Andrés Huaxpaltepec', '0001', 'San Andrés Huaxpaltepec', '2017-10-17 15:56:09', '20'),
('090', 'Juan C. Bonilla', '0001', 'Cuanalá', '2017-10-17 15:56:34', '21'),
('090', 'Jamapa', '0001', 'Jamapa', '2017-10-17 15:56:55', '30'),
('090', 'Timucuy', '0001', 'Timucuy', '2017-10-17 15:57:04', '31'),
('091', 'Tapilula', '0001', 'Tapilula', '2017-10-17 15:55:35', '07'),
('091', 'Teocaltiche', '0001', 'Teocaltiche', '2017-10-17 15:55:52', '14'),
('091', 'Teoloyucan', '0001', 'Teoloyucan', '2017-10-17 15:55:56', '15'),
('091', 'Tingüindín', '0001', 'Tingüindín', '2017-10-17 15:56:01', '16'),
('091', 'San Andrés Huayápam', '0001', 'San Andrés Huayápam', '2017-10-17 15:56:10', '20'),
('091', 'Juan Galindo', '0001', 'Nuevo Necaxa', '2017-10-17 15:56:34', '21'),
('091', 'Jesús Carranza', '0001', 'Jesús Carranza', '2017-10-17 15:56:55', '30'),
('091', 'Tinum', '0001', 'Tinum', '2017-10-17 15:57:04', '31'),
('092', 'Tecpatán', '0001', 'Tecpatán', '2017-10-17 15:55:35', '07'),
('092', 'Teocuitatlán de Corona', '0001', 'Teocuitatlán de Corona', '2017-10-17 15:55:52', '14'),
('092', 'Teotihuacán', '0001', 'Teotihuacán de Arista', '2017-10-17 15:55:57', '15'),
('092', 'Tiquicheo de Nicolás Romero', '0001', 'Tiquicheo', '2017-10-17 15:56:01', '16'),
('092', 'San Andrés Ixtlahuaca', '0001', 'San Andrés Ixtlahuaca', '2017-10-17 15:56:10', '20'),
('092', 'Juan N. Méndez', '0001', 'Atenayuca', '2017-10-17 15:56:34', '21'),
('092', 'Xico', '0001', 'Xico', '2017-10-17 15:56:55', '30'),
('092', 'Tixcacalcupul', '0001', 'Tixcacalcupul', '2017-10-17 15:57:04', '31'),
('093', 'Tenejapa', '0001', 'Tenejapa', '2017-10-17 15:55:35', '07'),
('093', 'Tepatitlán de Morelos', '0001', 'Tepatitlán de Morelos', '2017-10-17 15:55:52', '14'),
('093', 'Tepetlaoxtoc', '0001', 'Tepetlaoxtoc de Hidalgo', '2017-10-17 15:55:57', '15'),
('093', 'Tlalpujahua', '0001', 'Tlalpujahua de Rayón', '2017-10-17 15:56:01', '16'),
('093', 'San Andrés Lagunas', '0001', 'San Andrés Lagunas', '2017-10-17 15:56:10', '20'),
('093', 'Lafragua', '0001', 'Saltillo', '2017-10-17 15:56:34', '21'),
('093', 'Jilotepec', '0001', 'Jilotepec', '2017-10-17 15:56:55', '30'),
('093', 'Tixkokob', '0001', 'Tixkokob', '2017-10-17 15:57:04', '31'),
('094', 'Teopisca', '0001', 'Teopisca', '2017-10-17 15:55:35', '07'),
('094', 'Tequila', '0001', 'Tequila', '2017-10-17 15:55:52', '14'),
('094', 'Tepetlixpa', '0001', 'Tepetlixpa', '2017-10-17 15:55:57', '15'),
('094', 'Tlazazalca', '0001', 'Tlazazalca', '2017-10-17 15:56:01', '16'),
('094', 'San Andrés Nuxiño', '0001', 'San Andrés Nuxiño', '2017-10-17 15:56:10', '20'),
('094', 'Libres', '0001', 'Ciudad de Libres', '2017-10-17 15:56:34', '21'),
('094', 'Juan Rodríguez Clara', '0001', 'Juan Rodríguez Clara', '2017-10-17 15:56:55', '30'),
('094', 'Tixmehuac', '0001', 'Tixmehuac', '2017-10-17 15:57:04', '31'),
('095', 'Teuchitlán', '0001', 'Teuchitlán', '2017-10-17 15:55:52', '14'),
('095', 'Tepotzotlán', '0001', 'Tepotzotlán', '2017-10-17 15:55:57', '15'),
('095', 'Tocumbo', '0001', 'Tocumbo', '2017-10-17 15:56:01', '16'),
('095', 'San Andrés Paxtlán', '0001', 'San Andrés Paxtlán', '2017-10-17 15:56:10', '20'),
('095', 'La Magdalena Tlatlauquitepec', '0001', 'La Magdalena Tlatlauquitepec', '2017-10-17 15:56:34', '21'),
('095', 'Juchique de Ferrer', '0001', 'Juchique de Ferrer', '2017-10-17 15:56:55', '30'),
('095', 'Tixpéhual', '0001', 'Tixpéhual', '2017-10-17 15:57:04', '31'),
('096', 'Tila', '0001', 'Tila', '2017-10-17 15:55:35', '07'),
('096', 'Tizapán el Alto', '0001', 'Tizapán el Alto', '2017-10-17 15:55:52', '14'),
('096', 'Tequixquiac', '0001', 'Tequixquiac', '2017-10-17 15:55:57', '15'),
('096', 'Tumbiscatío', '0001', 'Tumbiscatío de Ruiz', '2017-10-17 15:56:01', '16'),
('096', 'San Andrés Sinaxtla', '0001', 'San Andrés Sinaxtla', '2017-10-17 15:56:10', '20'),
('096', 'Mazapiltepec de Juárez', '0001', 'Mazapiltepec de Juárez', '2017-10-17 15:56:34', '21'),
('096', 'Landero y Coss', '0001', 'Landero y Coss', '2017-10-17 15:56:55', '30'),
('096', 'Tizimín', '0001', 'Tizimín', '2017-10-17 15:57:04', '31'),
('097', 'Tonalá', '0001', 'Tonalá', '2017-10-17 15:55:35', '07'),
('097', 'Tlajomulco de Zúñiga', '0001', 'Tlajomulco de Zúñiga', '2017-10-17 15:55:52', '14'),
('097', 'Texcaltitlán', '0001', 'Texcaltitlán', '2017-10-17 15:55:57', '15'),
('097', 'Turicato', '0001', 'Turicato', '2017-10-17 15:56:02', '16'),
('097', 'San Andrés Solaga', '0001', 'San Andrés Solaga', '2017-10-17 15:56:10', '20'),
('097', 'Mixtla', '0001', 'San Francisco Mixtla', '2017-10-17 15:56:34', '21'),
('097', 'Lerdo de Tejada', '0001', 'Lerdo de Tejada', '2017-10-17 15:56:55', '30'),
('097', 'Tunkás', '0001', 'Tunkás', '2017-10-17 15:57:04', '31'),
('098', 'Totolapa', '0001', 'Totolapa', '2017-10-17 15:55:35', '07'),
('098', 'San Pedro Tlaquepaque', '0001', 'Tlaquepaque', '2017-10-17 15:55:52', '14'),
('098', 'Texcalyacac', '0001', 'San Mateo Texcalyacac', '2017-10-17 15:55:57', '15'),
('098', 'Tuxpan', '0001', 'Tuxpan', '2017-10-17 15:56:02', '16'),
('098', 'San Andrés Teotilálpam', '0001', 'San Andrés Teotilálpam', '2017-10-17 15:56:10', '20'),
('098', 'Molcaxac', '0001', 'Molcaxac', '2017-10-17 15:56:35', '21'),
('098', 'Magdalena', '0001', 'Magdalena', '2017-10-17 15:56:55', '30'),
('098', 'Tzucacab', '0001', 'Tzucacab', '2017-10-17 15:57:04', '31'),
('099', 'La Trinitaria', '0001', 'La Trinitaria', '2017-10-17 15:55:35', '07'),
('099', 'Tolimán', '0001', 'Tolimán', '2017-10-17 15:55:52', '14'),
('099', 'Texcoco', '0001', 'Texcoco de Mora', '2017-10-17 15:55:57', '15'),
('099', 'Tuzantla', '0001', 'Tuzantla', '2017-10-17 15:56:02', '16'),
('099', 'San Andrés Tepetlapa', '0001', 'San Andrés Tepetlapa', '2017-10-17 15:56:10', '20'),
('099', 'Cañada Morelos', '0001', 'Morelos Cañada', '2017-10-17 15:56:35', '21'),
('099', 'Maltrata', '0001', 'Maltrata', '2017-10-17 15:56:55', '30'),
('099', 'Uayma', '0001', 'Uayma', '2017-10-17 15:57:04', '31'),
('100', 'Tumbalá', '0001', 'Tumbalá', '2017-10-17 15:55:35', '07'),
('100', 'Tomatlán', '0001', 'Tomatlán', '2017-10-17 15:55:52', '14'),
('100', 'Tezoyuca', '0001', 'Tezoyuca', '2017-10-17 15:55:57', '15'),
('100', 'Tzintzuntzan', '0001', 'Tzintzuntzan', '2017-10-17 15:56:02', '16'),
('100', 'San Andrés Yaá', '0001', 'San Andrés Yaá', '2017-10-17 15:56:10', '20'),
('100', 'Naupan', '0001', 'Naupan', '2017-10-17 15:56:35', '21'),
('100', 'Manlio Fabio Altamirano', '0001', 'Manlio Fabio Altamirano', '2017-10-17 15:56:55', '30'),
('100', 'Ucú', '0001', 'Ucú', '2017-10-17 15:57:04', '31'),
('101', 'Tuxtla Gutiérrez', '0001', 'Tuxtla Gutiérrez', '2017-10-17 15:55:35', '07'),
('101', 'Tonalá', '0001', 'Tonalá', '2017-10-17 15:55:52', '14'),
('101', 'Tianguistenco', '0001', 'Santiago Tianguistenco de Galeana', '2017-10-17 15:55:57', '15'),
('101', 'Tzitzio', '0001', 'Tzitzio', '2017-10-17 15:56:02', '16'),
('101', 'San Andrés Zabache', '0001', 'San Andrés Zabache', '2017-10-17 15:56:10', '20'),
('101', 'Nauzontla', '0001', 'Nauzontla', '2017-10-17 15:56:35', '21'),
('101', 'Mariano Escobedo', '0001', 'Mariano Escobedo', '2017-10-17 15:56:55', '30'),
('101', 'Umán', '0001', 'Umán', '2017-10-17 15:57:04', '31'),
('102', 'Tuxtla Chico', '0001', 'Tuxtla Chico', '2017-10-17 15:55:35', '07'),
('102', 'Tonaya', '0001', 'Tonaya', '2017-10-17 15:55:52', '14'),
('102', 'Timilpan', '0001', 'San Andrés Timilpan', '2017-10-17 15:55:57', '15'),
('102', 'Uruapan', '0001', 'Uruapan', '2017-10-17 15:56:02', '16'),
('102', 'San Andrés Zautla', '0001', 'San Andrés Zautla', '2017-10-17 15:56:10', '20'),
('102', 'Nealtican', '0001', 'San Buenaventura Nealtican', '2017-10-17 15:56:35', '21'),
('102', 'Martínez de la Torre', '0001', 'Martínez de la Torre', '2017-10-17 15:56:55', '30'),
('102', 'Valladolid', '0001', 'Valladolid', '2017-10-17 15:57:04', '31'),
('103', 'Tuzantán', '0001', 'Tuzantán', '2017-10-17 15:55:35', '07'),
('103', 'Tonila', '0001', 'Tonila', '2017-10-17 15:55:52', '14'),
('103', 'Tlalmanalco', '0001', 'Tlalmanalco de Velázquez', '2017-10-17 15:55:57', '15'),
('103', 'Venustiano Carranza', '0001', 'Venustiano Carranza', '2017-10-17 15:56:02', '16'),
('103', 'San Antonino Castillo Velasco', '0001', 'San Antonino Castillo Velasco', '2017-10-17 15:56:10', '20'),
('103', 'Nicolás Bravo', '0001', 'Nicolás Bravo', '2017-10-17 15:56:35', '21'),
('103', 'Mecatlán', '0001', 'Mecatlán', '2017-10-17 15:56:55', '30'),
('103', 'Xocchel', '0001', 'Xocchel', '2017-10-17 15:57:04', '31'),
('104', 'Tzimol', '0001', 'Tzimol', '2017-10-17 15:55:35', '07'),
('104', 'Totatiche', '0001', 'Totatiche', '2017-10-17 15:55:52', '14'),
('104', 'Tlalnepantla de Baz', '0001', 'Tlalnepantla', '2017-10-17 15:55:57', '15'),
('104', 'Villamar', '0001', 'Villamar', '2017-10-17 15:56:02', '16'),
('104', 'San Antonino el Alto', '0001', 'San Antonino el Alto', '2017-10-17 15:56:10', '20'),
('104', 'Nopalucan', '0001', 'Nopalucan de la Granja', '2017-10-17 15:56:35', '21'),
('104', 'Mecayapan', '0001', 'Mecayapan', '2017-10-17 15:56:55', '30'),
('104', 'Yaxcabá', '0001', 'Yaxcabá', '2017-10-17 15:57:04', '31'),
('105', 'Unión Juárez', '0001', 'Unión Juárez', '2017-10-17 15:55:35', '07'),
('105', 'Tototlán', '0001', 'Tototlán', '2017-10-17 15:55:53', '14'),
('105', 'Tlatlaya', '0001', 'Tlatlaya', '2017-10-17 15:55:57', '15'),
('105', 'Vista Hermosa', '0001', 'Vista Hermosa de Negrete', '2017-10-17 15:56:02', '16'),
('105', 'San Antonino Monte Verde', '0001', 'San Antonino Monte Verde', '2017-10-17 15:56:10', '20'),
('105', 'Ocotepec', '0001', 'Ocotepec', '2017-10-17 15:56:35', '21'),
('105', 'Medellín de Bravo', '0001', 'Medellín', '2017-10-17 15:56:55', '30'),
('105', 'Yaxkukul', '0001', 'Yaxkukul', '2017-10-17 15:57:04', '31'),
('106', 'Venustiano Carranza', '0001', 'Venustiano Carranza', '2017-10-17 15:55:35', '07'),
('106', 'Tuxcacuesco', '0001', 'Tuxcacuesco', '2017-10-17 15:55:53', '14'),
('106', 'Toluca', '0001', 'Toluca de Lerdo', '2017-10-17 15:55:57', '15'),
('106', 'Yurécuaro', '0001', 'Yurécuaro', '2017-10-17 15:56:02', '16'),
('106', 'San Antonio Acutla', '0001', 'San Antonio Acutla', '2017-10-17 15:56:10', '20'),
('106', 'Ocoyucan', '0001', 'Santa Clara Ocoyucan', '2017-10-17 15:56:35', '21'),
('106', 'Miahuatlán', '0001', 'Miahuatlán', '2017-10-17 15:56:55', '30'),
('106', 'Yobaín', '0001', 'Yobaín', '2017-10-17 15:57:04', '31'),
('107', 'Villa Corzo', '0001', 'Villa Corzo', '2017-10-17 15:55:35', '07'),
('107', 'Tuxcueca', '0001', 'Tuxcueca', '2017-10-17 15:55:53', '14'),
('107', 'Tonatico', '0001', 'Tonatico', '2017-10-17 15:55:57', '15'),
('107', 'Zacapu', '0001', 'Zacapu', '2017-10-17 15:56:02', '16'),
('107', 'San Antonio de la Cal', '0001', 'San Antonio de la Cal', '2017-10-17 15:56:10', '20'),
('107', 'Olintla', '0001', 'Olintla', '2017-10-17 15:56:35', '21'),
('107', 'Las Minas', '0001', 'Las Minas', '2017-10-17 15:56:55', '30'),
('108', 'Villaflores', '0001', 'Villaflores', '2017-10-17 15:55:35', '07'),
('108', 'Tuxpan', '0001', 'Tuxpan', '2017-10-17 15:55:53', '14'),
('108', 'Tultepec', '0001', 'Tultepec', '2017-10-17 15:55:57', '15'),
('108', 'Zamora', '0001', 'Zamora de Hidalgo', '2017-10-17 15:56:02', '16'),
('108', 'San Antonio Huitepec', '0001', 'San Antonio Huitepec', '2017-10-17 15:56:10', '20'),
('108', 'Oriental', '0001', 'Oriental', '2017-10-17 15:56:35', '21'),
('108', 'Minatitlán', '0001', 'Minatitlán', '2017-10-17 15:56:55', '30'),
('109', 'Yajalón', '0001', 'Yajalón', '2017-10-17 15:55:35', '07'),
('109', 'Unión de San Antonio', '0001', 'Unión de San Antonio', '2017-10-17 15:55:53', '14'),
('109', 'Tultitlán', '0001', 'Tultitlán de Mariano Escobedo', '2017-10-17 15:55:57', '15'),
('109', 'Zináparo', '0001', 'Zináparo', '2017-10-17 15:56:02', '16'),
('109', 'San Antonio Nanahuatípam', '0001', 'San Antonio Nanahuatípam', '2017-10-17 15:56:10', '20'),
('109', 'Pahuatlán', '0001', 'Ciudad de Pahuatlán de Valle', '2017-10-17 15:56:35', '21'),
('109', 'Misantla', '0001', 'Misantla', '2017-10-17 15:56:55', '30'),
('110', 'San Lucas', '0001', 'San Lucas', '2017-10-17 15:55:35', '07'),
('110', 'Unión de Tula', '0001', 'Unión de Tula', '2017-10-17 15:55:53', '14'),
('110', 'Valle de Bravo', '0001', 'Valle de Bravo', '2017-10-17 15:55:57', '15'),
('110', 'Zinapécuaro', '0001', 'Zinapécuaro de Figueroa', '2017-10-17 15:56:02', '16'),
('110', 'San Antonio Sinicahua', '0001', 'San Antonio Sinicahua', '2017-10-17 15:56:10', '20'),
('110', 'Palmar de Bravo', '0001', 'Palmar de Bravo', '2017-10-17 15:56:35', '21'),
('110', 'Mixtla de Altamirano', '0001', 'Mixtla de Altamirano', '2017-10-17 15:56:56', '30'),
('111', 'Zinacantán', '0001', 'Zinacantán', '2017-10-17 15:55:35', '07'),
('111', 'Valle de Guadalupe', '0001', 'Valle de Guadalupe', '2017-10-17 15:55:53', '14'),
('111', 'Villa de Allende', '0001', 'San José Villa de Allende', '2017-10-17 15:55:57', '15'),
('111', 'Ziracuaretiro', '0001', 'Ziracuaretiro', '2017-10-17 15:56:02', '16'),
('111', 'San Antonio Tepetlapa', '0001', 'San Antonio Tepetlapa', '2017-10-17 15:56:10', '20'),
('111', 'Pantepec', '0001', 'Pantepec', '2017-10-17 15:56:35', '21'),
('111', 'Moloacán', '0001', 'Moloacán', '2017-10-17 15:56:56', '30'),
('112', 'San Juan Cancuc', '0001', 'San Juan Cancuc', '2017-10-17 15:55:36', '07'),
('112', 'Valle de Juárez', '0001', 'Valle de Juárez', '2017-10-17 15:55:53', '14'),
('112', 'Villa del Carbón', '0001', 'Villa del Carbón', '2017-10-17 15:55:57', '15'),
('112', 'Zitácuaro', '0001', 'Heróica Zitácuaro', '2017-10-17 15:56:02', '16'),
('112', 'San Baltazar Chichicápam', '0001', 'San Baltazar Chichicápam', '2017-10-17 15:56:10', '20'),
('112', 'Petlalcingo', '0001', 'Petlalcingo', '2017-10-17 15:56:35', '21'),
('112', 'Naolinco', '0001', 'Naolinco de Victoria', '2017-10-17 15:56:56', '30'),
('113', 'Aldama', '0001', 'Aldama', '2017-10-17 15:55:36', '07'),
('113', 'San Gabriel', '0001', 'San Gabriel', '2017-10-17 15:55:53', '14'),
('113', 'Villa Guerrero', '0001', 'Villa Guerrero', '2017-10-17 15:55:57', '15'),
('113', 'José Sixto Verduzco', '0001', 'Pastor Ortiz', '2017-10-17 15:56:02', '16'),
('113', 'San Baltazar Loxicha', '0001', 'San Baltazar Loxicha', '2017-10-17 15:56:10', '20'),
('113', 'Piaxtla', '0001', 'Piaxtla', '2017-10-17 15:56:35', '21'),
('113', 'Naranjal', '0001', 'Naranjal', '2017-10-17 15:56:56', '30'),
('114', 'Benemérito de las Américas', '0001', 'Benemérito de las Américas', '2017-10-17 15:55:36', '07'),
('114', 'Villa Corona', '0001', 'Villa Corona', '2017-10-17 15:55:53', '14'),
('114', 'Villa Victoria', '0001', 'Villa Victoria', '2017-10-17 15:55:57', '15'),
('114', 'San Baltazar Yatzachi el Bajo', '0001', 'San Baltazar Yatzachi el Bajo', '2017-10-17 15:56:10', '20'),
('114', 'Puebla', '0001', 'Heróica Puebla de Zaragoza', '2017-10-17 15:56:35', '21'),
('114', 'Nautla', '0001', 'Nautla', '2017-10-17 15:56:56', '30'),
('115', 'Maravilla Tenejapa', '0001', 'Maravilla Tenejapa', '2017-10-17 15:55:36', '07'),
('115', 'Villa Guerrero', '0001', 'Villa Guerrero', '2017-10-17 15:55:53', '14'),
('115', 'Xonacatlán', '0001', 'Xonacatlán', '2017-10-17 15:55:57', '15'),
('115', 'San Bartolo Coyotepec', '0001', 'San Bartolo Coyotepec', '2017-10-17 15:56:10', '20'),
('115', 'Quecholac', '0001', 'Quecholac', '2017-10-17 15:56:35', '21'),
('115', 'Nogales', '0001', 'Nogales', '2017-10-17 15:56:56', '30'),
('116', 'Marqués de Comillas', '0001', 'Zamora Pico de Oro', '2017-10-17 15:55:36', '07'),
('116', 'Villa Hidalgo', '0001', 'Villa Hidalgo', '2017-10-17 15:55:53', '14'),
('116', 'Zacazonapan', '0001', 'Zacazonapan', '2017-10-17 15:55:57', '15'),
('116', 'San Bartolomé Ayautla', '0001', 'San Bartolomé Ayautla', '2017-10-17 15:56:11', '20'),
('116', 'Quimixtlán', '0001', 'Quimixtlán', '2017-10-17 15:56:35', '21'),
('116', 'Oluta', '0001', 'Oluta', '2017-10-17 15:56:56', '30'),
('117', 'Montecristo de Guerrero', '0001', 'Montecristo de Guerrero', '2017-10-17 15:55:36', '07'),
('117', 'Cañadas de Obregón', '0001', 'Cañadas de Obregón', '2017-10-17 15:55:53', '14'),
('117', 'Zacualpan', '0001', 'Zacualpan', '2017-10-17 15:55:57', '15'),
('117', 'San Bartolomé Loxicha', '0001', 'San Bartolomé Loxicha', '2017-10-17 15:56:11', '20'),
('117', 'Rafael Lara Grajales', '0001', 'Ciudad de Rafael Lara Grajales', '2017-10-17 15:56:35', '21'),
('117', 'Omealca', '0001', 'Omealca', '2017-10-17 15:56:56', '30'),
('118', 'San Andrés Duraznal', '0001', 'San Andrés Duraznal', '2017-10-17 15:55:36', '07'),
('118', 'Yahualica de González Gallo', '0001', 'Yahualica de González Gallo', '2017-10-17 15:55:53', '14'),
('118', 'Zinacantepec', '0001', 'San Miguel Zinacantepec', '2017-10-17 15:55:57', '15'),
('118', 'San Bartolomé Quialana', '0001', 'San Bartolomé Quialana', '2017-10-17 15:56:11', '20'),
('118', 'Los Reyes de Juárez', '0001', 'Los Reyes de Juárez', '2017-10-17 15:56:35', '21'),
('118', 'Orizaba', '0001', 'Orizaba', '2017-10-17 15:56:56', '30'),
('119', 'Santiago el Pinar', '0001', 'Santiago el Pinar', '2017-10-17 15:55:36', '07'),
('119', 'Zacoalco de Torres', '0001', 'Zacoalco de Torres', '2017-10-17 15:55:53', '14'),
('119', 'Zumpahuacán', '0001', 'Zumpahuacán', '2017-10-17 15:55:58', '15'),
('119', 'San Bartolomé Yucuañe', '0001', 'San Bartolomé Yucuañe', '2017-10-17 15:56:11', '20'),
('119', 'San Andrés Cholula', '0001', 'San Andrés Cholula', '2017-10-17 15:56:35', '21'),
('119', 'Otatitlán', '0001', 'Otatitlán', '2017-10-17 15:56:56', '30'),
('120', 'Zapopan', '0001', 'Zapopan', '2017-10-17 15:55:53', '14'),
('120', 'Zumpango', '0001', 'Zumpango de Ocampo', '2017-10-17 15:55:58', '15'),
('120', 'San Bartolomé Zoogocho', '0001', 'San Bartolomé Zoogocho', '2017-10-17 15:56:11', '20'),
('120', 'San Antonio Cañada', '0001', 'San Antonio Cañada', '2017-10-17 15:56:35', '21'),
('120', 'Oteapan', '0001', 'Oteapan', '2017-10-17 15:56:56', '30'),
('121', 'Zapotiltic', '0001', 'Zapotiltic', '2017-10-17 15:55:53', '14'),
('121', 'Cuautitlán Izcalli', '0001', 'Cuautitlán Izcalli', '2017-10-17 15:55:58', '15'),
('121', 'San Bartolo Soyaltepec', '0001', 'San Bartolo Soyaltepec', '2017-10-17 15:56:11', '20'),
('121', 'San Diego la Mesa Tochimiltzingo', '0001', 'Tochimiltzingo', '2017-10-17 15:56:35', '21'),
('121', 'Ozuluama de Mascareñas', '0001', 'Ozuluama de Mascareñas', '2017-10-17 15:56:56', '30'),
('122', 'Zapotitlán de Vadillo', '0001', 'Zapotitlán de Vadillo', '2017-10-17 15:55:53', '14'),
('122', 'Valle de Chalco Solidaridad', '0001', 'Xico', '2017-10-17 15:55:58', '15'),
('122', 'San Bartolo Yautepec', '0001', 'San Bartolo Yautepec', '2017-10-17 15:56:11', '20'),
('122', 'San Felipe Teotlalcingo', '0001', 'San Felipe Teotlalcingo', '2017-10-17 15:56:35', '21'),
('122', 'Pajapan', '0001', 'Pajapan', '2017-10-17 15:56:56', '30'),
('123', 'Zapotlán del Rey', '0001', 'Zapotlán del Rey', '2017-10-17 15:55:53', '14'),
('123', 'Luvianos', '0001', 'Villa Luvianos', '2017-10-17 15:55:58', '15'),
('123', 'San Bernardo Mixtepec', '0001', 'San Bernardo Mixtepec', '2017-10-17 15:56:11', '20'),
('123', 'San Felipe Tepatlán', '0001', 'San Felipe Tepatlán', '2017-10-17 15:56:35', '21'),
('123', 'Pánuco', '0001', 'Pánuco', '2017-10-17 15:56:56', '30'),
('124', 'Zapotlanejo', '0001', 'Zapotlanejo', '2017-10-17 15:55:53', '14'),
('124', 'San José del Rincón', '0001', 'San José del Rincón Centro', '2017-10-17 15:55:58', '15'),
('124', 'San Blas Atempa', '0001', 'San Blas Atempa', '2017-10-17 15:56:11', '20'),
('124', 'San Gabriel Chilac', '0001', 'San Gabriel Chilac', '2017-10-17 15:56:36', '21'),
('124', 'Papantla', '0001', 'Papantla de Olarte', '2017-10-17 15:56:56', '30'),
('125', 'San Ignacio Cerro Gordo', '0001', 'San Ignacio Cerro Gordo', '2017-10-17 15:55:53', '14'),
('125', 'Tonanitla', '0001', 'Santa María Tonanitla', '2017-10-17 15:55:58', '15'),
('125', 'San Carlos Yautepec', '0001', 'San Carlos Yautepec', '2017-10-17 15:56:11', '20'),
('125', 'San Gregorio Atzompa', '0001', 'San Gregorio Atzompa', '2017-10-17 15:56:36', '21'),
('125', 'Paso del Macho', '0001', 'Paso del Macho', '2017-10-17 15:56:56', '30'),
('126', 'San Cristóbal Amatlán', '0001', 'San Cristóbal Amatlán', '2017-10-17 15:56:11', '20'),
('126', 'San Jerónimo Tecuanipan', '0001', 'San Jerónimo Tecuanipan', '2017-10-17 15:56:36', '21'),
('126', 'Paso de Ovejas', '0001', 'Paso de Ovejas', '2017-10-17 15:56:56', '30'),
('127', 'San Cristóbal Amoltepec', '0001', 'San Cristóbal Amoltepec', '2017-10-17 15:56:11', '20'),
('127', 'San Jerónimo Xayacatlán', '0001', 'San Jerónimo Xayacatlán', '2017-10-17 15:56:36', '21'),
('127', 'La Perla', '0001', 'La Perla', '2017-10-17 15:56:56', '30'),
('128', 'San Cristóbal Lachirioag', '0001', 'San Cristóbal Lachirioag', '2017-10-17 15:56:11', '20'),
('128', 'San José Chiapa', '0001', 'San José Chiapa', '2017-10-17 15:56:36', '21'),
('128', 'Perote', '0001', 'Perote', '2017-10-17 15:56:56', '30'),
('129', 'San Cristóbal Suchixtlahuaca', '0001', 'San Cristóbal Suchixtlahuaca', '2017-10-17 15:56:11', '20'),
('129', 'San José Miahuatlán', '0001', 'San José Miahuatlán', '2017-10-17 15:56:36', '21'),
('129', 'Platón Sánchez', '0001', 'Platón Sánchez', '2017-10-17 15:56:56', '30'),
('130', 'San Dionisio del Mar', '0001', 'San Dionisio del Mar', '2017-10-17 15:56:11', '20'),
('130', 'San Juan Atenco', '0001', 'San Juan Atenco', '2017-10-17 15:56:36', '21'),
('130', 'Playa Vicente', '0001', 'Playa Vicente', '2017-10-17 15:56:56', '30'),
('131', 'San Dionisio Ocotepec', '0001', 'San Dionisio Ocotepec', '2017-10-17 15:56:11', '20'),
('131', 'San Juan Atzompa', '0001', 'San Juan Atzompa', '2017-10-17 15:56:36', '21'),
('131', 'Poza Rica de Hidalgo', '0001', 'Poza Rica de Hidalgo', '2017-10-17 15:56:56', '30'),
('132', 'San Dionisio Ocotlán', '0001', 'San Dionisio Ocotlán', '2017-10-17 15:56:11', '20'),
('132', 'San Martín Texmelucan', '0001', 'San Martín Texmelucan de Labastida', '2017-10-17 15:56:36', '21'),
('132', 'Las Vigas de Ramírez', '0001', 'Las Vigas de Ramírez', '2017-10-17 15:56:56', '30'),
('133', 'San Esteban Atatlahuca', '0001', 'San Esteban Atatlahuca', '2017-10-17 15:56:11', '20'),
('133', 'San Martín Totoltepec', '0001', 'San Martín Totoltepec', '2017-10-17 15:56:36', '21'),
('133', 'Pueblo Viejo', '0001', 'Cd. Cuauhtémoc', '2017-10-17 15:56:56', '30'),
('134', 'San Felipe Jalapa de Díaz', '0001', 'San Felipe Jalapa de Díaz', '2017-10-17 15:56:11', '20'),
('134', 'San Matías Tlalancaleca', '0001', 'San Matías Tlalancaleca', '2017-10-17 15:56:36', '21'),
('134', 'Puente Nacional', '0001', 'Puente Nacional', '2017-10-17 15:56:56', '30'),
('135', 'San Felipe Tejalápam', '0001', 'San Felipe Tejalápam', '2017-10-17 15:56:11', '20'),
('135', 'San Miguel Ixitlán', '0001', 'San Miguel Ixitlán', '2017-10-17 15:56:36', '21'),
('135', 'Rafael Delgado', '0001', 'Rafael Delgado', '2017-10-17 15:56:57', '30'),
('136', 'San Felipe Usila', '0001', 'San Felipe Usila', '2017-10-17 15:56:11', '20'),
('136', 'San Miguel Xoxtla', '0001', 'San Miguel Xoxtla', '2017-10-17 15:56:36', '21'),
('136', 'Rafael Lucio', '0001', 'Rafael Lucio', '2017-10-17 15:56:57', '30'),
('137', 'San Francisco Cahuacuá', '0001', 'San Francisco Cahuacuá', '2017-10-17 15:56:11', '20'),
('137', 'San Nicolás Buenos Aires', '0001', 'San Nicolás Buenos Aires', '2017-10-17 15:56:36', '21'),
('137', 'Los Reyes', '0001', 'Los Reyes', '2017-10-17 15:56:57', '30'),
('138', 'San Francisco Cajonos', '0001', 'San Francisco Cajonos', '2017-10-17 15:56:11', '20'),
('138', 'San Nicolás de los Ranchos', '0001', 'San Nicolás de los Ranchos', '2017-10-17 15:56:36', '21'),
('138', 'Río Blanco', '0001', 'Río Blanco', '2017-10-17 15:56:57', '30'),
('139', 'San Francisco Chapulapa', '0001', 'San Francisco Chapulapa', '2017-10-17 15:56:11', '20'),
('139', 'San Pablo Anicano', '0001', 'San Pablo Anicano', '2017-10-17 15:56:36', '21'),
('139', 'Saltabarranca', '0001', 'Saltabarranca', '2017-10-17 15:56:57', '30'),
('140', 'San Francisco Chindúa', '0001', 'San Francisco Chindúa', '2017-10-17 15:56:12', '20'),
('140', 'San Pedro Cholula', '0001', 'Cholula de Rivadavia', '2017-10-17 15:56:36', '21'),
('140', 'San Andrés Tenejapan', '0001', 'San Andrés Tenejapan', '2017-10-17 15:56:57', '30'),
('141', 'San Francisco del Mar', '0036', 'San Francisco del Mar', '2017-10-17 15:56:12', '20'),
('141', 'San Pedro Yeloixtlahuaca', '0001', 'San Pedro Yeloixtlahuaca', '2017-10-17 15:56:36', '21'),
('141', 'San Andrés Tuxtla', '0001', 'San Andrés Tuxtla', '2017-10-17 15:56:57', '30'),
('142', 'San Francisco Huehuetlán', '0001', 'San Francisco Huehuetlán', '2017-10-17 15:56:12', '20'),
('142', 'San Salvador el Seco', '0001', 'San Salvador el Seco', '2017-10-17 15:56:36', '21'),
('142', 'San Juan Evangelista', '0001', 'San Juan Evangelista', '2017-10-17 15:56:57', '30'),
('143', 'San Francisco Ixhuatán', '0001', 'San Francisco Ixhuatán', '2017-10-17 15:56:12', '20'),
('143', 'San Salvador el Verde', '0001', 'San Salvador el Verde', '2017-10-17 15:56:36', '21'),
('143', 'Santiago Tuxtla', '0001', 'Santiago Tuxtla', '2017-10-17 15:56:57', '30'),
('144', 'San Francisco Jaltepetongo', '0001', 'San Francisco Jaltepetongo', '2017-10-17 15:56:12', '20'),
('144', 'San Salvador Huixcolotla', '0001', 'San Salvador Huixcolotla', '2017-10-17 15:56:36', '21'),
('144', 'Sayula de Alemán', '0001', 'Sayula de Alemán', '2017-10-17 15:56:57', '30'),
('145', 'San Francisco Lachigoló', '0001', 'San Francisco Lachigoló', '2017-10-17 15:56:12', '20'),
('145', 'San Sebastián Tlacotepec', '0001', 'Tlacotepec de Porfirio Díaz', '2017-10-17 15:56:36', '21'),
('145', 'Soconusco', '0001', 'Soconusco', '2017-10-17 15:56:57', '30'),
('146', 'San Francisco Logueche', '0001', 'San Francisco Logueche', '2017-10-17 15:56:12', '20'),
('146', 'Santa Catarina Tlaltempan', '0001', 'Santa Catarina Tlaltempan', '2017-10-17 15:56:36', '21'),
('146', 'Sochiapa', '0001', 'Sochiapa', '2017-10-17 15:56:57', '30'),
('147', 'San Francisco Nuxaño', '0001', 'San Francisco Nuxaño', '2017-10-17 15:56:12', '20'),
('147', 'Santa Inés Ahuatempan', '0001', 'Santa Inés Ahuatempan', '2017-10-17 15:56:36', '21'),
('147', 'Soledad Atzompa', '0001', 'Soledad Atzompa', '2017-10-17 15:56:57', '30'),
('148', 'San Francisco Ozolotepec', '0001', 'San Francisco Ozolotepec', '2017-10-17 15:56:12', '20'),
('148', 'Santa Isabel Cholula', '0001', 'Santa Isabel Cholula', '2017-10-17 15:56:36', '21'),
('148', 'Soledad de Doblado', '0001', 'Soledad de Doblado', '2017-10-17 15:56:57', '30'),
('149', 'San Francisco Sola', '0001', 'San Francisco Sola', '2017-10-17 15:56:12', '20'),
('149', 'Santiago Miahuatlán', '0001', 'Santiago Miahuatlán', '2017-10-17 15:56:36', '21'),
('149', 'Soteapan', '0001', 'Soteapan', '2017-10-17 15:56:57', '30'),
('150', 'San Francisco Telixtlahuaca', '0001', 'San Francisco Telixtlahuaca', '2017-10-17 15:56:12', '20'),
('150', 'Huehuetlán el Grande', '0001', 'Santo Domingo Huehuetlán', '2017-10-17 15:56:36', '21'),
('150', 'Tamalín', '0001', 'Tamalín', '2017-10-17 15:56:57', '30'),
('151', 'San Francisco Teopan', '0001', 'San Francisco Teopan', '2017-10-17 15:56:12', '20'),
('151', 'Santo Tomás Hueyotlipan', '0001', 'Santo Tomás Hueyotlipan', '2017-10-17 15:56:37', '21'),
('151', 'Tamiahua', '0001', 'Tamiahua', '2017-10-17 15:56:57', '30'),
('152', 'San Francisco Tlapancingo', '0001', 'San Francisco Tlapancingo', '2017-10-17 15:56:12', '20'),
('152', 'Soltepec', '0001', 'Soltepec', '2017-10-17 15:56:37', '21'),
('152', 'Tampico Alto', '0001', 'Tampico Alto', '2017-10-17 15:56:57', '30'),
('153', 'San Gabriel Mixtepec', '0001', 'San Gabriel Mixtepec', '2017-10-17 15:56:12', '20'),
('153', 'Tecali de Herrera', '0001', 'Tecali de Herrera', '2017-10-17 15:56:37', '21'),
('153', 'Tancoco', '0001', 'Tancoco', '2017-10-17 15:56:57', '30'),
('154', 'San Ildefonso Amatlán', '0001', 'San Ildefonso Amatlán', '2017-10-17 15:56:12', '20'),
('154', 'Tecamachalco', '0001', 'Tecamachalco', '2017-10-17 15:56:37', '21'),
('154', 'Tantima', '0001', 'Tantima', '2017-10-17 15:56:57', '30'),
('155', 'San Ildefonso Sola', '0001', 'San Ildefonso Sola', '2017-10-17 15:56:12', '20'),
('155', 'Tecomatlán', '0001', 'Tecomatlán', '2017-10-17 15:56:37', '21'),
('155', 'Tantoyuca', '0001', 'Tantoyuca', '2017-10-17 15:56:57', '30'),
('156', 'San Ildefonso Villa Alta', '0001', 'San Ildefonso Villa Alta', '2017-10-17 15:56:12', '20'),
('156', 'Tehuacán', '0001', 'Tehuacán', '2017-10-17 15:56:37', '21'),
('156', 'Tatatila', '0001', 'Tatatila', '2017-10-17 15:56:57', '30'),
('157', 'San Jacinto Amilpas', '0001', 'San Jacinto Amilpas', '2017-10-17 15:56:12', '20'),
('157', 'Tehuitzingo', '0001', 'Tehuitzingo', '2017-10-17 15:56:37', '21'),
('157', 'Castillo de Teayo', '0001', 'Castillo de Teayo', '2017-10-17 15:56:57', '30'),
('158', 'San Jacinto Tlacotepec', '0001', 'San Jacinto Tlacotepec', '2017-10-17 15:56:12', '20'),
('158', 'Tenampulco', '0001', 'Tenampulco', '2017-10-17 15:56:37', '21'),
('158', 'Tecolutla', '0001', 'Tecolutla', '2017-10-17 15:56:57', '30'),
('159', 'San Jerónimo Coatlán', '0001', 'San Jerónimo Coatlán', '2017-10-17 15:56:12', '20'),
('159', 'Teopantlán', '0001', 'Teopantlán', '2017-10-17 15:56:37', '21');
INSERT INTO `municipio` (`cve_mun`, `nom_mun`, `cve_cab`, `nom_cab`, `fechaModificacion`, `cve_ent`) VALUES
('159', 'Tehuipango', '0001', 'Tehuipango', '2017-10-17 15:56:58', '30'),
('160', 'San Jerónimo Silacayoapilla', '0001', 'San Jerónimo Silacayoapilla', '2017-10-17 15:56:12', '20'),
('160', 'Teotlalco', '0001', 'Teotlalco', '2017-10-17 15:56:37', '21'),
('160', 'Álamo Temapache', '0001', 'Álamo', '2017-10-17 15:56:58', '30'),
('161', 'San Jerónimo Sosola', '0001', 'San Jerónimo Sosola', '2017-10-17 15:56:12', '20'),
('161', 'Tepanco de López', '0001', 'Tepanco de López', '2017-10-17 15:56:37', '21'),
('161', 'Tempoal', '0001', 'Tempoal de Sánchez', '2017-10-17 15:56:58', '30'),
('162', 'San Jerónimo Taviche', '0001', 'San Jerónimo Taviche', '2017-10-17 15:56:12', '20'),
('162', 'Tepango de Rodríguez', '0001', 'Tepango de Rodríguez', '2017-10-17 15:56:37', '21'),
('162', 'Tenampa', '0001', 'Tenampa', '2017-10-17 15:56:58', '30'),
('163', 'San Jerónimo Tecóatl', '0001', 'San Jerónimo Tecóatl', '2017-10-17 15:56:12', '20'),
('163', 'Tepatlaxco de Hidalgo', '0001', 'Tepatlaxco de Hidalgo', '2017-10-17 15:56:37', '21'),
('163', 'Tenochtitlán', '0001', 'Tenochtitlán', '2017-10-17 15:56:58', '30'),
('164', 'San Jorge Nuchita', '0001', 'San Jorge Nuchita', '2017-10-17 15:56:12', '20'),
('164', 'Tepeaca', '0001', 'Tepeaca', '2017-10-17 15:56:37', '21'),
('164', 'Teocelo', '0001', 'Teocelo', '2017-10-17 15:56:58', '30'),
('165', 'San José Ayuquila', '0001', 'San José Ayuquila', '2017-10-17 15:56:13', '20'),
('165', 'Tepemaxalco', '0001', 'San Felipe Tepemaxalco', '2017-10-17 15:56:37', '21'),
('165', 'Tepatlaxco', '0001', 'Tepatlaxco', '2017-10-17 15:56:58', '30'),
('166', 'San José Chiltepec', '0001', 'San José Chiltepec', '2017-10-17 15:56:13', '20'),
('166', 'Tepeojuma', '0001', 'Tepeojuma', '2017-10-17 15:56:37', '21'),
('166', 'Tepetlán', '0001', 'Tepetlán', '2017-10-17 15:56:58', '30'),
('167', 'San José del Peñasco', '0001', 'San José del Peñasco', '2017-10-17 15:56:13', '20'),
('167', 'Tepetzintla', '0001', 'Tepetzintla', '2017-10-17 15:56:37', '21'),
('167', 'Tepetzintla', '0001', 'Tepetzintla', '2017-10-17 15:56:58', '30'),
('168', 'San José Estancia Grande', '0001', 'San José Estancia Grande', '2017-10-17 15:56:13', '20'),
('168', 'Tepexco', '0001', 'Tepexco', '2017-10-17 15:56:37', '21'),
('168', 'Tequila', '0001', 'Tequila', '2017-10-17 15:56:58', '30'),
('169', 'San José Independencia', '0001', 'San José Independencia', '2017-10-17 15:56:13', '20'),
('169', 'Tepexi de Rodríguez', '0001', 'Tepexi de Rodríguez', '2017-10-17 15:56:37', '21'),
('169', 'José Azueta', '0001', 'Villa Azueta', '2017-10-17 15:56:58', '30'),
('170', 'San José Lachiguiri', '0001', 'San José Lachiguiri', '2017-10-17 15:56:13', '20'),
('170', 'Tepeyahualco', '0001', 'Tepeyahualco', '2017-10-17 15:56:37', '21'),
('170', 'Texcatepec', '0001', 'Texcatepec', '2017-10-17 15:56:58', '30'),
('171', 'San José Tenango', '0001', 'San José Tenango', '2017-10-17 15:56:13', '20'),
('171', 'Tepeyahualco de Cuauhtémoc', '0001', 'Tepeyahualco de Cuauhtémoc', '2017-10-17 15:56:37', '21'),
('171', 'Texhuacán', '0001', 'Texhuacán', '2017-10-17 15:56:58', '30'),
('172', 'San Juan Achiutla', '0001', 'San Juan Achiutla', '2017-10-17 15:56:13', '20'),
('172', 'Tetela de Ocampo', '0001', 'Ciudad de Tetela de Ocampo', '2017-10-17 15:56:37', '21'),
('172', 'Texistepec', '0001', 'Texistepec', '2017-10-17 15:56:58', '30'),
('173', 'San Juan Atepec', '0001', 'San Juan Atepec', '2017-10-17 15:56:13', '20'),
('173', 'Teteles de Avila Castillo', '0001', 'Teteles de Avila Castillo', '2017-10-17 15:56:37', '21'),
('173', 'Tezonapa', '0001', 'Tezonapa', '2017-10-17 15:56:58', '30'),
('174', 'Ánimas Trujano', '0001', 'Ánimas Trujano', '2017-10-17 15:56:13', '20'),
('174', 'Teziutlán', '0001', 'Teziutlán', '2017-10-17 15:56:37', '21'),
('174', 'Tierra Blanca', '0001', 'Tierra Blanca', '2017-10-17 15:56:58', '30'),
('175', 'San Juan Bautista Atatlahuca', '0001', 'San Juan Bautista Atatlahuca', '2017-10-17 15:56:13', '20'),
('175', 'Tianguismanalco', '0001', 'Tianguismanalco', '2017-10-17 15:56:37', '21'),
('175', 'Tihuatlán', '0001', 'Tihuatlán', '2017-10-17 15:56:58', '30'),
('176', 'San Juan Bautista Coixtlahuaca', '0001', 'San Juan Bautista Coixtlahuaca', '2017-10-17 15:56:13', '20'),
('176', 'Tilapa', '0001', 'Tilapa', '2017-10-17 15:56:37', '21'),
('176', 'Tlacojalpan', '0001', 'Tlacojalpan', '2017-10-17 15:56:58', '30'),
('177', 'San Juan Bautista Cuicatlán', '0001', 'San Juan Bautista Cuicatlán', '2017-10-17 15:56:13', '20'),
('177', 'Tlacotepec de Benito Juárez', '0001', 'Tlacotepec de Benito Juárez', '2017-10-17 15:56:38', '21'),
('177', 'Tlacolulan', '0001', 'Tlacolulan', '2017-10-17 15:56:58', '30'),
('178', 'San Juan Bautista Guelache', '0001', 'San Juan Bautista Guelache', '2017-10-17 15:56:13', '20'),
('178', 'Tlacuilotepec', '0001', 'Tlacuilotepec', '2017-10-17 15:56:38', '21'),
('178', 'Tlacotalpan', '0001', 'Tlacotalpan', '2017-10-17 15:56:58', '30'),
('179', 'San Juan Bautista Jayacatlán', '0001', 'San Juan Bautista Jayacatlán', '2017-10-17 15:56:13', '20'),
('179', 'Tlachichuca', '0001', 'Tlachichuca', '2017-10-17 15:56:38', '21'),
('179', 'Tlacotepec de Mejía', '0001', 'Tlacotepec de Mejía', '2017-10-17 15:56:58', '30'),
('180', 'San Juan Bautista Lo de Soto', '0001', 'San Juan Bautista Lo de Soto', '2017-10-17 15:56:13', '20'),
('180', 'Tlahuapan', '0001', 'Santa Rita Tlahuapan', '2017-10-17 15:56:38', '21'),
('180', 'Tlachichilco', '0001', 'Tlachichilco', '2017-10-17 15:56:58', '30'),
('181', 'San Juan Bautista Suchitepec', '0001', 'San Juan Bautista Suchitepec', '2017-10-17 15:56:13', '20'),
('181', 'Tlaltenango', '0001', 'Tlaltenango', '2017-10-17 15:56:38', '21'),
('181', 'Tlalixcoyan', '0001', 'Tlalixcoyan', '2017-10-17 15:56:59', '30'),
('182', 'San Juan Bautista Tlacoatzintepec', '0001', 'San Juan Bautista Tlacoatzintepec', '2017-10-17 15:56:13', '20'),
('182', 'Tlanepantla', '0001', 'Tlanepantla', '2017-10-17 15:56:38', '21'),
('182', 'Tlalnelhuayocan', '0001', 'Tlalnelhuayocan', '2017-10-17 15:56:59', '30'),
('183', 'San Juan Bautista Tlachichilco', '0001', 'San Juan Bautista Tlachichilco', '2017-10-17 15:56:13', '20'),
('183', 'Tlaola', '0001', 'Tlaola', '2017-10-17 15:56:38', '21'),
('183', 'Tlapacoyan', '0001', 'Tlapacoyan', '2017-10-17 15:56:59', '30'),
('184', 'San Juan Bautista Tuxtepec', '0001', 'San Juan Bautista Tuxtepec', '2017-10-17 15:56:13', '20'),
('184', 'Tlapacoya', '0001', 'Tlapacoya', '2017-10-17 15:56:38', '21'),
('184', 'Tlaquilpa', '0001', 'Tlaquilpa', '2017-10-17 15:56:59', '30'),
('185', 'San Juan Cacahuatepec', '0001', 'San Juan Cacahuatepec', '2017-10-17 15:56:13', '20'),
('185', 'Tlapanalá', '0001', 'Tlapanalá', '2017-10-17 15:56:38', '21'),
('185', 'Tlilapan', '0001', 'Tlilapan', '2017-10-17 15:56:59', '30'),
('186', 'San Juan Cieneguilla', '0001', 'San Juan Cieneguilla', '2017-10-17 15:56:13', '20'),
('186', 'Tlatlauquitepec', '0001', 'Ciudad de Tlatlauquitepec', '2017-10-17 15:56:38', '21'),
('186', 'Tomatlán', '0001', 'Tomatlán', '2017-10-17 15:56:59', '30'),
('187', 'San Juan Coatzóspam', '0001', 'San Juan Coatzóspam', '2017-10-17 15:56:13', '20'),
('187', 'Tlaxco', '0001', 'Tlaxco', '2017-10-17 15:56:38', '21'),
('187', 'Tonayán', '0001', 'Tonayán', '2017-10-17 15:56:59', '30'),
('188', 'San Juan Colorado', '0001', 'San Juan Colorado', '2017-10-17 15:56:13', '20'),
('188', 'Tochimilco', '0001', 'Tochimilco', '2017-10-17 15:56:38', '21'),
('188', 'Totutla', '0001', 'Totutla', '2017-10-17 15:56:59', '30'),
('189', 'San Juan Comaltepec', '0001', 'San Juan Comaltepec', '2017-10-17 15:56:13', '20'),
('189', 'Tochtepec', '0001', 'Tochtepec', '2017-10-17 15:56:38', '21'),
('189', 'Tuxpan', '0001', 'Túxpam de Rodríguez Cano', '2017-10-17 15:56:59', '30'),
('190', 'San Juan Cotzocón', '0001', 'San Juan Cotzocón', '2017-10-17 15:56:13', '20'),
('190', 'Totoltepec de Guerrero', '0001', 'Totoltepec de Guerrero', '2017-10-17 15:56:38', '21'),
('190', 'Tuxtilla', '0001', 'Tuxtilla', '2017-10-17 15:56:59', '30'),
('191', 'San Juan Chicomezúchil', '0001', 'San Juan Chicomezúchil', '2017-10-17 15:56:14', '20'),
('191', 'Tulcingo', '0001', 'Tulcingo de Valle', '2017-10-17 15:56:38', '21'),
('191', 'Ursulo Galván', '0001', 'Ursulo Galván', '2017-10-17 15:56:59', '30'),
('192', 'San Juan Chilateca', '0001', 'San Juan Chilateca', '2017-10-17 15:56:14', '20'),
('192', 'Tuzamapan de Galeana', '0001', 'Tuzamapan de Galeana', '2017-10-17 15:56:38', '21'),
('192', 'Vega de Alatorre', '0001', 'Vega de Alatorre', '2017-10-17 15:56:59', '30'),
('193', 'San Juan del Estado', '0001', 'San Juan del Estado', '2017-10-17 15:56:14', '20'),
('193', 'Tzicatlacoyan', '0001', 'Tzicatlacoyan', '2017-10-17 15:56:38', '21'),
('193', 'Veracruz', '0001', 'Veracruz', '2017-10-17 15:56:59', '30'),
('194', 'San Juan del Río', '0001', 'San Juan del Río', '2017-10-17 15:56:14', '20'),
('194', 'Venustiano Carranza', '0001', 'Venustiano Carranza', '2017-10-17 15:56:38', '21'),
('194', 'Villa Aldama', '0001', 'Villa Aldama', '2017-10-17 15:56:59', '30'),
('195', 'San Juan Diuxi', '0001', 'San Juan Diuxi', '2017-10-17 15:56:14', '20'),
('195', 'Vicente Guerrero', '0001', 'Santa María del Monte', '2017-10-17 15:56:38', '21'),
('195', 'Xoxocotla', '0001', 'Xoxocotla', '2017-10-17 15:56:59', '30'),
('196', 'San Juan Evangelista Analco', '0001', 'San Juan Evangelista Analco', '2017-10-17 15:56:14', '20'),
('196', 'Xayacatlán de Bravo', '0001', 'Xayacatlán de Bravo', '2017-10-17 15:56:38', '21'),
('196', 'Yanga', '0001', 'Yanga', '2017-10-17 15:56:59', '30'),
('197', 'San Juan Guelavía', '0001', 'San Juan Guelavía', '2017-10-17 15:56:14', '20'),
('197', 'Xicotepec', '0001', 'Xicotepec de Juárez', '2017-10-17 15:56:38', '21'),
('197', 'Yecuatla', '0001', 'Yecuatla', '2017-10-17 15:56:59', '30'),
('198', 'San Juan Guichicovi', '0001', 'San Juan Guichicovi', '2017-10-17 15:56:14', '20'),
('198', 'Xicotlán', '0001', 'Xicotlán', '2017-10-17 15:56:38', '21'),
('198', 'Zacualpan', '0001', 'Zacualpan', '2017-10-17 15:56:59', '30'),
('199', 'San Juan Ihualtepec', '0001', 'San Juan Ihualtepec', '2017-10-17 15:56:14', '20'),
('199', 'Xiutetelco', '0001', 'San Juan Xiutetelco', '2017-10-17 15:56:38', '21'),
('199', 'Zaragoza', '0001', 'Zaragoza', '2017-10-17 15:56:59', '30'),
('200', 'San Juan Juquila Mixes', '0001', 'San Juan Juquila Mixes', '2017-10-17 15:56:14', '20'),
('200', 'Xochiapulco', '0001', 'Cinco de Mayo', '2017-10-17 15:56:38', '21'),
('200', 'Zentla', '0001', 'Colonia Manuel González', '2017-10-17 15:56:59', '30'),
('201', 'San Juan Juquila Vijanos', '0001', 'San Juan Juquila Vijanos', '2017-10-17 15:56:14', '20'),
('201', 'Xochiltepec', '0001', 'Xochiltepec', '2017-10-17 15:56:39', '21'),
('201', 'Zongolica', '0001', 'Zongolica', '2017-10-17 15:56:59', '30'),
('202', 'San Juan Lachao', '0001', 'San Juan Lachao', '2017-10-17 15:56:14', '20'),
('202', 'Xochitlán de Vicente Suárez', '0001', 'Xochitlán de Vicente Suárez', '2017-10-17 15:56:39', '21'),
('202', 'Zontecomatlán de López y Fuentes', '0001', 'Zontecomatlán de López y Fuentes', '2017-10-17 15:56:59', '30'),
('203', 'San Juan Lachigalla', '0001', 'San Juan Lachigalla', '2017-10-17 15:56:14', '20'),
('203', 'Xochitlán Todos Santos', '0001', 'Xochitlán', '2017-10-17 15:56:39', '21'),
('203', 'Zozocolco de Hidalgo', '0001', 'Zozocolco de Hidalgo', '2017-10-17 15:56:59', '30'),
('204', 'San Juan Lajarcia', '0001', 'San Juan Lajarcia', '2017-10-17 15:56:14', '20'),
('204', 'Yaonáhuac', '0001', 'Yaonáhuac', '2017-10-17 15:56:39', '21'),
('204', 'Agua Dulce', '0001', 'Agua Dulce', '2017-10-17 15:56:59', '30'),
('205', 'San Juan Lalana', '0001', 'San Juan Lalana', '2017-10-17 15:56:14', '20'),
('205', 'Yehualtepec', '0001', 'Yehualtepec', '2017-10-17 15:56:39', '21'),
('205', 'El Higo', '0001', 'El Higo', '2017-10-17 15:56:59', '30'),
('206', 'San Juan de los Cués', '0001', 'San Juan de los Cués', '2017-10-17 15:56:14', '20'),
('206', 'Zacapala', '0001', 'Zacapala', '2017-10-17 15:56:39', '21'),
('206', 'Nanchital de Lázaro Cárdenas del Río', '0001', 'Nanchital de Lázaro Cárdenas del Río', '2017-10-17 15:56:59', '30'),
('207', 'San Juan Mazatlán', '0001', 'San Juan Mazatlán', '2017-10-17 15:56:14', '20'),
('207', 'Zacapoaxtla', '0001', 'Zacapoaxtla', '2017-10-17 15:56:39', '21'),
('207', 'Tres Valles', '0001', 'Tres Valles', '2017-10-17 15:57:00', '30'),
('208', 'San Juan Mixtepec', '0001', 'San Juan Mixtepec Distrito 08', '2017-10-17 15:56:14', '20'),
('208', 'Zacatlán', '0001', 'Zacatlán', '2017-10-17 15:56:39', '21'),
('208', 'Carlos A. Carrillo', '0001', 'Carlos A. Carrillo', '2017-10-17 15:57:00', '30'),
('209', 'San Juan Mixtepec', '0001', 'San Juan Mixtepec Distrito 26', '2017-10-17 15:56:14', '20'),
('209', 'Zapotitlán', '0001', 'Zapotitlán Salinas', '2017-10-17 15:56:39', '21'),
('209', 'Tatahuicapan de Juárez', '0001', 'Tatahuicapan', '2017-10-17 15:57:00', '30'),
('210', 'San Juan Ñumí', '0001', 'San Juan Ñumí', '2017-10-17 15:56:14', '20'),
('210', 'Zapotitlán de Méndez', '0001', 'Zapotitlán de Méndez', '2017-10-17 15:56:39', '21'),
('210', 'Uxpanapa', '0001', 'Poblado 10', '2017-10-17 15:57:00', '30'),
('211', 'San Juan Ozolotepec', '0001', 'San Juan Ozolotepec', '2017-10-17 15:56:15', '20'),
('211', 'Zaragoza', '0001', 'Zaragoza', '2017-10-17 15:56:39', '21'),
('211', 'San Rafael', '0001', 'San Rafael', '2017-10-17 15:57:00', '30'),
('212', 'San Juan Petlapa', '0001', 'San Juan Petlapa', '2017-10-17 15:56:15', '20'),
('212', 'Zautla', '0001', 'Santiago Zautla', '2017-10-17 15:56:39', '21'),
('212', 'Santiago Sochiapan', '0001', 'Xochiapa', '2017-10-17 15:57:00', '30'),
('213', 'San Juan Quiahije', '0001', 'San Juan Quiahije', '2017-10-17 15:56:15', '20'),
('213', 'Zihuateutla', '0001', 'Zihuateutla', '2017-10-17 15:56:39', '21'),
('214', 'San Juan Quiotepec', '0001', 'San Juan Quiotepec', '2017-10-17 15:56:15', '20'),
('214', 'Zinacatepec', '0001', 'San Sebastián Zinacatepec', '2017-10-17 15:56:39', '21'),
('215', 'San Juan Sayultepec', '0001', 'San Juan Sayultepec', '2017-10-17 15:56:15', '20'),
('215', 'Zongozotla', '0001', 'Zongozotla', '2017-10-17 15:56:39', '21'),
('216', 'San Juan Tabaá', '0001', 'San Juan Tabaá', '2017-10-17 15:56:15', '20'),
('216', 'Zoquiapan', '0001', 'Zoquiapan', '2017-10-17 15:56:39', '21'),
('217', 'San Juan Tamazola', '0001', 'San Juan Tamazola', '2017-10-17 15:56:15', '20'),
('217', 'Zoquitlán', '0001', 'Zoquitlán', '2017-10-17 15:56:39', '21'),
('218', 'San Juan Teita', '0001', 'San Juan Teita', '2017-10-17 15:56:15', '20'),
('219', 'San Juan Teitipac', '0001', 'San Juan Teitipac', '2017-10-17 15:56:15', '20'),
('220', 'San Juan Tepeuxila', '0001', 'San Juan Tepeuxila', '2017-10-17 15:56:15', '20'),
('221', 'San Juan Teposcolula', '0001', 'San Juan Teposcolula', '2017-10-17 15:56:15', '20'),
('222', 'San Juan Yaeé', '0001', 'San Juan Yaeé', '2017-10-17 15:56:15', '20'),
('223', 'San Juan Yatzona', '0001', 'San Juan Yatzona', '2017-10-17 15:56:15', '20'),
('224', 'San Juan Yucuita', '0001', 'San Juan Yucuita', '2017-10-17 15:56:15', '20'),
('225', 'San Lorenzo', '0001', 'San Lorenzo', '2017-10-17 15:56:15', '20'),
('226', 'San Lorenzo Albarradas', '0001', 'San Lorenzo Albarradas', '2017-10-17 15:56:15', '20'),
('227', 'San Lorenzo Cacaotepec', '0001', 'San Lorenzo Cacaotepec', '2017-10-17 15:56:15', '20'),
('228', 'San Lorenzo Cuaunecuiltitla', '0001', 'San Lorenzo Cuaunecuiltitla', '2017-10-17 15:56:15', '20'),
('229', 'San Lorenzo Texmelúcan', '0001', 'San Lorenzo Texmelúcan', '2017-10-17 15:56:15', '20'),
('230', 'San Lorenzo Victoria', '0001', 'San Lorenzo Victoria', '2017-10-17 15:56:15', '20'),
('231', 'San Lucas Camotlán', '0001', 'San Lucas Camotlán', '2017-10-17 15:56:15', '20'),
('232', 'San Lucas Ojitlán', '0001', 'San Lucas Ojitlán', '2017-10-17 15:56:15', '20'),
('233', 'San Lucas Quiaviní', '0001', 'San Lucas Quiaviní', '2017-10-17 15:56:15', '20'),
('234', 'San Lucas Zoquiápam', '0001', 'San Lucas Zoquiápam', '2017-10-17 15:56:15', '20'),
('235', 'San Luis Amatlán', '0001', 'San Luis Amatlán', '2017-10-17 15:56:15', '20'),
('236', 'San Marcial Ozolotepec', '0001', 'San Marcial Ozolotepec', '2017-10-17 15:56:16', '20'),
('237', 'San Marcos Arteaga', '0001', 'San Marcos Arteaga', '2017-10-17 15:56:16', '20'),
('238', 'San Martín de los Cansecos', '0001', 'San Martín de los Cansecos', '2017-10-17 15:56:16', '20'),
('239', 'San Martín Huamelúlpam', '0001', 'San Martín Huamelúlpam', '2017-10-17 15:56:16', '20'),
('240', 'San Martín Itunyoso', '0001', 'San Martín Itunyoso', '2017-10-17 15:56:16', '20'),
('241', 'San Martín Lachilá', '0001', 'San Martín Lachilá', '2017-10-17 15:56:16', '20'),
('242', 'San Martín Peras', '0001', 'San Martín Peras', '2017-10-17 15:56:16', '20'),
('243', 'San Martín Tilcajete', '0001', 'San Martín Tilcajete', '2017-10-17 15:56:16', '20'),
('244', 'San Martín Toxpalan', '0001', 'San Martín Toxpalan', '2017-10-17 15:56:16', '20'),
('245', 'San Martín Zacatepec', '0001', 'San Martín Zacatepec', '2017-10-17 15:56:16', '20'),
('246', 'San Mateo Cajonos', '0001', 'San Mateo Cajonos', '2017-10-17 15:56:16', '20'),
('247', 'Capulálpam de Méndez', '0001', 'Capulálpam de Méndez', '2017-10-17 15:56:16', '20'),
('248', 'San Mateo del Mar', '0001', 'San Mateo del Mar', '2017-10-17 15:56:16', '20'),
('249', 'San Mateo Yoloxochitlán', '0001', 'San Mateo Yoloxochitlán', '2017-10-17 15:56:16', '20'),
('250', 'San Mateo Etlatongo', '0001', 'San Mateo Etlatongo', '2017-10-17 15:56:16', '20'),
('251', 'San Mateo Nejápam', '0001', 'San Mateo Nejápam', '2017-10-17 15:56:16', '20'),
('252', 'San Mateo Peñasco', '0001', 'San Mateo Peñasco', '2017-10-17 15:56:16', '20'),
('253', 'San Mateo Piñas', '0001', 'San Mateo Piñas', '2017-10-17 15:56:16', '20'),
('254', 'San Mateo Río Hondo', '0001', 'San Mateo Río Hondo', '2017-10-17 15:56:16', '20'),
('255', 'San Mateo Sindihui', '0001', 'San Mateo Sindihui', '2017-10-17 15:56:16', '20'),
('256', 'San Mateo Tlapiltepec', '0001', 'San Mateo Tlapiltepec', '2017-10-17 15:56:17', '20'),
('257', 'San Melchor Betaza', '0001', 'San Melchor Betaza', '2017-10-17 15:56:17', '20'),
('258', 'San Miguel Achiutla', '0001', 'San Miguel Achiutla', '2017-10-17 15:56:17', '20'),
('259', 'San Miguel Ahuehuetitlán', '0001', 'San Miguel Ahuehuetitlán', '2017-10-17 15:56:17', '20'),
('260', 'San Miguel Aloápam', '0001', 'San Miguel Aloápam', '2017-10-17 15:56:17', '20'),
('261', 'San Miguel Amatitlán', '0001', 'San Miguel Amatitlán', '2017-10-17 15:56:17', '20'),
('262', 'San Miguel Amatlán', '0001', 'San Miguel Amatlán', '2017-10-17 15:56:17', '20'),
('263', 'San Miguel Coatlán', '0001', 'San Miguel Coatlán', '2017-10-17 15:56:17', '20'),
('264', 'San Miguel Chicahua', '0001', 'San Miguel Chicahua', '2017-10-17 15:56:17', '20'),
('265', 'San Miguel Chimalapa', '0001', 'San Miguel Chimalapa', '2017-10-17 15:56:17', '20'),
('266', 'San Miguel del Puerto', '0001', 'San Miguel del Puerto', '2017-10-17 15:56:17', '20'),
('267', 'San Miguel del Río', '0001', 'San Miguel del Río', '2017-10-17 15:56:17', '20'),
('268', 'San Miguel Ejutla', '0001', 'San Miguel Ejutla', '2017-10-17 15:56:17', '20'),
('269', 'San Miguel el Grande', '0001', 'San Miguel el Grande', '2017-10-17 15:56:17', '20'),
('270', 'San Miguel Huautla', '0001', 'San Miguel Huautla', '2017-10-17 15:56:17', '20'),
('271', 'San Miguel Mixtepec', '0001', 'San Miguel Mixtepec', '2017-10-17 15:56:17', '20'),
('272', 'San Miguel Panixtlahuaca', '0001', 'San Miguel Panixtlahuaca', '2017-10-17 15:56:17', '20'),
('273', 'San Miguel Peras', '0001', 'San Miguel Peras', '2017-10-17 15:56:17', '20'),
('274', 'San Miguel Piedras', '0001', 'San Miguel Piedras', '2017-10-17 15:56:17', '20'),
('275', 'San Miguel Quetzaltepec', '0001', 'San Miguel Quetzaltepec', '2017-10-17 15:56:17', '20'),
('276', 'San Miguel Santa Flor', '0001', 'San Miguel Santa Flor', '2017-10-17 15:56:17', '20'),
('277', 'Villa Sola de Vega', '0001', 'Villa Sola de Vega', '2017-10-17 15:56:17', '20'),
('278', 'San Miguel Soyaltepec', '0001', 'Temascal', '2017-10-17 15:56:18', '20'),
('279', 'San Miguel Suchixtepec', '0001', 'San Miguel Suchixtepec', '2017-10-17 15:56:18', '20'),
('280', 'Villa Talea de Castro', '0001', 'Villa Talea de Castro', '2017-10-17 15:56:18', '20'),
('281', 'San Miguel Tecomatlán', '0001', 'San Miguel Tecomatlán', '2017-10-17 15:56:18', '20'),
('282', 'San Miguel Tenango', '0001', 'San Miguel Tenango', '2017-10-17 15:56:18', '20'),
('283', 'San Miguel Tequixtepec', '0001', 'San Miguel Tequixtepec', '2017-10-17 15:56:18', '20'),
('284', 'San Miguel Tilquiápam', '0001', 'San Miguel Tilquiápam', '2017-10-17 15:56:18', '20'),
('285', 'San Miguel Tlacamama', '0001', 'San Miguel Tlacamama', '2017-10-17 15:56:18', '20'),
('286', 'San Miguel Tlacotepec', '0001', 'San Miguel Tlacotepec', '2017-10-17 15:56:18', '20'),
('287', 'San Miguel Tulancingo', '0001', 'San Miguel Tulancingo', '2017-10-17 15:56:18', '20'),
('288', 'San Miguel Yotao', '0001', 'San Miguel Yotao', '2017-10-17 15:56:18', '20'),
('289', 'San Nicolás', '0001', 'San Nicolás', '2017-10-17 15:56:18', '20'),
('290', 'San Nicolás Hidalgo', '0001', 'San Nicolás Hidalgo', '2017-10-17 15:56:18', '20'),
('291', 'San Pablo Coatlán', '0001', 'San Pablo Coatlán', '2017-10-17 15:56:18', '20'),
('292', 'San Pablo Cuatro Venados', '0001', 'San Pablo Cuatro Venados', '2017-10-17 15:56:18', '20'),
('293', 'San Pablo Etla', '0001', 'San Pablo Etla', '2017-10-17 15:56:18', '20'),
('294', 'San Pablo Huitzo', '0001', 'San Pablo Huitzo', '2017-10-17 15:56:18', '20'),
('295', 'San Pablo Huixtepec', '0001', 'San Pablo Huixtepec', '2017-10-17 15:56:18', '20'),
('296', 'San Pablo Macuiltianguis', '0001', 'San Pablo Macuiltianguis', '2017-10-17 15:56:18', '20'),
('297', 'San Pablo Tijaltepec', '0001', 'San Pablo Tijaltepec', '2017-10-17 15:56:18', '20'),
('298', 'San Pablo Villa de Mitla', '0001', 'San Pablo Villa de Mitla', '2017-10-17 15:56:18', '20'),
('299', 'San Pablo Yaganiza', '0001', 'San Pablo Yaganiza', '2017-10-17 15:56:18', '20'),
('300', 'San Pedro Amuzgos', '0001', 'San Pedro Amuzgos', '2017-10-17 15:56:18', '20'),
('301', 'San Pedro Apóstol', '0001', 'San Pedro Apóstol', '2017-10-17 15:56:18', '20'),
('302', 'San Pedro Atoyac', '0001', 'San Pedro Atoyac', '2017-10-17 15:56:19', '20'),
('303', 'San Pedro Cajonos', '0001', 'San Pedro Cajonos', '2017-10-17 15:56:19', '20'),
('304', 'San Pedro Coxcaltepec Cántaros', '0001', 'San Pedro Coxcaltepec Cántaros', '2017-10-17 15:56:19', '20'),
('305', 'San Pedro Comitancillo', '0001', 'San Pedro Comitancillo', '2017-10-17 15:56:19', '20'),
('306', 'San Pedro el Alto', '0001', 'San Pedro el Alto', '2017-10-17 15:56:19', '20'),
('307', 'San Pedro Huamelula', '0001', 'San Pedro Huamelula', '2017-10-17 15:56:19', '20'),
('308', 'San Pedro Huilotepec', '0001', 'San Pedro Huilotepec', '2017-10-17 15:56:19', '20'),
('309', 'San Pedro Ixcatlán', '0001', 'San Pedro Ixcatlán', '2017-10-17 15:56:19', '20'),
('310', 'San Pedro Ixtlahuaca', '0001', 'San Pedro Ixtlahuaca', '2017-10-17 15:56:19', '20'),
('311', 'San Pedro Jaltepetongo', '0001', 'San Pedro Jaltepetongo', '2017-10-17 15:56:19', '20'),
('312', 'San Pedro Jicayán', '0001', 'San Pedro Jicayán', '2017-10-17 15:56:19', '20'),
('313', 'San Pedro Jocotipac', '0001', 'San Pedro Jocotipac', '2017-10-17 15:56:19', '20'),
('314', 'San Pedro Juchatengo', '0001', 'San Pedro Juchatengo', '2017-10-17 15:56:19', '20'),
('315', 'San Pedro Mártir', '0001', 'San Pedro Mártir', '2017-10-17 15:56:19', '20'),
('316', 'San Pedro Mártir Quiechapa', '0001', 'San Pedro Mártir Quiechapa', '2017-10-17 15:56:19', '20'),
('317', 'San Pedro Mártir Yucuxaco', '0001', 'San Pedro Mártir Yucuxaco', '2017-10-17 15:56:19', '20'),
('318', 'San Pedro Mixtepec', '0001', 'San Pedro Mixtepec Distrito 22', '2017-10-17 15:56:19', '20'),
('319', 'San Pedro Mixtepec', '0001', 'San Pedro Mixtepec Distrito 26', '2017-10-17 15:56:19', '20'),
('320', 'San Pedro Molinos', '0001', 'San Pedro Molinos', '2017-10-17 15:56:20', '20'),
('321', 'San Pedro Nopala', '0001', 'San Pedro Nopala', '2017-10-17 15:56:20', '20'),
('322', 'San Pedro Ocopetatillo', '0001', 'San Pedro Ocopetatillo', '2017-10-17 15:56:20', '20'),
('323', 'San Pedro Ocotepec', '0001', 'San Pedro Ocotepec', '2017-10-17 15:56:20', '20'),
('324', 'San Pedro Pochutla', '0001', 'San Pedro Pochutla', '2017-10-17 15:56:20', '20'),
('325', 'San Pedro Quiatoni', '0001', 'San Pedro Quiatoni', '2017-10-17 15:56:20', '20'),
('326', 'San Pedro Sochiápam', '0001', 'San Pedro Sochiápam', '2017-10-17 15:56:20', '20'),
('327', 'San Pedro Tapanatepec', '0001', 'San Pedro Tapanatepec', '2017-10-17 15:56:20', '20'),
('328', 'San Pedro Taviche', '0001', 'San Pedro Taviche', '2017-10-17 15:56:20', '20'),
('329', 'San Pedro Teozacoalco', '0001', 'San Pedro Teozacoalco', '2017-10-17 15:56:20', '20'),
('330', 'San Pedro Teutila', '0001', 'San Pedro Teutila', '2017-10-17 15:56:20', '20'),
('331', 'San Pedro Tidaá', '0001', 'San Pedro Tidaá', '2017-10-17 15:56:20', '20'),
('332', 'San Pedro Topiltepec', '0001', 'San Pedro Topiltepec', '2017-10-17 15:56:20', '20'),
('333', 'San Pedro Totolápam', '0001', 'San Pedro Totolápam', '2017-10-17 15:56:20', '20'),
('334', 'Villa de Tututepec de Melchor Ocampo', '0001', 'Villa de Tututepec de Melchor Ocampo', '2017-10-17 15:56:20', '20'),
('335', 'San Pedro Yaneri', '0001', 'San Pedro Yaneri', '2017-10-17 15:56:20', '20'),
('336', 'San Pedro Yólox', '0001', 'San Pedro Yólox', '2017-10-17 15:56:20', '20'),
('337', 'San Pedro y San Pablo Ayutla', '0001', 'San Pedro y San Pablo Ayutla', '2017-10-17 15:56:20', '20'),
('338', 'Villa de Etla', '0001', 'Villa de Etla', '2017-10-17 15:56:20', '20'),
('339', 'San Pedro y San Pablo Teposcolula', '0001', 'San Pedro y San Pablo Teposcolula', '2017-10-17 15:56:20', '20'),
('340', 'San Pedro y San Pablo Tequixtepec', '0001', 'San Pedro y San Pablo Tequixtepec', '2017-10-17 15:56:20', '20'),
('341', 'San Pedro Yucunama', '0001', 'San Pedro Yucunama', '2017-10-17 15:56:20', '20'),
('342', 'San Raymundo Jalpan', '0001', 'San Raymundo Jalpan', '2017-10-17 15:56:21', '20'),
('343', 'San Sebastián Abasolo', '0001', 'San Sebastián Abasolo', '2017-10-17 15:56:21', '20'),
('344', 'San Sebastián Coatlán', '0001', 'San Sebastián Coatlán', '2017-10-17 15:56:21', '20'),
('345', 'San Sebastián Ixcapa', '0001', 'San Sebastián Ixcapa', '2017-10-17 15:56:21', '20'),
('346', 'San Sebastián Nicananduta', '0001', 'San Sebastián Nicananduta', '2017-10-17 15:56:21', '20'),
('347', 'San Sebastián Río Hondo', '0001', 'San Sebastián Río Hondo', '2017-10-17 15:56:21', '20'),
('348', 'San Sebastián Tecomaxtlahuaca', '0001', 'San Sebastián Tecomaxtlahuaca', '2017-10-17 15:56:21', '20'),
('349', 'San Sebastián Teitipac', '0001', 'San Sebastián Teitipac', '2017-10-17 15:56:21', '20'),
('350', 'San Sebastián Tutla', '0001', 'San Sebastián Tutla', '2017-10-17 15:56:21', '20'),
('351', 'San Simón Almolongas', '0001', 'San Simón Almolongas', '2017-10-17 15:56:21', '20'),
('352', 'San Simón Zahuatlán', '0001', 'San Simón Zahuatlán', '2017-10-17 15:56:21', '20'),
('353', 'Santa Ana', '0001', 'Santa Ana', '2017-10-17 15:56:21', '20'),
('354', 'Santa Ana Ateixtlahuaca', '0001', 'Santa Ana Ateixtlahuaca', '2017-10-17 15:56:21', '20'),
('355', 'Santa Ana Cuauhtémoc', '0001', 'Santa Ana Cuauhtémoc', '2017-10-17 15:56:21', '20'),
('356', 'Santa Ana del Valle', '0001', 'Santa Ana del Valle', '2017-10-17 15:56:21', '20'),
('357', 'Santa Ana Tavela', '0001', 'Santa Ana Tavela', '2017-10-17 15:56:21', '20'),
('358', 'Santa Ana Tlapacoyan', '0001', 'Santa Ana Tlapacoyan', '2017-10-17 15:56:21', '20'),
('359', 'Santa Ana Yareni', '0001', 'Santa Ana Yareni', '2017-10-17 15:56:21', '20'),
('360', 'Santa Ana Zegache', '0001', 'Santa Ana Zegache', '2017-10-17 15:56:21', '20'),
('361', 'Santa Catalina Quierí', '0001', 'Santa Catalina Quierí', '2017-10-17 15:56:21', '20'),
('362', 'Santa Catarina Cuixtla', '0001', 'Santa Catarina Cuixtla', '2017-10-17 15:56:21', '20'),
('363', 'Santa Catarina Ixtepeji', '0001', 'Santa Catarina Ixtepeji', '2017-10-17 15:56:21', '20'),
('364', 'Santa Catarina Juquila', '0001', 'Santa Catarina Juquila', '2017-10-17 15:56:22', '20'),
('365', 'Santa Catarina Lachatao', '0001', 'Santa Catarina Lachatao', '2017-10-17 15:56:22', '20'),
('366', 'Santa Catarina Loxicha', '0001', 'Santa Catarina Loxicha', '2017-10-17 15:56:22', '20'),
('367', 'Santa Catarina Mechoacán', '0001', 'Santa Catarina Mechoacán', '2017-10-17 15:56:22', '20'),
('368', 'Santa Catarina Minas', '0001', 'Santa Catarina Minas', '2017-10-17 15:56:22', '20'),
('369', 'Santa Catarina Quiané', '0001', 'Santa Catarina Quiané', '2017-10-17 15:56:22', '20'),
('370', 'Santa Catarina Tayata', '0001', 'Santa Catarina Tayata', '2017-10-17 15:56:22', '20'),
('371', 'Santa Catarina Ticuá', '0001', 'Santa Catarina Ticuá', '2017-10-17 15:56:22', '20'),
('372', 'Santa Catarina Yosonotú', '0001', 'Santa Catarina Yosonotú', '2017-10-17 15:56:22', '20'),
('373', 'Santa Catarina Zapoquila', '0001', 'Santa Catarina Zapoquila', '2017-10-17 15:56:22', '20'),
('374', 'Santa Cruz Acatepec', '0001', 'Santa Cruz Acatepec', '2017-10-17 15:56:22', '20'),
('375', 'Santa Cruz Amilpas', '0001', 'Santa Cruz Amilpas', '2017-10-17 15:56:22', '20'),
('376', 'Santa Cruz de Bravo', '0001', 'Santa Cruz de Bravo', '2017-10-17 15:56:22', '20'),
('377', 'Santa Cruz Itundujia', '0001', 'Santa Cruz Itundujia', '2017-10-17 15:56:22', '20'),
('378', 'Santa Cruz Mixtepec', '0001', 'Santa Cruz Mixtepec', '2017-10-17 15:56:22', '20'),
('379', 'Santa Cruz Nundaco', '0001', 'Santa Cruz Nundaco', '2017-10-17 15:56:22', '20'),
('380', 'Santa Cruz Papalutla', '0001', 'Santa Cruz Papalutla', '2017-10-17 15:56:22', '20'),
('381', 'Santa Cruz Tacache de Mina', '0001', 'Santa Cruz Tacache de Mina', '2017-10-17 15:56:22', '20'),
('382', 'Santa Cruz Tacahua', '0001', 'Santa Cruz Tacahua', '2017-10-17 15:56:22', '20'),
('383', 'Santa Cruz Tayata', '0001', 'Santa Cruz Tayata', '2017-10-17 15:56:22', '20'),
('384', 'Santa Cruz Xitla', '0001', 'Santa Cruz Xitla', '2017-10-17 15:56:22', '20'),
('385', 'Santa Cruz Xoxocotlán', '0001', 'Santa Cruz Xoxocotlán', '2017-10-17 15:56:22', '20'),
('386', 'Santa Cruz Zenzontepec', '0001', 'Santa Cruz Zenzontepec', '2017-10-17 15:56:22', '20'),
('387', 'Santa Gertrudis', '0001', 'Santa Gertrudis', '2017-10-17 15:56:23', '20'),
('388', 'Santa Inés del Monte', '0001', 'Santa Inés del Monte', '2017-10-17 15:56:23', '20'),
('389', 'Santa Inés Yatzeche', '0001', 'Santa Inés Yatzeche', '2017-10-17 15:56:23', '20'),
('390', 'Santa Lucía del Camino', '0001', 'Santa Lucía del Camino', '2017-10-17 15:56:23', '20'),
('391', 'Santa Lucía Miahuatlán', '0001', 'Santa Lucía Miahuatlán', '2017-10-17 15:56:23', '20'),
('392', 'Santa Lucía Monteverde', '0001', 'Santa Lucía Monteverde', '2017-10-17 15:56:23', '20'),
('393', 'Santa Lucía Ocotlán', '0001', 'Santa Lucía Ocotlán', '2017-10-17 15:56:23', '20'),
('394', 'Santa María Alotepec', '0001', 'Santa María Alotepec', '2017-10-17 15:56:23', '20'),
('395', 'Santa María Apazco', '0001', 'Santa María Apazco', '2017-10-17 15:56:23', '20'),
('396', 'Santa María la Asunción', '0001', 'Santa María la Asunción', '2017-10-17 15:56:23', '20'),
('397', 'Heroica Ciudad de Tlaxiaco', '0001', 'Heroica Ciudad de Tlaxiaco', '2017-10-17 15:56:23', '20'),
('398', 'Ayoquezco de Aldama', '0001', 'Ayoquezco de Aldama', '2017-10-17 15:56:23', '20'),
('399', 'Santa María Atzompa', '0001', 'Santa María Atzompa', '2017-10-17 15:56:23', '20'),
('400', 'Santa María Camotlán', '0001', 'Santa María Camotlán', '2017-10-17 15:56:23', '20'),
('401', 'Santa María Colotepec', '0001', 'Santa María Colotepec', '2017-10-17 15:56:23', '20'),
('402', 'Santa María Cortijo', '0001', 'Santa María Cortijo', '2017-10-17 15:56:23', '20'),
('403', 'Santa María Coyotepec', '0001', 'Santa María Coyotepec', '2017-10-17 15:56:23', '20'),
('404', 'Santa María Chachoápam', '0001', 'Santa María Chachoápam', '2017-10-17 15:56:23', '20'),
('405', 'Villa de Chilapa de Díaz', '0001', 'Villa de Chilapa de Díaz', '2017-10-17 15:56:23', '20'),
('406', 'Santa María Chilchotla', '0001', 'Santa María Chilchotla', '2017-10-17 15:56:23', '20'),
('407', 'Santa María Chimalapa', '0001', 'Santa María Chimalapa', '2017-10-17 15:56:23', '20'),
('408', 'Santa María del Rosario', '0001', 'Santa María del Rosario', '2017-10-17 15:56:23', '20'),
('409', 'Santa María del Tule', '0001', 'Santa María del Tule', '2017-10-17 15:56:23', '20'),
('410', 'Santa María Ecatepec', '0001', 'Santa María Ecatepec', '2017-10-17 15:56:24', '20'),
('411', 'Santa María Guelacé', '0001', 'Santa María Guelacé', '2017-10-17 15:56:24', '20'),
('412', 'Santa María Guienagati', '0001', 'Santa María Guienagati', '2017-10-17 15:56:24', '20'),
('413', 'Santa María Huatulco', '0001', 'Santa María Huatulco', '2017-10-17 15:56:24', '20'),
('414', 'Santa María Huazolotitlán', '0001', 'Santa María Huazolotitlán', '2017-10-17 15:56:24', '20'),
('415', 'Santa María Ipalapa', '0001', 'Santa María Ipalapa', '2017-10-17 15:56:24', '20'),
('416', 'Santa María Ixcatlán', '0001', 'Santa María Ixcatlán', '2017-10-17 15:56:24', '20'),
('417', 'Santa María Jacatepec', '0001', 'Santa María Jacatepec', '2017-10-17 15:56:24', '20'),
('418', 'Santa María Jalapa del Marqués', '0001', 'Santa María Jalapa del Marqués', '2017-10-17 15:56:24', '20'),
('419', 'Santa María Jaltianguis', '0001', 'Santa María Jaltianguis', '2017-10-17 15:56:24', '20'),
('420', 'Santa María Lachixío', '0001', 'Santa María Lachixío', '2017-10-17 15:56:24', '20'),
('421', 'Santa María Mixtequilla', '0001', 'Santa María Mixtequilla', '2017-10-17 15:56:24', '20'),
('422', 'Santa María Nativitas', '0001', 'Santa María Nativitas', '2017-10-17 15:56:24', '20'),
('423', 'Santa María Nduayaco', '0001', 'Santa María Nduayaco', '2017-10-17 15:56:24', '20'),
('424', 'Santa María Ozolotepec', '0001', 'Santa María Ozolotepec', '2017-10-17 15:56:24', '20'),
('425', 'Santa María Pápalo', '0001', 'Santa María Pápalo', '2017-10-17 15:56:24', '20'),
('426', 'Santa María Peñoles', '0001', 'Santa María Peñoles', '2017-10-17 15:56:24', '20'),
('427', 'Santa María Petapa', '0001', 'Santa María Petapa', '2017-10-17 15:56:24', '20'),
('428', 'Santa María Quiegolani', '0001', 'Santa María Quiegolani', '2017-10-17 15:56:24', '20'),
('429', 'Santa María Sola', '0001', 'Santa María Sola', '2017-10-17 15:56:24', '20'),
('430', 'Santa María Tataltepec', '0001', 'Santa María Tataltepec', '2017-10-17 15:56:24', '20'),
('431', 'Santa María Tecomavaca', '0001', 'Santa María Tecomavaca', '2017-10-17 15:56:24', '20'),
('432', 'Santa María Temaxcalapa', '0001', 'Santa María Temaxcalapa', '2017-10-17 15:56:25', '20'),
('433', 'Santa María Temaxcaltepec', '0001', 'Santa María Temaxcaltepec', '2017-10-17 15:56:25', '20'),
('434', 'Santa María Teopoxco', '0001', 'Santa María Teopoxco', '2017-10-17 15:56:25', '20'),
('435', 'Santa María Tepantlali', '0001', 'Santa María Tepantlali', '2017-10-17 15:56:25', '20'),
('436', 'Santa María Texcatitlán', '0001', 'Santa María Texcatitlán', '2017-10-17 15:56:25', '20'),
('437', 'Santa María Tlahuitoltepec', '0001', 'Santa María Tlahuitoltepec', '2017-10-17 15:56:25', '20'),
('438', 'Santa María Tlalixtac', '0001', 'Santa María Tlalixtac', '2017-10-17 15:56:25', '20'),
('439', 'Santa María Tonameca', '0001', 'Santa María Tonameca', '2017-10-17 15:56:25', '20'),
('440', 'Santa María Totolapilla', '0001', 'Santa María Totolapilla', '2017-10-17 15:56:25', '20'),
('441', 'Santa María Xadani', '0001', 'Santa María Xadani', '2017-10-17 15:56:25', '20'),
('442', 'Santa María Yalina', '0001', 'Santa María Yalina', '2017-10-17 15:56:25', '20'),
('443', 'Santa María Yavesía', '0001', 'Santa María Yavesía', '2017-10-17 15:56:25', '20'),
('444', 'Santa María Yolotepec', '0001', 'Santa María Yolotepec', '2017-10-17 15:56:25', '20'),
('445', 'Santa María Yosoyúa', '0001', 'Santa María Yosoyúa', '2017-10-17 15:56:25', '20'),
('446', 'Santa María Yucuhiti', '0001', 'Santa María Yucuhiti', '2017-10-17 15:56:25', '20'),
('447', 'Santa María Zacatepec', '0001', 'Santa María Zacatepec', '2017-10-17 15:56:25', '20'),
('448', 'Santa María Zaniza', '0001', 'Santa María Zaniza', '2017-10-17 15:56:25', '20'),
('449', 'Santa María Zoquitlán', '0001', 'Santa María Zoquitlán', '2017-10-17 15:56:25', '20'),
('450', 'Santiago Amoltepec', '0001', 'Santiago Amoltepec', '2017-10-17 15:56:25', '20'),
('451', 'Santiago Apoala', '0001', 'Santiago Apoala', '2017-10-17 15:56:25', '20'),
('452', 'Santiago Apóstol', '0001', 'Santiago Apóstol', '2017-10-17 15:56:25', '20'),
('453', 'Santiago Astata', '0001', 'Santiago Astata', '2017-10-17 15:56:25', '20'),
('454', 'Santiago Atitlán', '0001', 'Santiago Atitlán', '2017-10-17 15:56:25', '20'),
('455', 'Santiago Ayuquililla', '0001', 'Santiago Ayuquililla', '2017-10-17 15:56:25', '20'),
('456', 'Santiago Cacaloxtepec', '0001', 'Santiago Cacaloxtepec', '2017-10-17 15:56:25', '20'),
('457', 'Santiago Camotlán', '0001', 'Santiago Camotlán', '2017-10-17 15:56:26', '20'),
('458', 'Santiago Comaltepec', '0001', 'Santiago Comaltepec', '2017-10-17 15:56:26', '20'),
('459', 'Santiago Chazumba', '0001', 'Santiago Chazumba', '2017-10-17 15:56:26', '20'),
('460', 'Santiago Choápam', '0001', 'Santiago Choápam', '2017-10-17 15:56:26', '20'),
('461', 'Santiago del Río', '0001', 'Santiago del Río', '2017-10-17 15:56:26', '20'),
('462', 'Santiago Huajolotitlán', '0001', 'Santiago Huajolotitlán', '2017-10-17 15:56:26', '20'),
('463', 'Santiago Huauclilla', '0001', 'Santiago Huauclilla', '2017-10-17 15:56:26', '20'),
('464', 'Santiago Ihuitlán Plumas', '0001', 'Santiago Ihuitlán Plumas', '2017-10-17 15:56:26', '20'),
('465', 'Santiago Ixcuintepec', '0001', 'Santiago Ixcuintepec', '2017-10-17 15:56:26', '20'),
('466', 'Santiago Ixtayutla', '0001', 'Santiago Ixtayutla', '2017-10-17 15:56:26', '20'),
('467', 'Santiago Jamiltepec', '0001', 'Santiago Jamiltepec', '2017-10-17 15:56:26', '20'),
('468', 'Santiago Jocotepec', '0019', 'Monte Negro', '2017-10-17 15:56:26', '20'),
('469', 'Santiago Juxtlahuaca', '0001', 'Santiago Juxtlahuaca', '2017-10-17 15:56:26', '20'),
('470', 'Santiago Lachiguiri', '0001', 'Santiago Lachiguiri', '2017-10-17 15:56:26', '20'),
('471', 'Santiago Lalopa', '0001', 'Santiago Lalopa', '2017-10-17 15:56:26', '20'),
('472', 'Santiago Laollaga', '0001', 'Santiago Laollaga', '2017-10-17 15:56:26', '20'),
('473', 'Santiago Laxopa', '0001', 'Santiago Laxopa', '2017-10-17 15:56:26', '20'),
('474', 'Santiago Llano Grande', '0001', 'Santiago Llano Grande', '2017-10-17 15:56:26', '20'),
('475', 'Santiago Matatlán', '0001', 'Santiago Matatlán', '2017-10-17 15:56:26', '20'),
('476', 'Santiago Miltepec', '0001', 'Santiago Miltepec', '2017-10-17 15:56:26', '20'),
('477', 'Santiago Minas', '0001', 'Santiago Minas', '2017-10-17 15:56:26', '20'),
('478', 'Santiago Nacaltepec', '0001', 'Santiago Nacaltepec', '2017-10-17 15:56:26', '20'),
('479', 'Santiago Nejapilla', '0001', 'Santiago Nejapilla', '2017-10-17 15:56:27', '20'),
('480', 'Santiago Nundiche', '0001', 'Santiago Nundiche', '2017-10-17 15:56:27', '20'),
('481', 'Santiago Nuyoó', '0001', 'Santiago Nuyoó', '2017-10-17 15:56:27', '20'),
('482', 'Santiago Pinotepa Nacional', '0001', 'Santiago Pinotepa Nacional', '2017-10-17 15:56:27', '20'),
('483', 'Santiago Suchilquitongo', '0001', 'Santiago Suchilquitongo', '2017-10-17 15:56:27', '20'),
('484', 'Santiago Tamazola', '0001', 'Santiago Tamazola', '2017-10-17 15:56:27', '20'),
('485', 'Santiago Tapextla', '0001', 'Santiago Tapextla', '2017-10-17 15:56:27', '20'),
('486', 'Villa Tejúpam de la Unión', '0001', 'Villa Tejúpam de la Unión', '2017-10-17 15:56:27', '20'),
('487', 'Santiago Tenango', '0001', 'Santiago Tenango', '2017-10-17 15:56:27', '20'),
('488', 'Santiago Tepetlapa', '0001', 'Santiago Tepetlapa', '2017-10-17 15:56:27', '20'),
('489', 'Santiago Tetepec', '0001', 'Santiago Tetepec', '2017-10-17 15:56:27', '20'),
('490', 'Santiago Texcalcingo', '0001', 'Santiago Texcalcingo', '2017-10-17 15:56:27', '20'),
('491', 'Santiago Textitlán', '0001', 'Santiago Textitlán', '2017-10-17 15:56:27', '20'),
('492', 'Santiago Tilantongo', '0001', 'Santiago Tilantongo', '2017-10-17 15:56:27', '20'),
('493', 'Santiago Tillo', '0001', 'Santiago Tillo', '2017-10-17 15:56:27', '20'),
('494', 'Santiago Tlazoyaltepec', '0001', 'Santiago Tlazoyaltepec', '2017-10-17 15:56:27', '20'),
('495', 'Santiago Xanica', '0001', 'Santiago Xanica', '2017-10-17 15:56:27', '20'),
('496', 'Santiago Xiacuí', '0001', 'Santiago Xiacuí', '2017-10-17 15:56:27', '20'),
('497', 'Santiago Yaitepec', '0001', 'Santiago Yaitepec', '2017-10-17 15:56:27', '20'),
('498', 'Santiago Yaveo', '0001', 'Santiago Yaveo', '2017-10-17 15:56:27', '20'),
('499', 'Santiago Yolomécatl', '0001', 'Santiago Yolomécatl', '2017-10-17 15:56:27', '20'),
('500', 'Santiago Yosondúa', '0001', 'Santiago Yosondúa', '2017-10-17 15:56:27', '20'),
('501', 'Santiago Yucuyachi', '0001', 'Santiago Yucuyachi', '2017-10-17 15:56:27', '20'),
('502', 'Santiago Zacatepec', '0001', 'Santiago Zacatepec', '2017-10-17 15:56:28', '20'),
('503', 'Santiago Zoochila', '0001', 'Santiago Zoochila', '2017-10-17 15:56:28', '20'),
('504', 'Nuevo Zoquiápam', '0001', 'Nuevo Zoquiápam', '2017-10-17 15:56:28', '20'),
('505', 'Santo Domingo Ingenio', '0001', 'Santo Domingo Ingenio', '2017-10-17 15:56:28', '20'),
('506', 'Santo Domingo Albarradas', '0001', 'Santo Domingo Albarradas', '2017-10-17 15:56:28', '20'),
('507', 'Santo Domingo Armenta', '0001', 'Santo Domingo Armenta', '2017-10-17 15:56:28', '20'),
('508', 'Santo Domingo Chihuitán', '0001', 'Santo Domingo Chihuitán', '2017-10-17 15:56:28', '20'),
('509', 'Santo Domingo de Morelos', '0001', 'Santo Domingo de Morelos', '2017-10-17 15:56:28', '20'),
('510', 'Santo Domingo Ixcatlán', '0001', 'Santo Domingo Ixcatlán', '2017-10-17 15:56:28', '20'),
('511', 'Santo Domingo Nuxaá', '0001', 'Santo Domingo Nuxaá', '2017-10-17 15:56:28', '20'),
('512', 'Santo Domingo Ozolotepec', '0001', 'Santo Domingo Ozolotepec', '2017-10-17 15:56:28', '20'),
('513', 'Santo Domingo Petapa', '0001', 'Santo Domingo Petapa', '2017-10-17 15:56:28', '20'),
('514', 'Santo Domingo Roayaga', '0001', 'Santo Domingo Roayaga', '2017-10-17 15:56:28', '20'),
('515', 'Santo Domingo Tehuantepec', '0001', 'Santo Domingo Tehuantepec', '2017-10-17 15:56:28', '20'),
('516', 'Santo Domingo Teojomulco', '0001', 'Santo Domingo Teojomulco', '2017-10-17 15:56:28', '20'),
('517', 'Santo Domingo Tepuxtepec', '0001', 'Santo Domingo Tepuxtepec', '2017-10-17 15:56:28', '20'),
('518', 'Santo Domingo Tlatayápam', '0001', 'Santo Domingo Tlatayápam', '2017-10-17 15:56:28', '20'),
('519', 'Santo Domingo Tomaltepec', '0001', 'Santo Domingo Tomaltepec', '2017-10-17 15:56:28', '20'),
('520', 'Santo Domingo Tonalá', '0001', 'Santo Domingo Tonalá', '2017-10-17 15:56:28', '20'),
('521', 'Santo Domingo Tonaltepec', '0001', 'Santo Domingo Tonaltepec', '2017-10-17 15:56:28', '20'),
('522', 'Santo Domingo Xagacía', '0001', 'Santo Domingo Xagacía', '2017-10-17 15:56:28', '20'),
('523', 'Santo Domingo Yanhuitlán', '0001', 'Santo Domingo Yanhuitlán', '2017-10-17 15:56:28', '20'),
('524', 'Santo Domingo Yodohino', '0001', 'Santo Domingo Yodohino', '2017-10-17 15:56:28', '20'),
('525', 'Santo Domingo Zanatepec', '0001', 'Santo Domingo Zanatepec', '2017-10-17 15:56:28', '20'),
('526', 'Santos Reyes Nopala', '0001', 'Santos Reyes Nopala', '2017-10-17 15:56:28', '20'),
('527', 'Santos Reyes Pápalo', '0001', 'Santos Reyes Pápalo', '2017-10-17 15:56:29', '20'),
('528', 'Santos Reyes Tepejillo', '0001', 'Santos Reyes Tepejillo', '2017-10-17 15:56:29', '20'),
('529', 'Santos Reyes Yucuná', '0001', 'Santos Reyes Yucuná', '2017-10-17 15:56:29', '20'),
('530', 'Santo Tomás Jalieza', '0001', 'Santo Tomás Jalieza', '2017-10-17 15:56:29', '20'),
('531', 'Santo Tomás Mazaltepec', '0001', 'Santo Tomás Mazaltepec', '2017-10-17 15:56:29', '20'),
('532', 'Santo Tomás Ocotepec', '0001', 'Santo Tomás Ocotepec', '2017-10-17 15:56:29', '20'),
('533', 'Santo Tomás Tamazulapan', '0001', 'Santo Tomás Tamazulapan', '2017-10-17 15:56:29', '20'),
('534', 'San Vicente Coatlán', '0001', 'San Vicente Coatlán', '2017-10-17 15:56:29', '20'),
('535', 'San Vicente Lachixío', '0001', 'San Vicente Lachixío', '2017-10-17 15:56:29', '20'),
('536', 'San Vicente Nuñú', '0001', 'San Vicente Nuñú', '2017-10-17 15:56:29', '20'),
('537', 'Silacayoápam', '0001', 'Silacayoápam', '2017-10-17 15:56:29', '20'),
('538', 'Sitio de Xitlapehua', '0001', 'Sitio de Xitlapehua', '2017-10-17 15:56:29', '20'),
('539', 'Soledad Etla', '0001', 'Soledad Etla', '2017-10-17 15:56:29', '20'),
('540', 'Villa de Tamazulápam del Progreso', '0001', 'Villa de Tamazulápam del Progreso', '2017-10-17 15:56:29', '20'),
('541', 'Tanetze de Zaragoza', '0001', 'Tanetze de Zaragoza', '2017-10-17 15:56:29', '20'),
('542', 'Taniche', '0001', 'Taniche', '2017-10-17 15:56:29', '20'),
('543', 'Tataltepec de Valdés', '0001', 'Tataltepec de Valdés', '2017-10-17 15:56:29', '20'),
('544', 'Teococuilco de Marcos Pérez', '0001', 'Teococuilco de Marcos Pérez', '2017-10-17 15:56:29', '20'),
('545', 'Teotitlán de Flores Magón', '0001', 'Teotitlán de Flores Magón', '2017-10-17 15:56:29', '20'),
('546', 'Teotitlán del Valle', '0001', 'Teotitlán del Valle', '2017-10-17 15:56:29', '20'),
('547', 'Teotongo', '0001', 'Teotongo', '2017-10-17 15:56:29', '20'),
('548', 'Tepelmeme Villa de Morelos', '0001', 'Tepelmeme Villa de Morelos', '2017-10-17 15:56:29', '20'),
('549', 'Heroica Villa Tezoatlán de Segura y Luna, Cuna de ', '0001', 'Heroica Villa Tezoatlán de Segura y Luna, Cuna de ', '2017-10-17 15:56:29', '20'),
('550', 'San Jerónimo Tlacochahuaya', '0001', 'San Jerónimo Tlacochahuaya', '2017-10-17 15:56:29', '20'),
('551', 'Tlacolula de Matamoros', '0001', 'Tlacolula de Matamoros', '2017-10-17 15:56:29', '20'),
('552', 'Tlacotepec Plumas', '0001', 'Tlacotepec Plumas', '2017-10-17 15:56:29', '20'),
('553', 'Tlalixtac de Cabrera', '0001', 'Tlalixtac de Cabrera', '2017-10-17 15:56:30', '20'),
('554', 'Totontepec Villa de Morelos', '0001', 'Totontepec Villa de Morelos', '2017-10-17 15:56:30', '20'),
('555', 'Trinidad Zaachila', '0001', 'Trinidad Zaachila', '2017-10-17 15:56:30', '20'),
('556', 'La Trinidad Vista Hermosa', '0001', 'La Trinidad Vista Hermosa', '2017-10-17 15:56:30', '20'),
('557', 'Unión Hidalgo', '0001', 'Unión Hidalgo', '2017-10-17 15:56:30', '20'),
('558', 'Valerio Trujano', '0001', 'Valerio Trujano', '2017-10-17 15:56:30', '20'),
('559', 'San Juan Bautista Valle Nacional', '0001', 'San Juan Bautista Valle Nacional', '2017-10-17 15:56:30', '20'),
('560', 'Villa Díaz Ordaz', '0001', 'Villa Díaz Ordaz', '2017-10-17 15:56:30', '20'),
('561', 'Yaxe', '0001', 'Yaxe', '2017-10-17 15:56:30', '20'),
('562', 'Magdalena Yodocono de Porfirio Díaz', '0001', 'Magdalena Yodocono de Porfirio Díaz', '2017-10-17 15:56:30', '20'),
('563', 'Yogana', '0001', 'Yogana', '2017-10-17 15:56:30', '20'),
('564', 'Yutanduchi de Guerrero', '0001', 'Yutanduchi de Guerrero', '2017-10-17 15:56:30', '20'),
('565', 'Villa de Zaachila', '0001', 'Villa de Zaachila', '2017-10-17 15:56:30', '20'),
('566', 'San Mateo Yucutindoo', '0009', 'San Mateo Yucutindoo', '2017-10-17 15:56:30', '20'),
('567', 'Zapotitlán Lagunas', '0001', 'Zapotitlán Lagunas', '2017-10-17 15:56:30', '20'),
('568', 'Zapotitlán Palmas', '0001', 'Zapotitlán Palmas', '2017-10-17 15:56:30', '20'),
('569', 'Santa Inés de Zaragoza', '0001', 'Santa Inés de Zaragoza', '2017-10-17 15:56:30', '20'),
('570', 'Zimatlán de Álvarez', '0001', 'Zimatlán de Álvarez', '2017-10-17 15:56:30', '20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota_remision`
--

CREATE TABLE `nota_remision` (
  `no_folio` varchar(20) NOT NULL,
  `no_venta` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_compra`
--

CREATE TABLE `orden_compra` (
  `no_orden` int(11) NOT NULL,
  `fecha_orden` date NOT NULL,
  `id_prov` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE `pais` (
  `id` varchar(2) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  `fechaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`id`, `nombre`, `fechaModificacion`) VALUES
('MX', 'Mexico', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `codigo` int(11) NOT NULL,
  `marca` varchar(40) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `unidades_medicion` varchar(20) NOT NULL,
  `nombre_categoria` varchar(40) NOT NULL,
  `no_serie` varchar(20) DEFAULT NULL,
  `descripcion` varchar(200) NOT NULL,
  `precio_venta` float NOT NULL,
  `no_catalogo` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  `no_caja` int(11) DEFAULT NULL,
  `no_seccion` int(11) DEFAULT NULL,
  `no_estante` int(11) DEFAULT NULL,
  `no_repisa` int(11) DEFAULT NULL,
  `existencia_bodega` float NOT NULL,
  `existencia_caja` float DEFAULT NULL,
  `existencia_repisa` float DEFAULT NULL,
  `limite_inferior` float NOT NULL,
  `limite_superior` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`codigo`, `marca`, `nombre`, `unidades_medicion`, `nombre_categoria`, `no_serie`, `descripcion`, `precio_venta`, `no_catalogo`, `anio`, `no_caja`, `no_seccion`, `no_estante`, `no_repisa`, `existencia_bodega`, `existencia_caja`, `existencia_repisa`, `limite_inferior`, `limite_superior`) VALUES
(10700, 'Trupper (test)', 'Desarmador trupper (test)', 'n/a (test)', 'Herramientas (test)', '1084952', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut ', 76, 123, 2017, 1, 1, 1, 1, 20, 2, 2, 10, 40);

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `delete_producto_venta_on_delete_producto` BEFORE DELETE ON `producto` FOR EACH ROW begin
		set @gg = 10;
		delete from producto_venta where codigo = OLD.codigo;
	end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_orden_compra`
--

CREATE TABLE `producto_orden_compra` (
  `codigo` int(11) NOT NULL,
  `marca` varchar(40) NOT NULL,
  `no_orden` int(11) NOT NULL,
  `fecha_orden` date NOT NULL,
  `precio_compra` float NOT NULL,
  `cantidad` float NOT NULL,
  `unidades` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_venta`
--

CREATE TABLE `producto_venta` (
  `codigo` int(11) NOT NULL,
  `marca` varchar(40) NOT NULL,
  `no_venta` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `precio_vendido` float NOT NULL,
  `cantidad` float NOT NULL,
  `unidades` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_prov` varchar(13) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `razon_social` varchar(40) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `calle` varchar(40) NOT NULL,
  `colonia` varchar(40) NOT NULL,
  `num_domicilio_ext` varchar(5) DEFAULT NULL,
  `num_domicilio_int` varchar(5) DEFAULT NULL,
  `cp` varchar(15) DEFAULT NULL,
  `cve_mun` varchar(3) NOT NULL,
  `cve_ent` varchar(2) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `fecha_ultima_visita` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_prov`, `nombre`, `razon_social`, `telefono`, `calle`, `colonia`, `num_domicilio_ext`, `num_domicilio_int`, `cp`, `cve_mun`, `cve_ent`, `email`, `fecha_ultima_visita`) VALUES
('9090', 'Eduardo Medina', 'E.U.', '1234', 'qastr', 'here', '201', '1', '30301', '010', '20', 'jemedina.96@gmail.com', '2017-11-23');

--
-- Disparadores `proveedor`
--
DELIMITER $$
CREATE TRIGGER `delete_catalogos_on_delete_proveedor` BEFORE DELETE ON `proveedor` FOR EACH ROW begin
		delete from catalogo where id_prov = OLD.id_prov;
	end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repisa`
--

CREATE TABLE `repisa` (
  `no_repisa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `repisa`
--

INSERT INTO `repisa` (`no_repisa`) VALUES
(1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccion`
--

CREATE TABLE `seccion` (
  `no_seccion` int(11) NOT NULL,
  `no_estante` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `no_venta` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `monto` float NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `es_a_credito` tinyint(1) DEFAULT NULL,
  `descuento` float DEFAULT NULL,
  `fecha_limite_pago` date DEFAULT NULL,
  `id_empleado` int(11) NOT NULL,
  `RFC` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`no_venta`, `fecha`, `hora`, `monto`, `tipo`, `es_a_credito`, `descuento`, `fecha_limite_pago`, `id_empleado`, `RFC`) VALUES
(2, '2017-12-11', '16:39:49', 5, 'MAYOREO', 0, 0, '2017-12-12', 1, NULL),
(3, '2017-12-11', '16:39:49', 5, 'MAYOREO', 0, 0, '2017-12-10', 1, NULL),
(4, '2017-12-11', '16:39:49', 5, 'MAYOREO', 0, 0, '2017-12-02', 1, NULL),
(5, '2017-12-11', '17:21:08', 177, 'MAYOREO', 1, 0, '2017-12-25', 1, 'qa'),
(6, '2017-12-11', '17:22:48', 212.4, 'MENUDEO', 1, 20, '2017-12-25', 1, '123'),
(7, '2017-12-11', '17:23:43', 354, 'MAYOREO', 0, 0, '2017-12-25', 1, NULL),
(8, '2017-12-11', '17:23:56', 708, 'MAYOREO', 0, 0, '2017-12-25', 1, NULL),
(20, '2017-12-11', '16:39:49', 5, 'MAYOREO', 0, 0, '2017-12-13', 1, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `abono_ferre`
--
ALTER TABLE `abono_ferre`
  ADD PRIMARY KEY (`no_mov`,`fecha`,`no_cta`),
  ADD KEY `no_cta` (`no_cta`),
  ADD KEY `no_folio` (`no_folio`);

--
-- Indices de la tabla `abono_prov`
--
ALTER TABLE `abono_prov`
  ADD PRIMARY KEY (`no_mov`,`fecha`,`no_cta`),
  ADD KEY `no_cta` (`no_cta`),
  ADD KEY `no_folio` (`no_folio`);

--
-- Indices de la tabla `caja`
--
ALTER TABLE `caja`
  ADD PRIMARY KEY (`no_caja`,`no_seccion`,`no_estante`);

--
-- Indices de la tabla `cargo_ferre`
--
ALTER TABLE `cargo_ferre`
  ADD PRIMARY KEY (`no_mov`,`fecha`,`no_cta`),
  ADD KEY `no_cta` (`no_cta`),
  ADD KEY `no_folio` (`no_folio`);

--
-- Indices de la tabla `cargo_prov`
--
ALTER TABLE `cargo_prov`
  ADD PRIMARY KEY (`no_mov`,`fecha`,`no_cta`),
  ADD KEY `no_cta` (`no_cta`),
  ADD KEY `no_folio` (`no_folio`);

--
-- Indices de la tabla `catalogo`
--
ALTER TABLE `catalogo`
  ADD PRIMARY KEY (`no_catalogo`,`anio`),
  ADD KEY `id_prov` (`id_prov`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`RFC`),
  ADD KEY `cve_mun` (`cve_mun`,`cve_ent`);

--
-- Indices de la tabla `comprobante`
--
ALTER TABLE `comprobante`
  ADD PRIMARY KEY (`no_folio`),
  ADD KEY `no_venta` (`no_venta`,`fecha`);

--
-- Indices de la tabla `cta_credito_ferre`
--
ALTER TABLE `cta_credito_ferre`
  ADD PRIMARY KEY (`no_cta`),
  ADD KEY `RFC` (`RFC`);

--
-- Indices de la tabla `cta_credito_prov`
--
ALTER TABLE `cta_credito_prov`
  ADD PRIMARY KEY (`no_cta`),
  ADD KEY `id_prov` (`id_prov`);

--
-- Indices de la tabla `devolucion`
--
ALTER TABLE `devolucion`
  ADD PRIMARY KEY (`no_devolucion`,`fecha`),
  ADD KEY `no_venta` (`no_venta`,`fecha_venta`);

--
-- Indices de la tabla `devolucion_producto`
--
ALTER TABLE `devolucion_producto`
  ADD PRIMARY KEY (`no_devolucion`,`fecha`,`codigo`,`marca`),
  ADD KEY `codigo` (`codigo`,`marca`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`),
  ADD KEY `cve_mun` (`cve_mun`,`cve_ent`);

--
-- Indices de la tabla `entidad`
--
ALTER TABLE `entidad`
  ADD PRIMARY KEY (`cve_ent`),
  ADD KEY `id_pais` (`id_pais`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`no_folio`),
  ADD KEY `no_orden` (`no_orden`,`fecha_orden`);

--
-- Indices de la tabla `historia_empleado`
--
ALTER TABLE `historia_empleado`
  ADD PRIMARY KEY (`id_empleado`,`fecha`,`hora`);

--
-- Indices de la tabla `municipio`
--
ALTER TABLE `municipio`
  ADD PRIMARY KEY (`cve_mun`,`cve_ent`),
  ADD UNIQUE KEY `cve_mun` (`cve_mun`,`cve_ent`),
  ADD KEY `cve_ent` (`cve_ent`);

--
-- Indices de la tabla `nota_remision`
--
ALTER TABLE `nota_remision`
  ADD PRIMARY KEY (`no_folio`),
  ADD KEY `no_venta` (`no_venta`,`fecha`);

--
-- Indices de la tabla `orden_compra`
--
ALTER TABLE `orden_compra`
  ADD PRIMARY KEY (`no_orden`,`fecha_orden`),
  ADD KEY `id_prov` (`id_prov`);

--
-- Indices de la tabla `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`codigo`,`marca`),
  ADD KEY `no_catalogo` (`no_catalogo`,`anio`),
  ADD KEY `no_caja` (`no_caja`,`no_seccion`,`no_estante`),
  ADD KEY `no_repisa` (`no_repisa`);

--
-- Indices de la tabla `producto_orden_compra`
--
ALTER TABLE `producto_orden_compra`
  ADD PRIMARY KEY (`codigo`,`marca`,`no_orden`,`fecha_orden`),
  ADD KEY `no_orden` (`no_orden`,`fecha_orden`);

--
-- Indices de la tabla `producto_venta`
--
ALTER TABLE `producto_venta`
  ADD PRIMARY KEY (`codigo`,`marca`,`no_venta`,`fecha`),
  ADD KEY `no_venta` (`no_venta`,`fecha`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_prov`),
  ADD KEY `cve_mun` (`cve_mun`,`cve_ent`);

--
-- Indices de la tabla `repisa`
--
ALTER TABLE `repisa`
  ADD PRIMARY KEY (`no_repisa`);

--
-- Indices de la tabla `seccion`
--
ALTER TABLE `seccion`
  ADD PRIMARY KEY (`no_seccion`,`no_estante`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`no_venta`,`fecha`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `RFC` (`RFC`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `abono_ferre`
--
ALTER TABLE `abono_ferre`
  ADD CONSTRAINT `abono_ferre_ibfk_1` FOREIGN KEY (`no_cta`) REFERENCES `cta_credito_ferre` (`no_cta`),
  ADD CONSTRAINT `abono_ferre_ibfk_2` FOREIGN KEY (`no_folio`) REFERENCES `comprobante` (`no_folio`);

--
-- Filtros para la tabla `abono_prov`
--
ALTER TABLE `abono_prov`
  ADD CONSTRAINT `abono_prov_ibfk_1` FOREIGN KEY (`no_cta`) REFERENCES `cta_credito_prov` (`no_cta`),
  ADD CONSTRAINT `abono_prov_ibfk_2` FOREIGN KEY (`no_folio`) REFERENCES `factura` (`no_folio`);

--
-- Filtros para la tabla `cargo_ferre`
--
ALTER TABLE `cargo_ferre`
  ADD CONSTRAINT `cargo_ferre_ibfk_1` FOREIGN KEY (`no_cta`) REFERENCES `cta_credito_ferre` (`no_cta`),
  ADD CONSTRAINT `cargo_ferre_ibfk_2` FOREIGN KEY (`no_folio`) REFERENCES `comprobante` (`no_folio`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `cargo_prov`
--
ALTER TABLE `cargo_prov`
  ADD CONSTRAINT `cargo_prov_ibfk_1` FOREIGN KEY (`no_cta`) REFERENCES `cta_credito_prov` (`no_cta`),
  ADD CONSTRAINT `cargo_prov_ibfk_2` FOREIGN KEY (`no_folio`) REFERENCES `factura` (`no_folio`);

--
-- Filtros para la tabla `catalogo`
--
ALTER TABLE `catalogo`
  ADD CONSTRAINT `catalogo_ibfk_1` FOREIGN KEY (`id_prov`) REFERENCES `proveedor` (`id_prov`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`cve_mun`,`cve_ent`) REFERENCES `municipio` (`cve_mun`, `cve_ent`);

--
-- Filtros para la tabla `comprobante`
--
ALTER TABLE `comprobante`
  ADD CONSTRAINT `comprobante_ibfk_1` FOREIGN KEY (`no_venta`,`fecha`) REFERENCES `venta` (`no_venta`, `fecha`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `cta_credito_ferre`
--
ALTER TABLE `cta_credito_ferre`
  ADD CONSTRAINT `cta_credito_ferre_ibfk_1` FOREIGN KEY (`RFC`) REFERENCES `cliente` (`RFC`);

--
-- Filtros para la tabla `cta_credito_prov`
--
ALTER TABLE `cta_credito_prov`
  ADD CONSTRAINT `cta_credito_prov_ibfk_1` FOREIGN KEY (`id_prov`) REFERENCES `proveedor` (`id_prov`);

--
-- Filtros para la tabla `devolucion`
--
ALTER TABLE `devolucion`
  ADD CONSTRAINT `devolucion_ibfk_1` FOREIGN KEY (`no_venta`,`fecha_venta`) REFERENCES `venta` (`no_venta`, `fecha`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `devolucion_producto`
--
ALTER TABLE `devolucion_producto`
  ADD CONSTRAINT `devolucion_producto_ibfk_1` FOREIGN KEY (`no_devolucion`,`fecha`) REFERENCES `devolucion` (`no_devolucion`, `fecha`) ON UPDATE CASCADE,
  ADD CONSTRAINT `devolucion_producto_ibfk_2` FOREIGN KEY (`codigo`,`marca`) REFERENCES `producto` (`codigo`, `marca`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`cve_mun`,`cve_ent`) REFERENCES `municipio` (`cve_mun`, `cve_ent`);

--
-- Filtros para la tabla `entidad`
--
ALTER TABLE `entidad`
  ADD CONSTRAINT `entidad_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`no_orden`,`fecha_orden`) REFERENCES `orden_compra` (`no_orden`, `fecha_orden`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `historia_empleado`
--
ALTER TABLE `historia_empleado`
  ADD CONSTRAINT `historia_empleado_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `municipio`
--
ALTER TABLE `municipio`
  ADD CONSTRAINT `municipio_ibfk_1` FOREIGN KEY (`cve_ent`) REFERENCES `entidad` (`cve_ent`);

--
-- Filtros para la tabla `nota_remision`
--
ALTER TABLE `nota_remision`
  ADD CONSTRAINT `nota_remision_ibfk_1` FOREIGN KEY (`no_venta`,`fecha`) REFERENCES `venta` (`no_venta`, `fecha`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `orden_compra`
--
ALTER TABLE `orden_compra`
  ADD CONSTRAINT `orden_compra_ibfk_1` FOREIGN KEY (`id_prov`) REFERENCES `proveedor` (`id_prov`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`no_catalogo`,`anio`) REFERENCES `catalogo` (`no_catalogo`, `anio`) ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`no_caja`,`no_seccion`,`no_estante`) REFERENCES `caja` (`no_caja`, `no_seccion`, `no_estante`) ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`no_repisa`) REFERENCES `repisa` (`no_repisa`);

--
-- Filtros para la tabla `producto_orden_compra`
--
ALTER TABLE `producto_orden_compra`
  ADD CONSTRAINT `producto_orden_compra_ibfk_1` FOREIGN KEY (`no_orden`,`fecha_orden`) REFERENCES `orden_compra` (`no_orden`, `fecha_orden`) ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_orden_compra_ibfk_2` FOREIGN KEY (`codigo`,`marca`) REFERENCES `producto` (`codigo`, `marca`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto_venta`
--
ALTER TABLE `producto_venta`
  ADD CONSTRAINT `producto_venta_ibfk_1` FOREIGN KEY (`no_venta`,`fecha`) REFERENCES `venta` (`no_venta`, `fecha`) ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_venta_ibfk_2` FOREIGN KEY (`codigo`,`marca`) REFERENCES `producto` (`codigo`, `marca`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`cve_mun`,`cve_ent`) REFERENCES `municipio` (`cve_mun`, `cve_ent`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`RFC`) REFERENCES `cliente` (`RFC`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
