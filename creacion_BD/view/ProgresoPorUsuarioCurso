CREATE VIEW vista_ProgresoPorUsuarioCurso AS
SELECT
    I.IDUsuario,
    I.IDCurso,
    COUNT(DISTINCT PA.IDArchivo) AS ArchivosCompletados,
    COUNT(DISTINCT A.IDArchivo) AS ArchivosTotales,
    CAST(
        COUNT(DISTINCT PA.IDArchivo) * 100.0
        / NULLIF(COUNT(DISTINCT A.IDArchivo), 0)
    AS DECIMAL(5,2)) AS PorcentajeProgreso
FROM Inscripcion AS I
INNER JOIN Archivo AS A ON A.IDCurso = I.IDCurso
LEFT JOIN ProgresoArchivo AS PA
    ON PA.IDArchivo = A.IDArchivo
    AND PA.IDUsuario = I.IDUsuario
    AND PA.completado = 1
GROUP BY I.IDUsuario, I.IDCurso;
GO
