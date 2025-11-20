
create table Proveedor (
idProveedor int not null PRIMARY KEY,
nombre varchar (30),
contacto numeric (10),
dirección varchar (50),);

alter table Proveedor alter column contacto char (10);

create table Productos (
idProducto int identity (1,1) not null PRIMARY KEY,
nombre varchar (30),
precio money ,
stock int ,
categoria varchar(30),
idProveedor int,
CONSTRAINT FK_Productos_idProveedor FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
);

create table Empleado (
idEmpleado int identity (1,1) not null PRIMARY KEY,
nombre varchar(15),
cargo varchar(15),
usuario varchar(15),
contraseña numeric (5));


create table Cliente (
idCliente int identity (1,1) not null PRIMARY KEY,
nombre varchar (30),
dni numeric (8),
telefono numeric (10),
dirección varchar (30));

Alter table Cliente alter column dni char (8);
alter table Cliente alter column telefono char (10);

create table Venta (
idVenta int identity (1,1) not null PRIMARY KEY,
fecha date,
idCliente int,
idEmpleado int,
CONSTRAINT FK_Venta_idCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
CONSTRAINT FK_Venta_idEmpleado FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado));

create table DetalleVenta (
idDetalle int identity (1,1) not null PRIMARY KEY,
idVenta int,
idProducto int,
cantidad int,
precioUnitario money,
subtotal money,
CONSTRAINT FK_DetalleVenta_idVenta FOREIGN KEY (idVenta) REFERENCES Venta(idVenta),
CONSTRAINT FK_DetalleVenta_idProducto FOREIGN KEY (idProducto) REFERENCES Productos(idProducto));

