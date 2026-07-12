CREATE FUNCTION fn_PromedioNotasUsuario (@IDUsuario INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @Promedio DECIMAL(5,2);

    SELECT @Promedio = AVG(CAST(notaObtenida AS DECIMAL(5,2)))
    FROM ResultadoEvaluacion
    WHERE IDUsuario = @IDUsuario;

    RETURN ISNULL(@Promedio, 0);
END;
GO
