INSERT INTO Departamento (nombre_departamento) VALUES
('La Paz'),
('Cochabamba'),
('Santa Cruz'),
('Oruro'),
('Potosi'),
('Tarija'),
('Chuquisaca'),
('Beni'),
('Pando');

INSERT INTO Laboratorio (nombre_laboratorio) VALUES
('Laboratorio Farmaceutico Andromaco'),
('Laboratorio Farmaceutico Beta'),
('Laboratorio Farmaceutico Bolivia'),
('Laboratorio Farmaceutico Farcos'),
('Laboratorio Farmaceutico Delta');

INSERT INTO Reguladores (nombre_regulador, telefono, cargo, departamento_id) VALUES
('Juan Perez', '123456789', 'Director', 1),
('Maria Gomez', '987654321', 'Coordinadora', 2),
('Pedro Rodriguez', '456789123', 'Supervisor', 3),
('Laura Martinez', '321654987', 'Analista', 4),
('Carlos Sanchez', '789123456', 'Especialista', 5);

INSERT INTO Medicamentos (nombre_medicamento, precio_unitario, cantidad_actual, laboratorio_id) VALUES
('Eritromicina', 56.63, 522, 1),
('Diclofenaco', 0.06, 140150, 2),
('Cloxacilina', 3.3, 2600, 3),
('lndometacina oindometacina. lndometacina 25mg', 0.13, 32500, 4),
('Electrolitos de cloruro de sodio - Solución Fisiológica', 7.59, 229750, 5),
('Clorhidrato de dopamina - Dopamina clorhidrato', 5.26, 112, 1),
('Combinación de suplemento nutricionalde vitaminas y minerales', 0.35, 66000, 2),
('Sutfato ferroso - Sulfato', 10, 370, 3),
('Azitromicina', 11, 1305, 4),
('Paracetamol - Acetaminofeno', 44, 190, 5),
('Carbonato de litio - Litio', 2.29, 11500, 1),
('Hidroclorotiazida + Amilorida', 0.2, 163052, 2),
('Dexametasona - Lidocaína', 2.51, 24200, 3),
('Carvedilol', 0.37, 123340, 4),
('Dicloxacilina sodica', 0.87, 27700, 5),
('Amoxicilina', 12.72, 4180, 1);

INSERT INTO Banco (nombre_banco, departamento_id, direccion) VALUES
('Banco Nacional de Bolivia', 1, 'Av. Mariscal Santa Cruz N123'),
('Banco Mercantil Santa Cruz', 2, 'Av. Canoto N456'),
('Banco de Credito de Bolivia', 3, 'Av. Mariscal Santa Cruz N789'),
('Banco Ganadero', 4, 'Av. Pando N321'),
('Banco BISA', 5, 'Av. Arce N567'),
('Banco Union', 1, 'Av. Camacho N789'),
('Banco FIE', 2, 'Av. Banzer N456'),
('Banco Fortaleza', 3, 'Av. América N321'),
('Banco Económico', 4, 'Av. Ballivián N567'),
('Banco Sol', 5, 'Av. 6 de Agosto N123');

INSERT INTO Categoria (nombre_categoria) VALUES
('Departamental'),
('Regional'),
('Zonal'),
('Subzonales'),
('Instituto Oncológico Nacional');

INSERT INTO Instituto (nombre_instituto, direccion, categoria_id, departamento_id)VALUES 
('Caja Petrolera de Salud La Paz - Regional', 'Av. Arce esq. Montenegro', 2, 1),
('Caja Petrolera de Salud Santa Cruz - Regional', 'Av. San Martin esq. 2 de Agosto', 2, 3),
('Caja Petrolera de Salud Cochabamba - Regional', 'Av. Heroinas esq. Ecuador', 2, 2),
('Caja Petrolera de Salud Oruro - Zonal', 'Av. 6 de Agosto esq. Soria Galvarro', 3, 4),
('Caja Petrolera de Salud Tarija - Zonal', 'Av. Las Americas esq. Aniceto Padilla', 3, 5);

INSERT INTO Subasta (fecha_hora_inicio, fecha_hora_final, estado, instituto_ganador) VALUES
('2023-06-01 10:00:00', '2023-06-01 11:48:00', 'No iniciado', 1),
('2023-07-02 09:30:00', '2023-07-02 11:18:00', 'No iniciado', 3),
('2023-08-03 11:15:00', '2023-08-03 12:58:00', 'No iniciado', 2),
('2023-09-04 10:30:00', '2023-09-04 12:22:00', 'No iniciado', 5),
('2023-10-05 09:00:00', '2023-10-05 10:42:00', 'No iniciado', 4);

INSERT INTO Subasta_Medicamento (subasta_id, medicamento_id, cantidad_medicamento)
VALUES
(1, 1, 10),
(1, 2, 20),
(1, 3, 15),
(2, 4, 30),
(2, 5, 25),
(3, 1, 12),
(3, 3, 18),
(3, 5, 22),
(4, 2, 15),
(4, 4, 20),
(5, 1, 8),
(5, 3, 10),
(5, 5, 15);


INSERT INTO Institutos_Participantes (subasta_id, instituto_id, dinero_ofrecido)
VALUES
(1, 1, 500.00),
(1, 2, 550.00),
(1, 3, 600.00),
(2, 4, 700.00),
(2, 5, 800.00),
(2, 1, 850.00),
(3, 3, 900.00);


