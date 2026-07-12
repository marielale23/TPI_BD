Sistema de Gestión de Cursos para Empresas

Este proyecto consiste en el desarrollo de una Base de Datos para la gestión de cursos, capacitaciones y seguimiento de progreso de usuarios dentro de un contexto empresarial.

📚 Contexto Académico

Este sistema fue desarrollado en el marco de la materia Base de Datos II (Año 2025) de la Tecnicatura Universitaria en Sistemas Informáticos - UTN FRGP (General Pacheco).

👥 Integrantes del equipo


Almiron, Joel Brian
De Grazia, Mariel Alejandra
Herrera, Mateo Tomas



🧩 Descripción del Sistema

La aplicación permite a los usuarios:


Registrarse e iniciar sesión
Suscribirse a distintos tipos de membresía
Inscribirse a cursos y realizar seguimiento de su progreso
Rendir evaluaciones y obtener certificados al aprobar
Dejar reseñas sobre los certificados obtenidos


Por su parte, las empresas pueden:


Gestionar sus propios roles y cursos internos
Asignar instructores a los cursos
Vincular usuarios como integrantes de la empresa


La base de datos respalda la lógica del sistema, gestionando entidades como:


Usuarios
Empresas
Roles
Cursos
Archivos (material de curso)
Instructores
Evaluaciones y resultados
Suscripciones y tipos de suscripción
Certificados y reseñas


⚙️ Componentes Técnicos

🔄 Triggers


tr_Aprobar — calcula automáticamente si un resultado de evaluación queda aprobado, comparando la nota obtenida contra el puntaje mínimo exigido.
tr_CalcularFechaFinSuscripcion — calcula la fecha de finalización de una suscripción a partir de la fecha de inicio y la duración del tipo de suscripción.
tr_EmitirCertificado — emite automáticamente un certificado cuando un resultado de evaluación pasa a estar aprobado.
tr_ImpedirCertificadoInvalido — impide la inserción manual de un certificado asociado a un resultado no aprobado.
tr_ValidarSuscripcionActiva — impide inscribir a un usuario a un curso si no tiene una suscripción vigente.


⚙️ Procedimientos almacenados


sp_InscribirUsuarioCurso — inscribe a un usuario a un curso, validando que exista y que no esté ya inscripto.
sp_RegistrarResultadoEvaluacion — registra la nota obtenida por un usuario en una evaluación.
sp_RenovarSuscripcion — genera una nueva suscripción para un usuario a partir de un tipo de suscripción.
sp_ReporteProgresoUsuario — devuelve el progreso de un usuario en todos los cursos en los que está inscripto.
sp_AltaCursoConInstructor — da de alta un curso y lo asigna a un instructor en una única transacción.


👁️‍🗨️ Vistas


vista_UsuariosDelAño — usuarios inscriptos durante el año actual, con fecha de inicio y fin de su suscripción.
vista_CursosConInstructores — cursos junto con los instructores asignados.
vista_ResultadosAprobados — resultados de evaluación aprobados, con usuario y curso correspondiente.
vista_SuscripcionesActivas — usuarios con suscripción vigente en el momento actual.
vista_ProgresoPorUsuarioCurso — porcentaje de archivos completados por usuario en cada curso.


🛠️ Funciones


fn_EstaSuscripcionActiva — indica si un usuario tiene una suscripción vigente.
fn_PorcentajeProgreso — calcula el porcentaje de avance de un usuario en un curso puntual.
fn_PromedioNotasUsuario — calcula el promedio de notas obtenidas por un usuario.
fn_CursosDeEmpresa — devuelve todos los cursos asociados a los roles de una empresa dada.


📝 Recomendaciones para el funcionamiento de la Base de Datos


El script está diseñado para crear la base de datos BDCursosEmpresas desde cero: crea las tablas, inserta los datos de prueba y genera todos los objetos (vistas, triggers, procedimientos y funciones) necesarios para el correcto funcionamiento del sistema.
Ejecutar los scripts en el siguiente orden:

Creación de tablas
Inserción de datos de prueba
Vistas, triggers, procedimientos y funciones







Grupo: 07
