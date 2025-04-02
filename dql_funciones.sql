-- 1. Calcular el promedio ponderado de evaluaciones de un camper
DELIMITER $$
CREATE FUNCTION promedio_ponderado_camper(p_id_camper INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE resultado DECIMAL(5,2);
    SELECT AVG(nota_final) INTO resultado
    FROM Evaluacion
    WHERE id_camper = p_id_camper;
    RETURN resultado;
END $$
DELIMITER ;

-- 2. Determinar si un camper aprueba un módulo específico
DELIMITER $$
CREATE FUNCTION aprueba_modulo(p_id_camper INT, p_id_modulo INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE nota DECIMAL(5,2);
    SELECT nota_final INTO nota
    FROM Evaluacion
    WHERE id_camper = p_id_camper AND id_modulo = p_id_modulo
    LIMIT 1;
    RETURN nota >= 60;
END $$
DELIMITER ;

-- 3. Evaluar el nivel de riesgo de un camper según promedio
DELIMITER $$
CREATE FUNCTION riesgo_por_promedio(p_id_camper INT) RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(5,2);
    SELECT AVG(nota_final) INTO promedio FROM Evaluacion WHERE id_camper = p_id_camper;
    RETURN CASE
        WHEN promedio >= 80 THEN 'Bajo'
        WHEN promedio >= 60 THEN 'Medio'
        ELSE 'Alto'
    END;
END $$
DELIMITER ;

-- 4. Total de campers asignados a una ruta
DELIMITER $$
CREATE FUNCTION total_campers_ruta(p_id_ruta INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM AsignacionRutaCamper WHERE id_ruta = p_id_ruta;
    RETURN total;
END $$
DELIMITER ;

-- 5. Cantidad de módulos aprobados por un camper
DELIMITER $$
CREATE FUNCTION modulos_aprobados(p_id_camper INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Evaluacion
    WHERE id_camper = p_id_camper AND nota_final >= 60;
    RETURN total;
END $$
DELIMITER ;

-- 6. Validar si hay cupos en área
DELIMITER $$
CREATE FUNCTION cupos_disponibles(p_id_area INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE capacidad INT;
    DECLARE ocupacion INT;

    SELECT capacidad_maxima INTO capacidad FROM AreaEntrenamiento WHERE id_area = p_id_area;
    SELECT COUNT(*) INTO ocupacion FROM Asistencia WHERE id_area = p_id_area;

    RETURN ocupacion < capacidad;
END $$
DELIMITER ;

-- 7. Porcentaje de ocupación de un área
DELIMITER $$
CREATE FUNCTION porcentaje_ocupacion(p_id_area INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE capacidad INT;
    DECLARE ocupacion INT;

    SELECT capacidad_maxima INTO capacidad FROM AreaEntrenamiento WHERE id_area = p_id_area;
    SELECT COUNT(*) INTO ocupacion FROM Asistencia WHERE id_area = p_id_area;

    RETURN (ocupacion * 100.0) / capacidad;
END $$
DELIMITER ;

-- 8. Nota más alta en un módulo
DELIMITER $$
CREATE FUNCTION nota_maxima_modulo(p_id_modulo INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE maxnota DECIMAL(5,2);
    SELECT MAX(nota_final) INTO maxnota FROM Evaluacion WHERE id_modulo = p_id_modulo;
    RETURN maxnota;
END $$
DELIMITER ;

-- 9. Tasa de aprobación de una ruta
DELIMITER $$
CREATE FUNCTION tasa_aprobacion_ruta(p_id_ruta INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total INT;
    DECLARE aprobados INT;

    SELECT COUNT(*) INTO total FROM Evaluacion e
    JOIN Modulo m ON e.id_modulo = m.id_modulo
    WHERE m.id_ruta = p_id_ruta;

    SELECT COUNT(*) INTO aprobados FROM Evaluacion e
    JOIN Modulo m ON e.id_modulo = m.id_modulo
    WHERE m.id_ruta = p_id_ruta AND e.nota_final >= 60;

    RETURN (aprobados * 100.0) / total;
END $$
DELIMITER ;

-- 10. Verificar si un trainer tiene horario disponible
DELIMITER $$
CREATE FUNCTION trainer_disponible(p_id_trainer INT, p_id_horario INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE ocupado INT;
    SELECT COUNT(*) INTO ocupado FROM HorarioTrainer
    WHERE id_trainer = p_id_trainer AND id_horario = p_id_horario;

    RETURN ocupado = 0;
END $$
DELIMITER ;

-- 11. Promedio de notas por ruta
DELIMITER $$
CREATE FUNCTION promedio_ruta(p_id_ruta INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(5,2);
    SELECT AVG(e.nota_final) INTO promedio
    FROM Evaluacion e
    JOIN Modulo m ON e.id_modulo = m.id_modulo
    WHERE m.id_ruta = p_id_ruta;
    RETURN promedio;
END $$
DELIMITER ;

-- 12. Cuántas rutas tiene un trainer
DELIMITER $$
CREATE FUNCTION total_rutas_trainer(p_id_trainer INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT id_ruta) INTO total FROM AsignacionTrainerRuta
    WHERE id_trainer = p_id_trainer;
    RETURN total;
END $$
DELIMITER ;

-- 13. Verificar si un camper puede graduarse
DELIMITER $$
CREATE FUNCTION puede_graduarse(p_id_camper INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE modulos INT;
    DECLARE aprobados INT;

    SELECT COUNT(*) INTO modulos FROM Evaluacion WHERE id_camper = p_id_camper;
    SELECT COUNT(*) INTO aprobados FROM Evaluacion
    WHERE id_camper = p_id_camper AND nota_final >= 60;

    RETURN aprobados = modulos AND modulos > 0;
END $$
DELIMITER ;

-- 14. Obtener estado actual de un camper
DELIMITER $$
CREATE FUNCTION estado_actual_camper(p_id_camper INT) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE estado VARCHAR(50);
    SELECT ec.descripcion INTO estado
    FROM Camper c
    JOIN EstadoCamper ec ON c.id_estado_camper = ec.id_estado_camper
    WHERE c.id_camper = p_id_camper;
    RETURN estado;
END $$
DELIMITER ;

-- 15. Carga horaria semanal de un trainer
DELIMITER $$
CREATE FUNCTION carga_horaria_trainer(p_id_trainer INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM HorarioTrainer
    WHERE id_trainer = p_id_trainer;
    RETURN total;
END $$
DELIMITER ;

-- 16. Ruta con módulos pendientes de evaluación
DELIMITER $$
CREATE FUNCTION ruta_con_pendientes(p_id_ruta INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE pendientes INT;
    SELECT COUNT(*) INTO pendientes FROM Modulo m
    LEFT JOIN Evaluacion e ON m.id_modulo = e.id_modulo
    WHERE m.id_ruta = p_id_ruta AND e.id_eval IS NULL;
    RETURN pendientes > 0;
END $$
DELIMITER ;

-- 17. Promedio general del programa
DELIMITER $$
CREATE FUNCTION promedio_general() RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(5,2);
    SELECT AVG(nota_final) INTO promedio FROM Evaluacion;
    RETURN promedio;
END $$
DELIMITER ;

-- 18. Verificar si un horario choca en un área
DELIMITER $$
CREATE FUNCTION horario_choca(p_id_area INT, p_id_horario INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe FROM AreaEntrenamiento
    WHERE id_area = p_id_area AND id_horario = p_id_horario;
    RETURN existe > 0;
END $$
DELIMITER ;

-- 19. Campers en riesgo en una ruta específica
DELIMITER $$
CREATE FUNCTION campers_en_riesgo(p_id_ruta INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM AsignacionRutaCamper arc
    JOIN Camper c ON arc.id_camper = c.id_camper
    JOIN NivelRiesgo nr ON c.id_riesgo = nr.id_riesgo
    WHERE arc.id_ruta = p_id_ruta AND nr.descripcion = 'Alto';
    RETURN total;
END $$
DELIMITER ;

-- 20. Número de módulos evaluados por camper
DELIMITER $$
CREATE FUNCTION modulos_evaluados(p_id_camper INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT id_modulo) INTO total FROM Evaluacion
    WHERE id_camper = p_id_camper;
    RETURN total;
END $$
DELIMITER ;
