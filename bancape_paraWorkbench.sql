-- DOADOR: pessoas físicas ou jurídicas
CREATE TABLE DOADOR (
  codigo INT AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  cnpj CHAR(14),
  cpf CHAR(11),
  email VARCHAR(255),
  telefone VARCHAR(20),
  endereco VARCHAR(255),
  PRIMARY KEY (codigo)
);

CREATE TABLE ONG (
  cnpj CHAR(14) PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  endereco VARCHAR(255),
  email VARCHAR(255),
  telefone VARCHAR(20)
);

CREATE TABLE HOSPITAL (
  cnpj CHAR(14) PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  telefone VARCHAR(20),
  email VARCHAR(255),
  cidade VARCHAR(255)
);

CREATE TABLE QUARTO (
  numero INT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  capacidade INT NOT NULL,
  ocupacao INT NOT NULL DEFAULT 0
);

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

CREATE TABLE DATAS_COLABORACAO (
  cpf_voluntario CHAR(11),
  data DATE,
  funcao VARCHAR(100),
  PRIMARY KEY (cpf_voluntario, data),
  FOREIGN KEY (cpf_voluntario) REFERENCES VOLUNTARIO(cpf)
);

CREATE TABLE DOACAO (
  codigo INT AUTO_INCREMENT,
  tipo ENUM('monetaria','item') NOT NULL,
  valor DECIMAL(10,2),
  data DATE NOT NULL,
  codigo_doador INT,
  PRIMARY KEY (codigo),
  FOREIGN KEY (codigo_doador) REFERENCES DOADOR(codigo)
);

CREATE TABLE ITEM (
  codigo INT AUTO_INCREMENT,
  descricao VARCHAR(255) NOT NULL,
  categoria ENUM('roupas','alimentos','brinquedos','higiene','limpeza') NOT NULL,
  validade DATE,
  tamanho VARCHAR(50),
  quantidade INT NOT NULL,
  codigo_doacao INT NOT NULL,
  PRIMARY KEY (codigo),
  FOREIGN KEY (codigo_doacao) REFERENCES DOACAO(codigo)
);

CREATE TABLE ENTREGA (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  data DATE NOT NULL,
  cpf_crianca CHAR(11),
  cnpj_ong   CHAR(14),
  cpf_func_responsavel CHAR(11) NOT NULL,
  FOREIGN KEY (cpf_crianca)           REFERENCES CRIANCA(cpf),
  FOREIGN KEY (cnpj_ong)              REFERENCES ONG(cnpj),
  FOREIGN KEY (cpf_func_responsavel)  REFERENCES FUNCIONARIO(cpf)
);

CREATE TABLE DISTRIBUIR (
  codigo_item INT,
  codigo_entrega INT,
  quantidade INT NOT NULL,
  PRIMARY KEY (codigo_item, codigo_entrega),
  FOREIGN KEY (codigo_item) REFERENCES ITEM(codigo),
  FOREIGN KEY (codigo_entrega) REFERENCES ENTREGA(codigo)
);

CREATE TABLE ESTADIA (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  data_entrada DATE NOT NULL,
  data_saida DATE,
  cpf_crianca CHAR(11) NOT NULL,
  numero_quarto INT NOT NULL,
  FOREIGN KEY (cpf_crianca) REFERENCES CRIANCA(cpf),
  FOREIGN KEY (numero_quarto) REFERENCES QUARTO(numero)
);