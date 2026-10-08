-- Projeto: ProjetoUniversidade


-- Autor: Raphael Kumbrevicius
-- Descrição: criação do banco, carga de dados fictícios e consultas de negócio
-- Banco: MySQL 


# Criar o banco de dados, comando DDL, Data Definition Language
CREATE DATABASE `ProjetoUniversidade`;

# Conectar ao banco de dados 
USE `ProjetoUniversidade`;

# Instruções DDL para criação das tabelas do banco de dados 
CREATE TABLE `aluno` (
	`pk_aluno` int auto_increment primary key,
	`sexo` char(1),
	`email` varchar(50) unique not null,
	`nome` varchar(100) not null,
	`cpf` char(11) unique not null,
	`data_nascimento` date,
	`ativo_sn` int default '1'
);

# Visualizar a estrutura de uma tabela
DESC aluno;


CREATE TABLE `aluno_curso` (
	`pk_aluno_curso` int auto_increment primary key,
	`fk_aluno` int not null,
	`fk_curso` int not null,
	`data_inscricao_curso` datetime default current_timestamp,
	`valor_pago_curso` decimal(10,2)
);

DESC aluno_curso;


CREATE TABLE `curso` (
	`pk_curso` int auto_increment primary key,
	`nome` varchar(50) not null
);

DESC curso;


CREATE TABLE `disciplina` (
	`pk_disciplina` int auto_increment primary key,
	`fk_professor` int not null,
	`fk_curso` int not null,
	`nome` varchar(50) not null,
	`carga_horaria` int
);

DESC disciplina;


CREATE TABLE `endereco` (
	`pk_endereco` int auto_increment primary key,
	`fk_aluno` int not null unique,
	`tipo_logradouro` varchar(50),
    `logradouro` varchar(100),
	`numero` varchar(10),
	`complemento` varchar(20),
	`bairro` varchar(50),
	`cidade` varchar(50),
	`estado` char(2),
    `cep`char(8)
);

DESC endereco;


CREATE TABLE `professor` (
	`pk_professor` int auto_increment primary key,
	`nome` varchar(50) not null,
	`email` varchar(50) unique not null
);

DESC professor;


CREATE TABLE `telefone` (
	`pk_telefone` int auto_increment primary key,
	`fk_aluno` int not null,
	`numero` varchar(20) not null,
	`tipo` enum('res','com','cel') not null
);

DESC telefone;


# FK foreign keys tabela aluno_curso 
ALTER TABLE `aluno_curso` ADD CONSTRAINT `fk_aluno_curso` 
FOREIGN KEY (`fk_aluno`) REFERENCES `aluno` (`pk_aluno`);

ALTER TABLE `aluno_curso` ADD CONSTRAINT `fk_curso_aluno` 
FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`pk_curso`);


# FK foreign keys tabela disciplina 
ALTER TABLE `disciplina` ADD CONSTRAINT `fk_curso_professor` 
FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`pk_curso`);

ALTER TABLE `disciplina` ADD CONSTRAINT `fk_professor_curso` 
FOREIGN KEY (`fk_professor`) REFERENCES `professor` (`pk_professor`);


# FK foreign keys tabela endereco 
ALTER TABLE `endereco` ADD CONSTRAINT `fk_aluno_endereco` 
FOREIGN KEY (`fk_aluno`) REFERENCES `aluno` (`pk_aluno`);


# FK foreign keys tabela telefone 
ALTER TABLE `telefone` ADD CONSTRAINT `fk_aluno_telefone` 
FOREIGN KEY (`fk_aluno`) REFERENCES `aluno` (`pk_aluno`);


