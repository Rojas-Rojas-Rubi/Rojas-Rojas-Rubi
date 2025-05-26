CREACION DE LA BASE DE DATOS

CREATE DATABASE pueblos_magicos;
USE pueblos_magicos;

-- Tabla: regiones
CREATE TABLE regiones (
  id_regiones INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL
);

-- Tabla: pueblos_magicos
CREATE TABLE pueblos_magicos (
  id_pueblo INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  num_habitantes INT,
  id_regiones INT,
  FOREIGN KEY (id_regiones) REFERENCES regiones(id_regiones)
);

-- Tabla: atracciones
CREATE TABLE atracciones (
  id_atraccion INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT,
  visitantes_anuales INT,
  id_pueblo INT,
  FOREIGN KEY (id_pueblo) REFERENCES pueblos_magicos(id_pueblo)
);

-- Tabla: atracciones_destacadas
CREATE TABLE atracciones_destacadas (
  id_destacada INT PRIMARY KEY AUTO_INCREMENT,
  id_atraccion INT,
  id_pueblo INT,
  id_regiones INT,
  FOREIGN KEY (id_atraccion) REFERENCES atracciones(id_atraccion),
  FOREIGN KEY (id_pueblo) REFERENCES pueblos_magicos(id_pueblo),
  FOREIGN KEY (id_regiones) REFERENCES regiones(id_regiones)
);


