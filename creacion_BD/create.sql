--Grupo 7

USE BDCursosEmpresas;
GO

CREATE TABLE Empresas (
    IDEmpresa    INT IDENTITY(1,1) PRIMARY KEY,
    nombre       VARCHAR(50)  NOT NULL,
    sector       VARCHAR(50)  NOT NULL,
    descripcion  VARCHAR(255) NULL
);
GO

CREATE TABLE Roles (
    IDRol        INT IDENTITY(1,1) PRIMARY KEY,
    IDEmpresa    INT NOT NULL,
    nombre       VARCHAR(50)  NOT NULL,
    descripcion  VARCHAR(255) NULL,
    CONSTRAINT FK_Roles_Empresas FOREIGN KEY (IDEmpresa) REFERENCES Empresas(IDEmpresa)
);
GO

CREATE TABLE Curso (
    IDCurso        INT IDENTITY(1,1) PRIMARY KEY,
    IDRol          INT NOT NULL,
    nombre         VARCHAR(50)  NOT NULL,
    descripcion    VARCHAR(255) NULL,
    duracionhoras  INT NOT NULL,
    CONSTRAINT FK_Curso_Roles FOREIGN KEY (IDRol) REFERENCES Roles(IDRol)
);
GO

CREATE TABLE TipoArchivo (
    IDTipoArchivo INT IDENTITY(1,1) PRIMARY KEY,
    nombre        VARCHAR(20) NOT NULL UNIQUE
);
GO

CREATE TABLE Archivo (
    IDArchivo     INT IDENTITY(1,1) PRIMARY KEY,
    IDCurso       INT NOT NULL,
    IDTipoArchivo INT NOT NULL,
    nombre        VARCHAR(50)  NOT NULL,
    tamano        INT NOT NULL,
    link          VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Archivo_Curso       FOREIGN KEY (IDCurso)       REFERENCES Curso(IDCurso),
    CONSTRAINT FK_Archivo_TipoArchivo FOREIGN KEY (IDTipoArchivo) REFERENCES TipoArchivo(IDTipoArchivo)
);
GO

CREATE TABLE Usuario (
    IDUsuario           INT IDENTITY(1,1) PRIMARY KEY,
    nombre              VARCHAR(50) NOT NULL,
    apellido            VARCHAR(50) NOT NULL,
    mail                VARCHAR(50) NOT NULL UNIQUE,
    contrasenia         VARCHAR(50) NOT NULL,
    fechaDeInscripcion  DATE NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE UsuarioEmpresa (
    IDUsuario   INT NOT NULL,
    IDEmpresa   INT NOT NULL,
    fechaAlta   DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_UsuarioEmpresa PRIMARY KEY (IDUsuario, IDEmpresa),
    CONSTRAINT FK_UsuarioEmpresa_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario),
    CONSTRAINT FK_UsuarioEmpresa_Empresa FOREIGN KEY (IDEmpresa) REFERENCES Empresas(IDEmpresa)
);
GO

CREATE TABLE Inscripcion (
    IDInscripcion    INT IDENTITY(1,1) PRIMARY KEY,
    IDUsuario        INT NOT NULL,
    IDCurso          INT NOT NULL,
    fechaInscripcion DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Inscripcion_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario),
    CONSTRAINT FK_Inscripcion_Curso   FOREIGN KEY (IDCurso)   REFERENCES Curso(IDCurso),
    CONSTRAINT UQ_Inscripcion UNIQUE (IDUsuario, IDCurso)
);
GO

CREATE TABLE Instructor (
    IDInstructor INT IDENTITY(1,1) PRIMARY KEY,
    IDEmpresa    INT NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    apellido     VARCHAR(50) NOT NULL,
    mail         VARCHAR(50) NOT NULL UNIQUE,
    puesto       VARCHAR(50) NULL,
    CONSTRAINT FK_Instructor_Empresa FOREIGN KEY (IDEmpresa) REFERENCES Empresas(IDEmpresa)
);
GO

