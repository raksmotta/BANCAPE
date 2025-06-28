-- Criando um banco de dados
CREATE DATABASE bancape;

-- Selecionando o banco de dados
USE bancape;

-- Drop tables if they exist to reset schema
DROP TABLE IF EXISTS DISTRIBUIR;
DROP TABLE IF EXISTS ESTADIA;
DROP TABLE IF EXISTS ITEM;
DROP TABLE IF EXISTS DOACAO;
DROP TABLE IF EXISTS DATAS_COLABORACAO;
DROP TABLE IF EXISTS VOLUNTARIO;
DROP TABLE IF EXISTS ENTREGA;
DROP TABLE IF EXISTS CRIANCA;
DROP TABLE IF EXISTS QUARTO;
DROP TABLE IF EXISTS FUNCIONARIO;
DROP TABLE IF EXISTS HOSPITAL;
DROP TABLE IF EXISTS ONG;
DROP TABLE IF EXISTS DOADOR;

-- DOADOR: pessoas físicas ou jurídicas
CREATE TABLE DOADOR (
  codigo INT AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  cnpj CHAR(14),
  cpf CHAR(11),
  email VARCHAR(255),
  telefone VARCHAR(20),
  endereco VARCHAR(255),
  PRIMARY KEY (codigo),
  CHECK ( (cnpj IS NOT NULL AND cpf IS NULL) OR (cpf IS NOT NULL AND cnpj IS NULL) )
);

-- ONG colaboradora
CREATE TABLE ONG (
  cnpj CHAR(14) PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  endereco VARCHAR(255),
  email VARCHAR(255),
  telefone VARCHAR(20)
);

-- HOSPITAL parceiro
CREATE TABLE HOSPITAL (
  cnpj CHAR(14) PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  telefone VARCHAR(20),
  email VARCHAR(255),
  cidade VARCHAR(255)
);

-- QUARTO da hospedagem
CREATE TABLE QUARTO (
  numero INT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  capacidade INT NOT NULL CHECK (capacidade > 0),
  ocupacao INT NOT NULL DEFAULT 0 CHECK (ocupacao >= 0 AND ocupacao <= capacidade)
);

-- FUNCIONARIO com vínculo
CREATE TABLE FUNCIONARIO (
  cpf CHAR(11) PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  telefone VARCHAR(20),
  endereco VARCHAR(255),
  data_nasc DATE,
  salario DECIMAL(10,2),
  cargo VARCHAR(100),
  tipo ENUM('CLT','prestador','terceirizado'),
  data_contratacao DATE,
  beneficios TEXT
);

-- CRIANCA e RESPONSAVEL (mesclados)
CREATE TABLE CRIANCA (
  cpf CHAR(11) PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  data_nasc DATE,
  endereco VARCHAR(255),
  status ENUM('ativo','alta','falecido'),
  categoria_doenca VARCHAR(100),
  cpf_responsavel CHAR(11) NOT NULL,
  nome_responsavel VARCHAR(255),
  email_responsavel VARCHAR(255),
  telefone_responsavel VARCHAR(20),
  parentesco_responsavel VARCHAR(50),
  cnpj_hospital CHAR(14) NOT NULL,
  FOREIGN KEY (cnpj_hospital) REFERENCES HOSPITAL(cnpj)
);

-- VOLUNTARIO sem vínculo empregatício
CREATE TABLE VOLUNTARIO (
  cpf CHAR(11) PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  telefone VARCHAR(20),
  endereco VARCHAR(255),
  periodicidade VARCHAR(100),
  cpf_func_supervisor CHAR(11) NOT NULL,
  FOREIGN KEY (cpf_func_supervisor) REFERENCES FUNCIONARIO(cpf)
);

-- DATAS_COLABORACAO (multivalorado)
CREATE TABLE DATAS_COLABORACAO (
  cpf_voluntario CHAR(11),
  data DATE,
  funcao VARCHAR(100),
  PRIMARY KEY (cpf_voluntario, data),
  FOREIGN KEY (cpf_voluntario) REFERENCES VOLUNTARIO(cpf)
);

-- DOACAO (monetária ou item)
CREATE TABLE DOACAO (
  codigo INT AUTO_INCREMENT,
  tipo ENUM('monetaria','item') NOT NULL,
  valor DECIMAL(10,2),
  data DATE NOT NULL,
  codigo_doador INT,
  PRIMARY KEY (codigo),
  FOREIGN KEY (codigo_doador) REFERENCES DOADOR(codigo),
  CHECK (
    (tipo = 'monetaria' AND valor IS NOT NULL)
    OR
    (tipo = 'item' AND valor IS NULL)
  )
);

-- ITEM em estoque
CREATE TABLE ITEM (
  codigo INT AUTO_INCREMENT,
  descricao VARCHAR(255) NOT NULL,
  categoria ENUM('roupas','alimentos','brinquedos','higiene','limpeza') NOT NULL,
  validade DATE,
  tamanho VARCHAR(50),
  quantidade INT NOT NULL CHECK (quantidade >= 1),
  codigo_doacao INT NOT NULL,
  PRIMARY KEY (codigo),
  FOREIGN KEY (codigo_doacao) REFERENCES DOACAO(codigo)
);

-- ENTREGA de itens aos destinatários
CREATE TABLE ENTREGA (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  data DATE NOT NULL,
  cpf_crianca CHAR(11),
  cnpj_ong   CHAR(14),
  cpf_func_responsavel CHAR(11) NOT NULL,
  FOREIGN KEY (cpf_crianca)           REFERENCES CRIANCA(cpf),
  FOREIGN KEY (cnpj_ong)              REFERENCES ONG(cnpj),
  FOREIGN KEY (cpf_func_responsavel)  REFERENCES FUNCIONARIO(cpf),
  CHECK (
    (cpf_crianca IS NOT NULL AND cnpj_ong IS NULL)
    OR
    (cpf_crianca IS NULL AND cnpj_ong IS NOT NULL)
  )
);

-- Relação N:N DISTRIBUIR entre ITEM e ENTREGA
CREATE TABLE DISTRIBUIR (
  codigo_item INT,
  codigo_entrega INT,
  quantidade INT NOT NULL CHECK (quantidade > 0),
  PRIMARY KEY (codigo_item, codigo_entrega),
  FOREIGN KEY (codigo_item) REFERENCES ITEM(codigo),
  FOREIGN KEY (codigo_entrega) REFERENCES ENTREGA(codigo)
);

-- ESTADIA em quarto
CREATE TABLE ESTADIA (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  data_entrada DATE NOT NULL,
  data_saida DATE,
  cpf_crianca CHAR(11) NOT NULL,
  numero_quarto INT NOT NULL,
  FOREIGN KEY (cpf_crianca) REFERENCES CRIANCA(cpf),
  FOREIGN KEY (numero_quarto) REFERENCES QUARTO(numero),
  CHECK (data_saida IS NULL OR data_saida >= data_entrada)
);