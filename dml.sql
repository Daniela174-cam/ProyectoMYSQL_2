USE Academico;

-- Estado del Camper
INSERT INTO EstadoCamper (descripcion) VALUES
('En proceso de ingreso'), ('Inscrito'), ('Aprobado'), ('Cursando'), ('Graduado'), ('Expulsado'), ('Retirado');

-- Estado de Evaluación
INSERT INTO EstadoEvaluacion (descripcion) VALUES
('Aprobado'), ('Bajo Rendimiento'), ('Reprobado');

-- Niveles de riesgo
INSERT INTO NivelRiesgo (descripcion) VALUES	
('Bajo'), ('Medio'), ('Alto');

-- Horarios (ejemplo clases cada 4 horas)
INSERT INTO Horario (hora, descripcion) VALUES
('08:00:00', 'Mañana'), ('12:00:00', 'Mediodía'), ('16:00:00', 'Tarde'), ('20:00:00', 'Noche');

-- Categorías de módulos
INSERT INTO CategoriaModulo (nombre_categoria) VALUES
('Fundamentos'), ('Web'), ('Formal'), ('Bases de Datos'), ('Backend');

-- SGDB
INSERT INTO SGDB (nombre) VALUES
('MySQL'), ('MongoDB'), ('PostgreSQL');

-- Tipos de contacto
INSERT INTO TipoContacto (tipo) VALUES
('Personal'), ('Acudiente'), ('Trabajo');

-- Cohorte
INSERT INTO Cohorte (nombre, fecha_inicio, fecha_fin) VALUES
('Cohorte Enero 2025', '2025-01-10', '2025-04-30'),
('Cohorte Mayo 2025', '2025-05-05', '2025-08-30'),
('Cohorte Septiembre 2025', '2025-09-02', '2025-12-15');

