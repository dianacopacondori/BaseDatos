
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

insert into Cliente values 
('Samuel Ramirez', 29638765, 935253886, 'Av. Los Olivos 123'),
('Ester Paredes',28656438, 947599035, 'Jr. Las Flores 456'),
('Carlos Mendoza', 36987656, 963422178, 'Calle Lima'),
('Ana Torres', 37625399, 932176389, 'Av.Arequipa 351'),
('Jorge Salazar', 47327865, 936599678, 'Jr. Cusco 624'),
('Maria Quispe', 28673657, 905134055, 'Calle Sol 386'),
('Pedro Gutierrez', 27597689, 915607566, 'Av. San Martin 145'),
('Sofia Chavez', 45237865, 970053189,  'Jr. Libertad 852');

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
('Bruno', 'cajero', 'cjBruno', 36788);

select cargo, usuario from Empleado;

INSERT INTO Proveedor ( idProveedor,nombre, contacto, dirección) VALUES
(1, 'Distribuidora Sol', 9876543210, 'Av. Los Olivos 123'),
(2,'Importaciones Andes', 9123456789, 'Jr. Las Flores 456'),
(3,'Tech Global SAC', 9567890123, 'Calle Lima 789'),
(4,'AgroPerú S.A.', 9345678901, 'Av. Arequipa 351'),
(5, 'Comercial Quispe', 9456789012, 'Jr. Cusco 624');
select * from Proveedor;
INSERT INTO Productos (nombre, precio, stock, categoria, idProveedor) VALUES
('Laptop Lenovo', 2500.00, 15, 'Electrónica', 3),
('Fertilizante Orgánico', 120.50, 40, 'Agricultura', 4),
('Helado de Fresa', 5.90, 100, 'Alimentos', 1),
('Cable HDMI', 18.75, 60, 'Electrónica', 3),
('Arroz Integral', 3.50, 200, 'Alimentos', 2),
('Mouse Inalámbrico', 45.00, 35, 'Electrónica', 3),
('Semillas de Maíz', 25.00, 80, 'Agricultura', 4),
('Galletas Quinoa', 6.20, 150, 'Alimentos', 5);
select * from Productos;
INSERT INTO Venta (fecha, idCliente, idEmpleado) VALUES
('2025-08-01', 1, 4),  -- Samuel Ramirez atendido por Mateo
('2025-08-02', 3, 8),  -- Carlos Mendoza atendido por Bruno
('2025-08-03', 5, 2),  -- Jorge Salazar atendido por Diego
('2025-08-04', 2, 1),  -- Ester Paredes atendida por Camila
('2025-08-05', 6, 7),  -- Maria Quispe atendida por Javier
('2025-08-06', 4, 5),  -- Ana Torres atendida por Sofia
('2025-08-07', 7, 3),  -- Pedro Gutierrez atendido por Lucia
('2025-08-08', 8, 6);  -- Sofia Chavez atendida por Valeria
select * from Venta;

INSERT INTO DetalleVenta (idVenta, cantidad, precioUnitario, subtotal)
VALUES 
(1, 2, 25.50, 51.00),     -- Venta 1, Producto 101 (2 unidades a S/25.50)
(1, 1, 40.00, 40.00),     -- Venta 1, Producto 102 (1 unidad a S/40.00)
(2, 3, 15.00, 45.00),     -- Venta 2, Producto 103 (3 unidades a S/15.00)
(3, 1, 25.50, 25.50),     -- Venta 3, Producto 101 (1 unidad a S/25.50)
(3, 5, 10.00, 50.00);     -- Venta 3, Producto 104 (5 unidades a S/10.00)

select * from DetalleVenta;