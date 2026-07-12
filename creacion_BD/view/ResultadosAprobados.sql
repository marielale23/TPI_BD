CREATE VIEW vista_ResultadosAprobados AS
SELECT
    RE.IDResultado,
    U.nombre + ' ' + U.apellido AS Usuario,
    C.nombre AS Curso,
    E.titulo AS Evaluacion,
    RE.notaObtenida
FROM ResultadoEvaluacion AS RE
INNER JOIN Usuario AS U ON U.IDUsuario = RE.IDUsuario
INNER JOIN Evaluacion AS E ON E.IDEvaluacion = RE.IDEvaluacion
INNER JOIN Curso AS C ON C.IDCurso = E.IDCurso
WHERE RE.aprobado = 1;
GO
