
DELIMITER $$

CREATE TRIGGER actualiza_cantidad_medicamento AFTER INSERT ON Subasta_Medicamento
FOR EACH ROW
BEGIN
  UPDATE Medicamentos
  SET cantidad_actual = cantidad_actual - NEW.cantidad_medicamento
  WHERE medicamento_id = NEW.medicamento_id;
END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER actualizar_costo_total AFTER INSERT ON Subasta_Medicamento
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2);

    -- Calcula el nuevo valor para costo_total
    SELECT SUM(m.precio_unitario * NEW.cantidad_medicamento)
    INTO total
    FROM Medicamentos m
    WHERE m.medicamento_id = NEW.medicamento_id;

    -- Actualiza el campo costo_total en la tabla Subasta
    UPDATE Subasta
    SET costo_total = costo_total + total
    WHERE subasta_id = NEW.subasta_id;
END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER VerificarEstadoSubasta
BEFORE INSERT ON Institutos_Participantes
FOR EACH ROW
BEGIN
  DECLARE estado_subasta VARCHAR(50);

  SELECT estado INTO estado_subasta FROM Subasta WHERE subasta_id = NEW.subasta_id;

  IF estado_subasta <> 'En curso' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La subasta no está disponible';
  END IF;
END $$


DELIMITER ;

DELIMITER $$
CREATE TRIGGER verificar_subasta_existente
BEFORE INSERT ON Subasta
FOR EACH ROW
BEGIN
    IF EXISTS(SELECT * FROM Subasta WHERE fecha_hora_inicio = NEW.fecha_hora_inicio) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Esta subasta ya se ha programado';
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER verifica_estado_subasta
BEFORE INSERT ON Subasta_Medicamento
FOR EACH ROW
BEGIN
    DECLARE estado_subasta VARCHAR(20);
    
    -- Obtener el estado de la subasta correspondiente
    SELECT estado INTO estado_subasta
    FROM Subasta
    WHERE subasta_id = NEW.subasta_id;
    
    -- Verificar si el estado es "No iniciado"
    IF estado_subasta <> 'No iniciado' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se permite la inserción en Subasta_Medicamento.';
    END IF;
END $$
DELIMITER ;




DELIMITER $$
CREATE TRIGGER audit_medicamentos
AFTER UPDATE ON Medicamentos
FOR EACH ROW
BEGIN
    IF NEW.nombre_medicamento != OLD.nombre_medicamento OR
       NEW.precio_unitario != OLD.precio_unitario OR
       NEW.cantidad_actual != OLD.cantidad_actual THEN
       
        INSERT INTO Auditoria_Medicamentos (medicamento_id, nombre_medicamento_anterior, precio_unitario_anterior, cantidad_actual_anterior)
        VALUES (OLD.medicamento_id, OLD.nombre_medicamento, OLD.precio_unitario, OLD.cantidad_actual);
        
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER audit_subasta
AFTER UPDATE ON Subasta
FOR EACH ROW
BEGIN
    IF NEW.estado != OLD.estado OR
       NEW.costo_total != OLD.costo_total THEN
       
        INSERT INTO Auditoria_Subasta (subasta_id, estado_anterior, costo_total_anterior)
        VALUES (OLD.subasta_id, OLD.estado, OLD.costo_total);
        
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER audit_instituto
AFTER UPDATE ON Instituto
FOR EACH ROW
BEGIN
    IF NEW.nombre_instituto != OLD.nombre_instituto OR
       NEW.direccion != OLD.direccion OR
       NEW.categoria_id != OLD.categoria_id OR
       NEW.departamento_id != OLD.departamento_id THEN
       
        INSERT INTO Auditoria_Instituto (instituto_id, nombre_instituto_anterior, direccion_anterior, categoria_id_anterior, departamento_id_anterior)
        VALUES (OLD.instituto_id, OLD.nombre_instituto, OLD.direccion, OLD.categoria_id, OLD.departamento_id);
        
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER audit_transferencia
AFTER UPDATE ON Transferencia
FOR EACH ROW
BEGIN
    IF NEW.fecha_pago != OLD.fecha_pago OR
       NEW.fecha_llegada != OLD.fecha_llegada OR
       NEW.banco_id != OLD.banco_id OR
       NEW.subasta_id != OLD.subasta_id THEN
       
        INSERT INTO Auditoria_Transferencia (transferencia_id, fecha_pago_anterior, fecha_llegada_anterior, banco_id_anterior, subasta_id_anterior)
        VALUES (OLD.transferencia_id, OLD.fecha_pago, OLD.fecha_llegada, OLD.banco_id, OLD.subasta_id);
        
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER audit_institutos_participantes
AFTER UPDATE ON Institutos_Participantes
FOR EACH ROW
BEGIN
    IF NEW.instituto_id != OLD.instituto_id OR
       NEW.dinero_ofrecido != OLD.dinero_ofrecido THEN
       
        INSERT INTO Auditoria_Institutos_Participantes (participante_id, subasta_id, instituto_id_anterior, dinero_ofrecido_anterior)
        VALUES (OLD.participante_id, OLD.subasta_id, OLD.instituto_id, OLD.dinero_ofrecido);
        
    END IF;
END $$
DELIMITER ;