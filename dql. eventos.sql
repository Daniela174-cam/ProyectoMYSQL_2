-- Activa el scheduler si no lo está
SET GLOBAL event_scheduler = ON;

-- 1. Evento para archivar campers graduados
DELIMITER $$
CREATE EVENT IF NOT EXISTS evt_archivar_graduados
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    INSERT INTO Egresado (id_camper, fecha_egreso)
    SELECT id_camper, CURDATE()
    FROM Camper
    WHERE id_estado_camper = (SELECT id_estado_camper FROM EstadoCamper WHERE descripcion = 'Graduado')
    AND id_camper NOT IN (SELECT id_camper FROM Egresado);
END$$
DELIMITER ;

-- 2. Resumen mensual de notas por ruta
DELIMITER $$
CREATE EVENT IF NOT EXISTS evt_resumen_notas_ruta
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    INSERT INTO ResumenNotasRuta (id_ruta, promedio, fecha)
    SELECT m.id_ruta, AVG(e.nota_final), CURDATE()
    FROM Evaluacion e
    JOIN Modulo m ON e.id_modulo = m.id_modulo
    GROUP BY m.id_ruta;
END$$
DELIMITER ;

-- 3. Expulsar campers sin asistencia en 7 días
DELIMITER $$
CREATE EVENT IF NOT EXISTS evt_estado_expulsado
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE Camper
    SET id_estado_camper = (SELECT id_estado_camper FROM EstadoCamper WHERE descripcion = 'Expulsado')
    WHERE id_camper NOT IN (
        SELECT DISTINCT id_camper
        FROM Asistencia
        WHERE fecha >= CURDATE() - INTERVAL 7 DAY
    );
END$$
DELIMITER ;

-- 4. Limpiar evaluaciones sin nota
DELIMITER $$
CREATE EVENT IF NOT EXISTS evt_limpieza_evaluaciones
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    DELETE FROM Evaluacion WHERE nota_final IS NULL;
END$$
DELIMITER ;

-- 5. Notificar áreas con alta ocupación
DELIMITER $$
CREATE EVENT IF NOT EXISTS evt_notificar_ocupacion
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    INSERT INTO Notificaciones (mensaje, fecha)
    SELECT CONCAT('Área ', id_area, ' supera 90% de ocupación'), NOW()
    FROM AreaEntrenamiento a
    JOIN (
        SELECT id_area, COUNT(*) AS ocupacion
        FROM Asistencia
        WHERE fecha = CURDATE()
        GROUP BY id_area
    ) AS oc ON a.id_area = oc.id_area
    WHERE (oc.ocupacion * 100.0) / a.capacidad_maxima > 90;
END$$
DELIMITER ;
