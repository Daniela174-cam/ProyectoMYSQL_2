
CREATE DATABASE Academico;

USE Academico;

-- =====================================
--          CATÁLOGOS Y REFERENCIAS
-- =====================================

CREATE TABLE EstadoCamper (
    id_estado_camper INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE EstadoEvaluacion (	
    id_estado_eval INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE NivelRiesgo (
    id_riesgo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) 
);

CREATE TABLE Horario (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    hora TIME ,
    descripcion VARCHAR(100)
);

CREATE TABLE CategoriaModulo (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE SGDB (
    id_sgdb INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE
);

CREATE TABLE TipoContacto (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(20) NOT NULL
);

CREATE TABLE Cohorte (
    id_cohorte INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

-- =====================================
--               ENTIDADES
-- =====================================

CREATE TABLE Acudiente (
    id_acudiente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE Camper (
    id_camper INT AUTO_INCREMENT PRIMARY KEY,
    identificacion VARCHAR(50) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion TEXT NOT NULL,
    id_acudiente INT,
    id_estado_camper INT	,
    id_riesgo INT,
    FOREIGN KEY (id_acudiente) REFERENCES Acudiente(id_acudiente),
    FOREIGN KEY (id_estado_camper) REFERENCES EstadoCamper(id_estado_camper),
    FOREIGN KEY (id_riesgo) REFERENCES NivelRiesgo(id_riesgo)
);

CREATE TABLE TelefonoCamper (
    id_telefono INT AUTO_INCREMENT PRIMARY KEY,
    id_camper INT NOT NULL,
    numero_telefono VARCHAR(20) NOT NULL,
    id_tipo INT,
    FOREIGN KEY (id_camper) REFERENCES Camper(id_camper) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo) REFERENCES TipoContacto(id_tipo)
);

CREATE TABLE CorreoCamper (
    id_correo INT AUTO_INCREMENT PRIMARY KEY,
    id_camper INT NOT NULL,
    correo VARCHAR(100) NOT NULL,
    id_tipo INT,
    FOREIGN KEY (id_camper) REFERENCES Camper(id_camper) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo) REFERENCES TipoContacto(id_tipo)
);

CREATE TABLE RutaEntrenamiento (
    id_ruta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE RutaSGDB (
    id_ruta INT,
    id_sgdb INT,
    tipo VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_ruta, id_sgdb),
    FOREIGN KEY (id_ruta) REFERENCES RutaEntrenamiento(id_ruta),
    FOREIGN KEY (id_sgdb) REFERENCES SGDB(id_sgdb)
);

CREATE TABLE Modulo (
    id_modulo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_modulo VARCHAR(100) NOT NULL,
    id_ruta INT,
    id_categoria INT,
    FOREIGN KEY (id_ruta) REFERENCES RutaEntrenamiento(id_ruta) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES CategoriaModulo(id_categoria)
);

CREATE TABLE ModuloRequisito (
    id_modulo INT,
    id_requisito INT,
    PRIMARY KEY (id_modulo, id_requisito),
    FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo),
    FOREIGN KEY (id_requisito) REFERENCES Modulo(id_modulo)
);

CREATE TABLE VersionModulo (
    id_version INT AUTO_INCREMENT PRIMARY KEY,
    id_modulo INT,
    descripcion TEXT NOT NULL,
    fecha_version DATE NOT NULL,
    FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo)
);

CREATE TABLE Trainer (
    id_trainer INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE TelefonoTrainer (
    id_telefono INT AUTO_INCREMENT PRIMARY KEY,
    id_trainer INT NOT NULL,
    numero_telefono VARCHAR(20) NOT NULL,
    id_tipo INT,
    FOREIGN KEY (id_trainer) REFERENCES Trainer(id_trainer) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo) REFERENCES TipoContacto(id_tipo)
);

CREATE TABLE CorreoTrainer (
    id_correo INT AUTO_INCREMENT PRIMARY KEY,
    id_trainer INT NOT NULL,
    correo VARCHAR(100) NOT NULL,
    id_tipo INT,
    FOREIGN KEY (id_trainer) REFERENCES Trainer(id_trainer) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo) REFERENCES TipoContacto(id_tipo)
);

CREATE TABLE HorarioTrainer (
    id_trainer INT,
    id_horario INT,
    PRIMARY KEY (id_trainer, id_horario),
    FOREIGN KEY (id_trainer) REFERENCES Trainer(id_trainer),
    FOREIGN KEY (id_horario) REFERENCES Horario(id_horario)
);

CREATE TABLE AreaEntrenamiento (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    capacidad_maxima INT NOT NULL CHECK (capacidad_maxima <= 33),
    id_horario INT,
    FOREIGN KEY (id_horario) REFERENCES Horario(id_horario)
);

-- =====================================
--    NUEVAS TABLAS PARA COMPLETAR
-- =====================================

-- Historial de cambios de estado del camper
CREATE TABLE HistorialEstadoCamper (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_camper INT,
    id_estado_camper INT,
    fecha_cambio DATE,
    FOREIGN KEY (id_camper) REFERENCES Camper(id_camper),
    FOREIGN KEY (id_estado_camper) REFERENCES EstadoCamper(id_estado_camper)
);

-- Asignación de campers a rutas (Inscripciones)
CREATE TABLE AsignacionRutaCamper (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_camper INT,
    id_ruta INT,
    fecha_inscripcion DATE NOT NULL,
    FOREIGN KEY (id_camper) REFERENCES Camper(id_camper),
    FOREIGN KEY (id_ruta) REFERENCES RutaEntrenamiento(id_ruta)
);

-- Asignación de trainers a rutas
CREATE TABLE AsignacionTrainerRuta (
    id_trainer INT,
    id_ruta INT,
    id_area INT,
    PRIMARY KEY (id_trainer, id_ruta),
    FOREIGN KEY (id_trainer) REFERENCES Trainer(id_trainer),
    FOREIGN KEY (id_ruta) REFERENCES RutaEntrenamiento(id_ruta),
    FOREIGN KEY (id_area) REFERENCES AreaEntrenamiento(id_area)
);

-- Evaluaciones por módulo
CREATE TABLE Evaluacion (
    id_eval INT AUTO_INCREMENT PRIMARY KEY,
    id_camper INT,
    id_modulo INT,
    nota_teorica DECIMAL(5,2) CHECK (nota_teorica <= 30),
    nota_practica DECIMAL(5,2) CHECK (nota_practica <= 60),
    nota_quiz DECIMAL(5,2) CHECK (nota_quiz <= 10),
    nota_final DECIMAL(5,2),
    id_estado_eval INT,
    FOREIGN KEY (id_camper) REFERENCES Camper(id_camper),
    FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo),
    FOREIGN KEY (id_estado_eval) REFERENCES EstadoEvaluacion(id_estado_eval)
);

-- Registro de asistencia
CREATE TABLE Asistencia (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_camper INT,
    id_area INT,
    id_horario INT,
    fecha DATE NOT NULL,
    presente BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_camper) REFERENCES Camper(id_camper),
    FOREIGN KEY (id_area) REFERENCES AreaEntrenamiento(id_area),
    FOREIGN KEY (id_horario) REFERENCES Horario(id_horario)
);

 