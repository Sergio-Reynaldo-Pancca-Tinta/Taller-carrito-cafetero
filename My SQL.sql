BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DetalleBoleta CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Boleta CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Producto CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Cliente CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Proveedor CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Personal CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


-- Crear tabla Personal
CREATE TABLE Personal (
    idPersonal VARCHAR2(50) PRIMARY KEY,
    cargoE VARCHAR2(50),
    nombreP VARCHAR2(100)
);
/


-- Crear tabla Proveedor
CREATE TABLE Proveedor (
    idProveedor VARCHAR2(50) PRIMARY KEY,
    nombreP VARCHAR2(100),
    tipoP VARCHAR2(50)
);
/


-- Crear tabla Cliente
CREATE TABLE Cliente (
    idClienteC VARCHAR2(50) PRIMARY KEY,
    nombreC VARCHAR2(100),
    telefonoC VARCHAR2(20)
);
/


-- Crear tabla Producto (CORREGIDA: se eliminó la relación con Personal)
CREATE TABLE Producto (
    idProductoP VARCHAR2(50) PRIMARY KEY,
    nombreP VARCHAR2(100),
    tipoP VARCHAR2(50),
    precioP NUMBER(10,2),
    stockP NUMBER(10),
    idProveedor VARCHAR2(50),
    CONSTRAINT fk_producto_proveedor FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
    -- Se eliminó: idPersonalCompra y su constraint fk_producto_personal
);
/


-- Crear tabla Boleta
CREATE TABLE Boleta (
    IdB VARCHAR2(50) PRIMARY KEY,
    idEmpleadoB VARCHAR2(50) NOT NULL,
    idClienteB VARCHAR2(50) NOT NULL,
    FechaB DATE,
    HoraB VARCHAR2(8), -- Oracle no tiene tipo TIME, usamos VARCHAR2 o DATE completo
    CONSTRAINT fk_boleta_personal FOREIGN KEY (idEmpleadoB) REFERENCES Personal(idPersonal),
    CONSTRAINT fk_boleta_cliente FOREIGN KEY (idClienteB) REFERENCES Cliente(idClienteC)
);
/


-- Crear tabla DetalleBoleta
CREATE TABLE DetalleBoleta (
    idDetalleDB VARCHAR2(50) PRIMARY KEY,
    idBoletaDB VARCHAR2(50) NOT NULL,
    idProductoDB VARCHAR2(50) NOT NULL,
    cantidadDB NUMBER(10),
    CONSTRAINT fk_detalle_boleta FOREIGN KEY (idBoletaDB) REFERENCES Boleta(IdB),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (idProductoDB) REFERENCES Producto(idProductoP)
);
/
