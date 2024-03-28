-- Creacion Base de Datos:
CREATE DATABASE desafio2_ion_cucer_597;

USE desafio2_ion_cucer_597;

-- Creacion de las tablas y llenado con datos
CREATE TABLE IF NOT EXISTS Inscritos (
    cantidad INT,
    fecha DATE,
    fuente VARCHAR (150)
);

INSERT INTO Inscritos (cantidad, fecha, fuente) VALUES
                                                    (44, '2021-01-01', 'Blog'),
                                                    (56, '2021-01-01', 'Página'),
                                                    (39, '2021-01-02', 'Blog'),
                                                    (81, '2021-01-02', 'Página'),
                                                    (12, '2021-01-03', 'Blog'),
                                                    (91, '2021-01-03', 'Página'),
                                                    (48, '2021-01-04', 'Blog'),
                                                    (45, '2021-01-04', 'Página'),
                                                    (55, '2021-01-05', 'Blog'),
                                                    (33, '2021-01-05', 'Página'),
                                                    (18, '2021-01-06', 'Blog'),
                                                    (12, '2021-01-06', 'Página'),
                                                    (34, '2021-01-07', 'Blog'),
                                                    (24, '2021-01-07', 'Página'),
                                                    (83, '2021-01-08', 'Blog'),
                                                    (99, '2021-01-08', 'Página');

--  1. ¿Cuántos registros hay?
SELECT COUNT(*) FROM Inscritos;

-- 2. ¿Cuántos inscritos hay en total?
SELECT SUM(cantidad) FROM Inscritos;

-- 3. ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT * FROM Inscritos
WHERE fecha = (SELECT MIN(fecha)
    FROM Inscritos
);

--  4. ¿Cuántos inscritos hay por día?
SELECT fecha, SUM(cantidad) FROM Inscritos
GROUP BY fecha;

--  5. ¿Qué día se inscribieron la mayor cantidad de personas
-- y cuántas personas se inscribieron en ese día?

SELECT fecha, SUM(cantidad) FROM Inscritos
GROUP BY fecha
ORDER BY SUM(cantidad) DESC
LIMIT 1;