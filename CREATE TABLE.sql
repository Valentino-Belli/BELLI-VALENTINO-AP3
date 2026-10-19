-- Creacion de la base de datos
CREATE DATABASE gestion_stock_distribuidora;
USE gestion_stock_distribuidora;

CREATE TABLE `gestion_stock_distribuidora`.`roles_usuario` (
  `idRolUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombreRol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRolUsuario`),
  UNIQUE INDEX `idRolUsuario_UNIQUE` (`idRolUsuario` ASC) VISIBLE);
  
  CREATE TABLE `gestion_stock_distribuidora`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(20) NOT NULL,
  `contraseña` VARCHAR(20) NOT NULL,
  `nombreUsuario` VARCHAR(50) NOT NULL,
  `apellidoUsuario` VARCHAR(50) NOT NULL,
  `idRolUsuario` INT NOT NULL,
  `usuarioActivo` TINYINT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_usuario_roles_usuario` (`idRolUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_roles_usuario` FOREIGN KEY (`idRolUsuario`) REFERENCES `roles_usuario` (`idRolUsuario`));
  
CREATE TABLE `gestion_stock_distribuidora`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombreCliente` VARCHAR(50) NOT NULL,
  `apellidoCliente` VARCHAR(50) NOT NULL,
  `dni` VARCHAR(8) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `idCliente_UNIQUE` (`idCliente` ASC) VISIBLE);

CREATE TABLE `gestion_stock_distribuidora`.`proveedor` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `nombreProveedor` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idProveedor`),
  UNIQUE INDEX `idProveedor_UNIQUE` (`idProveedor` ASC) VISIBLE);
  
  CREATE TABLE `gestion_stock_distribuidora`.`producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(254) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `stockMinimo` INT NOT NULL,
  `stockMaximo` INT NOT NULL,
  `stockActual` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  UNIQUE INDEX `idProducto_UNIQUE` (`idProducto` ASC) VISIBLE);

CREATE TABLE `gestion_stock_distribuidora`.`pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `idProveedor` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  UNIQUE INDEX `idPedido_UNIQUE` (`idPedido` ASC) VISIBLE,
  INDEX `fk_pedido_proveedor` (`idProveedor` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`));
  
CREATE TABLE `gestion_stock_distribuidora`.`detalle_pedido` (
  `idDetallePedido` INT NOT NULL AUTO_INCREMENT,
  `idPedido` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precioUnitario` DECIMAL(10,2) NOT NULL,
  `precioTotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idDetallePedido`, `idPedido`),
  INDEX `fk_detalle_pedido_pedido` (`idPedido` ASC) VISIBLE,
  INDEX `fk_detalle_pedido_producto` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_pedido_pedido` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`),
  CONSTRAINT `fk_detalle_pedido_producto` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`));
  
CREATE TABLE `gestion_stock_distribuidora`.`historial` (
  `idHistorial` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idProducto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `tipoMovimiento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idHistorial`),
  UNIQUE INDEX `idHistorial_UNIQUE` (`idHistorial` ASC) VISIBLE,
  INDEX `fk_historial_producto` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_historial_producto` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`));
    
CREATE TABLE `gestion_stock_distribuidora`.`estado_venta` (
  `idEstadoVenta` INT NOT NULL AUTO_INCREMENT,
  `nombreEstado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstadoVenta`),
  UNIQUE INDEX `idEstadoVenta_UNIQUE` (`idEstadoVenta` ASC) VISIBLE);
    
CREATE TABLE `gestion_stock_distribuidora`.`venta` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `idEstadoVenta` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idVenta`),
  UNIQUE INDEX `idVenta_UNIQUE` (`idVenta` ASC) VISIBLE,
  INDEX `fk_venta_estado_venta` (`idEstadoVenta` ASC) VISIBLE,
  INDEX `fk_venta_usuario` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_venta_cliente` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`),
  CONSTRAINT `fk_venta_estado_venta` FOREIGN KEY (`idEstadoVenta`) REFERENCES `estado_venta` (`idEstadoVenta`),
  CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`));
    
CREATE TABLE`gestion_stock_distribuidora`.`detalle_venta` (
  `idDetalleVenta` INT NOT NULL AUTO_INCREMENT,
  `idVenta` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precioUnitario` DECIMAL(10,2) NOT NULL,
  `precioTotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idDetalleVenta`, `idVenta`),
  INDEX `fk_detalle_venta_venta` (`idVenta` ASC) VISIBLE,
  INDEX `fk_detalle_venta_producto` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_venta_producto` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`),
  CONSTRAINT `fk_detalle_venta_venta` FOREIGN KEY (`idVenta`) REFERENCES `venta` (`idVenta`));