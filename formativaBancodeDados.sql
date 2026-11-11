CREATE DATABASE academia_movimento_mais_daniel

use academia_movimento_mais_daniel;
go

CREATE TABLE clientes (
    idClientes int primary key identity(1,1),
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL unique,
    email VARCHAR(100) NOT NULL unique,
    telefone VARCHAR(20) NOT NULL,
    datanicimento date NOT NULL,
    ativo bit NOT NULL DEFAULT 1
)

CREATE TABLE instrutores(
    idinstrutor int primary key IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    cref VARCHAR(20) NOT NULL UNIQUE,
    especialidade VARCHAR (80) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    ativo bit NOT NULL DEFAULT 1
)

CREATE TABLE modalidades(
    idmodalidade INT PRIMARY KEY IDENTITY,
    nomeModalidade VARCHAR(80) not NULL unique,
    nivel VARCHAR(20) not NULL,
    duracaominutos int NOT NULL CHECK (duracaominutos > 0),
    descricao VARCHAR(200) NULL
);

CREATE TABLE planos(
    idplano INT IDENTITY(1,1) PRIMARY KEY,
    nomeplano VARCHAR(80) NOT NULL UNIQUE,
    valormensal DECIMAL(10,2) NOT NULL CHECK (valormensal > 0),
    duracaomeses INT NOT NULL CHECK (duracaomeses BETWEEN 1 AND 24),
    acessolivre BIT DEFAULT 0
);

CREATE TABLE matriculas(
    idmatricula INT PRIMARY KEY IDENTITY(1,1),
    idClientes INT NOT NULL FOREIGN KEY REFERENCES clientes(idClientes),
    idplano INT NOT NULL FOREIGN KEY REFERENCES planos(idplano),
    datainicio DATE NOT NULL,
    statusmatricula VARCHAR(20) NOT NULL CHECK (statusmatricula IN ('Ativa', 'Suspensa', 'Encerrada')),
    desconto INT NOT NULL DEFAULT 0 CHECK (desconto BETWEEN 0 AND 100)
);

CREATE TABLE aulas(
    idaula int IDENTITY(1,1) PRIMARY KEY,
    idmodalidade int NOT NULL FOREIGN KEY REFERENCES modalidades(idmodalidade),
    idinstrutor int NOT NULL FOREIGN KEY REFERENCES instrutores(idinstrutor),
    dataaula date not NULL,
    horario time not null,
    vagas int NOT NULL CHECK (vagas BETWEEN 1 and 50),
    sala VARCHAR(30) NOT NULL
);

SELECT name AS TabelaCriada, create_date AS DataCriacao
FROM sys.tables;
GO

INSERT into instrutores (Nome, cref, especialidade, email) VALUES
('André Silva', 'CREF-SP-1001', 'Musculação', 'andre.silva@movimentomais.com'),
('Beatriz Costa', 'CREF-SP-1002', 'Pilates', 'beatriz.costa@movimentomais.com'),
('Caio Mendes', 'CREF-SP-1003', 'Cross Training', 'caio.mendes@movimentomais.com'),
('Daniela Reis', 'CREF-SP-1004', 'Dança', 'daniela.reis@movimentomais.com'),
('Eduardo Lima', 'CREF-SP-1005', 'Natação', 'eduardo.lima@movimentomais.com'),
('Fernanda Alves', 'CREF-SP-1006', 'Yoga', 'fernanda.alves@movimentomais.com'),
('Gabriel Rocha', 'CREF-SP-1007', 'Funcional', 'gabriel.rocha@movimentomais.com'),
('Helena Souza', 'CREF-SP-1008', 'Corrida', 'helena.souza@movimentomais.com'),
('Igor Martins', 'CREF-SP-1009', 'Lutas', 'igor.martins@movimentomais.com'),
('Juliana Nunes', 'CREF-SP-1010', 'Alongamento', 'juliana.nunes@movimentomais.com');
GO

INSERT into modalidades (nomeModalidade, nivel, duracaominutos, descricao)VALUES
('Musculação', 'Todos', 60, 'Treino com pesos e equipamentos.'),
('Pilates', 'Iniciante', 50, 'Exercícios de equilíbrio e fortalecimento.'),
('Cross Training', 'Intermediário', 45, 'Circuito de alta intensidade.'),
('Zumba', 'Todos', 50, 'Aula de dança com ritmos variados.'),
('Natação', 'Iniciante', 45, 'Fundamentos de natação.'),
('Yoga', 'Todos', 60, 'Posturas, respiração e concentração.'),
('Treino Funcional', 'Intermediário', 45, 'Movimentos para condicionamento físico.'),
('Corrida Orientada', 'Intermediário', 40, 'Técnica e resistência para corrida.'),
('Muay Thai', 'Iniciante', 60, 'Fundamentos da luta e condicionamento.'),
('Alongamento', 'Todos', 30, 'Mobilidade e flexibilidade.');
GO

insert into planos (nomeplano, valormensal, duracaomeses, acessolivre) VALUES
('Básico Mensal', 89.90, 1, 0),
('Básico Trimestral', 79.90, 3, 0),
('Básico Semestral', 74.90, 6, 0),
('Premium Mensal', 129.90, 1, 1),
('Premium Trimestral', 119.90, 3, 1),
('Premium Semestral', 109.90, 6, 1),
('Estudante Mensal', 69.90, 1, 0),
('Estudante Anual', 59.90, 12, 0),
('Família Mensal', 199.90, 1, 1),
('Corporativo Anual', 99.90, 12, 1);
GO


INSERT INTO clientes (nome, cpf, email, telefone, datanicimento) VALUES
('Alice Fernandes', '11122233344', 'alice.fernandes@email.com', '11990001111', '2004-04-16'),
('Bruno Carvalho', '22233344455', 'bruno.carvalho@email.com', '11990002222', '2001-09-20'),
('Camila Santos', '33344455566', 'camila.santos@email.com', '11990003333', '1999-01-10'),
('Diego Oliveira', '44455566677', 'diego.oliveira@email.com', '11990004444', '2003-07-05'),
('Elisa Martins', '55566677788', 'elisa.martins@email.com', '11990005555', '1998-11-23'),
('Felipe Rocha', '66677788899', 'felipe.rocha@email.com', '11990006666', '2002-03-18'),
('Gabriela Lima', '77788899900', 'gabriela.lima@email.com', '11990007777', '2000-12-09'),
('Henrique Alves', '88899900011', 'henrique.alves@email.com', '11990008888', '1997-06-27'),
('Isabela Costa', '99900011122', 'isabela.costa@email.com', '11990009999', '2005-02-14'),
('João Ribeiro', '00011122233', 'joao.ribeiro@email.com', '11991112222', '2001-08-15');
GO

INSERT INTO matriculas (idClientes, idplano, datainicio, statusmatricula)VALUES
('1', '7', '2026-02-01', 'ativa', '0'),
('2', '4', '2026-02-01', 'ativa', '10'),
('3', '6', '2026-02-02', 'ativa', '0'),
('4', '1', '2026-02-02', 'suspensa', '0'),
('5', '5', '2026-02-03', 'ativa', '5'),
('6', '2', '2026-02-03', 'encerrada', '0'),
('7', '8', '2026-02-04', 'ativa', '15'),
('8', '9', '2026-02-04', 'ativa', '0'),
('9', '7', '2026-02-05', 'ativa', '20'),
('10', '10','2026-02-05','ativa', '0');
GO







SELECT * from clientes
select * from planos
select * from modalidades
select * from instrutores
select * from aulas
select * from matriculas