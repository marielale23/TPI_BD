CREATE FUNCTION fn_EstaSuscripcionActiva (@IDUsuario INT)
RETURNS BIT
AS
BEGIN
    DECLARE @Activa BIT = 0;

    IF EXISTS (
        SELECT 1 FROM Suscripcion
        WHERE IDUsuario = @IDUsuario
          AND GETDATE() BETWEEN fechaInicio AND fechaFinalizacion
    )
        SET @Activa = 1;

    RETURN @Activa;
END;
GO
