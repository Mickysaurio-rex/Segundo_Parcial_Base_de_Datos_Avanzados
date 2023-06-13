USE segundaBase;

CREATE TABLE Laboratorio (
  laboratorio_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_laboratorio VARCHAR(100)
);

CREATE TABLE Departamento (
  departamento_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_departamento VARCHAR(50)
);

CREATE TABLE Medicamentos (
  medicamento_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_medicamento VARCHAR(100),
  precio_unitario DECIMAL(5,2),
  cantidad_actual INT,
  laboratorio_id INT,
  FOREIGN KEY (laboratorio_id) REFERENCES Laboratorio(laboratorio_id)
);

CREATE TABLE Categoria (
  categoria_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_categoria VARCHAR(100)
);

CREATE TABLE Instituto (
  instituto_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_instituto VARCHAR(100),
  direccion VARCHAR(100),
  categoria_id INT,
  departamento_id INT,
  FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id),
  FOREIGN KEY (departamento_id) REFERENCES Departamento(departamento_id)
);

CREATE TABLE Banco (
  banco_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_banco VARCHAR(100),
  departamento_id INT,
  direccion VARCHAR(100),
  FOREIGN KEY (departamento_id) REFERENCES Departamento(departamento_id)
);

CREATE TABLE Reguladores (
  regulador_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_regulador VARCHAR(100),
  telefono VARCHAR(20),
  cargo VARCHAR(80),
  departamento_id INT,
  FOREIGN KEY (departamento_id) REFERENCES Departamento(departamento_id)
);

CREATE TABLE Subasta (
  subasta_id INT PRIMARY KEY AUTO_INCREMENT,
  fecha_hora_inicio DATETIME,
  fecha_hora_final DATETIME,
  estado VARCHAR(20),
  costo_total DECIMAL(5,2) DEFAULT 0.00,
  instituto_ganador INT,
  FOREIGN KEY (instituto_ganador) REFERENCES Instituto(instituto_id)
);

CREATE TABLE Subasta_Medicamento (
  subasta_id INT,
  medicamento_id INT,
  cantidad_medicamento INT,
  FOREIGN KEY (subasta_id) REFERENCES Subasta(subasta_id),
  FOREIGN KEY (medicamento_id) REFERENCES Medicamentos(medicamento_id)
);

CREATE TABLE Institutos_Participantes (
  participante_id INT PRIMARY KEY AUTO_INCREMENT,
  subasta_id INT,
  instituto_id INT,
  dinero_ofrecido DECIMAL(6,2),
  FOREIGN KEY (subasta_id) REFERENCES Subasta(subasta_id),
  FOREIGN KEY (instituto_id) REFERENCES Instituto(instituto_id)
);

CREATE TABLE Transferencia (
  transferencia_id INT PRIMARY KEY AUTO_INCREMENT,
  fecha_pago DATE,
  fecha_llegada DATE,
  banco_id INT,
  subasta_id INT,
  FOREIGN KEY (banco_id) REFERENCES Banco(banco_id),
  FOREIGN KEY (subasta_id) REFERENCES Subasta(subasta_id)
);


CREATE INDEX idx_precio_unitario ON Medicamentos (precio_unitario);
CREATE INDEX idx_estado ON Subasta (estado);
CREATE INDEX idx_nombre_banco ON Banco (nombre_banco);
CREATE INDEX idx_subasta_id ON Institutos_Participantes (subasta_id);
CREATE INDEX idx_instituto_ganador ON Subasta (instituto_ganador);


CREATE INDEX idx_nombre_lab ON Medicamentos (nombre_medicamento, laboratorio_id);
CREATE INDEX idx_subasta_medicamento ON Subasta_Medicamento (subasta_id, medicamento_id);
CREATE INDEX idx_departamento_instituto ON Instituto (departamento_id, nombre_instituto);


CREATE TABLE Auditoria_Medicamentos (
  auditoria_id INT PRIMARY KEY AUTO_INCREMENT,
  medicamento_id INT,
  nombre_medicamento_anterior VARCHAR(100),
  precio_unitario_anterior DECIMAL(5,2),
  cantidad_actual_anterior INT,
  fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (medicamento_id) REFERENCES Medicamentos(medicamento_id)
);


CREATE TABLE Auditoria_Subasta (
  auditoria_id INT PRIMARY KEY AUTO_INCREMENT,
  subasta_id INT,
  estado_anterior VARCHAR(20),
  costo_total_anterior DECIMAL(5,2),
  fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (subasta_id) REFERENCES Subasta(subasta_id)
);


CREATE TABLE Auditoria_Instituto (
  auditoria_id INT PRIMARY KEY AUTO_INCREMENT,
  instituto_id INT,
  nombre_instituto_anterior VARCHAR(100),
  direccion_anterior VARCHAR(100),
  categoria_id_anterior INT,
  departamento_id_anterior INT,
  fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (instituto_id) REFERENCES Instituto(instituto_id)
);


CREATE TABLE Auditoria_Institutos_Participantes (
  auditoria_id INT PRIMARY KEY AUTO_INCREMENT,
  participante_id INT,
  subasta_id INT,
  instituto_id_anterior INT,
  dinero_ofrecido_anterior DECIMAL(6,2),
  fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (participante_id) REFERENCES Institutos_Participantes(participante_id)
);


CREATE TABLE Auditoria_Transferencia (
  auditoria_id INT PRIMARY KEY AUTO_INCREMENT,
  transferencia_id INT,
  fecha_pago_anterior DATE,
  fecha_llegada_anterior DATE,
  banco_id_anterior INT,
  subasta_id_anterior INT,
  fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (transferencia_id) REFERENCES Transferencia(transferencia_id)
);

