-- 1. Registrar un nuevo camper con información personal y estado inicial
DELIMITER $$
CREATE PROCEDURE registrar_camper(
    IN p_identificacion VARCHAR(50),
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_direccion TEXT,
    IN p_id_acudiente INT,
    IN p_id_estado_camper INT,
    IN p_id_riesgo INT
)
BEGIN
    INSERT INTO Camper (identificacion, nombres, apellidos, direccion, id_acudiente, id_estado_camper, id_riesgo)
    VALUES (p_identificacion, p_nombres, p_apellidos, p_direccion, p_id_acudiente, p_id_estado_camper, p_id_riesgo);
END $$
DELIMITER ;

-- 2. Actualizar el estado de un camper luego del ingreso
DELIMITER $$
CREATE PROCEDURE actualizar_estado_camper(IN p_id_camper INT, IN p_nuevo_estado INT)
BEGIN
    UPDATE Camper SET id_estado_camper = p_nuevo_estado WHERE id_camper = p_id_camper;
    
    INSERT INTO HistorialEstadoCamper (id_camper, id_estado_camper, fecha_cambio)
    VALUES (p_id_camper, p_nuevo_estado, CURDATE());
END $$
DELIMITER ;

-- 3. Procesar inscripción de un camper a una ruta
DELIMITER $$
CREATE PROCEDURE inscribir_camper_ruta(IN p_id_camper INT, IN p_id_ruta INT)
BEGIN
    INSERT INTO AsignacionRutaCamper (id_camper, id_ruta, fecha_inscripcion)
    VALUES (p_id_camper, p_id_ruta, CURDATE());
END $$
DELIMITER ;

-- 4. Registrar evaluación completa
DELIMITER $$
CREATE PROCEDURE registrar_evaluacion(
    IN p_id_camper INT,
    IN p_id_modulo INT,
    IN p_teorica DECIMAL(5,2),
    IN p_practica DECIMAL(5,2),
    IN p_quiz DECIMAL(5,2),
    IN p_id_estado_eval INT
)
BEGIN
    DECLARE p_final DECIMAL(5,2);
    SET p_final = p_teorica + p_practica + p_quiz;

    INSERT INTO Evaluacion (id_camper, id_modulo, nota_teorica, nota_practica, nota_quiz, nota_final, id_estado_eval)
    VALUES (p_id_camper, p_id_modulo, p_teorica, p_practica, p_quiz, p_final, p_id_estado_eval);
END $$
DELIMITER ;

-- 5. Calcular y registrar nota final (si la evaluación ya existe)
DELIMITER $$
CREATE PROCEDURE calcular_nota_final(IN p_id_eval INT)
BEGIN
    UPDATE Evaluacion
    SET nota_final = nota_teorica + nota_practica + nota_quiz
    WHERE id_eval = p_id_eval;
END $$
DELIMITER ;

