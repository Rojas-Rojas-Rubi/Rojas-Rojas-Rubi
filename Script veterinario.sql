-- Crear la base de datos
CREATE DATABASE veterinaria;
USE veterinaria;

-- Tabla de veterinarios
CREATE TABLE veterinario (
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    num_telefono VARCHAR(15),
    especialidad VARCHAR(50)
);

-- Tabla de áreas
CREATE TABLE area (
    id_area INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(50)
);

-- Tabla de pacientes
CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT,
    raza VARCHAR(100),
    sexo VARCHAR(20),
    padecimiento VARCHAR(100),
    id_veterinario INT,
    id_area INT,
    FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario),
    FOREIGN KEY (id_area) REFERENCES area(id_area)
);

-- Tabla de ingresos
CREATE TABLE ingresos (
    id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    fecha_ingreso DATE,
    tratamiento VARCHAR(100),
    id_paciente INT,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

-- Tabla intermedia para muchos a muchos (veterinario - área)
CREATE TABLE veterinario_area (
    id_veterinario INT,
    id_area INT,
    PRIMARY KEY (id_veterinario, id_area),
    FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario),
    FOREIGN KEY (id_area) REFERENCES area(id_area)
);
