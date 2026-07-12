CREATE PROCEDURE sp_RenovarSuscripcion
    @IDUsuario INT,
    @IDTipoSuscripcion INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM TipoSuscripcion WHERE IDTipoSuscripcion = @IDTipoSuscripcion)
    BEGIN
        RAISERROR('El tipo de suscripcion indicado no existe.', 16, 1);
        RETURN;
    END

    INSERT INTO Suscripcion (IDTipoSuscripcion, IDUsuario, fechaInicio, activa)
    VALUES (@IDTipoSuscripcion, @IDUsuario, GETDATE(), 1);
END;
GO
