USE BDCursosEmpresas;
GO

-- 1) Empresas
INSERT INTO Empresas (nombre, sector, descripcion) VALUES
('TechCorp', 'Tecnología', 'Empresa de desarrollo de software'),
('Consultora ABC', 'Consultoría', 'Servicios de consultoría empresarial');
GO

-- 2) Roles (depende de Empresas)
INSERT INTO Roles (IDEmpresa, nombre, descripcion) VALUES
(1, 'Desarrollador', 'Rol técnico de programación'),
(1, 'Analista de Datos', 'Rol de análisis y reportes'),
(2, 'Consultor Junior', 'Rol de consultoría inicial');
GO

-- 3) Usuario
INSERT INTO Usuario (nombre, apellido, mail, contrasenia, fechaDeInscripcion) VALUES
('Ana', 'Gómez', 'ana.gomez@mail.com', 'hash_pass_1', GETDATE()),
('Luis', 'Pérez', 'luis.perez@mail.com', 'hash_pass_2', GETDATE());
GO

-- 4) UsuarioEmpresa (depende de Usuario y Empresas)
INSERT INTO UsuarioEmpresa (IDUsuario, IDEmpresa, fechaAlta) VALUES
(1, 1, GETDATE()),
(2, 2, GETDATE());
GO

-- 5) Instructor (depende de Empresas)
INSERT INTO Instructor (IDEmpresa, nombre, apellido, mail, puesto) VALUES
(1, 'Marta', 'Suárez', 'marta.suarez@mail.com', 'Senior Developer'),
(2, 'Jorge', 'López', 'jorge.lopez@mail.com', 'Consultor Senior');
GO

-- 6) Curso (depende de Roles)
INSERT INTO Curso (IDRol, nombre, descripcion, duracionhoras) VALUES
(1, 'Introducción a SQL', 'Curso básico de bases de datos relacionales', 20),
(2, 'Power BI Esencial', 'Curso de visualización de datos', 15);
GO

-- 7) CursoInstructor (depende de Curso e Instructor)
INSERT INTO CursoInstructor (IDCurso, IDInstructor) VALUES
(1, 1),
(2, 2);
GO

-- 8) TipoArchivo
INSERT INTO TipoArchivo (nombre) VALUES
('Video'),
('PDF'),
('Audio');
GO

-- 9) Archivo (depende de Curso y TipoArchivo)
INSERT INTO Archivo (IDCurso, IDTipoArchivo, nombre, tamano, link) VALUES
(1, 1, 'Clase 1 - Introducción', 250, 'https://ejemplo.com/curso1/clase1.mp4'),
(1, 2, 'Apunte SQL básico', 10, 'https://ejemplo.com/curso1/apunte.pdf');
GO

-- 10) Evaluacion (depende de Curso)
INSERT INTO Evaluacion (IDCurso, titulo, puntajeMinimo) VALUES
(1, 'Examen final SQL', 60),
(2, 'Evaluación Power BI', 70);
GO

-- 11) TipoSuscripcion
INSERT INTO TipoSuscripcion (nombre, detalle, duracion, precio) VALUES
('Mensual', 'Acceso por 30 días', 30, 2500.00),
('Anual', 'Acceso por 365 días', 365, 20000.00);
GO

-- 12) Suscripcion (depende de TipoSuscripcion y Usuario)
-- fechaFinalizacion la completa el trigger tr_CalcularFechaFinSuscripcion
INSERT INTO Suscripcion (IDTipoSuscripcion, IDUsuario, fechaInicio, activa) VALUES
(1, 1, GETDATE(), 1),
(2, 2, GETDATE(), 1);
GO

-- 13) Inscripcion (depende de Usuario y Curso)
-- el trigger tr_ValidarSuscripcionActiva exige que el usuario
-- ya tenga una suscripcion activa antes de insertar aca
INSERT INTO Inscripcion (IDUsuario, IDCurso, fechaInscripcion) VALUES
(1, 1, GETDATE()),
(2, 2, GETDATE());
GO

-- 14) ProgresoArchivo (depende de Usuario y Archivo)
INSERT INTO ProgresoArchivo (IDUsuario, IDArchivo, completado, fechaCompletado) VALUES
(1, 1, 1, GETDATE()),
(1, 2, 0, NULL);
GO

-- 15) ResultadoEvaluacion (depende de Evaluacion y Usuario)
-- el trigger tr_Aprobar calcula "aprobado" automaticamente
INSERT INTO ResultadoEvaluacion (IDEvaluacion, IDUsuario, notaObtenida, aprobado) VALUES
(1, 1, 75, 0),
(2, 2, 55, 0);
GO

-- Certificado se genera solo via tr_EmitirCertificado, no hace
-- falta insertarlo manualmente si el trigger esta activo.

-- 16) Reseña (depende de Certificado, solo si ya se genero uno)
-- INSERT INTO Reseña (IDCertificado, comentario, puntuacion, fecha) VALUES
-- (1, 'Muy buen curso, aprendí bastante', 5, GETDATE());
GO
