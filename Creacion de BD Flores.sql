CREACION DE LA BASE DE DATOS

CREATE DATABASE florería;

USE florería;

CREATE TABLE flores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    color VARCHAR(50),
    cantidad INT
);
