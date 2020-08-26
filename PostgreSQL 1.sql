/* EXCLUSÃO DAS TABELAS*/
DROP TABLE usuarios;
DROP TABLE livros;
DROP TABLE locacao;

/*CRIÇÃO DAS TABELAS*/
CREATE TABLE livros (
	id SERIAL PRIMARY KEY UNIQUE,
	titulo VARCHAR(255),
	autor VARCHAR(255) 
);

CREATE TABLE usuarios (
	id SERIAL PRIMARY KEY UNIQUE,
	nome VARCHAR(255),
	telefone CHAR(11)
);

CREATE TABLE locacao (
	id SERIAL PRIMARY KEY UNIQUE,
	id_user SERIAL,
	id_livro SERIAL,
	
	FOREIGN KEY (id_user) REFERENCES usuarios (id)
	ON DELETE CASCADE,
	ON UPDATE CASCADE,
	
	FOREIGN KEY (id_livro) REFERENCES livros (id)
);

/*
ABAIXO É GERADO O RELATÓRIO DE TITULO E NOME quando pertencem a locacao 
*/

SELECT livros.titulo,
	   usuarios.nome
	   
	   FROM locacao
	   JOIN livros ON livros.id = locacao.id_livro
	   JOIN usuarios ON usuarios.id = locacao.id_user /*lista de livros e usuarios*/
	   
SELECT livros.titulo,
	   usuarios.nome
	   
	   FROM usuarios
	   LEFT JOIN locacao ON locacao.id_user = usuarios.id
	   LEFT JOIN livros ON livros.id = locacao.id_livro  /*para ver a lista de usuarios, mesmo que não tenha locado algum livro*/
	   
SELECT livros.titulo,
	   usuarios.nome
	   
	   FROM livros
	   LEFT JOIN locacao ON locacao.id_livro = livros.id
	   LEFT JOIN usuarios ON usuarios.id = locacao.id_user /*para ver a lista de livros mesmo que não locados*/

SELECT livros.titulo,
	   usuarios.nome
	   
	   FROM usuarios
	   FULL JOIN locacao ON locacao.id_user = usuarios.id
	   FULL JOIN livros ON livros.id = locacao.id_livro /*para ver as duas listas completas mesmo que são se interliguem*/
/*Posso usar o order direto no select*/
	   ORDER BY usuarios.nome DESC

SELECT livros.titulo,
	   usuarios.nome
	   
	   FROM usuarios
	   CROSS JOIN livros


/*TIPOS DE ORDENAÇÃO DA TABELA*/

SELECT FROM usuarios
	ORDER BY nome;
SELECT FROM usuarios
	ORDER BY nome, telefone;
SELECT FROM usuarios
	ORDER BY nome DESC;
SELECT FROM usuarios
	ORDER BY 2;
SELECT FROM usuarios
	ORDER BY 2,1; 
	
/*COMANDO DE LIMITE PARA MOSTRAR E MOSTRAR A PARTIR DE TAL N*/

SELECT * FROM usuarios
	ORDER BY nome
	LIMIT 3
	OFFSET 2
	
/*ABAIXO FICARÃO FUNÇÕES DE AGREGAÇÃO*/

SELECT COUNT(id),  /*quantidade de registros*/
	   SUM(id),    /*soma dos registros*/
	   MAX(id),    /*maior valor dos registros*/
	   MIN(id),    /*menor valor dos registros*/
 ROUND (AVG(id),2)   /*média dos registros, e o ROUND para colocar as casas deciamais indicadas no final, no caso 2*/            
	FROM usuarios;

/*FORMAS DE NÃO REPETIR, pode ser adicionado mais de um filtro (nome) ex:. nome, sobrenome */

SELECT DISTINCT nome FROM usuarios ORDER BY nome /*apenar remove o repetido*/
	/*USANDO O GROUP*/
SELECT nome, COUNT(id) FROM usuarios GROUP BY nome ORDER BY nome /*remove e mostra um contador dos repetidos*/

SELECT livros.titulo,
	  COUNT(usuarios.id)
	   
	   FROM usuarios
	   LEFT JOIN locacao ON locacao.id_user = usuarios.id
	   LEFT JOIN livros ON livros.id = locacao.id_livro 
GROUP BY 1

/*FILTRO EM CONSULTAS AGRUPADAS*/

SELECT livros.titulo,
	   COUNT(usuarios.id)
	   
	   FROM livros
	   LEFT JOIN locacao ON locacao.id_livro = livros.id
	   LEFT JOIN usuarios ON usuarios.id = locacao.id_user
GROUP BY 1
	HAVING COUNT(usuarios.id) > 0 /*mostra os livros que que estão alugados*/
							  = 0 /*mostra os livros que não estão locados*/
/*
ABAIXO INSERÇÃO DE VALORES NA TABELA livros
*/
INSERT INTO livros (titulo, autor)
	VALUES('HARRY POTTER E A CAMARA SECRETA', 'J. K. ROLLING');

INSERT INTO livros (titulo, autor)
	VALUES('HARRY POTTER E A PEDRA FILOSOFAL', 'J. K. ROLLING');

INSERT INTO livros (titulo, autor)
	VALUES('HARRY POTTER E O PRISIONEIRO DE AZKABAN', 'J. K. ROLLING');

/*
ABAIXO INSERÇÃO DE VALORES NA TABELA usuarios
*/

INSERT INTO usuarios (nome, telefone) 
	VALUES('Ana Paula', '51998364799');
	
INSERT INTO usuarios (nome, telefone)
	VALUES ('Tatiana', '51123456789');
	
INSERT INTO usuarios (nome, telefone)
	VALUES ('Alison', '51987654321');

INSERT INTO usuarios (nome, telefone) 
	VALUES('Amanda', '51968364799');

INSERT INTO usuarios (nome, telefone) 
	VALUES('Alison', '51948364799');

/*
ABAIXO INSERÇÃO DE VALORES NA TABELA locacao 
*/

INSERT INTO locacao(id_livro, id_user) VALUES (1,2); 
INSERT INTO locacao(id_livro, id_user) VALUES (2,1);

/*
ABAIXO EXCLUSÃO DE VALORES NA TABELA locacao e usuarios 
*/

DELETE FROM locacao WHERE id=4;
DELETE FROM locacao WHERE id=5;
DELETE FROM locacao WHERE id=3;

DELETE FROM usuarios WHERE id=1;

/*ABAIXO FICARÃO OS UPDATES DAS TABELAS USUARIOS*/

UPDATE usuarios
	SET nome = 'Vera'
	WHERE nome = 'Alison'; /*qual o id que será alterado*/

/*
ABAIXO FICARÃO OS COMANDOS DE VIZUALIZAÇÃO POR TABELA
*/

SELECT * FROM usuarios;

SELECT * FROM livros;

SELECT * FROM locacao;

SELECT * FROM usuarios WHERE id = 1; /*visualização a partir de um id especifico*/