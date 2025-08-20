
create table Productos (
idProducto int identity (1,1) not null PRIMARY KEY,
nombre varchar (30),
precio money ,
stock int ,
categoria varchar(30),
idProveedor int,
CONSTRAINT FK_Productos_idProveedor FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
);


create table Proveedor (
idProveedor int not null PRIMARY KEY,
nombre varchar (30),
contacto numeric (10),
dirección varchar (50),);

create table Empleado (
idEmpleado int identity (1,1) not null PRIMARY KEY,
nombre varchar(15),
cargo varchar(15),
usuario varchar(15),
contraseña numeric (5));

create table Venta (
idVenta int not null PRIMARY KEY,
fecha date);