CREATE TABLE CursoInstructor (
    IDCurso      INT NOT NULL,
    IDInstructor INT NOT NULL,
    CONSTRAINT PK_CursoInstructor PRIMARY KEY (IDCurso, IDInstructor),
    CONSTRAINT FK_CursoInstructor_Curso      FOREIGN KEY (IDCurso)      REFERENCES Curso(IDCurso),
    CONSTRAINT FK_CursoInstructor_Instructor FOREIGN KEY (IDInstructor) REFERENCES Instructor(IDInstructor)
);
GO

CREATE TABLE Evaluacion (
    IDEvaluacion   INT IDENTITY(1,1) PRIMARY KEY,
    IDCurso        INT NOT NULL,
    titulo         VARCHAR(50) NOT NULL,
    puntajeMinimo  INT NOT NULL,
    CONSTRAINT FK_Evaluacion_Curso FOREIGN KEY (IDCurso) REFERENCES Curso(IDCurso),
    CONSTRAINT CK_Evaluacion_PuntajeMinimo CHECK (puntajeMinimo BETWEEN 0 AND 100)
);
GO

CREATE TABLE ProgresoArchivo (
    IDProgreso      INT IDENTITY(1,1) PRIMARY KEY,
    IDUsuario       INT NOT NULL,
    IDArchivo       INT NOT NULL,
    completado      BIT NOT NULL DEFAULT 0,
    fechaCompletado DATE NULL,
    CONSTRAINT FK_ProgresoArchivo_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario),
    CONSTRAINT FK_ProgresoArchivo_Archivo FOREIGN KEY (IDArchivo) REFERENCES Archivo(IDArchivo),
    CONSTRAINT UQ_ProgresoArchivo UNIQUE (IDUsuario, IDArchivo)
);
GO

CREATE TABLE TipoSuscripcion (
    IDTipoSuscripcion INT IDENTITY(1,1) PRIMARY KEY,
    nombre            VARCHAR(50)  NOT NULL,
    detalle           VARCHAR(255) NULL,
    duracion          INT NOT NULL,
    precio            DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE Suscripcion (
    IDSuscripcion      INT IDENTITY(1,1) PRIMARY KEY,
    IDTipoSuscripcion  INT NOT NULL,
    IDUsuario          INT NOT NULL,
    fechaInicio        DATE NOT NULL DEFAULT GETDATE(),
    fechaFinalizacion  DATE NULL,
    activa             BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Suscripcion_TipoSuscripcion FOREIGN KEY (IDTipoSuscripcion) REFERENCES TipoSuscripcion(IDTipoSuscripcion),
    CONSTRAINT FK_Suscripcion_Usuario         FOREIGN KEY (IDUsuario)         REFERENCES Usuario(IDUsuario)
);
GO

CREATE TABLE ResultadoEvaluacion (
    IDResultado    INT IDENTITY(1,1) PRIMARY KEY,
    IDEvaluacion   INT NOT NULL,
    IDUsuario      INT NOT NULL,
    notaObtenida   INT NOT NULL,
    aprobado       BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_ResultadoEvaluacion_Evaluacion FOREIGN KEY (IDEvaluacion) REFERENCES Evaluacion(IDEvaluacion),
    CONSTRAINT FK_ResultadoEvaluacion_Usuario    FOREIGN KEY (IDUsuario)    REFERENCES Usuario(IDUsuario),
    CONSTRAINT CK_ResultadoEvaluacion_Nota CHECK (notaObtenida BETWEEN 0 AND 100)
);
GO

CREATE TABLE Certificado (
    IDCertificado INT IDENTITY(1,1) PRIMARY KEY,
    IDResultado   INT NOT NULL UNIQUE,
    fechaEmision  DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Certificado_ResultadoEvaluacion FOREIGN KEY (IDResultado) REFERENCES ResultadoEvaluacion(IDResultado)
);
GO

CREATE TABLE Reseña (
    IDReseña      INT IDENTITY(1,1) PRIMARY KEY,
    IDCertificado INT NOT NULL,
    comentario    VARCHAR(255) NULL,
    puntuacion    INT NOT NULL,
    fecha         DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Reseña_Certificado FOREIGN KEY (IDCertificado) REFERENCES Certificado(IDCertificado),
    CONSTRAINT CK_Reseña_Puntuacion CHECK (puntuacion BETWEEN 1 AND 5)
);
GO
