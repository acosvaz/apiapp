-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-01-2021 a las 09:33:21
-- Versión del servidor: 10.1.26-MariaDB
-- Versión de PHP: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `primaria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` bigint(20) NOT NULL,
  `maestro_id` bigint(20) NOT NULL,
  `nombre_curso` varchar(100) NOT NULL,
  `clave_curso` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `maestro_id`, `nombre_curso`, `clave_curso`) VALUES
(19, 1, 'Lengua Materna', '6094d3'),
(20, 1, 'Ciencias Naturales', 'f6021b');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_alumnos`
--

CREATE TABLE `curso_alumnos` (
  `id` bigint(20) NOT NULL,
  `alumno` varchar(150) NOT NULL,
  `maestro` varchar(150) NOT NULL,
  `curso` varchar(100) NOT NULL,
  `clave_curso` varchar(50) NOT NULL,
  `ejercicios` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicios`
--

CREATE TABLE `ejercicios` (
  `id` bigint(20) NOT NULL,
  `curso_id` bigint(20) NOT NULL,
  `ejercicio` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ejercicios`
--

INSERT INTO `ejercicios` (`id`, `curso_id`, `ejercicio`) VALUES
(23, 19, 'Replica la palabra'),
(24, 19, 'Selecciona la palabra'),
(25, 20, 'Replica la palabra');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicio_contenidos`
--

CREATE TABLE `ejercicio_contenidos` (
  `id` bigint(20) NOT NULL,
  `problema` varchar(250) NOT NULL,
  `imagen` varchar(250) DEFAULT NULL,
  `audio` varchar(255) DEFAULT NULL,
  `ejercicio_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ejercicio_contenidos`
--

INSERT INTO `ejercicio_contenidos` (`id`, `problema`, `imagen`, `audio`, `ejercicio_id`, `created_at`, `updated_at`) VALUES
(10, '1', 'http://localhost/apiapp/uploads/imagen1.jpg', NULL, 23, '2021-01-19 08:29:01', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicio_respuestas`
--

CREATE TABLE `ejercicio_respuestas` (
  `id` bigint(20) NOT NULL,
  `respuesta` varchar(255) NOT NULL,
  `short` varchar(50) DEFAULT NULL,
  `nu_pregunta` bigint(20) NOT NULL,
  `valor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ejercicio_respuestas`
--

INSERT INTO `ejercicio_respuestas` (`id`, `respuesta`, `short`, `nu_pregunta`, `valor`) VALUES
(13, 'Dado', NULL, 10, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultados`
--

CREATE TABLE `resultados` (
  `id` bigint(20) NOT NULL,
  `nu_user` bigint(20) NOT NULL,
  `nu_respuesta` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `tipo_user` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `username`, `password`, `tipo_user`) VALUES
(1, 'claudia', 'claudia', 'claudia', 'admin'),
(2, 'xiomara', 'xiomara', 'xiomara', 'user');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `curso_alumnos`
--
ALTER TABLE `curso_alumnos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `ejercicio_contenidos`
--
ALTER TABLE `ejercicio_contenidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ejercicio_id` (`ejercicio_id`);

--
-- Indices de la tabla `ejercicio_respuestas`
--
ALTER TABLE `ejercicio_respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nu_pregunta` (`nu_pregunta`);

--
-- Indices de la tabla `resultados`
--
ALTER TABLE `resultados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nu_respuesta` (`nu_respuesta`),
  ADD KEY `nu_user` (`nu_user`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `curso_alumnos`
--
ALTER TABLE `curso_alumnos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `ejercicio_contenidos`
--
ALTER TABLE `ejercicio_contenidos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `ejercicio_respuestas`
--
ALTER TABLE `ejercicio_respuestas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `resultados`
--
ALTER TABLE `resultados`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  ADD CONSTRAINT `ejercicios_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ejercicio_contenidos`
--
ALTER TABLE `ejercicio_contenidos`
  ADD CONSTRAINT `ejercicio_contenidos_ibfk_1` FOREIGN KEY (`ejercicio_id`) REFERENCES `ejercicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ejercicio_respuestas`
--
ALTER TABLE `ejercicio_respuestas`
  ADD CONSTRAINT `ejercicio_respuestas_ibfk_1` FOREIGN KEY (`nu_pregunta`) REFERENCES `ejercicio_contenidos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `resultados`
--
ALTER TABLE `resultados`
  ADD CONSTRAINT `nu_respuesta` FOREIGN KEY (`nu_respuesta`) REFERENCES `ejercicio_respuestas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `resultados_ibfk_1` FOREIGN KEY (`nu_user`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
