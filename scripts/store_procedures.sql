
DELIMITER $$

CREATE PROCEDURE CrearSubasta(
    IN fechaInicio DATETIME
)
BEGIN
    DECLARE fechaFin DATETIME;
    SET fechaFin = DATE_ADD(fechaInicio, INTERVAL 108 MINUTE);

    INSERT INTO Subasta (fecha_hora_inicio, fecha_hora_final, estado)
    VALUES (fechaInicio, fechaFin, 'No iniciado');
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE RellenarSubastaMedicamento(
    IN medicamento_id INT,
    IN cantidad_medicamento INT,
    IN subasta_id INT
)
BEGIN
    INSERT INTO Subasta_Medicamento (medicamento_id, cantidad_medicamento, subasta_id)
    VALUES (medicamento_id, cantidad_medicamento, subasta_id);
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE PujarPorSubasta(
  IN instituto_id INT,
  IN subasta_id INT,
  IN dinero_pujado DECIMAL(6, 2)
)
BEGIN
  DECLARE monto_anterior DECIMAL(6, 2);

  -- Obtener el monto anterior del instituto participante
  SELECT dinero_ofrecido INTO monto_anterior
  FROM Institutos_Participantes
  ORDER BY participante_id DESC
  LIMIT 1;
  

  -- Verificar si el monto ofrecido es mayor al monto anterior
  IF dinero_pujado <= monto_anterior THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto para pujar debe ser mayor al monto anterior.';
  ELSE
    INSERT INTO Institutos_Participantes (instituto_id, subasta_id, dinero_ofrecido)
    VALUES (instituto_id, subasta_id, dinero_pujado);
    UPDATE Subasta
    SET instituto_ganador = instituto_id
    WHERE subasta_id = subasta_id;    
  END IF;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE ActualizarEstadoSubasta(IN estado_actual TEXT, IN subasta_modificar INT)
BEGIN
  DECLARE estado_nuevo TEXT;

  IF estado_actual = 'comenzar' THEN
    SET estado_nuevo = 'En curso';
  ELSEIF estado_actual = 'finalizar' THEN
    SET estado_nuevo = 'Finalizado';
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor no válido. Debe ser "comenzar" o "finalizar"';
  END IF;

  UPDATE Subasta S
  SET estado = estado_nuevo
  WHERE S.subasta_id = subasta_modificar;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE CrearTransferencia(
  IN bancoId INT,
  IN subastaId INT
)
BEGIN
  DECLARE fechaPago DATE;
  SET fechaPago = CURDATE(); -- Obtener la fecha actual

  INSERT INTO Transferencia (fecha_pago, fecha_llegada, banco_id, subasta_id)
  VALUES (fechaPago, NULL, bancoId, subastaId);

END $$

DELIMITER ;