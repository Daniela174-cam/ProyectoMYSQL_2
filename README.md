# 📚 Proyecto: Sistema Académico CampusLands
🧾 Descripción del Proyecto
Este proyecto consiste en el diseño y desarrollo de una base de datos relacional para la gestión académica de los estudiantes (campers), trainers, rutas de formación y evaluaciones dentro del ecosistema de CampusLands.

La base de datos permite:

Registrar y gestionar campers, evaluaciones, rutas y módulos.

Automatizar cambios de estado, asignaciones y control de asistencia.

Generar reportes de rendimiento y ocupación.

Aplicar validaciones y lógica avanzada mediante funciones, procedimientos, triggers y eventos.

# 🛠 Requisitos del Sistema
Sistema Gestor: MySQL Server 8.0 o superior

Cliente recomendado: MySQL Workbench, DBeaver o CLI MySQL

Activación requerida: event_scheduler = ON para ejecutar eventos

# ⚙️ Instalación y Configuración
Clona o descarga este repositorio en tu equipo.

Abre tu cliente de base de datos (MySQL Workbench o similar).

Ejecuta el archivo estructura_ddl.sql para crear toda la estructura (tablas, relaciones).

Ejecuta el archivo datos_dml.sql para insertar los datos iniciales (camper, rutas, evaluaciones, etc.).

Ejecuta logica_avanzada.sql que incluye:

Consultas SQL (básicas, avanzadas, JOINs)

Procedimientos almacenados

Funciones

Triggers

Eventos

# 🗃 Estructura de la Base de Datos
La base de datos está compuesta por:

Camper: Registro principal de estudiantes.

Acudiente: Contacto de emergencia por cada camper.

Trainer: Docentes asignados a rutas y áreas.

RutaEntrenamiento: Rutas formativas (Backend, FullStack, etc.).

Modulo: Contenidos de cada ruta.

Evaluacion: Registro de calificaciones por módulo.

AreaEntrenamiento y Asistencia: Control de espacio físico y asistencia.

Tablas de soporte: EstadoCamper, NivelRiesgo, SGDB, etc.

# 🧪 Ejemplos de Consultas
-- Campers en estado 'Inscrito'
SELECT nombres, apellidos FROM Camper
JOIN EstadoCamper USING(id_estado_camper)
WHERE descripcion = 'Inscrito';

-- Promedio de notas por módulo
SELECT nombre_modulo, AVG(nota_final) FROM Evaluacion
JOIN Modulo USING(id_modulo)
GROUP BY nombre_modulo;
# 🔁 Procedimientos, Funciones, Triggers y Eventos
Procedimientos: Registro de campers, asignación automática, graduación, etc.

Funciones: Promedio ponderado, validaciones, estado académico.

Triggers: Actualizan estados, validan notas, automatizan registros.

Eventos: Tareas automáticas diarias y mensuales (reportes, limpieza, notificaciones).

Ejemplo de uso:
CALL registrar_camper('123456', 'Juan', 'Pérez', 'Calle 123', 1, 1, 2);
SELECT promedio_ponderado_camper(10);
# 🔐 Roles de Usuario y Permisos
Se crearon 5 roles con los siguientes permisos (ejemplo básico):

# Rol	Permisos principales
admin	ALL PRIVILEGES
trainer	SELECT, INSERT, UPDATE en evaluación
coordinador	SELECT, UPDATE en rutas y asignaciones
asistente	INSERT, UPDATE en asistencia y horarios
consulta	SOLO SELECT
Para crear usuarios:
CREATE USER 'coordinador1'@'%' IDENTIFIED BY '1234';
GRANT SELECT, UPDATE ON Academico.* TO 'coordinador1'@'%';
# 👤 Contribuciones
Este proyecto fue desarrollado de forma individual por mí. Todos los módulos, scripts y documentación han sido diseñados y probados personalmente.

# 📩 Licencia y Contacto
Este proyecto es de uso académico. Si tienes preguntas o sugerencias:

📧 Email: [danielamendez0023@gmail.com]
