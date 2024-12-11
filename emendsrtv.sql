-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-12-2024 a las 07:58:58
-- Versión del servidor: 8.0.37
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `emendsrtv`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(450) NOT NULL,
  `foto1` varchar(250) NOT NULL,
  `foto2` varchar(250) NOT NULL,
  `foto3` varchar(250) NOT NULL,
  `producto_idProducto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idClientes` int NOT NULL,
  `Nombre` varchar(125) NOT NULL,
  `Documento` varchar(45) NOT NULL,
  `Correo` varchar(45) NOT NULL,
  `Contraseña` varbinary(255) NOT NULL,
  `Fechadenacimiento` datetime NOT NULL,
  `roles_idRoles` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idClientes`, `Nombre`, `Documento`, `Correo`, `Contraseña`, `Fechadenacimiento`, `roles_idRoles`) VALUES
(12, '123', '123', '123@gmail.com', 0x243279243130243731526b35495258356f5a5161783739774b6436746531686d7a7551653868525736492f4d2f4563594d39305039304e564f6d7171, '2003-12-11 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigonis`
--

CREATE TABLE `codigonis` (
  `idCodigoNIS` int NOT NULL,
  `Descripcion` varchar(10) NOT NULL,
  `mesa_idMesa` int NOT NULL,
  `menu_idMenu` int NOT NULL,
  `cliente_idClientes` int DEFAULT NULL,
  `Producto_idProducto` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `codigonis`
--

INSERT INTO `codigonis` (`idCodigoNIS`, `Descripcion`, `mesa_idMesa`, `menu_idMenu`, `cliente_idClientes`, `Producto_idProducto`) VALUES
(2, '124', 7, 2, NULL, NULL),
(3, '21432', 8, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalledeorden`
--

CREATE TABLE `detalledeorden` (
  `idDetalleDeOrden` int NOT NULL,
  `Descripcion` varchar(700) NOT NULL,
  `Hora` time NOT NULL,
  `Entregado` tinyint NOT NULL,
  `orden_idOrden` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `idEvento` int NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_evento` datetime NOT NULL,
  `menu_idMenu1` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `idMenu` int NOT NULL,
  `Descripcion` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`idMenu`, `Descripcion`) VALUES
(1, 'Común'),
(2, 'Evento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesa`
--

CREATE TABLE `mesa` (
  `idMesa` int NOT NULL,
  `Numeropiso` int NOT NULL,
  `NumeroMesa` int NOT NULL,
  `CantidadPuestos` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `mesa`
--

INSERT INTO `mesa` (`idMesa`, `Numeropiso`, `NumeroMesa`, `CantidadPuestos`) VALUES
(1, 123, 123, 1234),
(2, 123, 1123, 123),
(3, 12, 12, 12),
(4, 12, 12, 12),
(5, 12, 12, 12),
(6, 12, 12, 12),
(7, 2, 123, 123122),
(8, 453, 123, 123);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metododepago`
--

CREATE TABLE `metododepago` (
  `idmetodoDePago` int NOT NULL,
  `Metodo` varchar(45) NOT NULL,
  `detalledeorden_idDetalleDeOrden` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

CREATE TABLE `orden` (
  `idOrden` int NOT NULL,
  `tokenCliente` int NOT NULL,
  `PrecioFinal` float NOT NULL,
  `Fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idProducto` int NOT NULL,
  `Precio` float NOT NULL,
  `Disponibilidad` tinyint NOT NULL,
  `Cantidad` int NOT NULL,
  `orden_idOrden` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idRoles` int NOT NULL,
  `Descripcion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idRoles`, `Descripcion`) VALUES
(1, 'Admin'),
(2, 'Gerente'),
(3, 'Bartender'),
(4, 'Cliente');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD KEY `fk_categoria_producto1_idx` (`producto_idProducto`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idClientes`),
  ADD KEY `fk_cliente_roles_idx` (`roles_idRoles`);

--
-- Indices de la tabla `codigonis`
--
ALTER TABLE `codigonis`
  ADD PRIMARY KEY (`idCodigoNIS`),
  ADD KEY `fk_codigonis_mesa1_idx` (`mesa_idMesa`),
  ADD KEY `fk_codigonis_menu1_idx` (`menu_idMenu`),
  ADD KEY `fk_codigonis_cliente1_idx` (`cliente_idClientes`),
  ADD KEY `fk_codigonis_producto1_idx` (`Producto_idProducto`);

--
-- Indices de la tabla `detalledeorden`
--
ALTER TABLE `detalledeorden`
  ADD PRIMARY KEY (`idDetalleDeOrden`),
  ADD KEY `fk_detalledeorden_orden1_idx` (`orden_idOrden`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`idEvento`),
  ADD KEY `fk_eventos_menu1_idx1` (`menu_idMenu1`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`idMenu`);

--
-- Indices de la tabla `mesa`
--
ALTER TABLE `mesa`
  ADD PRIMARY KEY (`idMesa`);

--
-- Indices de la tabla `metododepago`
--
ALTER TABLE `metododepago`
  ADD PRIMARY KEY (`idmetodoDePago`),
  ADD KEY `fk_metododepago_detalledeorden1_idx` (`detalledeorden_idDetalleDeOrden`);

--
-- Indices de la tabla `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`idOrden`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `fk_producto_orden1_idx` (`orden_idOrden`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRoles`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idClientes` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `codigonis`
--
ALTER TABLE `codigonis`
  MODIFY `idCodigoNIS` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalledeorden`
--
ALTER TABLE `detalledeorden`
  MODIFY `idDetalleDeOrden` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `idEvento` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `idMenu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `mesa`
--
ALTER TABLE `mesa`
  MODIFY `idMesa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `metododepago`
--
ALTER TABLE `metododepago`
  MODIFY `idmetodoDePago` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `orden`
--
ALTER TABLE `orden`
  MODIFY `idOrden` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idProducto` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idRoles` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD CONSTRAINT `fk_categoria_producto1` FOREIGN KEY (`producto_idProducto`) REFERENCES `producto` (`idProducto`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_roles` FOREIGN KEY (`roles_idRoles`) REFERENCES `roles` (`idRoles`);

--
-- Filtros para la tabla `codigonis`
--
ALTER TABLE `codigonis`
  ADD CONSTRAINT `fk_codigonis_cliente1` FOREIGN KEY (`cliente_idClientes`) REFERENCES `cliente` (`idClientes`),
  ADD CONSTRAINT `fk_codigonis_menu1` FOREIGN KEY (`menu_idMenu`) REFERENCES `menu` (`idMenu`),
  ADD CONSTRAINT `fk_codigonis_mesa1` FOREIGN KEY (`mesa_idMesa`) REFERENCES `mesa` (`idMesa`),
  ADD CONSTRAINT `fk_codigonis_producto1` FOREIGN KEY (`Producto_idProducto`) REFERENCES `producto` (`idProducto`);

--
-- Filtros para la tabla `detalledeorden`
--
ALTER TABLE `detalledeorden`
  ADD CONSTRAINT `fk_detalledeorden_orden1` FOREIGN KEY (`orden_idOrden`) REFERENCES `orden` (`idOrden`);

--
-- Filtros para la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `fk_eventos_menu1` FOREIGN KEY (`menu_idMenu1`) REFERENCES `menu` (`idMenu`);

--
-- Filtros para la tabla `metododepago`
--
ALTER TABLE `metododepago`
  ADD CONSTRAINT `fk_metododepago_detalledeorden1` FOREIGN KEY (`detalledeorden_idDetalleDeOrden`) REFERENCES `detalledeorden` (`idDetalleDeOrden`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_producto_orden1` FOREIGN KEY (`orden_idOrden`) REFERENCES `orden` (`idOrden`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
