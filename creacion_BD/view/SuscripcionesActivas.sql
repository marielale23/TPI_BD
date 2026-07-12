CREATE VIEW vista_SuscripcionesActivas AS
SELECT
    U.IDUsuario,
    U.nombre + ' ' + U.apellido AS Usuario,
    S.IDSuscripcion,
    TS.nombre AS TipoSuscripcion,
    S.fechaInicio,
    S.fechaFinalizacion
FROM Suscripcion AS S
INNER JOIN Usuario AS U ON U.IDUsuario = S.IDUsuario
INNER JOIN TipoSuscripcion AS TS ON TS.IDTipoSuscripcion = S.IDTipoSuscripcion
WHERE GETDATE() BETWEEN S.fechaInicio AND S.fechaFinalizacion;
GO