-- 6. Asignar campers aprobados a rutas disponibles
DELIMITER $$
CREATE PROCEDURE asignar_aprobados_ruta(IN p_id_ruta INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cid INT;
    DECLARE camper_cursor CURSOR FOR
        SELECT id_camper FROM Camper
        WHERE id_estado_camper = (SELECT id_estado_camper FROM EstadoCamper WHERE descripcion = 'Aprobado')
          AND id_camper NOT IN (SELECT id_camper FROM AsignacionRutaCamper);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN camper_cursor;
    read_loop: LOOP
        FETCH camper_cursor INTO cid;
        IF done THEN
            LEAVE read_loop;
        END IF;
        CALL inscribir_camper_ruta(cid, p_id_ruta);
    END LOOP;
    CLOSE camper_cursor;
END $$
DELIMITER ;

-- 7. Asignar un trainer a ruta y área validando horario
DELIMITER $$
CREATE PROCEDURE asignar_trainer(
    IN p_id_trainer INT,
    IN p_id_ruta INT,
    IN p_id_area INT
)
BEGIN
    -- Se puede agregar validación adicional de horario/ocupación aquí
    INSERT INTO AsignacionTrainerRuta (id_trainer, id_ruta, id_area)
    VALUES (p_id_trainer, p_id_ruta, p_id_area);
END $$
DELIMITER ;

-- 8. Registrar nueva ruta con módulos y SGDBs
-- Esta se dividiría en varias operaciones, puede usar transacciones
-- Por ahora solo creamos la ruta
DELIMITER $$
CREATE PROCEDURE registrar_ruta(IN p_nombre VARCHAR(100))
BEGIN
    INSERT INTO RutaEntrenamiento (nombre) VALUES (p_nombre);
END $$
DELIMITER ;

-- 9. Registrar nueva área con capacidad y horario
DELIMITER $$
CREATE PROCEDURE registrar_area(IN p_capacidad INT, IN p_id_horario INT)
BEGIN
    INSERT INTO AreaEntrenamiento (capacidad_maxima, id_horario)
    VALUES (p_capacidad, p_id_horario);
END $$
DELIMITER ;

-- 10. Consultar disponibilidad de horario en un área
DELIMITER $$
CREATE PROCEDURE disponibilidad_area(IN p_id_area INT)
BEGIN
    SELECT h.descripcion, h.hora
    FROM AreaEntrenamiento a
    JOIN Horario h ON a.id_horario = h.id_horario
    WHERE a.id_area = p_id_area;
END $$
DELIMITER ;

-- 11. Reasignar camper por bajo rendimiento
DELIMITER $$
CREATE PROCEDURE reasignar_camper(
    IN p_id_camper INT,
    IN p_nueva_ruta INT
)
BEGIN
    DELETE FROM AsignacionRutaCamper WHERE id_camper = p_id_camper;
    INSERT INTO AsignacionRutaCamper (id_camper, id_ruta, fecha_inscripcion)
    VALUES (p_id_camper, p_nueva_ruta, CURDATE());
END $$
DELIMITER ;

-- 12. Cambiar estado de un camper a “Graduado”
DELIMITER $$
CREATE PROCEDURE graduar_camper(IN p_id_camper INT)
BEGIN
    DECLARE estado_graduado INT;
    SELECT id_estado_camper INTO estado_graduado FROM EstadoCamper WHERE descripcion = 'Graduado';

    UPDATE Camper SET id_estado_camper = estado_graduado WHERE id_camper = p_id_camper;
    INSERT INTO HistorialEstadoCamper (id_camper, id_estado_camper, fecha_cambio)
    VALUES (p_id_camper, estado_graduado, CURDATE());
END $$
DELIMITER ;

-- 13. Consultar datos de rendimiento de un camper
DELIMITER $$
CREATE PROCEDURE rendimiento_camper(IN p_id_camper INT)
BEGIN
    SELECT e.id_eval, m.nombre_modulo, e.nota_teorica, e.nota_practica, e.nota_quiz, e.nota_final
    FROM Evaluacion e
    JOIN Modulo m ON e.id_modulo = m.id_modulo
    WHERE e.id_camper = p_id_camper;
END $$
DELIMITER ;

-- 14. Registrar asistencia por área y horario
DELIMITER $$
CREATE PROCEDURE registrar_asistencia(
    IN p_id_camper INT,
    IN p_id_area INT,
    IN p_id_horario INT
)
BEGIN
    INSERT INTO Asistencia (id_camper, id_area, id_horario, fecha)
    VALUES (p_id_camper, p_id_area, p_id_horario, CURDATE());
END $$
DELIMITER ;

-- 15. Reporte mensual de notas por ruta
DELIMITER $$
CREATE PROCEDURE reporte_notas_ruta(IN p_id_ruta INT)
BEGIN
    SELECT c.nombres, c.apellidos, m.nombre_modulo, e.nota_final
    FROM Evaluacion e
    JOIN Camper c ON e.id_camper = c.id_camper
    JOIN Modulo m ON e.id_modulo = m.id_modulo
    WHERE m.id_ruta = p_id_ruta AND MONTH(e.fecha_evaluacion) = MONTH(CURDATE());
END $$
DELIMITER ;

-- 16. Validar asignación de salón a ruta sin exceder capacidad
-- Requiere lógica adicional, aquí solo el placeholder
DELIMITER $$
CREATE PROCEDURE validar_asignacion_salon()
BEGIN
END $$
DELIMITER ;

-- 17. Registrar cambio de horario de un trainer
DELIMITER $$
CREATE PROCEDURE cambiar_horario_trainer(IN p_id_trainer INT, IN p_id_horario_nuevo INT)
BEGIN
    DELETE FROM HorarioTrainer WHERE id_trainer = p_id_trainer;
    INSERT INTO HorarioTrainer (id_trainer, id_horario)
    VALUES (p_id_trainer, p_id_horario_nuevo);
END $$
DELIMITER ;

-- 18. Eliminar inscripción de camper a una ruta
DELIMITER $$
CREATE PROCEDURE retirar_camper(IN p_id_camper INT)
BEGIN
    DELETE FROM AsignacionRutaCamper WHERE id_camper = p_id_camper;
END $$
DELIMITER ;

-- 19. Recalcular estado de campers según su promedio
DELIMITER $$
CREATE PROCEDURE actualizar_estado_segun_rendimiento()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cid INT;
    DECLARE promedio DECIMAL(5,2);
    DECLARE c_estado INT;
    DECLARE cur1 CURSOR FOR SELECT id_camper FROM Camper;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur1;
    read_loop: LOOP
        FETCH cur1 INTO cid;
        IF done THEN LEAVE read_loop; END IF;
        SELECT AVG(nota_final) INTO promedio FROM Evaluacion WHERE id_camper = cid;

        IF promedio >= 60 THEN
            SELECT id_estado_camper INTO c_estado FROM EstadoCamper WHERE descripcion = 'Aprobado';
        ELSE
            SELECT id_estado_camper INTO c_estado FROM EstadoCamper WHERE descripcion = 'En proceso de ingreso';
        END IF;

        UPDATE Camper SET id_estado_camper = c_estado WHERE id_camper = cid;
    END LOOP;
    CLOSE cur1;
END $$
DELIMITER ;

-- 20. Asignar horarios automáticamente a trainers disponibles
-- Placeholder de lógica avanzada
DELIMITER $$
CREATE PROCEDURE asignar_horario_automatico_()
BEGIN
    INSERT INTO HorarioTrainer (id_trainer, id_horario)
    SELECT t.id_trainer, h.id_horario
    FROM Trainer t
    JOIN Horario h
    WHERE NOT EXISTS (
        SELECT 1 FROM HorarioTrainer ht
        WHERE ht.id_trainer = t.id_trainer AND ht.id_horario = h.id_horario
    )
    LIMIT 1;
END $$
DELIMITER ;
