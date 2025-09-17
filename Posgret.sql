DROP TABLE IF EXISTS detalleboleta CASCADE;
DROP TABLE IF EXISTS boleta CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS proveedor CASCADE;
DROP TABLE IF EXISTS personal CASCADE;

-- Crear tabla personal
CREATE TABLE personal (
    idpersonal VARCHAR(50) PRIMARY KEY,
    cargoe VARCHAR(50),
    nombrep VARCHAR(100)
);

-- Crear tabla proveedor
CREATE TABLE proveedor (
    idproveedor VARCHAR(50) PRIMARY KEY,
    nombrep VARCHAR(100),
    tipop VARCHAR(50)
);

-- Crear tabla cliente
CREATE TABLE cliente (
    idclientec VARCHAR(50) PRIMARY KEY,
    nombrec VARCHAR(100),
    telefonoc VARCHAR(20)
);

-- Crear tabla producto SIN columna ni FK a personal
CREATE TABLE producto (
    idproductop VARCHAR(50) PRIMARY KEY,
    nombrep VARCHAR(100),
    tipop VARCHAR(50),
    preciop NUMERIC(10,2),
    stockp INT,
    idproveedor VARCHAR(50),
    FOREIGN KEY (idproveedor) REFERENCES proveedor(idproveedor)
);

-- Crear tabla boleta
CREATE TABLE boleta (
    idb VARCHAR(50) PRIMARY KEY,
    idempleadob VARCHAR(50) NOT NULL,
    idclienteb VARCHAR(50) NOT NULL,
    fechab DATE,
    horab TIME,
    FOREIGN KEY (idempleadob) REFERENCES personal(idpersonal),
    FOREIGN KEY (idclienteb) REFERENCES cliente(idclientec)
);

-- Crear tabla detalleboleta
CREATE TABLE detalleboleta (
    iddetalledb VARCHAR(50) PRIMARY KEY,
    idboletadb VARCHAR(50) NOT NULL,
    idproductodb VARCHAR(50) NOT NULL,
    cantidaddb INT,
    FOREIGN KEY (idboletadb) REFERENCES boleta(idb),
    FOREIGN KEY (idproductodb) REFERENCES producto(idproductop)
);

-- Consultas para verificar
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'producto';

SELECT
    tc.table_name AS tabla,
    kcu.column_name AS columna,
    ccu.table_name AS tabla_referenciada,
    ccu.column_name AS columna_referenciada
FROM
    information_schema.table_constraints AS tc
JOIN
    information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
JOIN
    information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
WHERE
    tc.constraint_type = 'FOREIGN KEY' AND
    tc.table_schema = 'public';
