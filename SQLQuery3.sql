
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

