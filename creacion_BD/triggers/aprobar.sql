CREATE TRIGGER tr_Aprobar
ON ResultadoEvaluacion
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE re
    SET re.aprobado = CASE WHEN re.notaObtenida >= e.puntajeMinimo THEN 1 ELSE 0 END
    FROM ResultadoEvaluacion re
    INNER JOIN inserted i ON re.IDResultado = i.IDResultado
    INNER JOIN Evaluacion e ON e.IDEvaluacion = re.IDEvaluacion;
END;
GO
