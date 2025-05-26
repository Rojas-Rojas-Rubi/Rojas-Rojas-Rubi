Consultas 

-- a) Listar todos los pueblos mágicos con su región, número de habitantes y atracciones:
SELECT 
  r.nombre AS region,
  p.nombre AS pueblo_magico,
  p.num_habitantes,
  a.nombre AS atraccion
FROM pueblos_magicos p
JOIN regiones r ON p.id_regiones = r.id_regiones
LEFT JOIN atracciones a ON p.id_pueblo = a.id_pueblo
ORDER BY r.nombre, p.nombre;


-- b) Mostrar cuántas atracciones tiene cada pueblo mágico:
SELECT 
  p.nombre AS pueblo_magico,
  r.nombre AS region,
  COUNT(a.id_atraccion) AS total_atracciones
FROM pueblos_magicos p
JOIN regiones r ON p.id_regiones = r.id_regiones
LEFT JOIN atracciones a ON p.id_pueblo = a.id_pueblo
GROUP BY p.id_pueblo
ORDER BY r.nombre, total_atracciones DESC;


-- c) Listar todos los pueblos mágicos junto con la región a la que pertenecen:
SELECT pm.nombre AS pueblo, r.nombre AS region
FROM pueblos_magicos pm
JOIN regiones r ON pm.id_regiones = r.id_regiones;

-- d) Mostrar las atracciones de un pueblo específico, por ejemplo “Mazunte”:
SELECT a.nombre AS atraccion, a.visitantes_anuales
FROM atracciones a
JOIN pueblos_magicos p ON a.id_pueblo = p.id_pueblo
WHERE p.nombre = 'Mazunte';

-- e) Mostrar pueblos mágicos con más de 5,000 habitantes y sus atracciones:
SELECT 
  r.nombre AS region,
  p.nombre AS pueblo_magico,
  p.num_habitantes,
  a.nombre AS atraccion
FROM pueblos_magicos p
JOIN regiones r ON p.id_regiones = r.id_regiones
LEFT JOIN atracciones a ON p.id_pueblo = a.id_pueblo
WHERE p.num_habitantes > 5000
ORDER BY r.nombre, p.nombre;
