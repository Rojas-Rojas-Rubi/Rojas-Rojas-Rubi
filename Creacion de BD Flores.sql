CREACION DE LA BASE DE DATOS

CREATE DATABASE pueblos_magicos;
CREATE DATABASE florería;

USE florería;

CREATE TABLE flor (
    id_flor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    color VARCHAR(30),
    precio DECIMAL(6,2)
);

CREATE TABLE inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    cantidad INT,
    proveedor VARCHAR(50),
    id_flor INT UNIQUE,
    FOREIGN KEY (id_flor) REFERENCES flor(id_flor)
);


