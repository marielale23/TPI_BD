CREATE VIEW vista_UsuariosDelAño AS
SELECT
    U.IDUsuario,
    U.Nombre + ', ' + U.Apellido AS 'Nombre y apellido',
    U.fechaDeInscripcion,
    S.fechaFinalizacion
FROM Usuario AS U
INNER JOIN Suscripcion AS S ON U.IDUsuario = S.IDUsuario
WHERE YEAR(S.fechaInicio) = YEAR(GETDATE());
GO
