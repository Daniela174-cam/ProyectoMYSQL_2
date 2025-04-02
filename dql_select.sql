-- ========================
-- CAMPERS
-- ========================

-- 1. Obtener todos los campers inscritos actualmente
SELECT c.id_camper, c.identificacion, c.nombres, c.apellidos, ec.descripcion AS estado
FROM Camper c
JOIN EstadoCamper ec ON c.id_estado_camper = ec.id_estado_camper
WHERE ec.descripcion = 'Inscrito';

-- 2. Listar los campers con estado "Aprobado"
SELECT c.id_camper, c.nombres, c.apellidos
FROM Camper c
JOIN EstadoCamper e ON c.id_estado_camper = e.id_estado_camper
WHERE e.descripcion = 'Aprobado';

-- 3. Mostrar los campers que ya están cursando alguna ruta
SELECT c.id_camper, c.nombres, c.apellidos, r.nombre AS ruta
FROM Camper c
JOIN AsignacionRutaCamper arc ON c.id_camper = arc.id_camper
JOIN RutaEntrenamiento r ON arc.id_ruta = r.id_ruta;

-- 4. Consultar los campers graduados por cada ruta
SELECT r.nombre AS ruta, c.nombres, c.apellidos
FROM Camper c
JOIN AsignacionRutaCamper arc ON c.id_camper = arc.id_camper
JOIN RutaEntrenamiento r ON arc.id_ruta = r.id_ruta
JOIN EstadoCamper e ON c.id_estado_camper = e.id_estado_camper
WHERE e.descripcion = 'Graduado';

-- 5. Obtener los campers que se encuentran en estado "Expulsado" o "Retirado"
SELECT c.id_camper, c.nombres, c.apellidos, e.descripcion AS estado
FROM Camper c
JOIN EstadoCamper e ON c.id_estado_camper = e.id_estado_camper
WHERE e.descripcion IN ('Expulsado', 'Retirado');

-- 6. Listar campers con nivel de riesgo “Alto”
SELECT c.id_camper, c.nombres, c.apellidos, nr.descripcion AS nivel_riesgo
FROM Camper c
JOIN NivelRiesgo nr ON c.id_riesgo = nr.id_riesgo
WHERE nr.descripcion = 'Alto';

-- 7. Mostrar el total de campers por cada nivel de riesgo
SELECT nr.descripcion AS nivel_riesgo, COUNT(*) AS total_campers
FROM Camper c
JOIN NivelRiesgo nr ON c.id_riesgo = nr.id_riesgo
GROUP BY nr.descripcion;

-- 8. Obtener campers con más de un número telefónico registrado
SELECT c.id_camper, c.nombres, c.apellidos, COUNT(tc.id_telefono) AS cantidad_telefonos
FROM Camper c
JOIN TelefonoCamper tc ON c.id_camper = tc.id_camper
GROUP BY c.id_camper, c.nombres, c.apellidos
HAVING COUNT(tc.id_telefono) > 1;

-- 9. Listar los campers y sus respectivos acudientes y teléfonos
SELECT c.nombres, c.apellidos, a.nombre AS acudiente, a.telefono AS tel_acudiente
FROM Camper c
JOIN Acudiente a ON c.id_acudiente = a.id_acudiente;

-- 10. Mostrar campers que aún no han sido asignados a una ruta
SELECT c.id_camper, c.nombres, c.apellidos
FROM Camper c
LEFT JOIN AsignacionRutaCamper arc ON c.id_camper = arc.id_camper
WHERE arc.id_camper IS NULL;

-- ========================
-- EVALUACIONES
-- ========================

-- 1. Obtener las notas teóricas, prácticas y quizzes de cada camper por módulo
SELECT e.id_eval, c.nombres, c.apellidos, m.nombre_modulo, e.nota_teorica, e.nota_practica, e.nota_quiz
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo;

-- 2. Calcular la nota final de cada camper por módulo
SELECT c.nombres, c.apellidos, m.nombre_modulo,
       e.nota_teorica, e.nota_practica, e.nota_quiz,
       e.nota_final
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo;

