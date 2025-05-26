INSERCION DE DATOS

-- Inserción de regiones
INSERT INTO regiones (nombre) VALUES 
('Cañada'),
('Costa'),
('Istmo'),
('Mixteca'),
('Papaloapan'),
('Sierra Norte'),
('Sierra Sur'),
('Valles Centrales');

-- Inserción de pueblos mágicos
INSERT INTO pueblos_magicos (nombre, num_habitantes, id_regiones) VALUES
('Huautla de Jiménez', 31829, 1), -- Cañada
('Mazunte', 3750, 2),             -- Costa
('San Pedro y San Pablo Teposcolula', 4353, 4), -- Mixteca
('Capulálpam de Méndez', 1619, 6),              -- Sierra Norte
('Santa Catarina Juquila', 6165, 7),            -- Sierra Sur
('San Pablo Villa de Mitla', 13587, 8);         -- Valles Centrales

-- Inserción de atracciones
INSERT INTO atracciones (nombre, descripcion, visitantes_anuales, id_pueblo) VALUES
-- Huautla de Jiménez
('Casa Museo de María Sabina', 'Dedicada a la famosa curandera mazateca', 5000, 1),
('Catedral de San Juan Evangelista', 'Iglesia principal del municipio', 3000, 1),
('Cerro de la Adoración', 'Lugar sagrado para rituales y con vistas panorámicas', 4500, 1),
('Grutas de San Sebastián', 'Cavernas para exploración', 4000, 1),
('Cascada Puente de Fierro', 'Belleza natural en la región', 3500, 1),

-- Mazunte
('Centro Mexicano de la Tortuga', 'Dedicado a la conservación de tortugas marinas', 80000, 2),
('Punta Cometa', 'Mirador natural con vistas al océano', 70000, 2),
('Playa Mazunte', 'Ideal para relajarse y nadar', 100000, 2),
('Laguna Ventanilla', 'Ecosistema de manglares con fauna diversa', 60000, 2),

-- San Pedro y San Pablo Teposcolula
('Templo y Ex Convento de San Pedro y San Pablo', 'Conjunto arquitectónico del siglo XVI', 5000, 3),
('Casa de la Cacica', 'Residencia histórica de líderes indígenas', 3500, 3),
('Parque Municipal', 'Espacio recreativo en el centro del pueblo', 3000, 3),
('Zona arqueológica Cerro Jazmín', 'Sitio prehispánico con vestigios', 2500, 3),
('Miradores La Peña y Las Nubes', 'Puntos panorámicos de la región', 2800, 3),

-- Capulálpam de Méndez
('Centro de Medicina Tradicional', 'Espacio de medicina ancestral', 7000, 4),
('Templo de San Mateo Apóstol', 'Iglesia del siglo XVII', 5000, 4),
('Talleres de orfebrería y textiles', 'Elaboración de artesanías', 3000, 4),
('Bosques de coníferas', 'Caminatas y ecoturismo', 4500, 4),
('Galería de Juguete', 'Exhibición de juguetes artesanales', 2000, 4),

-- Santa Catarina Juquila
('Santuario de la Inmaculada Virgen de Juquila', 'Centro de peregrinación', 200000, 5),
('El Pedimento', 'Lugar de oración y promesas', 150000, 5),
('Cascada Chorro Conejo', 'Caída de agua de 30 metros', 5000, 5),
('Sendero de la Fe', 'Camino rodeado de naturaleza al santuario', 10000, 5),
('Talleres de tallado de madera y bordados chatinos', 'Artesanías locales', 3000, 5),

-- San Pablo Villa de Mitla
('Zona Arqueológica de Mitla', 'Sitio arqueológico zapoteca', 120000, 6),
('Templo de San Pablo Apóstol', 'Iglesia colonial junto a la zona arqueológica', 20000, 6),
('Museo de Sitio', 'Muestra objetos arqueológicos y culturales', 10000, 6),
('Mercado de artesanías', 'Venta de productos locales', 8000, 6),
('Cuevas prehistóricas', 'Cuevas Patrimonio Mundial por la UNESCO', 9000, 6);

-- Atracciones destacadas
INSERT INTO atracciones_destacadas (id_atraccion, id_pueblo, id_regiones) VALUES
-- Huautla de Jiménez - Cañada (región 1)
(1, 1, 1), -- Casa Museo de María Sabina

-- Mazunte – Costa (región 2)
(7, 2, 2), -- Playa Mazunte

-- San Pedro y San Pablo Teposcolula – Mixteca (región 4)
(10, 3, 4), -- Templo y Ex Convento

-- Capulálpam de Méndez – Sierra Norte (región 6)
(16, 4, 6), -- Centro de Medicina Tradicional

-- Santa Catarina Juquila – Sierra Sur (región 7)
(21, 5, 7), -- Santuario de la Virgen de Juquila

-- San Pablo Villa de Mitla – Valles Centrales (región 8)
(26, 6, 8); -- Zona Arqueológica de Mitla
