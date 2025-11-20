DROP DATABASE IF EXISTS koaj_san_pedro;
CREATE DATABASE koaj_san_pedro;
USE koaj_san_pedro;


-- TABLAS PRINCIPALES

CREATE TABLE Categorias (
    IDCategoria INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Tallas (
    IDTalla INT PRIMARY KEY AUTO_INCREMENT,
    Talla VARCHAR(10) NOT NULL
);

CREATE TABLE Colores (
    IDColor INT PRIMARY KEY AUTO_INCREMENT,
    Color VARCHAR(30) NOT NULL
);

CREATE TABLE Proveedores (
    IDProveedor INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Telefono VARCHAR(15),
    Ciudad VARCHAR(50)
);

CREATE TABLE Productos (
    IDProducto INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Precio DECIMAL(10,2),
    IDCategoria INT,
    IDProveedor INT,
    FOREIGN KEY (IDCategoria) REFERENCES Categorias(IDCategoria),
    FOREIGN KEY (IDProveedor) REFERENCES Proveedores(IDProveedor)
);

CREATE TABLE Sucursales (
    IDSucursal INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Ciudad VARCHAR(50),
    Direccion VARCHAR(150)
);

CREATE TABLE Stock_Tienda (
    IDStock INT PRIMARY KEY AUTO_INCREMENT,
    IDSucursal INT,
    IDProducto INT,
    IDTalla INT,
    IDColor INT,
    Cantidad INT,
    FOREIGN KEY (IDSucursal) REFERENCES Sucursales(IDSucursal),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto),
    FOREIGN KEY (IDTalla) REFERENCES Tallas(IDTalla),
    FOREIGN KEY (IDColor) REFERENCES Colores(IDColor)
);

CREATE TABLE Empleados (
    IDEmpleado INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Cargo VARCHAR(50),
    IDSucursal INT,
    FOREIGN KEY (IDSucursal) REFERENCES Sucursales(IDSucursal)
);

CREATE TABLE Clientes (
    IDCliente INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Telefono VARCHAR(15),
    Ciudad VARCHAR(50)
);

 
CREATE TABLE Ventas (
    IDVenta INT PRIMARY KEY AUTO_INCREMENT,
    IDCliente INT,
    IDEmpleado INT,
    Fecha DATETIME,
    Total DECIMAL(10,2),
    FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente),
    FOREIGN KEY (IDEmpleado) REFERENCES Empleados(IDEmpleado)
);

CREATE TABLE DetalleVenta (
    IDDetalle INT PRIMARY KEY AUTO_INCREMENT,
    IDVenta INT,
    IDProducto INT,
    Cantidad INT,
    PrecioUnit DECIMAL(10,2),
    FOREIGN KEY (IDVenta) REFERENCES Ventas(IDVenta),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
);


-- TABLAS DE SEGURIDAD


CREATE TABLE Seg_Usuarios (
    IDUsuario INT PRIMARY KEY AUTO_INCREMENT,
    Usuario VARCHAR(50),
    Clave VARCHAR(200)
);

CREATE TABLE Seg_Roles (
    IDRol INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50)
);

CREATE TABLE Seg_Permisos (
    IDPermiso INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50)
);

CREATE TABLE Seg_UsuarioRol (
    IDUsuario INT,
    IDRol INT,
    PRIMARY KEY (IDUsuario, IDRol),
    FOREIGN KEY (IDUsuario) REFERENCES Seg_Usuarios(IDUsuario),
    FOREIGN KEY (IDRol) REFERENCES Seg_Roles(IDRol)
);

CREATE TABLE Seg_RolPermiso (
    IDRol INT,
    IDPermiso INT,
    PRIMARY KEY (IDRol, IDPermiso),
    FOREIGN KEY (IDRol) REFERENCES Seg_Roles(IDRol),
    FOREIGN KEY (IDPermiso) REFERENCES Seg_Permisos(IDPermiso)
);

CREATE TABLE Seg_Sesiones (
    IDSesion INT PRIMARY KEY AUTO_INCREMENT,
    IDUsuario INT,
    FechaInicio DATETIME,
    FechaFin DATETIME,
    FOREIGN KEY (IDUsuario) REFERENCES Seg_Usuarios(IDUsuario)
);

CREATE TABLE Seg_LogEventos (
    IDEvento INT PRIMARY KEY AUTO_INCREMENT,
    IDUsuario INT,
    Evento VARCHAR(200),
    Fecha DATETIME,
    FOREIGN KEY (IDUsuario) REFERENCES Seg_Usuarios(IDUsuario)
);