-- 3. Mostrar los campers que reprobaron algún módulo (nota < 60)
SELECT c.nombres, c.apellidos, m.nombre_modulo, e.nota_final
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo
WHERE e.nota_final < 60;

-- 4. Listar los módulos con más campers en bajo rendimiento
SELECT m.nombre_modulo, COUNT(*) AS total_reprobados
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
WHERE e.nota_final < 60
GROUP BY m.nombre_modulo
ORDER BY total_reprobados DESC;

-- 5. Obtener el promedio de notas finales por cada módulo
SELECT m.nombre_modulo, AVG(e.nota_final) AS promedio_final
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
GROUP BY m.nombre_modulo;

-- 6. Consultar el rendimiento general por ruta de entrenamiento
SELECT r.nombre AS ruta, AVG(e.nota_final) AS promedio_ruta
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN RutaEntrenamiento r ON m.id_ruta = r.id_ruta
GROUP BY r.nombre;

-- 7. Mostrar los trainers responsables de campers con bajo rendimiento
SELECT DISTINCT t.nombre
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN AsignacionTrainerRuta atr ON m.id_ruta = atr.id_ruta
JOIN Trainer t ON atr.id_trainer = t.id_trainer
WHERE e.nota_final < 60;

-- 8. Comparar el promedio de rendimiento por trainer
SELECT t.nombre, AVG(e.nota_final) AS promedio_final
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN AsignacionTrainerRuta atr ON m.id_ruta = atr.id_ruta
JOIN Trainer t ON atr.id_trainer = t.id_trainer
GROUP BY t.nombre;

-- 9. Listar los mejores 5 campers por nota final en cada ruta
SELECT r.nombre AS ruta, c.nombres, c.apellidos, e.nota_final
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN RutaEntrenamiento r ON m.id_ruta = r.id_ruta
ORDER BY r.nombre, e.nota_final DESC
LIMIT 5;

-- 10. Mostrar cuántos campers pasaron cada módulo por ruta
SELECT r.nombre AS ruta, m.nombre_modulo, COUNT(*) AS aprobados
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN RutaEntrenamiento r ON m.id_ruta = r.id_ruta
WHERE e.nota_final >= 60
GROUP BY r.nombre, m.nombre_modulo;

-- ========================
-- RUTAS Y ÁREAS DE ENTRENAMIENTO
-- ========================

-- 1. Mostrar todas las rutas de entrenamiento disponibles
SELECT id_ruta, nombre FROM RutaEntrenamiento;

-- 2. Obtener las rutas con su SGDB principal y alternativo
SELECT r.nombre AS ruta, s.nombre AS sgdb, rs.tipo
FROM RutaSGDB rs
JOIN RutaEntrenamiento r ON rs.id_ruta = r.id_ruta
JOIN SGDB s ON rs.id_sgdb = s.id_sgdb;

-- 3. Listar los módulos asociados a cada ruta
SELECT r.nombre AS ruta, m.nombre_modulo
FROM Modulo m
JOIN RutaEntrenamiento r ON m.id_ruta = r.id_ruta;

-- 4. Consultar cuántos campers hay en cada ruta
SELECT r.nombre AS ruta, COUNT(arc.id_camper) AS total_campers
FROM AsignacionRutaCamper arc
JOIN RutaEntrenamiento r ON arc.id_ruta = r.id_ruta
GROUP BY r.nombre;

-- 5. Mostrar las áreas de entrenamiento y su capacidad máxima
SELECT id_area, capacidad_maxima FROM AreaEntrenamiento;

-- 6. Obtener las áreas que están ocupadas al 100%
SELECT a.id_area, a.capacidad_maxima, COUNT(asist.id_camper) AS ocupacion
FROM AreaEntrenamiento a
JOIN Asistencia asist ON a.id_area = asist.id_area
GROUP BY a.id_area, a.capacidad_maxima
HAVING COUNT(asist.id_camper) >= a.capacidad_maxima;