------------------------------------------------------------------------------------------------------------------
-- Acudientes
insert into Acudiente (id_acudiente, nombre, telefono) values (1, 'Shannan Benton', '+502 100 787 2523');
insert into Acudiente (id_acudiente, nombre, telefono) values (2, 'Maggy Welds', '+965 572 759 8881');
insert into Acudiente (id_acudiente, nombre, telefono) values (3, 'Forster Redish', '+81 701 948 1709');
insert into Acudiente (id_acudiente, nombre, telefono) values (4, 'Boonie Surfleet', '+92 112 806 5760');
insert into Acudiente (id_acudiente, nombre, telefono) values (5, 'Blinni Showl', '+62 682 989 9890');
insert into Acudiente (id_acudiente, nombre, telefono) values (6, 'Spenser Seiller', '+48 679 929 1768');
insert into Acudiente (id_acudiente, nombre, telefono) values (7, 'Ashil Troker', '+62 574 902 2747');
insert into Acudiente (id_acudiente, nombre, telefono) values (8, 'Maryann Thickins', '+48 929 268 3356');
insert into Acudiente (id_acudiente, nombre, telefono) values (9, 'Zechariah Poulson', '+62 329 107 1609');
insert into Acudiente (id_acudiente, nombre, telefono) values (10, 'Marion Leheude', '+48 172 732 5126');
insert into Acudiente (id_acudiente, nombre, telefono) values (11, 'Celeste Klosges', '+47 903 733 4833');
insert into Acudiente (id_acudiente, nombre, telefono) values (12, 'Sharleen Scalera', '+30 702 530 0230');
insert into Acudiente (id_acudiente, nombre, telefono) values (13, 'Fredelia Muschette', '+7 814 519 6831');
insert into Acudiente (id_acudiente, nombre, telefono) values (14, 'Carleen Griniov', '+46 121 678 0742');
insert into Acudiente (id_acudiente, nombre, telefono) values (15, 'Emmott O''Dougherty', '+54 249 865 6626');
insert into Acudiente (id_acudiente, nombre, telefono) values (16, 'Loreen Trulock', '+62 708 800 2490');
insert into Acudiente (id_acudiente, nombre, telefono) values (17, 'Barbabas Jedrzejkiewicz', '+687 545 941 1909');
insert into Acudiente (id_acudiente, nombre, telefono) values (18, 'Catharina Kaszper', '+55 652 940 4863');
insert into Acudiente (id_acudiente, nombre, telefono) values (19, 'Haze Hammatt', '+970 913 815 4090');
insert into Acudiente (id_acudiente, nombre, telefono) values (20, 'Jeremias Bottrill', '+7 109 601 5818');
insert into Acudiente (id_acudiente, nombre, telefono) values (21, 'Alexine Summerskill', '+381 211 786 9719');
insert into Acudiente (id_acudiente, nombre, telefono) values (22, 'Kim Spinello', '+46 308 485 1834');
insert into Acudiente (id_acudiente, nombre, telefono) values (23, 'De witt Caverhill', '+81 166 892 6773');
insert into Acudiente (id_acudiente, nombre, telefono) values (24, 'Duffy Tolland', '+55 657 322 0955');
insert into Acudiente (id_acudiente, nombre, telefono) values (25, 'Philomena Joel', '+66 324 102 8070');
insert into Acudiente (id_acudiente, nombre, telefono) values (26, 'Tamas Bride', '+48 619 410 4735');
insert into Acudiente (id_acudiente, nombre, telefono) values (27, 'Tiffanie Mongeot', '+93 831 243 9386');
insert into Acudiente (id_acudiente, nombre, telefono) values (28, 'Lyndell Peskin', '+52 449 319 7949');
insert into Acudiente (id_acudiente, nombre, telefono) values (29, 'Camila Northill', '+1 524 126 8173');
insert into Acudiente (id_acudiente, nombre, telefono) values (30, 'Chevalier Sollis', '+359 779 634 2652');
insert into Acudiente (id_acudiente, nombre, telefono) values (31, 'Billy Kapelhof', '+66 191 311 4594');
insert into Acudiente (id_acudiente, nombre, telefono) values (32, 'Abbey Arendsen', '+598 525 216 5214');
insert into Acudiente (id_acudiente, nombre, telefono) values (33, 'Arleen Mawdsley', '+976 923 307 6714');
insert into Acudiente (id_acudiente, nombre, telefono) values (34, 'Jessalin Aulsford', '+351 228 227 7385');
insert into Acudiente (id_acudiente, nombre, telefono) values (35, 'Danny Durbann', '+54 649 439 1219');
insert into Acudiente (id_acudiente, nombre, telefono) values (36, 'Giralda Chessor', '+381 616 461 4968');
insert into Acudiente (id_acudiente, nombre, telefono) values (37, 'Cristiano Braksper', '+62 540 575 6849');
insert into Acudiente (id_acudiente, nombre, telefono) values (38, 'Ophelia Ditts', '+52 881 543 5598');
insert into Acudiente (id_acudiente, nombre, telefono) values (39, 'Tabatha Philipson', '+62 854 394 8925');
insert into Acudiente (id_acudiente, nombre, telefono) values (40, 'Calley Gooly', '+7 752 559 2940');
insert into Acudiente (id_acudiente, nombre, telefono) values (41, 'Evyn Ledwich', '+218 553 102 8699');
insert into Acudiente (id_acudiente, nombre, telefono) values (42, 'Goldy Bonick', '+86 704 494 9625');
insert into Acudiente (id_acudiente, nombre, telefono) values (43, 'Libby McGuffog', '+86 775 900 2387');
insert into Acudiente (id_acudiente, nombre, telefono) values (44, 'Ruby Sloley', '+86 614 660 2501');
insert into Acudiente (id_acudiente, nombre, telefono) values (45, 'Alwin Cloonan', '+54 711 263 0787');
insert into Acudiente (id_acudiente, nombre, telefono) values (46, 'Goldy Eastlake', '+86 314 385 5189');
insert into Acudiente (id_acudiente, nombre, telefono) values (47, 'Marigold Matterson', '+82 370 583 2804');
insert into Acudiente (id_acudiente, nombre, telefono) values (48, 'Siegfried Ferrarini', '+33 415 753 4908');
insert into Acudiente (id_acudiente, nombre, telefono) values (49, 'Codi Munning', '+62 649 562 3912');
insert into Acudiente (id_acudiente, nombre, telefono) values (50, 'Ami Bawle', '+86 465 798 7112');
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Campers
INSERT INTO Camper (id_camper, identificacion, nombres, apellidos, direccion, id_acudiente, id_estado_camper, id_riesgo) VALUES
(1, '3815441374', 'Svend', 'Diddams', '2373', 1, 1, 1),
(2, '9723131463', 'Thomasina', 'Parradice', '02859', 2, 2, 2),
(3, '7551628991', 'Dionis', 'Coakley', '6493', 3, 3, 3),
(4, '0516722646', 'Karna', 'Gowthorpe', '652', 4, 4, 1),
(5, '2765693919', 'Lori', 'Weerdenburg', '7', 5, 5, 2),
(6, '4518793978', 'Marcile', 'Schubbert', '30586', 6, 6, 3),
(7, '1743001924', 'Nichol', 'Maginot', '38', 7, 7, 1),
(8, '4659956962', 'Hallie', 'Shulver', '3', 8, 1, 2),
(9, '0103043195', 'Theda', 'Taye', '89', 9, 2, 3),
(10, '1852472766', 'Madlen', 'Drakers', '598', 10, 3, 1),
(11, '2527705979', 'Maxi', 'Twelves', '4745', 11, 4, 2),
(12, '9773190773', 'Ofella', 'Robelow', '39441', 12, 5, 3),
(13, '8118135144', 'Brockie', 'Gandy', '08', 13, 6, 1),
(14, '1129152510', 'Coreen', 'Henrych', '7907', 14, 7, 2),
(15, '6748803691', 'Bobbe', 'David', '11065', 15, 1, 3),
(16, '5828549138', 'Olive', 'Manterfield', '10', 16, 2, 1),
(17, '3341043713', 'Karlotta', 'Antusch', '7', 17, 3, 2),
(18, '6815407780', 'Andee', 'Sottell', '56084', 18, 4, 3),
(19, '2734049678', 'Micheal', 'Riddell', '90', 19, 5, 1),
(20, '7232316453', 'Rorke', 'Girtin', '76460', 20, 6, 2),
(21, '9349947870', 'Roxanne', 'Tolerton', '44', 21, 7, 3),
(22, '7128158707', 'Xerxes', 'Cersey', '55', 22, 1, 1),
(23, '7447608912', 'Lezlie', 'Garner', '296', 23, 2, 2),
(24, '5172709118', 'Ally', 'Accum', '4', 24, 3, 3),
(25, '8178105551', 'Jelene', 'Kytter', '05151', 25, 4, 1),
(26, '5661523068', 'Ephrem', 'Noon', '0723', 26, 5, 2),
(27, '9086939392', 'Gerri', 'Rickaert', '678', 27, 6, 3),
(28, '2835843469', 'Raine', 'Somerfield', '9', 28, 7, 1),
(29, '8968717346', 'Valentia', 'Gurnett', '401', 29, 1, 2),
(30, '7383555899', 'Bern', 'Staite', '659', 30, 2, 3),
(31, '5086702542', 'Brent', 'Elis', '11', 31, 3, 1),
(32, '7806839372', 'Sallyann', 'Calleja', '30', 32, 4, 2),
(33, '2359101250', 'Woody', 'Renney', '613', 33, 5, 3),
(34, '7207484755', 'Geraldine', 'Bollins', '1515', 34, 6, 1),
(35, '0316605905', 'Dawna', 'Knight', '1936', 35, 7, 2),
(36, '7674283461', 'Mannie', 'Really', '48', 36, 1, 3),
(37, '3687635996', 'Kalindi', 'Flavelle', '687', 37, 2, 1),
(38, '1372610553', 'Rafe', 'Millery', '3', 38, 3, 2),
(39, '2658505353', 'Olenka', 'Cardinal', '5401', 39, 4, 3),
(40, '5767116881', 'Lars', 'Skill', '096', 40, 5, 1),
(41, '1725848171', 'Sybilla', 'Atkirk', '12', 41, 6, 2),
(42, '7499074692', 'Sadie', 'MacEveley', '1303', 42, 7, 3),
(43, '8940534891', 'Giovanna', 'Levey', '685', 43, 1, 1),
(44, '9456872025', 'Renaud', 'Richten', '9358', 44, 2, 2),
(45, '4778924398', 'Leontyne', 'Blitzer', '30', 45, 3, 3),
(46, '4200268779', 'Vivia', 'Bourke', '567', 46, 4, 1),
(47, '3095920164', 'Nara', 'Trembey', '8811', 47, 5, 2),
(48, '5390127714', 'Minetta', 'Cannam', '8', 48, 6, 3),
(49, '2073424457', 'Town', 'Lieber', '0136', 49, 7, 1),
(50, '2146918896', 'Cordie', 'Enterlein', '14498', 50, 1, 2);