--TRIGGER
CREATE TRIGGER trg_ValidarStock
ON DetalleVenta
AFTER INSERT
AS
BEGIN
    -- Si algún producto quedaría con stock negativo, cancelar
    IF EXISTS (
        SELECT 1
        FROM Productos p
        INNER JOIN inserted i ON p.idProducto = i.idProducto
        WHERE p.stock - i.cantidad < 0
    )
    BEGIN
        RAISERROR ('Stock insuficiente para realizar la venta.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Si todo bien, descontamos el stock
    UPDATE p
    SET p.stock = p.stock - i.cantidad
    FROM Productos p
    INNER JOIN inserted i ON p.idProducto = i.idProducto;
END;
GO


insert into Cliente values 
('Samuel Ramirez', 29638765, 935253886, 'Av. Los Olivos 123'),
('Ester Paredes',28656438, 947599035, 'Jr. Las Flores 456'),
('Carlos Mendoza', 36987656, 963422178, 'Calle Lima'),
('Ana Torres', 37625399, 932176389, 'Av.Arequipa 351'),
('Jorge Salazar', 47327865, 936599678, 'Jr. Cusco 624'),
('Maria Quispe', 28673657, 905134055, 'Calle Sol 386'),
('Pedro Gutierrez', 27597689, 915607566, 'Av. San Martin 145'),
('Sofia Chavez', 45237865, 970053189,  'Jr. Libertad 852'),
('Lucia Fernandez', 29876543, 987654321, 'Av. Los Robles 234'),
('Miguel Herrera', 31234567, 976543210, 'Jr. Amazonas 789'),
('Paola Rios', 35678901, 954321876, 'Calle Puno 112'),
('Andres Castillo', 42345678, 944567823, 'Av. La Marina 560'),
('Gabriela Torres', 33456789, 967452310, 'Jr. Arequipa 908'),
('Fernando Lopez', 44567890, 922345678, 'Calle Trujillo 129'),
('Valeria Nuñez', 37890123, 933456712, 'Av. Progreso 745'),
('Ricardo Aguilar', 35671234, 955678123, 'Jr. Moquegua 653'),
('Daniela Suarez', 40123456, 946712589, 'Calle Tacna 312'),
('Hugo Vargas', 38901234, 938456721, 'Av. Independencia 1005');

select * from Cliente
ORDER BY nombre ASC;


select * from Cliente where nombre = 'Carlos Mendoza';

insert into Empleado values
('Camila', 'gerente', 'grCamila', 05382),
('Diego', 'repositor', 'rpDiego', 56382),
('Lucia', 'analista', 'anLucia', 62980),
('Mateo', 'vendedor', 'vdMateo', 74900),
('Sofia', 'supervisor', 'spSofia', 01563),
('Valeria','aistente', 'asValeria', 67493),
('Javier', 'logistica', 'lgJavier', 64830),
('Bruno', 'cajero', 'cjBruno', 36788),
('Mariana', 'secretaria', 'scMariana', 48291),
('Rodrigo', 'vendedor', 'vdRodrigo', 52987),
('Angela', 'analista', 'anAngela', 63820),
('Sebastian', 'repositor', 'rpSebastian', 74102),
('Claudia', 'supervisor', 'spClaudia', 38562),
('Felipe', 'logistica', 'lgFelipe', 59387),
('Carolina', 'gerente', 'grCarolina', 81236),
('Alonso', 'cajero', 'cjAlonso', 46739),
('Natalia', 'asistente', 'asNatalia', 52940),
('Gustavo', 'vendedor', 'vdGustavo', 69831);


select cargo, usuario from Empleado;

INSERT INTO Proveedor ( idProveedor,nombre, contacto, dirección) VALUES
(1, 'Distribuidora Sol', 9876543210, 'Av. Los Olivos 123'),
(2,'Importaciones Andes', 9123456789, 'Jr. Las Flores 456'),
(3,'Tech Global SAC', 9567890123, 'Calle Lima 789'),
(4,'AgroPerú S.A.', 9345678901, 'Av. Arequipa 351'),
(5, 'Comercial Quispe', 9456789012, 'Jr. Cusco 624'),
(6, 'Industrias Rivera', 987120345, 'Av. San Martín 102'),
(7, 'MegaTech Import', 934562781, 'Calle Progreso 456'),
(8, 'Agroinsumos del Sur', 956732198, 'Jr. Amazonas 321'),
(9, 'Textiles Huamán', 945678432, 'Av. La Marina 980'),
(10, 'ConstruMarket SAC', 912345987, 'Calle Industrial 45'),
(11, 'Distribuciones López', 931245678, 'Av. Independencia 765'),
(12, 'Alimentos Andinos', 987654120, 'Jr. Moquegua 652'),
(13, 'Global Farma', 954327890, 'Av. República 410'),
(14, 'Ferretería Ramos', 963214578, 'Calle Comercio 233'),
(15, 'Electro Hogar SAC', 976543210, 'Av. Grau 150');


select * from Proveedor;

INSERT INTO Productos (nombre, precio, stock, categoria, idProveedor) VALUES
('Laptop Lenovo', 2500.00, 15, 'Electrónica', 3),
('Fertilizante Orgánico', 120.50, 40, 'Agricultura', 4),
('Helado de Fresa', 5.90, 100, 'Alimentos', 1),
('Cable HDMI', 18.75, 60, 'Electrónica', 3),
('Arroz Integral', 3.50, 200, 'Alimentos', 2),
('Mouse Inalámbrico', 45.00, 35, 'Electrónica', 3),
('Semillas de Maíz', 25.00, 80, 'Agricultura', 4),
('Galletas Quinoa', 6.20, 150, 'Alimentos', 5),
('Smartphone Samsung', 1850.00, 20, 'Electrónica', 3),
('Televisor LG 50"', 2800.00, 10, 'Electrónica', 3),
('Harina de Trigo', 2.80, 300, 'Alimentos', 2),
('Aceite de Girasol', 8.50, 120, 'Alimentos', 1),
('Yogurt Natural', 4.20, 90, 'Alimentos', 5),
('Fertilizante Químico', 150.00, 50, 'Agricultura', 4),
('Herramienta Eléctrica', 320.00, 25, 'Construcción', 10),
('Cemento Portland', 28.00, 400, 'Construcción', 10),
('Camisa de Algodón', 75.00, 60, 'Textiles', 9),
('Zapatos de Cuero', 180.00, 45, 'Textiles', 9),
('Medicamento Genérico A', 35.00, 200, 'Farmacia', 13),
('Suplemento Vitamínico', 55.00, 150, 'Farmacia', 13),
('Taladro Industrial', 450.00, 18, 'Ferretería', 14),
('Juego de Destornilladores', 60.00, 70, 'Ferretería', 14),
('Refrigeradora Mabe', 2100.00, 12, 'Electrodomésticos', 15);


select * from Productos;

INSERT INTO Venta (fecha, idCliente, idEmpleado) VALUES
('2025-08-01', 1, 4),  -- Samuel Ramirez atendido por Mateo
('2025-08-02', 3, 8),  -- Carlos Mendoza atendido por Bruno
('2025-08-03', 5, 2),  -- Jorge Salazar atendido por Diego
('2025-08-04', 2, 1),  -- Ester Paredes atendida por Camila
('2025-08-05', 6, 7),  -- Maria Quispe atendida por Javier
('2025-08-06', 4, 5),  -- Ana Torres atendida por Sofia
('2025-08-07', 7, 3),  -- Pedro Gutierrez atendido por Lucia
('2025-08-08', 8, 6),  -- Sofia Chavez atendida por Valeria
('2025-08-09', 10, 9),  -- Hugo Vargas atendido por Natalia
('2025-08-10', 9, 10),  -- Daniela Suarez atendida por Gustavo
('2025-08-11', 12, 11), -- Alimentos Andinos compra registrada por Mariana
('2025-08-12', 11, 2),  -- Distribuciones López atendido por Diego
('2025-08-13', 14, 8),  -- Ferretería Ramos atendido por Bruno
('2025-08-14', 13, 7),  -- Global Farma atendido por Javier
('2025-08-15', 15, 6),  -- Electro Hogar SAC atendido por Valeria
('2025-08-16', 5, 4),   -- Jorge Salazar atendido nuevamente por Mateo
('2025-08-17', 2, 3),   -- Ester Paredes atendida por Lucia
('2025-08-18', 8, 5);   -- Sofia Chavez atendida por Sofia

select * from Venta;

INSERT INTO DetalleVenta (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES 
(1, 3,  2, 25.50, 51.00),     -- Venta 1, Producto 101 (2 unidades a S/25.50)
(1, 1,  1, 40.00, 40.00),     -- Venta 1, Producto 102 (1 unidad a S/40.00)
(2, 7 , 3, 15.00, 45.00),     -- Venta 2, Producto 103 (3 unidades a S/15.00)
(3, 5 , 1, 25.50, 25.50),     -- Venta 3, Producto 101 (1 unidad a S/25.50)
(3, 8,  5, 10.00, 50.00),     -- Venta 3, Producto 104 (5 unidades a S/10.00)
(4, 2,  2, 120.50, 241.00),   -- Venta 4: Fertilizante Orgánico
(4, 5,  4, 3.50, 14.00),      -- Venta 4: Arroz Integral
(5, 6,  1, 45.00, 45.00),     -- Venta 5: Mouse Inalámbrico
(6, 4,  2, 18.75, 37.50),     -- Venta 6: Cable HDMI
(6, 7,  10, 25.00, 250.00),   -- Venta 6: Semillas de Maíz
(7, 1,  1, 2500.00, 2500.00), -- Venta 7: Laptop Lenovo
(8, 8,  3, 6.20, 18.60),      -- Venta 8: Galletas Quinoa
(9, 10, 2, 180.00, 360.00),   -- Venta 9: Zapatos de Cuero
(10, 12, 5, 55.00, 275.00),   -- Venta 10: Suplemento Vitamínico
(11, 15, 1, 2100.00, 2100.00);-- Venta 11: Refrigeradora Mabe


select * from DetalleVenta;

SELECT 
    V.fecha,
    E.nombre AS nombreEmpleado,
    E.cargo
FROM Venta V
INNER JOIN Empleado E ON V.idEmpleado = E.idEmpleado;

SELECT 
    V.fecha,
    C.nombre AS nombreCliente,
    E.nombre AS nombreEmpleado,
    E.cargo
FROM Venta V
INNER JOIN Cliente C ON V.idCliente = C.idCliente
INNER JOIN Empleado E ON V.idEmpleado = E.idEmpleado;

SELECT * FROM Venta 
WHERE fecha is null;

SELECT * FROM Cliente 
WHERE nombre LIKE'A%';

SELECT * FROM Productos
WHERE idProveedor IN ( 1, 3, 5);

SELECT * FROM DetalleVenta 
WHERE subtotal BETWEEN 30 AND 100; 

SELECT * FROM DetalleVenta 
WHERE subtotal > 100 OR subtotal is null ; 

SELECT idEmpleado, COUNT(*) AS ventasEmpleados
FROM Venta
GROUP BY idEmpleado;

SELECT categoria, AVG(stock) AS promediostock
FROM Productos
GROUP BY categoria;

SELECT categoria, AVG(precio) AS precioPromedio
FROM Productos
GROUP BY categoria
HAVING AVG(precio) > 100;

SELECT nombre,
       stock,
       CASE 
         WHEN stock <= 10 THEN 'Stock Crítico'
         ELSE 'Stock Suficiente'
       END AS estadoStock
FROM Productos;

CREATE PROCEDURE sp_RegistrarVenta
    @idCliente INT,
    @idEmpleado INT,
    @fecha DATE,
    @idProducto INT,
    @cantidad INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar la venta
        INSERT INTO Venta (fecha, idCliente, idEmpleado)
        VALUES (@fecha, @idCliente, @idEmpleado);

        -- Obtener el ID de la venta recién creada
        DECLARE @idVenta INT = SCOPE_IDENTITY();

        -- 2. Obtener el precio actual del producto
        DECLARE @precioUnitario DECIMAL(10,2);

        SELECT @precioUnitario = precio
        FROM Productos
        WHERE idProducto = @idProducto;

        -- 3. Insertar detalle de venta
        INSERT INTO DetalleVenta (idVenta, idProducto, cantidad, precioUnitario, subtotal)
        VALUES (@idVenta, @idProducto, @cantidad, @precioUnitario, @cantidad * @precioUnitario);

        -- 4. Actualizar stock
        UPDATE Productos
        SET stock = stock - @cantidad
        WHERE idProducto = @idProducto;

        -- Confirmar
        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT 'Error en la transacción: ' + ERROR_MESSAGE();
    END CATCH
END;

select * from Venta;
select * from DetalleVenta;

EXEC sp_RegistrarVenta 
    @idCliente = 3,
    @idEmpleado = 8,
    @fecha = '2025-09-30',
    @idProducto = 2,
    @cantidad = 3;