-- 7. Verificar la ocupación actual de cada área
SELECT a.id_area, a.capacidad_maxima, COUNT(asist.id_camper) AS ocupacion
FROM AreaEntrenamiento a
LEFT JOIN Asistencia asist ON a.id_area = asist.id_area
GROUP BY a.id_area, a.capacidad_maxima;

-- 8. Consultar los horarios disponibles por cada área
SELECT a.id_area, h.descripcion, h.hora
FROM AreaEntrenamiento a
JOIN Horario h ON a.id_horario = h.id_horario;

-- 9. Mostrar las áreas con más campers asignados
SELECT a.id_area, COUNT(asist.id_camper) AS total_campers
FROM AreaEntrenamiento a
JOIN Asistencia asist ON a.id_area = asist.id_area
GROUP BY a.id_area
ORDER BY total_campers DESC;

-- 10. Listar las rutas con sus respectivos trainers y áreas asignadas
SELECT r.nombre AS ruta, t.nombre AS trainer, a.id_area
FROM AsignacionTrainerRuta atr
JOIN RutaEntrenamiento r ON atr.id_ruta = r.id_ruta
JOIN Trainer t ON atr.id_trainer = t.id_trainer
JOIN AreaEntrenamiento a ON atr.id_area = a.id_area;

-- ========================
-- TRAINERS
-- ========================

-- 1. Listar todos los entrenadores registrados
SELECT id_trainer, nombre
FROM Trainer;

-- 2. Mostrar los trainers con sus horarios asignados
SELECT t.nombre, h.descripcion, h.hora
FROM HorarioTrainer ht
JOIN Trainer t ON ht.id_trainer = t.id_trainer
JOIN Horario h ON ht.id_horario = h.id_horario;

-- 3. Consultar los trainers asignados a más de una ruta
SELECT t.nombre, COUNT(DISTINCT atr.id_ruta) AS total_rutas
FROM AsignacionTrainerRuta atr
JOIN Trainer t ON atr.id_trainer = t.id_trainer
GROUP BY t.nombre
HAVING COUNT(DISTINCT atr.id_ruta) > 1;

-- 4. Obtener el número de campers por trainer
SELECT t.nombre, COUNT(DISTINCT arc.id_camper) AS total_campers
FROM AsignacionTrainerRuta atr
JOIN Trainer t ON atr.id_trainer = t.id_trainer
JOIN AsignacionRutaCamper arc ON arc.id_ruta = atr.id_ruta
GROUP BY t.nombre;

-- 5. Mostrar las áreas en las que trabaja cada trainer
SELECT t.nombre AS trainer, a.id_area
FROM AsignacionTrainerRuta atr
JOIN Trainer t ON atr.id_trainer = t.id_trainer
JOIN AreaEntrenamiento a ON atr.id_area = a.id_area;

-- 6. Listar los trainers sin asignación de área o ruta
SELECT t.id_trainer, t.nombre
FROM Trainer t
LEFT JOIN AsignacionTrainerRuta atr ON t.id_trainer = atr.id_trainer
WHERE atr.id_trainer IS NULL;

-- 7. Mostrar cuántos módulos están a cargo de cada trainer
-- (Asumiendo que un trainer se relaciona con módulos vía ruta)
SELECT t.nombre, COUNT(DISTINCT m.id_modulo) AS total_modulos
FROM AsignacionTrainerRuta atr
JOIN Trainer t ON atr.id_trainer = t.id_trainer
JOIN Modulo m ON atr.id_ruta = m.id_ruta
GROUP BY t.nombre;

-- 8. Obtener el trainer con mejor rendimiento promedio de campers
SELECT t.nombre, AVG(e.nota_final) AS promedio_rendimiento
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN AsignacionTrainerRuta atr ON m.id_ruta = atr.id_ruta
JOIN Trainer t ON atr.id_trainer = t.id_trainer
GROUP BY t.nombre
ORDER BY promedio_rendimiento DESC
LIMIT 1;

-- 9. Consultar los horarios ocupados por cada trainer
SELECT t.nombre, h.hora, h.descripcion
FROM HorarioTrainer ht
JOIN Trainer t ON ht.id_trainer = t.id_trainer
JOIN Horario h ON ht.id_horario = h.id_horario;

