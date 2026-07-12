CREATE TRIGGER tr_CalcularFechaFinSuscripcion
ON Suscripcion
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE s
    SET s.fechaFinalizacion = DATEADD(DAY, ts.duracion, s.fechaInicio)
    FROM Suscripcion s
    INNER JOIN inserted i ON s.IDSuscripcion = i.IDSuscripcion
    INNER JOIN TipoSuscripcion ts ON ts.IDTipoSuscripcion = s.IDTipoSuscripcion;
END;
GO
