
create table Proveedor (
idProveedor int not null PRIMARY KEY,
nombre varchar (30),
contacto numeric (10),
dirección varchar (50),);

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