-- 10. Mostrar la disponibilidad semanal de cada trainer
-- (Basado en horario asignado)
SELECT t.nombre AS trainer, COUNT(ht.id_horario) AS total_bloques
FROM HorarioTrainer ht
JOIN Trainer t ON ht.id_trainer = t.id_trainer
GROUP BY t.nombre;


-- ========================
-- SUB CONSULTAS
-- ========================

-- 1. Obtener los campers con la nota más alta en cada módulo
SELECT e.id_modulo, m.nombre_modulo, c.nombres, c.apellidos, e.nota_final
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo
WHERE e.nota_final = (
    SELECT MAX(e2.nota_final)
    FROM Evaluacion e2
    WHERE e2.id_modulo = e.id_modulo
);

-- 2. Promedio general de notas por ruta y comparación con el global
SELECT r.nombre AS ruta,
       AVG(e.nota_final) AS promedio_ruta,
       (SELECT AVG(nota_final) FROM Evaluacion) AS promedio_global
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN RutaEntrenamiento r ON m.id_ruta = r.id_ruta
GROUP BY r.nombre;

-- 3. Áreas con más del 80% de ocupación
SELECT a.id_area, a.capacidad_maxima,
       COUNT(asist.id_camper) AS ocupados,
       ROUND(COUNT(asist.id_camper)*100.0 / a.capacidad_maxima, 2) AS porcentaje
FROM AreaEntrenamiento a
JOIN Asistencia asist ON a.id_area = asist.id_area
GROUP BY a.id_area, a.capacidad_maxima
HAVING porcentaje > 80;

-- 4. Trainers con menos del 70% de rendimiento promedio
SELECT t.nombre, AVG(e.nota_final) AS promedio
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN AsignacionTrainerRuta atr ON m.id_ruta = atr.id_ruta
JOIN Trainer t ON atr.id_trainer = t.id_trainer
GROUP BY t.nombre
HAVING AVG(e.nota_final) < 70;

-- 5. Campers con promedio por debajo del general
SELECT c.id_camper, c.nombres, c.apellidos, AVG(e.nota_final) AS promedio_camper
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
GROUP BY c.id_camper, c.nombres, c.apellidos
HAVING promedio_camper < (
    SELECT AVG(nota_final) FROM Evaluacion
);

