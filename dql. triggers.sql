-- 1. Calcular automáticamente la nota final al insertar una evaluación
DELIMITER $$
CREATE TRIGGER trg_calc_nota_final_insert
BEFORE INSERT ON Evaluacion
FOR EACH ROW
BEGIN
    SET NEW.nota_final = NEW.nota_teorica + NEW.nota_practica + NEW.nota_quiz;
END $$
DELIMITER ;

-- 2. Verificar aprobación al actualizar nota final
DELIMITER $$
CREATE TRIGGER trg_verificar_aprobacion
AFTER UPDATE ON Evaluacion
FOR EACH ROW
BEGIN
    DECLARE estado INT;
    IF NEW.nota_final >= 60 THEN
        SELECT id_estado_eval INTO estado FROM EstadoEvaluacion WHERE descripcion = 'Aprobado';
    ELSE
        SELECT id_estado_eval INTO estado FROM EstadoEvaluacion WHERE descripcion = 'Reprobado';
    END IF;

    UPDATE Evaluacion SET id_estado_eval = estado WHERE id_eval = NEW.id_eval;
END $$
DELIMITER ;

-- 3. Cambiar estado a “Inscrito” al registrar inscripción
DELIMITER $$
CREATE TRIGGER trg_estado_inscrito
AFTER INSERT ON AsignacionRutaCamper
FOR EACH ROW
BEGIN
    UPDATE Camper
    SET id_estado_camper = (SELECT id_estado_camper FROM EstadoCamper WHERE descripcion = 'Inscrito')
    WHERE id_camper = NEW.id_camper;
END $$
DELIMITER ;

-- 4. Recalcular nota final al actualizar evaluación
DELIMITER $$
CREATE TRIGGER trg_recalcular_nota
BEFORE UPDATE ON Evaluacion
FOR EACH ROW
BEGIN
    SET NEW.nota_final = NEW.nota_teorica + NEW.nota_practica + NEW.nota_quiz;
END $$
DELIMITER ;

-- 5. Marcar como “Retirado” al eliminar inscripción
DELIMITER $$
CREATE TRIGGER trg_retirar_camper
AFTER DELETE ON AsignacionRutaCamper
FOR EACH ROW
BEGIN
    UPDATE Camper
    SET id_estado_camper = (SELECT id_estado_camper FROM EstadoCamper WHERE descripcion = 'Retirado')
    WHERE id_camper = OLD.id_camper;
END $$
DELIMITER ;

-- 6. Registrar SGDB automáticamente al insertar módulo (simulación básica)
-- Este trigger requiere saber el SGDB por defecto o inferencia, puede usar lógica adicional
DELIMITER $$
CREATE TRIGGER trg_insert_modulo_sgdb
AFTER INSERT ON Modulo
FOR EACH ROW
BEGIN
    INSERT IGNORE INTO RutaSGDB (id_ruta, id_sgdb, tipo)
    VALUES (NEW.id_ruta, 1, 'Principal'); 
END $$
DELIMITER ;

-- 7. Verificar duplicados por identificación al insertar trainer
DELIMITER $$
CREATE TRIGGER trg_verificar_trainer
BEFORE INSERT ON Trainer
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Trainer WHERE nombre = NEW.nombre) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Trainer ya registrado con ese nombre.';
    END IF;
END $$
DELIMITER ;

-- 8. Validar que no exceda capacidad al asignar área
DELIMITER $$
CREATE TRIGGER trg_validar_capacidad
BEFORE INSERT ON Asistencia
FOR EACH ROW
BEGIN
    DECLARE capacidad INT;
    DECLARE ocupados INT;

    SELECT capacidad_maxima INTO capacidad FROM AreaEntrenamiento WHERE id_area = NEW.id_area;
    SELECT COUNT(*) INTO ocupados FROM Asistencia WHERE id_area = NEW.id_area AND fecha = CURDATE();

    IF ocupados >= capacidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Área ya está llena para hoy.';
    END IF;
END $$
DELIMITER ;

-- 9. Evaluación < 60 → marcar como “Bajo rendimiento”
DELIMITER $$
CREATE TRIGGER trg_bajo_rendimiento
AFTER INSERT ON Evaluacion
FOR EACH ROW
BEGIN
    IF NEW.nota_final < 60 THEN
        UPDATE Camper
        SET id_estado_camper = (SELECT id_estado_camper FROM EstadoCamper WHERE descripcion = 'Bajo rendimiento')
        WHERE id_camper = NEW.id_camper;
    END IF;
END $$
DELIMITER ;

-- 10. Al cambiar estado a “Graduado”, mover a tabla de egresados
DELIMITER $$
CREATE TRIGGER trg_mover_egresado
AFTER UPDATE ON Camper
FOR EACH ROW
BEGIN
    IF (SELECT descripcion FROM EstadoCamper WHERE id_estado_camper = NEW.id_estado_camper) = 'Graduado' THEN
        INSERT INTO Egresado (id_camper, fecha_egreso) VALUES (NEW.id_camper, CURDATE());
    END IF;