CREATE TABLE Seg_IntentosFallidos (
    IDIntento INT PRIMARY KEY AUTO_INCREMENT,
    IDUsuario INT,
    Fecha DATETIME,
    FOREIGN KEY (IDUsuario) REFERENCES Seg_Usuarios(IDUsuario)
);


-- INSERTS DE CATEGORÍAS


INSERT INTO Categorias (Nombre) VALUES
('Camisas'), ('Pantalones'), ('Chaquetas'), ('Accesorios'), ('Calzado'),
('Deportivo'), ('Formal'), ('Casual'), ('Jeans'), ('Ropa Interior');


-- INSERTS DE TALLAS


INSERT INTO Tallas (Talla) VALUES
('XS'),('S'),('M'),('L'),('XL'),('XXL'),('28'),('30'),('32'),('34');


-- INSERTS DE COLORES


INSERT INTO Colores (Color) VALUES
('Negro'),('Blanco'),('Azul'),('Rojo'),('Verde'),
('Beige'),('Gris'),('Amarillo'),('Café'),('Rosado');


-- INSERTS DE PROVEEDORES


INSERT INTO Proveedores (Nombre, Telefono, Ciudad) VALUES
('Textiles Bogotá','3001234567','Bogotá'),
('Moda Import','3129876543','Medellín'),
('Fabrica Jeans','3105557788','Cali'),
('Fashion World','3112223344','Barranquilla'),
('Distribuciones Norte','3201112233','Bucaramanga');


-- INSERTS DE PRODUCTOS


INSERT INTO Productos (Nombre, Precio, IDCategoria, IDProveedor) VALUES
('Camisa manga larga', 95000, 1, 1),
('Camisa casual', 85000, 1, 2),
('Jean slim fit', 120000, 9, 3),
('Chaqueta cuero', 250000, 3, 4),
('Gorra negra', 45000, 4, 2),
('Zapatos deportivos', 180000, 5, 5),
('Camiseta básica', 55000, 1, 1),
('Pantalón formal', 130000, 2, 4),
('Sudadera deportiva', 110000, 6, 5),
('Medias tobilleras', 15000, 10, 2);


-- INSERTS DE SUCURSALES


INSERT INTO Sucursales (Nombre, Ciudad, Direccion) VALUES
('Koaj San Pedro Plaza','Neiva','Cra 8 #38-40'),
('Koaj Gran Plaza','Neiva','Cl 12 #32-10'),
('Koaj Unicentro','Bogotá','Av 15 #124-30');


-- INSERTS DE STOCK POR TIENDA


INSERT INTO Stock_Tienda (IDSucursal, IDProducto, IDTalla, IDColor, Cantidad) VALUES
(1,1,3,1,20),(1,2,4,2,15),(1,3,7,3,25),(1,4,5,1,10),(1,5,3,2,30),
(2,1,3,1,18),(2,3,8,3,20),(2,6,5,4,12),(3,2,4,2,22),(3,9,6,5,17);


-- INSERTS DE EMPLEADOS


INSERT INTO Empleados (Nombre, Cargo, IDSucursal) VALUES
('Laura Pérez','Cajera',1),
('Juan Gómez','Vendedor',1),
('Ana Ruiz','Administradora',2),
('Carlos Peña','Bodega',3),
('Sofía Díaz','Vendedora',3);


-- INSERTS DE CLIENTES


INSERT INTO Clientes (Nombre, Telefono, Ciudad) VALUES
('Pedro Martínez','3159876543','Neiva'),
('Camila Torres','3112223344','Neiva'),
('Santiago Rojas','3001122334','Bogotá'),
('Luisa Moreno','3205557788','Cali'),
('Andrés Beltrán','3169871122','Neiva');


-- INSERTS DE VENTAS

INSERT INTO Ventas (IDCliente, IDEmpleado, Fecha, Total) VALUES
(1,1,'2025-01-10 10:00:00',180000),
(2,2,'2025-01-11 14:30:00',250000),
(3,5,'2025-01-12 16:00:00',120000);


-- INSERTS DE DETALLE DE VENTAS


INSERT INTO DetalleVenta (IDVenta, IDProducto, Cantidad, PrecioUnit) VALUES
(1,1,1,95000),(1,7,1,85000),
(2,4,1,250000),
(3,3,1,120000);


-- INSERTS DE SEGURIDAD


-- Usuarios
INSERT INTO Seg_Usuarios (Usuario, Clave) VALUES
('admin','123'),
('empleado1','abc'),
('empleado2','xyz');

