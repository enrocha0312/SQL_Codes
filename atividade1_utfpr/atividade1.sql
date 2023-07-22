#Eduardo Nepomuceno da Rocha
#Disciplina: Bancos
#Pós-graduação em tecnologia JAva

#RESPOSTAS

#QUESTÂO 1

CREATE TEMPORARY TABLE QtdPorCantores
SELECT c.nome_cantor, COUNT(g.cod_cantor) contagem FROM cantor c
INNER JOIN gravacao g
ON 
c.cod_cantor = g.cod_cantor
GROUP BY g.cod_cantor

SELECT * FROM QtdPorCantores
WHERE CONTAGEM = (SELECT MIN(contagem) FROM QtdPorCantores)

#QUESTÃO 2

SELECT C.nome_cantor, COUNT(DISTINCT A.COD_GRAVADORA) GRAVADORAS_DISTINTAS
FROM cantor C
INNER JOIN gravacao G
ON C.cod_cantor = G.cod_cantor
INNER JOIN gravadora A
ON G.cod_gravadora = A.cod_gravadora
GROUP BY c.nome_cantor
HAVING GRAVADORAS_DISTINTAS = (SELECT MAX(TABELA.DISTINTOS) FROM
(SELECT  COUNT(DISTINCT A.cod_gravadora) distintos FROM cantor C
INNER JOIN gravacao G
ON C.cod_cantor = G.cod_cantor
INNER JOIN gravadora A
ON G.cod_gravadora = A.cod_gravadora
GROUP BY c.nome_cantor
ORDER BY distintos DESC) AS TABELA)

#QUESTÃO 3

SELECT c.nome_cantor,  AVG(duracao) from musica m 
INNER join gravacao g
ON m.cod_musica = g.cod_musica
INNER JOIN cantor c
ON c.cod_cantor = g.cod_cantor
GROUP BY c.nome_cantor
ORDER BY AVG(duracao) DESC
LIMIT 1

#QUESTÃO 4

SELECT distinct c.nome_cantor FROM cantor C
INNER JOIN gravacao G
ON G.cod_cantor = C.cod_cantor
INNER JOIN gravadora A
ON A.cod_gravadora = G.cod_gravadora
WHERE A.nome_gravadora != 'Sony'

#QUESTÃO 5

SELECT c.nome_cantor, m.titulo, g.data_gravacao FROM cantor C
INNER JOIN gravacao G
ON G.cod_cantor = C.cod_cantor
INNER JOIN gravadora A
ON A.cod_gravadora = G.cod_gravadora
INNER JOIN musica m
ON m.cod_musica = g.cod_musica
WHERE g.data_gravacao LIKE '2004%'

#QUESTÃO 6

SELECT c.nome_cantor, COALESCE(g.data_gravacao, '')
FROM cantor c
LEFT JOIN gravacao g
ON c.cod_cantor = g.cod_cantor
GROUP BY c.nome_cantor
ORDER BY g.data_gravacao desc

#QUESTÃO 7

//Primeiro criei três views, para depois utilizar joins

ALTER ALGORITHM = UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `telefonescelulares` AS SELECT p.nome_pessoa AS 'nome', f.numero AS 'celular' FROM
pessoa p
INNER JOIN fone f
ON f.cod_pessoa = p.cod_pessoa
WHERE f.tipo = 'L'  ;

ALTER ALGORITHM = UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `telefonescomerciais` AS SELECT p.nome_pessoa AS 'nome', f.numero AS 'fone_comercial' FROM
pessoa p
INNER JOIN fone f
ON f.cod_pessoa = p.cod_pessoa
WHERE f.tipo = 'C'  ;

ALTER ALGORITHM = UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `telefonesresidenciais` AS SELECT p.nome_pessoa AS 'nome', f.numero AS 'fone_residencial' FROM
pessoa p
INNER JOIN fone f
ON f.cod_pessoa = p.cod_pessoa
WHERE f.tipo = 'R'  ;

//E finalmente

SELECT L.nome, R.fone_residencial, C.fone_comercial, L.celular FROM TELEFONESCELULARES L
INNER JOIN TELEFONESCOMERCIAIS C
ON L.nome = C.nome
INNER JOIN TELEFONESRESIDENCIAIS R
ON L.nome = R.nome