END $$
DELIMITER ;

-- 11. Verificar solapamiento de horarios de trainer
DELIMITER $$
CREATE TRIGGER trg_validar_solapamiento
BEFORE INSERT ON HorarioTrainer
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM HorarioTrainer
        WHERE id_trainer = NEW.id_trainer AND id_horario = NEW.id_horario
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Horario ya asignado al trainer.';
    END IF;
END $$
DELIMITER ;

-- 12. Liberar horarios y rutas al eliminar un trainer
DELIMITER $$
CREATE TRIGGER trg_liberar_trainer
AFTER DELETE ON Trainer
FOR EACH ROW
BEGIN
    DELETE FROM AsignacionTrainerRuta WHERE id_trainer = OLD.id_trainer;
    DELETE FROM HorarioTrainer WHERE id_trainer = OLD.id_trainer;
END $$
DELIMITER ;

-- 13. Al cambiar la ruta del camper, actualizar sus módulos
-- Este requiere una tabla intermedia, aquí solo ejemplo
-- (debería borrar evaluaciones de ruta anterior si aplica)
DELIMITER $$
CREATE TRIGGER trg_actualizar_modulos
AFTER UPDATE ON AsignacionRutaCamper
FOR EACH ROW
BEGIN
    -- lógica según contexto
END $$
DELIMITER ;

-- 14. Verificar duplicado de documento al insertar camper
DELIMITER $$
CREATE TRIGGER trg_verificar_doc_camper
BEFORE INSERT ON Camper
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Camper WHERE identificacion = NEW.identificacion) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya existe un camper con esa identificación.';
    END IF;
END $$
DELIMITER ;

-- 15. Recalcular estado del módulo al cambiar nota
DELIMITER $$
CREATE TRIGGER trg_actualizar_estado_modulo_
AFTER UPDATE ON Evaluacion
FOR EACH ROW
BEGIN
    DECLARE nuevo_estado INT;

    IF NEW.nota_final >= 60 THEN
        SELECT id_estado_eval INTO nuevo_estado FROM EstadoEvaluacion WHERE descripcion = 'Aprobado';
    ELSE
        SELECT id_estado_eval INTO nuevo_estado FROM EstadoEvaluacion WHERE descripcion = 'Reprobado';
    END IF;

    UPDATE Evaluacion SET id_estado_eval = nuevo_estado WHERE id_eval = NEW.id_eval;
END $$
DELIMITER ;


-- 16. Verificar si el trainer conoce el módulo antes de asignarlo
-- Asumiendo tabla de conocimientos o relación entre trainer y módulo
-- Placeholder
DELIMITER $$
CREATE TRIGGER trg_verificar_conocimiento_trainer_
BEFORE INSERT ON AsignacionTrainerRuta
FOR EACH ROW
BEGIN
    IF NEW.id_trainer < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Trainer no válido para asignación de módulo.';
    END IF;
END $$
DELIMITER ;


-- 17. Si área se vuelve inactiva, liberar campers
-- Asumimos una columna `activa` (boolean) en AreaEntrenamiento
DELIMITER $$
CREATE TRIGGER trg_area_inactiva
AFTER UPDATE ON AreaEntrenamiento
FOR EACH ROW
BEGIN
    IF OLD.capacidad_maxima > 0 AND NEW.capacidad_maxima = 0 THEN
        DELETE FROM Asistencia WHERE id_area = NEW.id_area;
    END IF;
END $$
DELIMITER ;

-- 18. Al crear ruta, clonar módulos base
-- Se requiere plantilla de módulos base
DELIMITER $$
CREATE TRIGGER trg_clonar_modulos_base_
AFTER INSERT ON RutaEntrenamiento
FOR EACH ROW
BEGIN
    INSERT INTO Modulo (nombre_modulo, id_ruta, id_categoria)
    SELECT CONCAT(nombre_modulo, ' - Base'), NEW.id_ruta, id_categoria
    FROM Modulo
    WHERE id_modulo <= 3;
END $$
DELIMITER ;


-- 19. Verificar nota práctica no mayor a 60%
DELIMITER $$
CREATE TRIGGER trg_validar_nota_practica
BEFORE INSERT ON Evaluacion
FOR EACH ROW
BEGIN
    IF NEW.nota_practica > 60 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nota práctica no puede superar 60.';
    END IF;
END $$
DELIMITER ;

-- 20. Notificar a trainers al modificar ruta
-- Aquí solo simulado (notificación puede ser por tabla de logs)
DELIMITER $$
CREATE TRIGGER trg_notificar_cambio_ruta
AFTER UPDATE ON RutaEntrenamiento
FOR EACH ROW
BEGIN
    INSERT INTO Notificaciones (mensaje, fecha) VALUES (
        CONCAT('Ruta modificada: ', NEW.nombre),
        NOW()
    );
END $$
DELIMITER ;
