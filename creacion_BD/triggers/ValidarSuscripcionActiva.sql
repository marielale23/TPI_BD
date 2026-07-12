CREATE TRIGGER tr_ValidarSuscripcionActiva
ON Inscripcion
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1 FROM Suscripcion s
            WHERE s.IDUsuario = i.IDUsuario
              AND GETDATE() BETWEEN s.fechaInicio AND s.fechaFinalizacion
        )
    )
    BEGIN
        RAISERROR('El usuario no tiene una suscripcion activa.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
