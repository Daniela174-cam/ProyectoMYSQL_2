-- ========================
-- JOINS
-- ========================

-- 1. Nombres completos de los campers y nombre de la ruta a la que están inscritos
SELECT c.nombres, c.apellidos, r.nombre AS ruta
FROM Camper c
JOIN AsignacionRutaCamper arc ON c.id_camper = arc.id_camper
JOIN RutaEntrenamiento r ON arc.id_ruta = r.id_ruta;

-- 2. Campers con sus evaluaciones (nota teórica, práctica, quizzes y final) por módulo
SELECT c.nombres, c.apellidos, m.nombre_modulo,
       e.nota_teorica, e.nota_practica, e.nota_quiz, e.nota_final
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo;

-- 3. Todos los módulos que componen cada ruta de entrenamiento
SELECT r.nombre AS ruta, m.nombre_modulo
FROM RutaEntrenamiento r
JOIN Modulo m ON r.id_ruta = m.id_ruta;

-- 4. Rutas con sus trainers asignados y áreas en las que imparten clases
SELECT r.nombre AS ruta, t.nombre AS trainer, a.id_area
FROM AsignacionTrainerRuta atr
JOIN RutaEntrenamiento r ON atr.id_ruta = r.id_ruta
JOIN Trainer t ON atr.id_trainer = t.id_trainer
JOIN AreaEntrenamiento a ON atr.id_area = a.id_area;

-- 5. Campers junto con el trainer responsable de su ruta actual
SELECT c.nombres, c.apellidos, t.nombre AS trainer
FROM Camper c
JOIN AsignacionRutaCamper arc ON c.id_camper = arc.id_camper
JOIN AsignacionTrainerRuta atr ON arc.id_ruta = atr.id_ruta
JOIN Trainer t ON atr.id_trainer = t.id_trainer;

-- 6. Evaluaciones realizadas con nombre de camper, módulo y ruta
SELECT e.id_eval, c.nombres, c.apellidos, m.nombre_modulo, r.nombre AS ruta
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN RutaEntrenamiento r ON m.id_ruta = r.id_ruta;

-- 7. Trainers y los horarios en que están asignados a áreas de entrenamiento
SELECT t.nombre AS trainer, h.descripcion, h.hora, a.id_area
FROM HorarioTrainer ht
JOIN Trainer t ON ht.id_trainer = t.id_trainer
JOIN Horario h ON ht.id_horario = h.id_horario
JOIN AsignacionTrainerRuta atr ON t.id_trainer = atr.id_trainer
JOIN AreaEntrenamiento a ON atr.id_area = a.id_area;

-- 8. Campers junto con su estado actual y nivel de riesgo
SELECT c.nombres, c.apellidos, ec.descripcion AS estado, nr.descripcion AS nivel_riesgo
FROM Camper c
LEFT JOIN EstadoCamper ec ON c.id_estado_camper = ec.id_estado_camper
LEFT JOIN NivelRiesgo nr ON c.id_riesgo = nr.id_riesgo;

-- 9. Módulos de cada ruta (con porcentaje de nota teórica, práctica, quiz)
-- Suponiendo que los porcentajes están definidos en alguna columna que no está en tu modelo,
-- este es solo una estructura base; ajusta según tu modelo.
-- Aquí solo se listan módulos y rutas.
SELECT r.nombre AS ruta, m.nombre_modulo
FROM Modulo m
JOIN RutaEntrenamiento r ON m.id_ruta = r.id_ruta;

-- 10. Nombres de las áreas junto con nombres de campers que asisten a esos espacios
SELECT a.id_area, c.nombres, c.apellidos
FROM Asistencia asist
JOIN AreaEntrenamiento a ON asist.id_area = a.id_area
JOIN Camper c ON asist.id_camper = c.id_camper;


-- ========================
-- Joins Condiciones Especificas
-- ========================