#  Inserts, comando DML, Data Manipulation Language, inserir dados a tabela
INSERT INTO `aluno` (`sexo`, `email`, `nome`, `cpf`, `data_nascimento`) VALUES 
('m', 'jose@teste.com.br', 'jose', '22222222222', '1985-06-01'),
('f', 'maria@teste.com.br', 'maria', '11111111111', '1979-12-10'),
('f', 'rosa@teste.com.br', 'rosa', '33333333333', '1990-12-22'),
('m', 'joao@teste.com.br', 'joao', '44444444444', '1970-08-05'),
('m', 'pedro@teste.com.br', 'pedro', '55555555555', '1967-07-02'),
('f', 'bianca@teste.com.br', 'bianca', '66666666666', '1995-11-22'),
('m', 'jorge@teste.com.br', 'jorge', '77777777777', '1989-01-06'),
('f', 'mariana@teste.com.br', 'mariana', '88888888888', '1980-01-30'),
('m', 'antonio@teste.com.br', 'antonio', '99999999999', '1991-12-03');

SELECT * FROM aluno;


INSERT INTO `endereco` (`fk_aluno`, `tipo_logradouro`, `logradouro`, `numero`, `bairro`, `cidade`, `estado`, `cep`) VALUES
(9, 'rua', 'das flores' , 'nº 9', 'bairro 9', 'sao paulo', 'sp', '01310100'),
(5, 'travessa', 'da passarela', 'nº 5', 'bairro 5', 'belo horizonte', 'mg', '04005200'),
(3, 'avenida', 'paulista', 'nº 3', 'bairro 3', 'natal', 'rn', '11013800'),
(8, 'alameda', 'santos', 'nº 8', 'bairro 8', 'rio de janeiro', 'rj', '13040900'),
(4, 'praca','dos andradas', 'nº 4', 'bairro 4', 'fortaleza', 'ce', '14020150'),
(1, 'rua', 'nova', 'nº 1', 'bairro 1', 'manaus', 'am', '26785422'),
(7, 'rodovia', 'imigrantes', 'nº 7', 'bairro 7', 'goiania', 'go', '12345678'),
(2, 'rua', 'conceicao', 'nº 2', 'bairro 2', 'florianopolis', 'sc', '87654321'),
(6, 'estrada', 'felicidade',  'nº 6', 'bairro 6', 'vitoria', 'es', '23234455');

SELECT * FROM endereco;


INSERT INTO `telefone` (`numero`, `fk_aluno`, `tipo`) VALUES
('11 92222-2222', 9, 'cel'), 
('11 3333-2222', 9, 'com'), 
('31 5555-2222', 5, 'res'),
('21 4444-1111', 8, 'res'), 
('21 91111-2222', 9, 'cel'), 
('62 98888-7777', 7, 'cel'), 
('62 4444-4444', 7, 'com'), 
('62 6666-9999', 7, 'res'),
('27 95555-0000', 6, 'cel');

SELECT * FROM telefone;


INSERT INTO `curso` (`nome`) VALUES
('nodejs e mongodb'),
('web completo 2019'),
('es6, typescript e angular'),
('react native'),
('banco de dados relacional');

SELECT * FROM curso;


INSERT INTO `professor` (`nome`, `email`) VALUES 
('laura', 'laura@teste.com.br'),
('miguel', 'miguel@teste.com.br'),
('sofia', 'sofia@teste.com.br'),
('patrícia', 'patricia@teste.com.br'),
('arthur', 'arthur@teste.com.br'),
('breno', 'breno@teste.com.br'),
('raquel', 'raquel@teste.com.br'),
('hugo', 'hugo@teste.com.br'),
('alex', 'alex@teste.com.br');

SELECT * FROM professor;


INSERT INTO `disciplina` (`nome`, `carga_horaria`, `fk_professor`, `fk_curso`) VALUES
('html', 4, 5, 2), 
('css', 3, 7, 2), 
('bootstrap', 5, 5, 2), 
('javascript', 10, 6, 2), 
('php', 15, 9, 2),
('nodejs', 8, 3, 1), 
('mongodb', 6, 3, 1), 
('express', 4, 3, 5), 
('es6', 7, 3, 3), 
('typescript', 4, 3, 3), 
('orientada a objetos', 5, 7, 3),
('angular', 20, 4, 3), 
('es6', 7, 3, 5), 
('react native', 7, 8, 4), 
('redux', 4, 8, 4),
('mysql', 7, 6, 5);

SELECT * FROM disciplina;



INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(1, 3, '2026-05-15', 550.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(1, 4, '2026-12-25', 550.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(2, 2, '2026-03-25', 420.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(3, 1, '2026-03-30', 420.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(3, 2, '2026-04-12', 375.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(3, 3, '2026-04-21', 375.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(3, 4, '2026-03-12', 600.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(4, 1, '2026-03-12', 700.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(5, 5, '2026-06-22', 290.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(5, 2, '2026-03-18', 600.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(6, 5, '2026-06-18', 420.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(6, 3, '2026-03-30', 700.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(7, 3, '2026-01-05', 199.50);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(7, 4, '2026-01-14', 299.50);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(8, 1, '2026-03-09', 500.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(8, 5, '2026-01-09', 300.00);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(9, 2, '2026-11-17', 375.50);
INSERT INTO aluno_curso(fk_aluno, fk_curso, data_inscricao_curso, valor_pago_curso)VALUES(9, 5, '2026-10-23', 635.90);

SELECT * FROM aluno_curso;


# Selects, selecionar tabelas
SELECT * FROM aluno;
SELECT * FROM aluno_curso;
SELECT * FROM curso;
SELECT * FROM disciplina;
SELECT * FROM endereco;
SELECT * FROM professor;
SELECT * FROM telefone;       

# Criando left join (junção à esquerda) 
SELECT * FROM aluno 
LEFT JOIN telefone ON (aluno.pk_aluno = telefone.fk_aluno)
WHERE sexo = 'f';

SELECT * FROM curso
LEFT JOIN disciplina ON (curso.pk_curso = disciplina.fk_curso)
LEFT JOIN professor ON (disciplina.fk_professor = professor.pk_professor)
WHERE pk_curso = 1;


# Seleção, projeção, junção e apelidos (alias)
# Formato original 
SELECT 
	curso.pk_curso,
    curso.nome,
    disciplina.nome,
    professor.pk_professor,
	professor.nome,
    now() 
FROM
	curso
LEFT JOIN
	disciplina on (curso.pk_curso = disciplina.fk_curso)
LEFT JOIN
	professor on (disciplina.fk_professor = pk_professor)
WHERE 
	pk_curso = 1;
    

# Seleção, projeção, junção e apelidos (alias)     
# Formato abreviado     
SELECT
	c.pk_curso,
    c.nome,
    d.nome,
    p.pk_professor,
	p.nome,
    now() as Data_Atual
FROM
	curso AS c
LEFT JOIN
	disciplina AS d ON (c.pk_curso = d.fk_curso)
LEFT JOIN
	professor AS p ON (d.fk_professor = p.pk_professor)
WHERE 
	pk_curso = 1;
    
SELECT * FROM curso;
SELECT * FROM disciplina;


# Right Join & Left Join
SELECT * FROM curso AS c RIGHT JOIN disciplina AS d ON (c.pk_curso = d.fk_curso);
SELECT * FROM curso AS c LEFT JOIN disciplina AS d ON (c.pk_curso = d.fk_curso);
SELECT * FROM disciplina AS d RIGHT JOIN curso AS c ON (c.pk_curso = d.fk_curso);
SELECT * FROM disciplina AS d LEFT JOIN curso as c ON (c.pk_curso = d.fk_curso);

SELECT * FROM professor;
SELECT * FROM disciplina;

SELECT * FROM professor AS p RIGHT JOIN disciplina AS d ON (p.pk_professor = d.fk_professor);
SELECT * FROM professor AS p LEFT JOIN disciplina AS d ON (p.pk_professor = d.fk_professor);
SELECT * FROM disciplina AS d RIGHT JOIN professor AS p ON (p.pk_professor = d.fk_professor);
SELECT * FROM disciplina AS d LEFT JOIN professor AS p ON (p.pk_professor = d.fk_professor);   


# Inner Join 
SELECT * FROM curso AS c INNER JOIN disciplina AS d ON (c.pk_curso = d.fk_curso);

SELECT * FROM disciplina AS d INNER JOIN curso AS c ON (c.pk_curso = d.fk_curso);

SELECT * FROM professor;
SELECT * FROM disciplina;

SELECT * FROM professor AS p INNER JOIN disciplina AS d ON (p.pk_professor = d.fk_professor);

SELECT * FROM disciplina AS d INNER JOIN professor AS p ON (p.pk_professor = d.fk_professor);



# Criar usuário no MySQL, comando DDL, Data Definition Language
CREATE USER 'analista'@'localhost' IDENTIFIED BY 'SUA_SENHA_AQUI';


# Conceder privilégios, permitir somente leitura no banco do projeto
# Comando DCL, Data Control Language
GRANT SELECT ON ProjetoUniversidade.* TO 'analista'@'localhost';


# Conferir permissão
SHOW GRANTS FOR 'analista'@'localhost';



# Business Queries

# Painel de KPIs, qual o atual tamanho do negócio ?
# Decisão, baseline para metas e comparação com períodos futuros. 

SELECT
    COUNT(*)                                                   AS total_inscricoes,
    COUNT(DISTINCT fk_aluno)                                   AS alunos_com_inscricao,
    COUNT(DISTINCT fk_curso)                                   AS cursos_vendidos,
    SUM(valor_pago_curso)                                      AS receita_total,
    ROUND(AVG(valor_pago_curso), 2)                            AS ticket_medio,
    ROUND(SUM(valor_pago_curso) / COUNT(DISTINCT fk_aluno), 2) AS receita_por_aluno,
    ROUND(COUNT(*) / COUNT(DISTINCT fk_aluno), 2)              AS cursos_por_aluno
FROM aluno_curso;



# Business Queries

# Receita, volume e participação por curso
# Quais cursos sustentam o faturamento ?
# Decisão, onde investir em marketing e quais cursos revisar.

SELECT
    c.nome                                                   AS curso,
    COUNT(ac.pk_aluno_curso)                                 AS inscricoes,
    COALESCE(SUM(ac.valor_pago_curso), 0)                    AS receita,
    ROUND(COALESCE(AVG(ac.valor_pago_curso), 0), 2)          AS ticket_medio,
    ROUND(100 * COALESCE(SUM(ac.valor_pago_curso), 0)
              / NULLIF(SUM(SUM(ac.valor_pago_curso)) OVER (), 0), 2) AS pct_da_receita
FROM curso AS c
LEFT JOIN aluno_curso AS ac ON ac.fk_curso = c.pk_curso
GROUP BY c.pk_curso, c.nome
ORDER BY receita DESC;



# Business Queries

# Top 5 alunos por valor investido (clientes de maior valor)
# Quem são os melhores clientes ?
# Decisão, programa de fidelidade, ofertas exclusivas, realcionamentos.

SELECT
    a.pk_aluno,
    a.nome                              AS aluno,
    COUNT(*)                            AS cursos_comprados,
    SUM(ac.valor_pago_curso)            AS total_investido,
    ROUND(AVG(ac.valor_pago_curso), 2)  AS ticket_medio,
    MIN(ac.data_inscricao_curso)        AS primeira_compra,
    MAX(ac.data_inscricao_curso)        AS ultima_compra
FROM aluno AS a
JOIN aluno_curso AS ac ON ac.fk_aluno = a.pk_aluno
GROUP BY a.pk_aluno, a.nome
ORDER BY total_investido DESC
LIMIT 5;
 


# Business Queries

# Receita por estado (visão geográfica)
# De onde vem a receita ?
# Decisão, observar participação por regionalidade.

SELECT
    UPPER(e.estado)                       AS uf,
    COUNT(DISTINCT a.pk_aluno)            AS alunos,
    COUNT(ac.pk_aluno_curso)              AS inscricoes,
    COALESCE(SUM(ac.valor_pago_curso), 0) AS receita
FROM endereco AS e
JOIN aluno AS a             ON a.pk_aluno = e.fk_aluno
LEFT JOIN aluno_curso AS ac ON ac.fk_aluno = a.pk_aluno
GROUP BY UPPER(e.estado)
ORDER BY receita DESC;
 


 





