
-- Base del CARRITO CAFETERO
-- Log Dog
-- 10/03/2025
use master
go
if DB_ID('SistemaVentas') is not null
drop database SistemaVentas
go
create database SistemaVentas
go
use SistemaVentas
go

-- Tabla Personal
if OBJECT_ID('Personal') is not null
drop table Personal
go
CREATE TABLE Personal (
    idPersonal varchar(50) primary key,
    cargoE varchar(50),
    nombreP varchar(100)
);
go

-- Tabla Proveedor
if OBJECT_ID('Proveedor') is not null
drop table Proveedor
go
CREATE TABLE Proveedor (
    idProveedor varchar(50) primary key,
    nombreP varchar(100),
    tipoP varchar(50)
);
go

-- Tabla Cliente
if OBJECT_ID('Cliente') is not null
drop table Cliente
go
CREATE TABLE Cliente (
    idClienteC varchar(50) primary key,
    nombreC varchar(100),
    telefonoC varchar(20)
);
go

-- Tabla Producto (CORREGIDA: se eliminó la relación con Personal)
if OBJECT_ID('Producto') is not null
drop table Producto
go
CREATE TABLE Producto (
    idProductoP varchar(50) primary key,
    nombreP varchar(100),
    tipoP varchar(50),
    precioP numeric(10,2),
    stockP int,
    idProveedor varchar(50),
    foreign key (idProveedor) references Proveedor(idProveedor)
    -- Se eliminó: idPersonalCompra y su foreign key
);
go

-- Tabla Boleta
if OBJECT_ID('Boleta') is not null
drop table Boleta
go
CREATE TABLE Boleta (
    IdB varchar(50) primary key,
    idEmpleadoB varchar(50) not null,
    idClienteB varchar(50) not null,
    FechaB date,
    HoraB time,
    foreign key (idEmpleadoB) references Personal(idPersonal),
    foreign key (idClienteB) references Cliente(idClienteC)
);
go

-- Tabla DetalleBoleta
if OBJECT_ID('DetalleBoleta') is not null
drop table DetalleBoleta
go
CREATE TABLE DetalleBoleta (
    idDetalleDB varchar(50) primary key,
    idBoletaDB varchar(50) not null,
    idProductoDB varchar(50) not null,
    cantidadDB int,
    foreign key (idBoletaDB) references Boleta(IdB),
    foreign key (idProductoDB) references Producto(idProductoP)
);
go
