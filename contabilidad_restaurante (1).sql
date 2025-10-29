-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-10-2025 a las 01:18:15
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `contabilidad_restaurante`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asientos`
--

CREATE TABLE `asientos` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `creado_en` datetime DEFAULT current_timestamp(),
  `actualizado_en` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asientos`
--

INSERT INTO `asientos` (`id`, `empresa_id`, `fecha`, `descripcion`, `creado_en`, `actualizado_en`) VALUES
(1, 1, '2025-10-01', 'Compra de insumos de cocina', '2025-10-01 20:04:21', '2025-10-01 20:04:21'),
(2, 1, '2025-10-02', 'Venta en efectivo de almuerzo', '2025-10-01 20:04:21', '2025-10-01 20:04:21'),
(3, 2, '2025-10-03', 'Pago de servicios públicos', '2025-10-01 20:04:21', '2025-10-01 20:04:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `tipo` enum('activo','pasivo','patrimonio','ingreso','gasto') NOT NULL,
  `cuenta_padre_id` int(11) DEFAULT NULL,
  `empresa_id` int(11) NOT NULL,
  `creado_en` datetime DEFAULT current_timestamp(),
  `actualizado_en` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id`, `codigo`, `nombre`, `tipo`, `cuenta_padre_id`, `empresa_id`, `creado_en`, `actualizado_en`) VALUES
(1, '1105', 'Caja', 'activo', NULL, 1, '2025-10-01 20:04:21', '2025-10-01 20:04:21'),
(2, '1435', 'Inventarios', 'activo', NULL, 1, '2025-10-01 20:04:21', '2025-10-01 20:04:21'),
(3, '4135', 'Ventas', 'ingreso', NULL, 1, '2025-10-01 20:04:21', '2025-10-01 20:04:21'),
(4, '5105', 'Gastos de servicios públicos', 'gasto', NULL, 1, '2025-10-01 20:04:21', '2025-10-01 20:04:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_asientos`
--

CREATE TABLE `detalles_asientos` (
  `id` int(11) NOT NULL,
  `asiento_id` int(11) NOT NULL,
  `cuenta_id` int(11) NOT NULL,
  `debe` decimal(15,2) DEFAULT 0.00,
  `haber` decimal(15,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_asientos`
--

INSERT INTO `detalles_asientos` (`id`, `asiento_id`, `cuenta_id`, `debe`, `haber`) VALUES
(1, 1, 2, 200000.00, 0.00),
(2, 1, 1, 0.00, 200000.00),
(3, 2, 1, 50000.00, 0.00),
(4, 2, 3, 0.00, 50000.00),
(5, 3, 4, 150000.00, 0.00),
(6, 3, 1, 0.00, 150000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_pedidos`
--

CREATE TABLE `detalles_pedidos` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `inventario_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) DEFAULT 1.00,
  `precio` decimal(15,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_pedidos`
--

INSERT INTO `detalles_pedidos` (`id`, `pedido_id`, `inventario_id`, `cantidad`, `precio`) VALUES
(1, 1, 1, 2.00, 5000.00),
(2, 2, 2, 1.00, 18000.00),
(3, 3, 3, 3.00, 9000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `nit` varchar(50) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `creado_en` datetime DEFAULT current_timestamp(),
  `actualizado_en` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `nombre`, `nit`, `direccion`, `telefono`, `creado_en`, `actualizado_en`) VALUES
(1, 'Restaurante El Sabor', '123456789-0', 'Cra 10 #15-20, Buga', '3115558899', '2025-10-01 20:04:21', '2025-10-01 20:04:21'),
(2, 'La Parrilla Gourmet', '987654321-0', 'Av. Central #45-60, Cali', '3002223344', '2025-10-01 20:04:21', '2025-10-01 20:04:21'),
(3, 'Delicias Caseras', '456789123-0', 'Cl 20 #30-10, Palmira', '3126667788', '2025-10-01 20:04:21', '2025-10-01 20:04:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `categoria` enum('ingrediente','bebida','otros') NOT NULL,
  `cantidad` decimal(10,2) DEFAULT 0.00,
  `unidad` varchar(20) DEFAULT 'unidad',
  `precio_unitario` decimal(15,2) DEFAULT 0.00,
  `proveedor_id` int(11) DEFAULT NULL,
  `empresa_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id`, `nombre`, `categoria`, `cantidad`, `unidad`, `precio_unitario`, `proveedor_id`, `empresa_id`) VALUES
(1, 'Arroz', 'ingrediente', 50.00, 'kg', 2500.00, 1, 1),
(2, 'Carne de res', 'ingrediente', 30.00, 'kg', 18000.00, 3, 1),
(3, 'Gaseosa', 'bebida', 100.00, 'litro', 3000.00, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesas`
--

CREATE TABLE `mesas` (
  `id` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `estado` enum('libre','ocupada','reservada') DEFAULT 'libre',
  `empresa_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mesas`
--

INSERT INTO `mesas` (`id`, `numero`, `capacidad`, `estado`, `empresa_id`) VALUES
(1, 1, 4, 'libre', 1),
(2, 2, 2, 'ocupada', 1),
(3, 3, 6, 'reservada', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `mesa_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `total` decimal(15,2) DEFAULT 0.00,
  `estado` enum('pendiente','servido','pagado','cancelado') DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `mesa_id`, `usuario_id`, `fecha`, `total`, `estado`) VALUES
(1, 1, 3, '2025-10-01 20:04:22', 25000.00, 'pendiente'),
(2, 2, 2, '2025-10-01 20:04:22', 50000.00, 'servido'),
(3, 3, 3, '2025-10-01 20:04:22', 75000.00, 'pagado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `empresa_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `contacto`, `telefono`, `direccion`, `empresa_id`) VALUES
(1, 'Distribuidora La Buena Mesa', 'Carlos Pérez', '3105556677', 'Calle 50 #20-10, Cali', 1),
(2, 'Frutas y Verduras El Campo', 'María López', '3204448899', 'Cra 15 #33-22, Buga', 1),
(3, 'Carnes Premium', 'Luis Díaz', '3151112233', 'Av. Las Américas #12-34, Cali', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` enum('admin','contador','mesero','cajero','cocinero') DEFAULT 'mesero',
  `empresa_id` int(11) NOT NULL,
  `creado_en` datetime DEFAULT current_timestamp(),
  `actualizado_en` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `contrasena`, `rol`, `empresa_id`, `creado_en`, `actualizado_en`) VALUES
(1, 'admin1', 'hashedpass1', 'admin', 1, '2025-10-01 20:04:21', '2025-10-01 20:04:21'),
(2, 'cajero1', 'hashedpass2', 'cajero', 1, '2025-10-01 20:04:21', '2025-10-01 20:04:21'),
(3, 'mesero1', 'hashedpass3', 'mesero', 2, '2025-10-01 20:04:21', '2025-10-01 20:04:21');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asientos`
--
ALTER TABLE `asientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `empresa_id` (`empresa_id`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `cuenta_padre_id` (`cuenta_padre_id`),
  ADD KEY `empresa_id` (`empresa_id`);

--
-- Indices de la tabla `detalles_asientos`
--
ALTER TABLE `detalles_asientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asiento_id` (`asiento_id`),
  ADD KEY `cuenta_id` (`cuenta_id`);

--
-- Indices de la tabla `detalles_pedidos`
--
ALTER TABLE `detalles_pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `inventario_id` (`inventario_id`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nit` (`nit`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proveedor_id` (`proveedor_id`),
  ADD KEY `empresa_id` (`empresa_id`);

--
-- Indices de la tabla `mesas`
--
ALTER TABLE `mesas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `empresa_id` (`empresa_id`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mesa_id` (`mesa_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `empresa_id` (`empresa_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD KEY `empresa_id` (`empresa_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asientos`
--
ALTER TABLE `asientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalles_asientos`
--
ALTER TABLE `detalles_asientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `detalles_pedidos`
--
ALTER TABLE `detalles_pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `mesas`
--
ALTER TABLE `mesas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asientos`
--
ALTER TABLE `asientos`
  ADD CONSTRAINT `asientos_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`cuenta_padre_id`) REFERENCES `cuentas` (`id`),
  ADD CONSTRAINT `cuentas_ibfk_2` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalles_asientos`
--
ALTER TABLE `detalles_asientos`
  ADD CONSTRAINT `detalles_asientos_ibfk_1` FOREIGN KEY (`asiento_id`) REFERENCES `asientos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalles_asientos_ibfk_2` FOREIGN KEY (`cuenta_id`) REFERENCES `cuentas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalles_pedidos`
--
ALTER TABLE `detalles_pedidos`
  ADD CONSTRAINT `detalles_pedidos_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalles_pedidos_ibfk_2` FOREIGN KEY (`inventario_id`) REFERENCES `inventario` (`id`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`),
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mesas`
--
ALTER TABLE `mesas`
  ADD CONSTRAINT `mesas_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`mesa_id`) REFERENCES `mesas` (`id`),
  ADD CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `proveedores_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
