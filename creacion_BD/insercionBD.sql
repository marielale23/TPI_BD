USE BDCursosEmpresas;
GO

INSERT INTO Empresas (nombre, sector, descripcion) VALUES
('TechCorp', 'Tecnología', 'Empresa de desarrollo de software'),
('Consultora ABC', 'Consultoría', 'Servicios de consultoría empresarial');
GO

INSERT INTO Roles (IDEmpresa, nombre, descripcion) VALUES
(1, 'Desarrollador', 'Rol técnico de programación'),
(1, 'Analista de Datos', 'Rol de análisis y reportes'),
(2, 'Consultor Junior', 'Rol de consultoría inicial');
GO

INSERT INTO Usuario (nombre, apellido, mail, contrasenia, fechaDeInscripcion) VALUES
('Ana', 'Gómez', 'ana.gomez@mail.com', 'hash_pass_1', GETDATE()),
('Luis', 'Pérez', 'luis.perez@mail.com', 'hash_pass_2', GETDATE());
GO

INSERT INTO UsuarioEmpresa (IDUsuario, IDEmpresa, fechaAlta) VALUES
(1, 1, GETDATE()),
(2, 2, GETDATE());
GO

INSERT INTO Instructor (IDEmpresa, nombre, apellido, mail, puesto) VALUES
(1, 'Marta', 'Suárez', 'marta.suarez@mail.com', 'Senior Developer'),
(2, 'Jorge', 'López', 'jorge.lopez@mail.com', 'Consultor Senior');
GO

INSERT INTO Curso (IDRol, nombre, descripcion, duracionhoras) VALUES
(1, 'Introducción a SQL', 'Curso básico de bases de datos relacionales', 20),
(2, 'Power BI Esencial', 'Curso de visualización de datos', 15);
GO

INSERT INTO CursoInstructor (IDCurso, IDInstructor) VALUES
(1, 1),
(2, 2);
GO

INSERT INTO TipoArchivo (nombre) VALUES
('Video'),
('PDF'),
('Audio');
GO

INSERT INTO Archivo (IDCurso, IDTipoArchivo, nombre, tamano, link) VALUES
(1, 1, 'Clase 1 - Introducción', 250, 'https://ejemplo.com/curso1/clase1.mp4'),
(1, 2, 'Apunte SQL básico', 10, 'https://ejemplo.com/curso1/apunte.pdf');
GO

INSERT INTO Evaluacion (IDCurso, titulo, puntajeMinimo) VALUES
(1, 'Examen final SQL', 60),
(2, 'Evaluación Power BI', 70);
GO

INSERT INTO TipoSuscripcion (nombre, detalle, duracion, precio) VALUES
('Mensual', 'Acceso por 30 días', 30, 2500.00),
('Anual', 'Acceso por 365 días', 365, 20000.00);
GO

INSERT INTO Suscripcion (IDTipoSuscripcion, IDUsuario, fechaInicio, activa) VALUES
(1, 1, GETDATE(), 1),
(2, 2, GETDATE(), 1);
GO

INSERT INTO Inscripcion (IDUsuario, IDCurso, fechaInscripcion) VALUES
(1, 1, GETDATE()),
(2, 2, GETDATE());
GO

INSERT INTO ProgresoArchivo (IDUsuario, IDArchivo, completado, fechaCompletado) VALUES
(1, 1, 1, GETDATE()),
(1, 2, 0, NULL);
GO

INSERT INTO ResultadoEvaluacion (IDEvaluacion, IDUsuario, notaObtenida, aprobado) VALUES
(1, 1, 75, 0),
(2, 2, 55, 0);
GO


GO