-- 1. Campers que han aprobado todos los módulos de su ruta (nota_final >= 60)
SELECT c.nombres, c.apellidos
FROM Camper c
JOIN AsignacionRutaCamper arc ON c.id_camper = arc.id_camper
WHERE NOT EXISTS (
    SELECT 1
    FROM Modulo m
    LEFT JOIN Evaluacion e ON m.id_modulo = e.id_modulo AND e.id_camper = c.id_camper
    WHERE m.id_ruta = arc.id_ruta AND (e.nota_final IS NULL OR e.nota_final < 60)
);

-- 2. Rutas que tienen más de 10 campers inscritos actualmente
SELECT r.nombre, COUNT(*) AS total_campers
FROM AsignacionRutaCamper arc
JOIN Camper c ON arc.id_camper = c.id_camper
JOIN EstadoCamper ec ON c.id_estado_camper = ec.id_estado_camper
JOIN RutaEntrenamiento r ON arc.id_ruta = r.id_ruta
WHERE ec.descripcion = 'Inscrito'
GROUP BY r.nombre
HAVING COUNT(*) > 10;

-- 3. Áreas que superan el 80% de su capacidad con número actual de campers
SELECT a.id_area, a.capacidad_maxima, COUNT(asist.id_camper) AS ocupacion,
       ROUND(COUNT(asist.id_camper)*100.0 / a.capacidad_maxima, 2) AS porcentaje
FROM AreaEntrenamiento a
JOIN Asistencia asist ON a.id_area = asist.id_area
GROUP BY a.id_area, a.capacidad_maxima
HAVING porcentaje > 80;

-- 4. Trainers que imparten más de una ruta diferente
SELECT t.nombre, COUNT(DISTINCT atr.id_ruta) AS total_rutas
FROM AsignacionTrainerRuta atr
JOIN Trainer t ON atr.id_trainer = t.id_trainer
GROUP BY t.nombre
HAVING COUNT(DISTINCT atr.id_ruta) > 1;

-- 5. Evaluaciones donde la nota práctica es mayor que la nota teórica
SELECT c.nombres, c.apellidos, m.nombre_modulo, e.nota_teorica, e.nota_practica
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo
WHERE e.nota_practica > e.nota_teorica;

-- 6. Campers en rutas cuyo SGDB principal es MySQL
SELECT DISTINCT c.nombres, c.apellidos, r.nombre AS ruta
FROM Camper c
JOIN AsignacionRutaCamper arc ON c.id_camper = arc.id_camper
JOIN RutaEntrenamiento r ON arc.id_ruta = r.id_ruta
JOIN RutaSGDB rs ON r.id_ruta = rs.id_ruta
JOIN SGDB s ON rs.id_sgdb = s.id_sgdb
WHERE rs.tipo = 'Principal' AND s.nombre = 'MySQL';

-- 7. Nombres de módulos donde campers han tenido bajo rendimiento (<60)
SELECT DISTINCT m.nombre_modulo
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
WHERE e.nota_final < 60;

-- 8. Rutas con más de 3 módulos asociados
SELECT r.nombre, COUNT(m.id_modulo) AS total_modulos
FROM RutaEntrenamiento r
JOIN Modulo m ON r.id_ruta = m.id_ruta
GROUP BY r.nombre
HAVING COUNT(m.id_modulo) > 3;

-- 9. Inscripciones realizadas en los últimos 30 días con campers y rutas
SELECT arc.fecha_inscripcion, c.nombres, c.apellidos, r.nombre AS ruta
FROM AsignacionRutaCamper arc
JOIN Camper c ON arc.id_camper = c.id_camper
JOIN RutaEntrenamiento r ON arc.id_ruta = r.id_ruta
WHERE arc.fecha_inscripcion >= CURDATE() - INTERVAL 30 DAY;

