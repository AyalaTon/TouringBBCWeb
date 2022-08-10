-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-08-2022 a las 20:38:03
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `touringbbc`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad`
--

CREATE TABLE `actividad` (
  `nombre` varchar(255) NOT NULL,
  `cupos` int(11) NOT NULL,
  `vigente` bit(1) NOT NULL,
  `funcionario_ci` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `actividad`
--

INSERT INTO `actividad` (`nombre`, `cupos`, `vigente`, `funcionario_ci`) VALUES
('Actividad Anual X', 50, b'1', NULL),
('Actividad X', 50, b'1', NULL),
('Actividad Y', 50, b'1', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` bigint(20) NOT NULL,
  `edadMax` int(11) NOT NULL,
  `edadMin` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `vigente` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `edadMax`, `edadMin`, `nombre`, `vigente`) VALUES
(1, 26, 23, 'Categoría X', b'1'),
(2, 40, 27, 'Categoría XX', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuota`
--

CREATE TABLE `cuota` (
  `id` bigint(20) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `frecuencia` varchar(255) DEFAULT NULL,
  `monto` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `vigente` bit(1) NOT NULL,
  `actividad_nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuota`
--

INSERT INTO `cuota` (`id`, `descripcion`, `fecha`, `frecuencia`, `monto`, `nombre`, `vigente`, `actividad_nombre`) VALUES
(1, ' cuota x descripcion ejemplo', '2022-08-04', 'Mensual', 600, 'Cuota X', b'1', 'Actividad X'),
(2, 'Cuota y ejemplo de descripcion ', '2022-08-05', 'Mensual', 700, 'Cuota Y', b'1', 'Actividad Y'),
(3, ' Cuota anual x descripción testeo', '2022-08-04', 'Anual', 1200, 'Cuota Anual X', b'1', 'Actividad Anual X');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuota_socio`
--

CREATE TABLE `cuota_socio` (
  `cuotas_id` bigint(20) NOT NULL,
  `socios_ci` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuota_socio`
--

INSERT INTO `cuota_socio` (`cuotas_id`, `socios_ci`) VALUES
(2, 50374906),
(2, 20138247),
(3, 20138247);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacio`
--

CREATE TABLE `espacio` (
  `id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familia`
--

CREATE TABLE `familia` (
  `id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `familia`
--

INSERT INTO `familia` (`id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(18),
(19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funcionario`
--

CREATE TABLE `funcionario` (
  `ci` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE `horario` (
  `id` bigint(20) NOT NULL,
  `dia` varchar(255) DEFAULT NULL,
  `duracion` int(11) NOT NULL,
  `hora` int(11) NOT NULL,
  `vigente` bit(1) NOT NULL,
  `actividad_nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`id`, `dia`, `duracion`, `hora`, `vigente`, `actividad_nombre`) VALUES
(1, 'Lunes', 120, 6, b'1', 'Actividad X'),
(2, 'Martes', 60, 8, b'1', 'Actividad Y'),
(3, 'Lunes', 120, 10, b'1', 'Actividad Anual X');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `carnetHabilitante` date DEFAULT NULL,
  `detalles` varchar(255) DEFAULT NULL,
  `tipoCarnet` int(11) NOT NULL,
  `venCi` date DEFAULT NULL,
  `ci` int(11) NOT NULL,
  `plantel_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`carnetHabilitante`, `detalles`, `tipoCarnet`, `venCi`, `ci`, `plantel_id`) VALUES
('2028-10-09', 'Información sobre Pablo Gómez, bla bla.', 0, '2025-05-11', 20138247, 2),
('2022-08-27', 'info de milton', 0, '2022-08-28', 50374906, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagobbc`
--

CREATE TABLE `pagobbc` (
  `id` bigint(20) NOT NULL,
  `fecha` date DEFAULT NULL,
  `monto` int(11) NOT NULL,
  `socio_ci` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pagobbc`
--

INSERT INTO `pagobbc` (`id`, `fecha`, `monto`, `socio_ci`) VALUES
(1, '2022-08-04', 200, 50374906),
(2, '2022-08-04', 250, 20138247),
(3, '2022-08-04', 500, 20138247),
(4, '2022-08-04', 500, 20138247),
(5, '2022-08-04', 1000, 20138247),
(6, '2022-08-04', 1500, 20138247),
(7, '2022-08-04', 700, 20138247),
(8, '2022-08-04', 800, 20138247),
(9, '2022-08-04', 750, 20138247),
(10, '2022-08-04', 650, 20138247),
(11, '2022-08-04', 500, 20138247),
(12, '2022-08-04', 1200, 20138247),
(13, '2022-08-04', 150, 36985949),
(14, '2022-08-05', 500, 27172327);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personabbc`
--

CREATE TABLE `personabbc` (
  `ci` int(11) NOT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `fechaNac` date DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `vigente` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `personabbc`
--

INSERT INTO `personabbc` (`ci`, `apellido`, `direccion`, `fechaNac`, `nombre`, `telefono`, `vigente`) VALUES
(20138247, 'Gomez', 'Bvar Artigas 1234', '1994-04-05', 'Pablo', '098273512', b'1'),
(27172327, 'Ayala Alvarez', 'Zorrilla 1872', '1971-02-10', 'Richar', '098174376', b'1'),
(34648242, 'henrich', 'Florida 455', '1991-12-04', 'Anna', '098726372', b'1'),
(35219604, 'Hernandez', 'Dr. Olazábal 1891', '1997-10-13', 'Sofia', '092983990', b'1'),
(36985949, 'Santos', 'Setembrino Pereda 653', '1971-08-14', 'Adriana', '098765432', b'1'),
(37641106, 'Farinha', 'Washington 648', '2004-10-12', 'Nicolas', '091348263', b'1'),
(42498120, 'Suanes', '25 de agosto 664', '1987-02-20', 'Esteban', '091687980', b'1'),
(43687980, 'Ayala', 'Florida 772', '1977-12-19', 'Norri Nelson', '099465163', b'1'),
(49993070, 'Silveira', 'Florida3497', '1998-07-07', 'Paula', '47421234', b'1'),
(50374906, 'Ayala', 'Wilson Ferreira 161', '1997-08-04', 'Milton', '099067458', b'1'),
(50374912, 'Ayala', 'wilson 443', '1999-09-16', 'Peter', '098627365', b'1'),
(53678600, 'Gomez', 'Wilson Ferreira Aldunate 1661', '1999-01-31', 'Gabriel', '099941164', b'1'),
(61971870, 'Antonini', 'Florida 887', '1987-07-11', 'Virginia', '098925372', b'1'),
(71531389, 'Lopez', 'Avenida Artigas y Orden', '1991-12-17', 'Daisy', '098391513', b'1'),
(73106475, 'Fanss', 'Numero 1 871', '2005-04-04', 'Martin', '099907655', b'1'),
(78016766, 'Alvarez', '18 de julio 1892', '2005-10-01', 'Camilo', '472 3418', b'1'),
(78465163, 'Alvarez', 'Orden 443', '1980-08-18', 'Olga Ester', '4742 3418', b'1'),
(79048617, 'Santos', 'Orden 654', '2001-12-04', 'Tomas', '092174635', b'1'),
(85299686, 'Fernandez', 'Dr. Penza 1998', '1994-07-08', 'Ayrton', '098146493', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `fechaIngreso` date DEFAULT NULL,
  `rol` bit(1) NOT NULL,
  `ci` int(11) NOT NULL,
  `familia_id` bigint(20) DEFAULT NULL,
  `tipo_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`fechaIngreso`, `rol`, `ci`, `familia_id`, `tipo_id`) VALUES
('2022-07-19', b'1', 20138247, 10, 2),
('2022-07-24', b'1', 27172327, 8, 1),
('2022-08-02', b'1', 34648242, 3, 1),
('2022-06-30', b'1', 35219604, 14, 1),
('2022-08-01', b'1', 36985949, 9, 1),
('2022-07-11', b'1', 37641106, 13, 1),
('2022-05-25', b'1', 42498120, 19, 1),
('2022-01-15', b'1', 43687980, 18, 1),
('2022-06-30', b'1', 49993070, 4, 1),
('2022-08-04', b'1', 50374906, 1, 1),
('2022-08-04', b'1', 50374912, 2, 1),
('2022-08-04', b'0', 53678600, 10, 1),
('2022-06-17', b'1', 61971870, 5, 1),
('2022-06-29', b'1', 71531389, 11, 1),
('2022-06-16', b'0', 73106475, 10, 1),
('2022-08-26', b'0', 78016766, 10, 1),
('2022-02-17', b'0', 78465163, 18, 1),
('2022-05-05', b'1', 79048617, 6, 1),
('2022-06-15', b'1', 85299686, 12, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socioactividad`
--

CREATE TABLE `socioactividad` (
  `id` bigint(20) NOT NULL,
  `actividades_nombre` varchar(255) DEFAULT NULL,
  `cuota_id` bigint(20) DEFAULT NULL,
  `socios_ci` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `socioactividad`
--

INSERT INTO `socioactividad` (`id`, `actividades_nombre`, `cuota_id`, `socios_ci`) VALUES
(1, 'Actividad X', 1, 50374906),
(2, 'Actividad X', 1, 20138247),
(3, 'Actividad Y', 2, 20138247);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socioactividad_horario`
--

CREATE TABLE `socioactividad_horario` (
  `socioActividadHorario_id` bigint(20) NOT NULL,
  `horarios_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `socioactividad_horario`
--

INSERT INTO `socioactividad_horario` (`socioActividadHorario_id`, `horarios_id`) VALUES
(1, 1),
(2, 1),
(3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sueldo`
--

CREATE TABLE `sueldo` (
  `id` bigint(20) NOT NULL,
  `funcionario_ci` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposocio`
--

CREATE TABLE `tiposocio` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `vigente` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tiposocio`
--

INSERT INTO `tiposocio` (`id`, `nombre`, `vigente`) VALUES
(1, 'Tipo X', b'1'),
(2, 'Tipo Y', b'1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividad`
--
ALTER TABLE `actividad`
  ADD PRIMARY KEY (`nombre`),
  ADD KEY `FK_ei6mvdye45sk93fo92hou68ps` (`funcionario_ci`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuota`
--
ALTER TABLE `cuota`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_dumrx76wj8xinug9cnjd38ne6` (`actividad_nombre`);

--
-- Indices de la tabla `cuota_socio`
--
ALTER TABLE `cuota_socio`
  ADD KEY `FK_t9eoiwckmg45v34or5wrvw5ce` (`socios_ci`),
  ADD KEY `FK_bj30byrxdk71n69pbdeajc5s0` (`cuotas_id`);

--
-- Indices de la tabla `espacio`
--
ALTER TABLE `espacio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `familia`
--
ALTER TABLE `familia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`ci`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_3k6npej156pygphadr7rpm2f5` (`actividad_nombre`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`ci`),
  ADD KEY `FK_2c728vt5um6dlh2ji1ie6iyb` (`plantel_id`);

--
-- Indices de la tabla `pagobbc`
--
ALTER TABLE `pagobbc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_96dqr0cym0fla50tvra3majjv` (`socio_ci`);

--
-- Indices de la tabla `personabbc`
--
ALTER TABLE `personabbc`
  ADD PRIMARY KEY (`ci`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`ci`),
  ADD KEY `FK_iisfr5je6yug9aa4jxuvsjnml` (`familia_id`),
  ADD KEY `FK_knulc916i1c218c86oh6fhlna` (`tipo_id`);

--
-- Indices de la tabla `socioactividad`
--
ALTER TABLE `socioactividad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_qajyvdkgl27m5134qbu98ur3l` (`actividades_nombre`),
  ADD KEY `FK_ta2q7n3dm0x4e9bh0v8o1osh1` (`cuota_id`),
  ADD KEY `FK_mnvat6rmtodpov8tpbqvbdj0r` (`socios_ci`);

--
-- Indices de la tabla `socioactividad_horario`
--
ALTER TABLE `socioactividad_horario`
  ADD KEY `FK_k9dacufgvfe81ruoq7kkcs11w` (`horarios_id`),
  ADD KEY `FK_el0pips6yb85ra0myehvmr4ih` (`socioActividadHorario_id`);

--
-- Indices de la tabla `sueldo`
--
ALTER TABLE `sueldo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_mbmyxqkuvjrodihx14edq2518` (`funcionario_ci`);

--
-- Indices de la tabla `tiposocio`
--
ALTER TABLE `tiposocio`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cuota`
--
ALTER TABLE `cuota`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `espacio`
--
ALTER TABLE `espacio`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `familia`
--
ALTER TABLE `familia`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `horario`
--
ALTER TABLE `horario`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pagobbc`
--
ALTER TABLE `pagobbc`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `socioactividad`
--
ALTER TABLE `socioactividad`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sueldo`
--
ALTER TABLE `sueldo`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tiposocio`
--
ALTER TABLE `tiposocio`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actividad`
--
ALTER TABLE `actividad`
  ADD CONSTRAINT `FK_ei6mvdye45sk93fo92hou68ps` FOREIGN KEY (`funcionario_ci`) REFERENCES `funcionario` (`ci`);

--
-- Filtros para la tabla `cuota`
--
ALTER TABLE `cuota`
  ADD CONSTRAINT `FK_dumrx76wj8xinug9cnjd38ne6` FOREIGN KEY (`actividad_nombre`) REFERENCES `actividad` (`nombre`);

--
-- Filtros para la tabla `cuota_socio`
--
ALTER TABLE `cuota_socio`
  ADD CONSTRAINT `FK_bj30byrxdk71n69pbdeajc5s0` FOREIGN KEY (`cuotas_id`) REFERENCES `cuota` (`id`),
  ADD CONSTRAINT `FK_t9eoiwckmg45v34or5wrvw5ce` FOREIGN KEY (`socios_ci`) REFERENCES `socio` (`ci`);

--
-- Filtros para la tabla `funcionario`
--
ALTER TABLE `funcionario`
  ADD CONSTRAINT `FK_a4c9c6w4813momjjlhkctaed6` FOREIGN KEY (`ci`) REFERENCES `personabbc` (`ci`);

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `FK_3k6npej156pygphadr7rpm2f5` FOREIGN KEY (`actividad_nombre`) REFERENCES `actividad` (`nombre`);

--
-- Filtros para la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `FK_2c728vt5um6dlh2ji1ie6iyb` FOREIGN KEY (`plantel_id`) REFERENCES `categoria` (`id`),
  ADD CONSTRAINT `FK_rxpcpgyu3nnr6sr0v10pj0bgt` FOREIGN KEY (`ci`) REFERENCES `socio` (`ci`);

--
-- Filtros para la tabla `pagobbc`
--
ALTER TABLE `pagobbc`
  ADD CONSTRAINT `FK_96dqr0cym0fla50tvra3majjv` FOREIGN KEY (`socio_ci`) REFERENCES `socio` (`ci`);

--
-- Filtros para la tabla `socio`
--
ALTER TABLE `socio`
  ADD CONSTRAINT `FK_iisfr5je6yug9aa4jxuvsjnml` FOREIGN KEY (`familia_id`) REFERENCES `familia` (`id`),
  ADD CONSTRAINT `FK_knulc916i1c218c86oh6fhlna` FOREIGN KEY (`tipo_id`) REFERENCES `tiposocio` (`id`),
  ADD CONSTRAINT `FK_ovysvbkvi9c5a9gapxw2ceo8w` FOREIGN KEY (`ci`) REFERENCES `personabbc` (`ci`);

--
-- Filtros para la tabla `socioactividad`
--
ALTER TABLE `socioactividad`
  ADD CONSTRAINT `FK_mnvat6rmtodpov8tpbqvbdj0r` FOREIGN KEY (`socios_ci`) REFERENCES `socio` (`ci`),
  ADD CONSTRAINT `FK_qajyvdkgl27m5134qbu98ur3l` FOREIGN KEY (`actividades_nombre`) REFERENCES `actividad` (`nombre`),
  ADD CONSTRAINT `FK_ta2q7n3dm0x4e9bh0v8o1osh1` FOREIGN KEY (`cuota_id`) REFERENCES `cuota` (`id`);

--
-- Filtros para la tabla `socioactividad_horario`
--
ALTER TABLE `socioactividad_horario`
  ADD CONSTRAINT `FK_el0pips6yb85ra0myehvmr4ih` FOREIGN KEY (`socioActividadHorario_id`) REFERENCES `socioactividad` (`id`),
  ADD CONSTRAINT `FK_k9dacufgvfe81ruoq7kkcs11w` FOREIGN KEY (`horarios_id`) REFERENCES `horario` (`id`);

--
-- Filtros para la tabla `sueldo`
--
ALTER TABLE `sueldo`
  ADD CONSTRAINT `FK_mbmyxqkuvjrodihx14edq2518` FOREIGN KEY (`funcionario_ci`) REFERENCES `funcionario` (`ci`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