-- Roles
INSERT INTO Seg_Roles (Nombre) VALUES
('Administrador'),
('Vendedor'),
('Gerente');

-- Permisos
INSERT INTO Seg_Permisos (Nombre) VALUES
('Crear'),('Editar'),('Eliminar'),('Ver'),('Reportes');

-- Usuario – Rol
INSERT INTO Seg_UsuarioRol VALUES
(1,1),
(2,2),
(3,3);

-- Rol – Permiso
INSERT INTO Seg_RolPermiso VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),
(2,4),
(3,5);

-- Sesiones
INSERT INTO Seg_Sesiones (IDUsuario, FechaInicio, FechaFin) VALUES
(1,'2025-01-10 09:00:00','2025-01-10 17:00:00'),
(2,'2025-01-11 10:00:00','2025-01-11 18:00:00');

-- Log de eventos
INSERT INTO Seg_LogEventos (IDUsuario, Evento, Fecha) VALUES
(1,'Inicio de sesión','2025-01-10 09:00:00'),
(2,'Cierre de sesión','2025-01-11 18:00:00');

-- Intentos fallidos
INSERT INTO Seg_IntentosFallidos (IDUsuario, Fecha) VALUES
(1,'2025-01-05 08:10:00'),
(2,'2025-01-07 12:20:00'),
(3,'2025-01-09 14:00:00');

DELIMITER $$

CREATE PROCEDURE RegistrarVentaCompleta (
    IN p_IDCliente INT,
    IN p_IDEmpleado INT,
    IN p_IDProducto INT,
    IN p_Cantidad INT
)
BEGIN
    DECLARE v_PrecioUnit INT;
    DECLARE v_Total INT;
    DECLARE v_IDVenta INT;

    -- 1. Obtener precio unitario
    SELECT Precio INTO v_PrecioUnit
    FROM Productos
    WHERE IDProducto = p_IDProducto;

    -- 2. Calcular total
    SET v_Total = v_PrecioUnit * p_Cantidad;

    -- 3. Insertar venta (cabecera)
    INSERT INTO Ventas (IDCliente, IDEmpleado, Fecha, Total)
    VALUES (p_IDCliente, p_IDEmpleado, NOW(), 0);

    -- 4. Guardar ID recién insertado
    SET v_IDVenta = LAST_INSERT_ID();

    -- 5. Insertar el detalle
    INSERT INTO DetalleVenta (IDVenta, IDProducto, Cantidad, PrecioUnit)
    VALUES (v_IDVenta, p_IDProducto, p_Cantidad, v_PrecioUnit);

    -- 6. Actualizar total final
    UPDATE Ventas
    SET Total = v_Total
    WHERE IDVenta = v_IDVenta;

END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE BuscarProductos (
    IN p_Categoria VARCHAR(50),
    IN p_Color VARCHAR(50),
    IN p_PrecioMin INT,
    IN p_PrecioMax INT
)
BEGIN
    SELECT p.Nombre AS Producto, p.Precio, 
           c.Nombre AS Categoria, col.Color
    FROM Productos p
    JOIN Categorias c ON p.IDCategoria = c.IDCategoria
    JOIN Stock_Tienda st ON p.IDProducto = st.IDProducto
    JOIN Colores col ON st.IDColor = col.IDColor
    WHERE c.Nombre LIKE CONCAT('%', p_Categoria, '%')
      AND col.Color LIKE CONCAT('%', p_Color, '%')
      AND p.Precio BETWEEN p_PrecioMin AND p_PrecioMax
    GROUP BY p.IDProducto, col.IDColor;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION CalcularTotalVenta (
    p_IDProducto INT,
    p_Cantidad INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_PrecioUnit INT;
    DECLARE v_Total INT;

    -- Obtener precio del producto
    SELECT Precio INTO v_PrecioUnit
    FROM Productos
    WHERE IDProducto = p_IDProducto;

    -- Calcular total
    SET v_Total = v_PrecioUnit * p_Cantidad;

    RETURN v_Total;
END $$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION CalcularPrecioUnitario (
    p_IDProducto INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_PrecioUnit INT;

    SELECT Precio INTO v_PrecioUnit
    FROM Productos
    WHERE IDProducto = p_IDProducto;

    RETURN v_PrecioUnit;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER ActualizarStockVenta
AFTER INSERT ON DetalleVenta
FOR EACH ROW
BEGIN
    UPDATE Stock_Tienda
    SET Cantidad = Cantidad - NEW.Cantidad
    WHERE IDProducto = NEW.IDProducto
      AND IDSucursal = 1;
END $$

DELIMITER ;

















