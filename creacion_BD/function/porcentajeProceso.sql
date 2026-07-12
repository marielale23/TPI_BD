CREATE FUNCTION fn_PorcentajeProgreso (@IDUsuario INT, @IDCurso INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @Porcentaje DECIMAL(5,2);

    SELECT @Porcentaje = CAST(
        COUNT(DISTINCT PA.IDArchivo) * 100.0
        / NULLIF(COUNT(DISTINCT A.IDArchivo), 0)
    AS DECIMAL(5,2))
    FROM Archivo AS A
    LEFT JOIN ProgresoArchivo AS PA
        ON PA.IDArchivo = A.IDArchivo
        AND PA.IDUsuario = @IDUsuario
        AND PA.completado = 1
    WHERE A.IDCurso = @IDCurso;

    RETURN ISNULL(@Porcentaje, 0);
END;
GO
