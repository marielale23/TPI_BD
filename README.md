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


Usuario
Empresas
UsuarioEmpresa (relación N a N entre usuarios y empresas)
Roles
Curso
Archivo / TipoArchivo (material de curso)
Instructor
Evaluacion y ResultadoEvaluacion
Suscripcion y TiposSuscripcion
Certificado y Resena


🗂️ Estructura del repositorio

create_bd/          → script de creación de la base de datos (tablas)
insercion-bd/        → datos de prueba
view/                → vistas
triggers/            → triggers
store_procedure/      → procedimientos almacenados
function/            → funciones

⚙️ Componentes Técnicos

🔄 Triggers


tr_Aprobar — calcula automáticamente ResultadoEvaluacion.Aprobado, comparando la nota obtenida contra el puntaje mínimo exigido por la evaluación.
tr_CalcularFechaFinSuscripcion — calcula Suscripcion.FechaFinalizacion a partir de FechaInicio y la Duracion del tipo de suscripción (si Duracion es NULL, la suscripción no vence).
tr_EmitirCertificado — emite automáticamente un certificado cuando un resultado de evaluación pasa a estar aprobado.
tr_ImpedirCertificadoInvalido — impide la inserción manual de un certificado asociado a un resultado no aprobado.
tr_ValidarSuscripcionActiva — impide inscribir a un usuario a un curso si no tiene una suscripción vigente (activa y dentro de su rango de fechas).


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


🆕 Cambios de la versión 4 (revisión del profesor)


Se agregó la tabla UsuarioEmpresa para resolver la relación N a N entre Usuario y Empresas, que antes no estaba modelada.
Se agregó la tabla TipoArchivo como catálogo, reemplazando el campo Archivo.formato que antes era texto libre.
Curso.DuracionHoras pasó a NOT NULL.
Se agregaron CHECK de rango (0 a 100) en Evaluacion.PuntajeMinimo y ResultadoEvaluacion.NotaObtenida.
Suscripcion.FechaFinalizacion y ResultadoEvaluacion.Aprobado se calculan automáticamente vía trigger, en vez de cargarse manualmente.


📝 Recomendaciones para el funcionamiento de la Base de Datos


-El script create_bd/create_bd.sql elimina la base BDCursosEmpresas si ya existe y la vuelve a crear desde cero.
-Ejecutar los scripts en el siguiente orden:

  1- create_bd/create_bd.sql — creación de tablas
  2- insercion-bd/insercion_bd.sql — datos de prueba
  3-view/*.sql — vistas
  4-triggers/*.sql — triggers
  5-store_procedure/*.sql — procedimientos almacenados (algunos dependen de las vistas)
  6-function/*.sql — funciones

Grupo: 07