-- 6. Módulos con menor tasa de aprobación
SELECT m.nombre_modulo,
       ROUND(SUM(CASE WHEN e.nota_final >= 60 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_aprobacion
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
GROUP BY m.nombre_modulo
ORDER BY tasa_aprobacion ASC;

-- 7. Campers que han aprobado todos los módulos de su ruta
SELECT c.nombres, c.apellidos
FROM Camper c
WHERE NOT EXISTS (
    SELECT 1
    FROM AsignacionRutaCamper arc
    JOIN Modulo m ON arc.id_ruta = m.id_ruta
    LEFT JOIN Evaluacion e ON e.id_modulo = m.id_modulo AND e.id_camper = arc.id_camper
    WHERE arc.id_camper = c.id_camper AND (e.nota_final IS NULL OR e.nota_final < 60)
);

-- 8. Rutas con más de 10 campers en bajo rendimiento (<60)
SELECT r.nombre, COUNT(*) AS reprobados
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN RutaEntrenamiento r ON m.id_ruta = r.id_ruta
WHERE e.nota_final < 60
GROUP BY r.nombre
HAVING COUNT(*) > 10;

-- 9. Promedio de rendimiento por SGDB principal
SELECT s.nombre AS sgdb, AVG(e.nota_final) AS promedio
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
JOIN RutaEntrenamiento r ON m.id_ruta = r.id_ruta
JOIN RutaSGDB rs ON r.id_ruta = rs.id_ruta
JOIN SGDB s ON rs.id_sgdb = s.id_sgdb
WHERE rs.tipo = 'Principal'
GROUP BY s.nombre;

-- 10. Módulos con al menos 30% de campers reprobados
SELECT m.nombre_modulo,
       ROUND(SUM(CASE WHEN e.nota_final < 60 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_reprobacion
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
GROUP BY m.nombre_modulo
HAVING tasa_reprobacion >= 30;

-- 11. Módulo más cursado por campers con riesgo alto
SELECT m.nombre_modulo, COUNT(*) AS veces_cursado
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo
WHERE c.id_riesgo = (SELECT id_riesgo FROM NivelRiesgo WHERE descripcion = 'Alto')
GROUP BY m.nombre_modulo
ORDER BY veces_cursado DESC
LIMIT 1;

-- 12. Trainers con más de 3 rutas asignadas
SELECT t.nombre, COUNT(DISTINCT atr.id_ruta) AS total_rutas
FROM AsignacionTrainerRuta atr
JOIN Trainer t ON atr.id_trainer = t.id_trainer
GROUP BY t.nombre
HAVING COUNT(DISTINCT atr.id_ruta) > 3;

-- 13. Horarios más ocupados por áreas
SELECT h.descripcion, h.hora, COUNT(*) AS usos
FROM Asistencia a
JOIN Horario h ON a.id_horario = h.id_horario
GROUP BY h.descripcion, h.hora
ORDER BY usos DESC;

-- 14. Rutas con mayor número de módulos
SELECT r.nombre, COUNT(m.id_modulo) AS total_modulos
FROM RutaEntrenamiento r
JOIN Modulo m ON r.id_ruta = m.id_ruta
GROUP BY r.nombre
ORDER BY total_modulos DESC;

-- 15. Campers que han cambiado de estado más de una vez
SELECT c.id_camper, c.nombres, c.apellidos, COUNT(h.id_historial) AS cambios
FROM Camper c
JOIN HistorialEstadoCamper h ON c.id_camper = h.id_camper
GROUP BY c.id_camper, c.nombres, c.apellidos
HAVING COUNT(h.id_historial) > 1;

-- 16. Evaluaciones donde la nota teórica es mayor a la práctica
SELECT e.id_eval, c.nombres, m.nombre_modulo, e.nota_teorica, e.nota_practica
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo
WHERE e.nota_teorica > e.nota_practica;

-- 17. Módulos donde la media de quizzes supera el 9
SELECT m.nombre_modulo, AVG(e.nota_quiz) AS promedio_quiz
FROM Evaluacion e
JOIN Modulo m ON e.id_modulo = m.id_modulo
GROUP BY m.nombre_modulo
HAVING AVG(e.nota_quiz) > 9;

-- 18. Ruta con mayor tasa de graduación
SELECT r.nombre, ROUND(SUM(CASE WHEN ec.descripcion = 'Graduado' THEN 1 ELSE 0 END)*100.0 / COUNT(c.id_camper), 2) AS tasa_graduacion
FROM AsignacionRutaCamper arc
JOIN RutaEntrenamiento r ON arc.id_ruta = r.id_ruta
JOIN Camper c ON arc.id_camper = c.id_camper
JOIN EstadoCamper ec ON c.id_estado_camper = ec.id_estado_camper
GROUP BY r.nombre
ORDER BY tasa_graduacion DESC
LIMIT 1;

-- 19. Módulos cursados por campers de riesgo medio o alto
SELECT DISTINCT m.nombre_modulo
FROM Evaluacion e
JOIN Camper c ON e.id_camper = c.id_camper
JOIN Modulo m ON e.id_modulo = m.id_modulo
WHERE c.id_riesgo IN (
    SELECT id_riesgo FROM NivelRiesgo WHERE descripcion IN ('Medio', 'Alto')
);

-- 20. Obtener la diferencia entre capacidad y ocupación en cada área
SELECT a.id_area,
       a.capacidad_maxima,
       COUNT(asist.id_camper) AS ocupacion_actual,
       (a.capacidad_maxima - COUNT(asist.id_camper)) AS diferencia
FROM AreaEntrenamiento a
LEFT JOIN Asistencia asist ON a.id_area = asist.id_area
GROUP BY a.id_area, a.capacidad_maxima;