------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Teléfonos Camper
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (1, 1, '+420 990 254 0790', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (2, 2, '+86 731 289 6570', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (3, 3, '+56 845 839 3783', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (4, 4, '+33 692 653 5175', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (5, 5, '+63 321 278 1001', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (6, 6, '+255 760 325 8809', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (7, 7, '+64 331 372 2149', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (8, 8, '+263 334 896 0856', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (9, 9, '+977 332 312 9124', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (10, 10, '+86 611 179 1699', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (11, 11, '+351 699 158 5029', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (12, 12, '+86 805 623 9335', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (13, 13, '+62 368 249 5094', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (14, 14, '+93 724 679 7702', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (15, 15, '+63 324 697 8482', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (16, 16, '+31 874 162 1090', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (17, 17, '+86 698 969 4478', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (18, 18, '+58 310 261 4518', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (19, 19, '+86 648 232 0082', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (20, 20, '+86 960 867 0563', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (21, 21, '+380 211 485 4607', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (22, 22, '+374 292 478 8233', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (23, 23, '+86 917 987 6870', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (24, 24, '+57 739 912 4623', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (25, 25, '+249 138 408 1140', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (26, 26, '+62 664 734 6669', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (27, 27, '+48 424 611 7174', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (28, 28, '+62 512 942 6839', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (29, 29, '+33 586 720 1220', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (30, 30, '+86 336 192 8683', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (31, 31, '+52 768 729 7377', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (32, 32, '+48 984 360 7073', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (33, 33, '+86 198 187 3418', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (34, 34, '+7 703 541 7520', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (35, 35, '+1 304 236 7590', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (36, 36, '+84 643 328 7703', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (37, 37, '+420 540 315 5290', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (38, 38, '+251 301 764 8453', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (39, 39, '+251 932 989 0439', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (40, 40, '+1 502 109 9185', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (41, 41, '+992 524 132 3021', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (42, 42, '+1 542 278 4958', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (43, 43, '+63 579 923 1213', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (44, 44, '+1 417 648 5843', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (45, 45, '+51 584 664 2485', 2);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (46, 46, '+47 157 819 7497', 3);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (47, 47, '+86 796 391 5538', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (48, 48, '+63 915 579 8342', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (49, 49, '+62 694 165 0496', 1);
insert into TelefonoCamper (id_telefono, id_camper, numero_telefono, id_tipo) values (50, 50, '+355 281 501 7193', 2);
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Correo Camper	
INSERT INTO CorreoCamper (id_camper, correo, id_tipo) VALUES
(1, 'svend.diddams@campus.com', 3),
(2, 'thomasina.parradice@campus.com', 1),
(3, 'dionis.coakley@campus.com', 2),
(4, 'karna.gowthorpe@campus.com', 1),
(5, 'lori.weerdenburg@campus.com', 2),
(6, 'marcile.schubbert@campus.com', 3),
(7, 'nichol.maginot@campus.com', 2),
(8, 'hallie.shulver@campus.com', 1),
(9, 'theda.taye@campus.com', 2),
(10, 'madlen.drakers@campus.com', 3),
(11, 'maxi.twelves@campus.com', 1),
(12, 'ofella.robelow@campus.com', 3),
(13, 'brockie.gandy@campus.com', 2),
(14, 'coreen.henrych@campus.com', 2),
(15, 'bobbe.david@campus.com', 1),
(16, 'olive.manterfield@campus.com', 3),
(17, 'karlotta.antusch@campus.com', 2),
(18, 'andee.sottell@campus.com', 1),
(19, 'micheal.riddell@campus.com', 3),
(20, 'rorke.girtin@campus.com', 2),
(21, 'roxanne.tolerton@campus.com', 1),
(22, 'xerxes.cersey@campus.com', 2),
(23, 'lezlie.garner@campus.com', 3),
(24, 'ally.accum@campus.com', 1),
(25, 'jelene.kytter@campus.com', 2),
(26, 'ephrem.noon@campus.com', 3),
(27, 'gerri.rickaert@campus.com', 1),
(28, 'raine.somerfield@campus.com', 3),
(29, 'valentia.gurnett@campus.com', 2),
(30, 'bern.staite@campus.com', 1),
(31, 'brent.elis@campus.com', 2),
(32, 'sallyann.calleja@campus.com', 3),
(33, 'woody.renney@campus.com', 1),
(34, 'geraldine.bollins@campus.com', 2),
(35, 'dawna.knight@campus.com', 3),
(36, 'mannie.really@campus.com', 2),
(37, 'kalindi.flavelle@campus.com', 1),
(38, 'rafe.millery@campus.com', 3),
(39, 'olenka.cardinal@campus.com', 1),
(40, 'lars.skill@campus.com', 2),
(41, 'sybilla.atkirk@campus.com', 2),
(42, 'sadie.maceveley@campus.com', 1),
(43, 'giovanna.levey@campus.com', 3),
(44, 'renaud.richten@campus.com', 2),
(45, 'leontyne.blitzer@campus.com', 1),
(46, 'vivia.bourke@campus.com', 3),
(47, 'nara.trembey@campus.com', 1),
(48, 'minetta.cannam@campus.com', 2),
(49, 'town.lieber@campus.com', 3),
(50, 'cordie.enterlein@campus.com', 2);

------------------------------------------------------------------------------------------------------------------

-- Rutas
INSERT INTO RutaEntrenamiento (nombre) VALUES
('Fundamentos de Programación'), 
('Programación Web'), 
('Backend');

-- Ruta-SGDB
INSERT INTO RutaSGDB (id_ruta, id_sgdb, tipo) VALUES
(1, 1, 'Principal'), (1, 2, 'Alternativo'),
(2, 2, 'Principal'), (2, 3, 'Alternativo'),
(3, 3, 'Principal'), (3, 1, 'Alternativo');

-- Módulos
INSERT INTO Modulo (nombre_modulo, id_ruta, id_categoria) VALUES
('Introducción a la algoritmia', 1, 1),
('PSeInt', 1, 1),
('Python', 1, 1),
('HTML', 2, 2),
('CSS', 2, 2),
('Bootstrap', 2, 2),
('NodeJS', 3, 5),
('Express', 3, 5);

-- Módulos Requisito
INSERT INTO ModuloRequisito (id_modulo, id_requisito) VALUES
(2, 1),  -- PSeInt ← Introducción a la algoritmia
(3, 2),  -- Python ← PSeInt
(5, 4),  -- CSS ← HTML
(6, 5),  -- Bootstrap ← CSS
(7, 3),  -- NodeJS ← Python
(8, 7),  -- Express ← NodeJS
(6, 4),  -- Bootstrap ← HTML (requisito adicional directo)
(8, 5);  -- Express ← CSS (front-end requerido para entender Express)

-- Version Módulo
INSERT INTO VersionModulo (id_modulo, descripcion, fecha_version) VALUES
(1, 'Versión inicial: conceptos básicos de algoritmia', '2024-01-10'),
(2, 'Se añadieron estructuras condicionales', '2024-02-15'),
(3, 'Versión inicial: sintaxis básica y variables', '2024-03-01'),
(3, 'Incluye estructuras de datos y funciones', '2024-06-01'),
(4, 'Introducción a etiquetas HTML5', '2024-01-20'),
(5, 'Añadido flexbox y posicionamiento', '2024-02-10'),
(6, 'Versión inicial con componentes de Bootstrap 4', '2024-03-15'),
(8, 'Incluye manejo de rutas y middlewares en Express', '2024-04-01');

------------------------------------------------------------------------------------------------------------------
-- Trainers
INSERT INTO Trainer (nombre) VALUES
('Jholver Pardo'), ('Miguel Perez'), ('Pedro Gomez');
------------------------------------------------------------------------------------------------------------------
-- telefonoTrainer
insert into TelefonoTrainer (id_telefono, id_trainer, numero_telefono, id_tipo) values (3, 1, '+62 485 449 6548', 3);
insert into TelefonoTrainer (id_telefono, id_trainer, numero_telefono, id_tipo) values (3, 2, '+86 249 787 4853', 3);
insert into TelefonoTrainer (id_telefono, id_trainer, numero_telefono, id_tipo) values (2, 3, '+1 435 272 2878', 1);

-- CorreoTrainers
INSERT INTO CorreoTrainer (id_trainer, correo) VALUES
(1, 'jholver.pardo@campus.com'),
(2, 'miguel.perez@campus.com'),
(3, 'pedro.gomez@campus.com');

-- horarioTrainer
INSERT INTO HorarioTrainer (id_trainer, id_horario) VALUES
(2, 1),   -- Miguel Perez  → Mañana
(3, 2),   -- Pedro Gomez   → Mediodía
(1, 4),   -- Jholver Pardo → Noche
(2, 3),   -- Miguel Perez  → Tarde
(3, 3),   -- Pedro Gomez   → Tarde
(3, 4);   -- Pedro Gomez   → Noche

-- Áreas
INSERT INTO AreaEntrenamiento (capacidad_maxima, id_horario) VALUES
(33, 1), (33, 2), (33, 3);

------------------------------------------------------------------------------------------------------------------
-- Asignación de campers a rutas (Inscripciones)

insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (1, 1, 3, '2025-03-07');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (2, 2, 1, '2024-02-20');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (3, 3, 1, '2024-11-05');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (4, 4, 3, '2024-01-23');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (5, 5, 3, '2024-12-08');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (6, 6, 3, '2024-10-08');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (7, 7, 3, '2024-09-13');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (8, 8, 1, '2025-03-23');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (9, 9, 2, '2024-12-13');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (10, 10, 1, '2024-09-20');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (11, 11, 3, '2024-11-02');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (12, 12, 2, '2024-04-24');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (13, 13, 3, '2024-01-04');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (14, 14, 2, '2025-01-20');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (15, 15, 1, '2025-01-02');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (16, 16, 1, '2024-01-25');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (17, 17, 2, '2024-02-05');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (18, 18, 3, '2024-11-24');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (19, 19, 1, '2024-03-23');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (20, 20, 1, '2025-02-24');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (21, 21, 2, '2024-09-17');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (22, 22, 3, '2024-02-06');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (23, 23, 1, '2024-09-12');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (24, 24, 3, '2024-11-20');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (25, 25, 3, '2024-08-18');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (26, 26, 3, '2024-08-20');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (27, 27, 3, '2025-01-30');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (28, 28, 3, '2024-06-01');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (29, 29, 2, '2024-07-27');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (30, 30, 2, '2024-04-08');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (31, 31, 1, '2024-10-13');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (32, 32, 3, '2024-10-20');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (33, 33, 2, '2024-11-26');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (34, 34, 1, '2024-05-06');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (35, 35, 2, '2025-01-04');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (36, 36, 3, '2025-02-12');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (37, 37, 1, '2024-02-29');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (38, 38, 1, '2024-10-04');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (39, 39, 2, '2024-07-16');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (40, 40, 2, '2024-07-03');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (41, 41, 2, '2024-12-19');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (42, 42, 2, '2024-08-11');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (43, 43, 2, '2024-09-07');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (44, 44, 1, '2024-10-10');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (45, 45, 2, '2025-02-16');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (46, 46, 1, '2024-09-22');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (47, 47, 2, '2024-06-02');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (48, 48, 3, '2024-11-29');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (49, 49, 3, '2025-01-04');
insert into AsignacionRutaCamper (id_asignacion, id_camper, id_ruta, fecha_inscripcion) values (50, 50, 2, '2024-08-30');
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Asignación de trainers a rutas
INSERT INTO AsignacionTrainerRuta (id_trainer, id_ruta, id_area) VALUES
(1, 1, 1),
(2, 2, 2),	
(3, 3, 3);
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Evaluaciones por módulo
INSERT INTO Evaluacion (id_camper, id_modulo, nota_teorica, nota_practica, nota_quiz, nota_final, id_estado_eval) VALUES
(1, 2, 28.88, 32.99, 9.89, 71.76, 3),
(2, 4, 6.52, 39.27, 4.01, 49.80, 3),
(3, 7, 3.52, 17.26, 7.53, 28.31, 2),
(4, 5, 25.78, 23.49, 3.38, 52.65, 3),
(5, 6, 27.12, 49.73, 4.23, 81.08, 2),
(6, 5, 14.01, 36.15, 3.56, 53.72, 3),
(7, 5, 9.80, 40.17, 6.90, 56.87, 2),
(8, 7, 26.02, 34.97, 2.53, 63.52, 1),
(9, 5, 22.77, 48.91, 3.59, 75.27, 2),
(10, 1, 13.82, 28.71, 1.25, 43.78, 3),
(11, 7, 22.26, 50.81, 0.91, 73.98, 1),
(12, 8, 5.55, 52.56, 6.83, 64.94, 1),
(13, 4, 18.74, 19.12, 2.32, 40.18, 2),
(14, 5, 2.81, 57.04, 3.30, 63.15, 1),
(15, 1, 25.95, 1.14, 2.33, 29.42, 2),
(16, 4, 28.07, 13.79, 6.91, 48.77, 2),
(17, 1, 1.22, 14.14, 1.00, 16.36, 1),
(18, 6, 19.79, 30.04, 7.67, 57.50, 1),
(19, 4, 12.02, 45.94, 1.72, 59.68, 2),
(20, 2, 10.26, 5.44, 6.33, 22.03, 2),
(21, 7, 14.07, 10.67, 7.57, 32.31, 3),
(22, 7, 15.21, 29.23, 0.04, 44.48, 1),
(23, 7, 4.60, 22.90, 0.57, 28.07, 1),
(24, 2, 11.53, 41.83, 8.99, 62.35, 3),
(25, 2, 17.44, 56.37, 4.96, 78.77, 1),
(26, 7, 19.89, 29.96, 7.15, 57.00, 2),
(27, 2, 13.97, 41.98, 4.99, 60.94, 2),
(28, 1, 26.06, 37.76, 3.87, 67.69, 1),
(29, 6, 3.02, 37.82, 8.31, 49.15, 2),
(30, 3, 12.79, 1.04, 4.19, 18.02, 1),
(31, 2, 26.51, 24.49, 0.48, 51.48, 2),
(32, 2, 7.37, 4.35, 8.73, 20.45, 2),
(33, 4, 10.70, 9.92, 6.51, 27.13, 2),
(34, 8, 17.13, 9.37, 2.13, 28.63, 3),
(35, 7, 12.76, 34.64, 2.83, 50.23, 2),
(36, 7, 25.84, 46.85, 0.96, 73.65, 1),
(37, 7, 28.44, 26.22, 3.03, 57.69, 1),
(38, 5, 26.20, 33.97, 8.40, 68.57, 3),
(39, 8, 26.45, 2.08, 2.28, 30.81, 2),
(40, 5, 22.87, 15.52, 4.29, 42.68, 3),
(41, 3, 23.06, 33.53, 6.11, 62.70, 2),
(42, 4, 28.80, 58.25, 6.06, 93.11, 3),
(43, 3, 4.71, 31.73, 9.69, 46.13, 3),
(44, 5, 23.09, 11.05, 9.75, 43.89, 3),
(45, 8, 28.65, 59.28, 5.44, 93.37, 1),
(46, 8, 17.76, 13.57, 3.22, 34.55, 3),
(47, 5, 13.80, 11.30, 4.16, 29.26, 1),
(48, 3, 17.53, 16.99, 5.29, 39.81, 3),
(49, 6, 18.71, 59.30, 1.06, 79.07, 2),
(50, 1, 6.28, 33.45, 8.17, 47.90, 3);
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Registro de asistencia
INSERT INTO Asistencia (id_camper, id_area, id_horario, fecha, presente) VALUES
(1, 2, 2, '2025-03-01', FALSE),
(2, 1, 2, '2025-03-02', TRUE),
(3, 1, 3, '2025-03-03', TRUE),
(4, 3, 1, '2025-03-04', TRUE),
(5, 2, 1, '2025-03-05', FALSE),
(6, 1, 2, '2025-03-06', TRUE),
(7, 1, 4, '2025-03-07', TRUE),
(8, 3, 2, '2025-03-08', FALSE),
(9, 2, 3, '2025-03-09', TRUE),
(10, 1, 3, '2025-03-10', FALSE),
(11, 3, 4, '2025-03-11', TRUE),
(12, 3, 4, '2025-03-12', FALSE),
(13, 2, 1, '2025-03-13', TRUE),
(14, 1, 4, '2025-03-14', FALSE),
(15, 1, 1, '2025-03-15', TRUE),
(16, 3, 3, '2025-03-16', FALSE),
(17, 2, 1, '2025-03-17', TRUE),
(18, 2, 3, '2025-03-18', FALSE),
(19, 1, 2, '2025-03-19', TRUE),
(20, 3, 2, '2025-03-20', FALSE),
(21, 3, 4, '2025-03-21', TRUE),
(22, 2, 4, '2025-03-22', FALSE),
(23, 1, 1, '2025-03-23', TRUE),
(24, 2, 4, '2025-03-24', TRUE),
(25, 1, 1, '2025-03-25', TRUE),
(26, 1, 1, '2025-03-26', FALSE),
(27, 2, 2, '2025-03-27', TRUE),
(28, 2, 4, '2025-03-28', FALSE),
(29, 2, 3, '2025-03-29', FALSE),
(30, 1, 3, '2025-03-30', TRUE),
(31, 1, 3, '2025-03-31', TRUE),
(32, 3, 1, '2025-04-01', FALSE),
(33, 1, 2, '2025-04-02', FALSE),
(34, 1, 1, '2025-04-03', FALSE),
(35, 3, 4, '2025-04-04', TRUE),
(36, 1, 1, '2025-04-05', FALSE),
(37, 2, 2, '2025-04-06', FALSE),
(38, 3, 2, '2025-04-07', TRUE),
(39, 2, 3, '2025-04-08', TRUE),
(40, 2, 4, '2025-04-09', TRUE),
(41, 2, 1, '2025-04-10', FALSE),
(42, 2, 4, '2025-04-11', TRUE),
(43, 3, 3, '2025-04-12', FALSE),
(44, 1, 3, '2025-04-13', FALSE),
(45, 3, 3, '2025-04-14', FALSE),
(46, 1, 1, '2025-04-15', TRUE),
(47, 2, 1, '2025-04-16', TRUE),
(48, 3, 2, '2025-04-17', FALSE),
(49, 2, 3, '2025-04-18', FALSE),
(50, 1, 4, '2025-04-19', TRUE);
