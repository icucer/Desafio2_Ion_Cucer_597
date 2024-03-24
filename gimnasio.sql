-- Apuntamos a la base de datos a ocupar.
USE curso53;

-- Creacion tabla Clientes.
CREATE TABLE Clientes (
    id INT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50),
    RUT INT NOT NULL UNIQUE,
    correo_electronico VARCHAR(75) NOT NULL);

-- Creacion tabla Matriculas.
CREATE TABLE Matriculas (
    id_cliente INT,
    monto FLOAT,
    estado BOOLEAN,
    RUT_cliente INT NOT NULL);

-- Modificacion tabla Clientes, asignamos campo "id"
-- como clave primaria.
ALTER TABLE Clientes ADD PRIMARY KEY (id);
-- modificamos el campo id que se autocomplete incrimentandose con uno.
ALTER TABLE Clientes MODIFY COLUMN id INT AUTO_INCREMENT;
-- modificamos el campo monto de FLOAT a INT
ALTER TABLE Matriculas MODIFY COLUMN monto INT;

-- Ingreso de los registros, tabla Clientes.
INSERT INTO Clientes
    (nombre, apellido, RUT, correo_electronico)
VALUES
    ('Cliente 1', 'Apellido cliente 1', '999999999', 'cliente1@email.com'),
    ('Cliente 2', 'Apellido cliente 2', '888888888', 'cliente2@email.com'),
    ('Cliente 3', 'Apellido cliente 3', '777777777', 'cliente3@email.com'),
    ('Cliente 4', 'Apellido cliente 4', '666666666', 'cliente4@email.com'),
    ('Cliente 5', 'Apellido cliente 5', '555555555', 'cliente5@email.com');

-- Actualizas el campo id_cliente en la tabla Matriculas,
-- mediante comparaciones de RUT_cliente en tabla Matriculas
-- con el RUT en tabla Clientes.
UPDATE Matriculas AS m
INNER JOIN Clientes AS c ON m.RUT_cliente = c.RUT
SET m.id_cliente = c.id;


-- Ingreso de los registros, tabla Matricula.
INSERT INTO Matriculas
(Matriculas.id_cliente, monto, estado, RUT_cliente)
VALUES
    ((SELECT c.id FROM Clientes AS c WHERE c.RUT = '999999999'),'40000', True, '999999999'),
    ((SELECT c.id FROM Clientes AS c WHERE c.RUT = '888888888'),'40000', False, '888888888'),
    ((SELECT c.id FROM Clientes AS c WHERE c.RUT = '555555555'),'55000', True, '555555555'),
    ((SELECT c.id FROM Clientes AS c WHERE c.RUT = '777777777'),'35000', True, '777777777'),
    ((SELECT c.id FROM Clientes AS c WHERE c.RUT = '666666666'),'60000', False, '666666666');

-- Seleccionar los registros relacionados utilizando comando
-- INNER JOIN
SELECT correo_electronico, RUT, monto, estado FROM Clientes
INNER JOIN Matriculas ON Clientes.id = Matriculas.id_cliente;

-- Ordenar los resultados del comando INNER JOIN de forma ascendente.
SELECT correo_electronico, id, monto, estado FROM Clientes
INNER JOIN Matriculas ON Clientes.id = Matriculas.id_cliente
ORDER BY Matriculas.monto;

-- Agregamos matricula nueva a un RUT existente.
INSERT INTO Matriculas
(Matriculas.id_cliente, monto, estado, RUT_cliente)
VALUES
    ((SELECT c.id FROM Clientes AS c WHERE c.RUT = '999999999'),'325000', True, '999999999'),
    ((SELECT c.id FROM Clientes AS c WHERE c.RUT = '555555555'),'32500', False, '555555555');

-- Seleccionar los clientes con mas de una matricula
SELECT id_cliente, COUNT(monto) AS 'nr. de registros', SUM(monto) AS 'monto total'
    FROM Matriculas
    GROUP BY id_cliente
    HAVING COUNT(monto) >= 2;

-- Seleccionar y agrupar la informacion de los clientes
-- con una o mas matriculas.
SELECT Clientes.id, correo_electronico, RUT, estado, COUNT(id_cliente) AS 'nr. de registros', SUM(monto) AS 'monto total'
    FROM Clientes
    INNER JOIN Matriculas ON Clientes.id = Matriculas.id_cliente
    GROUP BY Clientes.id, correo_electronico, RUT, Matriculas.estado;

-- Seleccionar registros que tienen mas de una matricula con mismos estados
SELECT Clientes.id, correo_electronico, RUT, Matriculas.estado, COUNT(id_cliente) AS 'nr. de registros', SUM(monto) AS 'monto total'
    FROM Clientes
    INNER JOIN Matriculas ON Clientes.id = Matriculas.id_cliente
    GROUP BY Clientes.id, correo_electronico, RUT, Matriculas.estado
    HAVING COUNT(id_cliente) >= 2;

-- Seleccionar registros que tienen mas de una matricula con mismo y distintos estados
SELECT Clientes.id, correo_electronico, RUT, COUNT(id_cliente) AS 'nr. de registros', SUM(monto) AS 'monto total'
    FROM Clientes
    INNER JOIN Matriculas ON Clientes.id = Matriculas.id_cliente
    GROUP BY Clientes.id, correo_electronico, RUT
    HAVING COUNT(id_cliente) >= 2;