-- 10. Trainers asignados a rutas con campers en estado de “Alto Riesgo”
SELECT DISTINCT t.nombre
FROM AsignacionTrainerRuta atr
JOIN Trainer t ON atr.id_trainer = t.id_trainer
JOIN AsignacionRutaCamper arc ON atr.id_ruta = arc.id_ruta
JOIN Camper c ON arc.id_camper = c.id_camper
JOIN NivelRiesgo nr ON c.id_riesgo = nr.id_riesgo
WHERE nr.descripcion = 'Alto';


-- ========================
-- Joins Funciones Agregación 
-- ========================

-- 1. Promedio de nota final por módulo
SELECT m.nombre_modulo, AVG(e.nota_final) AS promedio_final
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
GROUP BY m.nombre_modulo;

-- 2. Cantidad total de campers por ruta
SELECT r.nombre AS ruta, COUNT(arc.id_camper) AS total_campers
FROM RutaEntrenamiento r
JOIN AsignacionRutaCamper arc ON r.id_ruta = arc.id_ruta
GROUP BY r.nombre;

-- 3. Cantidad de evaluaciones realizadas por cada trainer (según rutas que imparte)
SELECT t.nombre AS trainer, COUNT(e.id_eval) AS total_evaluaciones
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN AsignacionTrainerRuta atr ON m.id_ruta = atr.id_ruta
JOIN Trainer t ON atr.id_trainer = t.id_trainer
GROUP BY t.nombre;

-- 4. Promedio general de rendimiento por cada área de entrenamiento
SELECT a.id_area, AVG(e.nota_final) AS promedio_rendimiento
FROM Evaluacion e
JOIN Asistencia asist ON e.id_camper = asist.id_camper
JOIN AreaEntrenamiento a ON asist.id_area = a.id_area
GROUP BY a.id_area;

-- 5. Cantidad de módulos asociados a cada ruta de entrenamiento
SELECT r.nombre AS ruta, COUNT(m.id_modulo) AS total_modulos
FROM RutaEntrenamiento r
LEFT JOIN Modulo m ON r.id_ruta = m.id_ruta
GROUP BY r.nombre;

-- 6. Promedio de nota final de campers en estado “Cursando”
SELECT AVG(e.nota_final) AS promedio_cursando
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN EstadoCamper ec ON c.id_estado_camper = ec.id_estado_camper
WHERE ec.descripcion = 'Cursando';

-- 7. Número de campers evaluados en cada módulo
SELECT m.nombre_modulo, COUNT(DISTINCT e.id_camper) AS total_evaluados
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
GROUP BY m.nombre_modulo;

-- 8. Porcentaje de ocupación actual por cada área de entrenamiento
SELECT a.id_area,
       a.capacidad_maxima,
       COUNT(asist.id_camper) AS ocupados,
       ROUND(COUNT(asist.id_camper)*100.0 / a.capacidad_maxima, 2) AS porcentaje_ocupacion
FROM AreaEntrenamiento a
LEFT JOIN Asistencia asist ON a.id_area = asist.id_area
GROUP BY a.id_area, a.capacidad_maxima;

-- 9. Cuántos trainers tiene asignados cada área
SELECT a.id_area, COUNT(DISTINCT atr.id_trainer) AS total_trainers
FROM AreaEntrenamiento a
JOIN AsignacionTrainerRuta atr ON a.id_area = atr.id_area
GROUP BY a.id_area;

-- 10. Rutas que tienen más campers en riesgo alto
SELECT r.nombre AS ruta, COUNT(*) AS total_riesgo_alto
FROM AsignacionRutaCamper arc
JOIN Camper c ON arc.id_camper = c.id_camper
JOIN NivelRiesgo nr ON c.id_riesgo = nr.id_riesgo
JOIN RutaEntrenamiento r ON arc.id_ruta = r.id_ruta
WHERE nr.descripcion = 'Alto'
GROUP BY r.nombre
ORDER BY total_riesgo_alto DESC;
