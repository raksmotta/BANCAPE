-- Script para popular o banco de dados BANCAPE
-- Desabilita temporariamente as checagens de integridade referencial
SET FOREIGN_KEY_CHECKS = 0;

-- 1) DOADORES
INSERT INTO DOADOR (nome, cnpj, cpf, email, telefone, endereco)
VALUES
('João Silva', NULL, '12345678901', 'joao.silva@email.com', '(31)99999-0001', 'Rua das Flores, 100'),
('Empresa ABC Ltda', '12345678000190', NULL, 'contato@abc.com.br', '(31)3333-4444', 'Av. Brasil, 200');

-- 2) ONGs
INSERT INTO ONG (cnpj, nome, endereco, email, telefone)
VALUES
('98765432000165', 'ONG Amiga', 'Rua das Oliveiras, 50', 'contato@ongamiga.org', '(31)98888-1111'),
('55577788000122', 'ONG Parceira', 'Av. dos Anjos, 345', 'parceira@ong.org', '(31)97777-2222');

-- 3) HOSPITAIS
INSERT INTO HOSPITAL (cnpj, nome, telefone, email, cidade)
VALUES
('11122233000144', 'Hospital São Lucas', '(31)3277-8888', 'contato@saolucas.com.br', 'Passos'),
('22233344000155', 'Hospital Bom Pastor', '(31)3344-5566', 'contato@bombastor.com.br', 'Contagem');

-- 4) QUARTOS
INSERT INTO QUARTO (numero, nome, capacidade, ocupacao)
VALUES
(101, 'Beija-Flor', 2, 1),
(102, 'Arara', 4, 2);

-- 5) FUNCIONÁRIOS
INSERT INTO FUNCIONARIO (
cpf, nome, email, telefone, endereco, data_nasc, salario, cargo, tipo, data_contratacao, beneficios
) VALUES
('22233344455', 'Maria Oliveira', 'maria.oliveira@cape.org', '(31)99999-2222', 'Av. Amazonas, 123, Belo Horizonte', '1980-05-10', 3500.00, 'Coordenadora', 'CLT', '2023-01-15', 'Plano de saúde'),
('33344455566', 'Carlos Santos', 'carlos.santos@cape.org', '(31)99998-3333', 'Rua do Sol, 45, Belo Horizonte', '1975-09-20', 2800.00, 'Psicólogo', 'prestador', '2022-07-01', NULL);

-- 6) CRIANÇAS (com responsável mesclado)
INSERT INTO CRIANCA (
cpf, nome, data_nasc, endereco, status, categoria_doenca, cpf_responsavel, nome_responsavel, email_responsavel, telefone_responsavel, parentesco_responsavel, cnpj_hospital
) VALUES
('44455566677', 'Ana Beatriz Alves', '2015-03-12', 'Rua das Laranjeiras, 200, Araçuaí', 'ativo', 'hematologia', '55566677788', 'Pedro Alves', 'pedro.alves@email.com', '(31)98877-3333', 'pai', '11122233000144'),
('55588899900', 'Lucas Coelho', '2018-11-05', 'Rua das Palmeiras, 400, Montes Claros', 'ativo', 'oncologia', '77788899911', 'Mariana Coelho', 'mariana.coelho@email.com', '(31)98866-5555', 'mãe', '11122233000144');

-- 7) VOLUNTÁRIOS
INSERT INTO VOLUNTARIO (
cpf, nome, email, telefone, endereco, periodicidade, cpf_func_supervisor
) VALUES
('66677788899', 'Luisa Costa', 'luisa.costa@voluntaria.org', '(31)98800-4444', 'Rua das Acácias, 300, Belo Horizonte', 'semanal', '22233344455');

-- 8) DATAS de COLABORAÇÃO dos VOLUNTÁRIOS
INSERT INTO DATAS_COLABORACAO (cpf_voluntario, data, funcao)
VALUES
('66677788899', '2025-06-01', 'assistente lúdico'),
('66677788899', '2025-06-15', 'apoio administrativo');

-- 9) DOAÇÕES
INSERT INTO DOACAO (tipo, valor, data, codigo_doador)
VALUES
('monetaria', 500.00, '2025-06-20', 1),
('item', NULL, '2025-06-21', 2);

-- 10) ITENS em ESTOQUE
INSERT INTO ITEM (
descricao, categoria, validade, tamanho, quantidade, codigo_doacao
) VALUES
('Camisas infantis', 'roupas', '2026-12-31', 'M', 10, 2),
('Brinquedos educativos', 'brinquedos', NULL, NULL, 5, 2);

-- 11) ENTREGAS
INSERT INTO ENTREGA (data, cpf_crianca, cnpj_ong, cpf_func_responsavel)
VALUES
('2025-06-25', '44455566677', NULL, '22233344455'),
('2025-06-26', NULL, '98765432000165', '33344455566');

-- 12) DISTRIBUIR (itens por entrega)
INSERT INTO DISTRIBUIR (codigo_item, codigo_entrega, quantidade)
VALUES
(1, 1, 2),
(2, 1, 1),
(2, 2, 2);

-- 13) ESTADIAS
INSERT INTO ESTADIA (data_entrada, data_saida, cpf_crianca, numero_quarto)
VALUES
('2025-06-22', '2025-06-28', '44455566677', 101),
('2025-06-23', NULL, '55588899900', 102);

-- Reabilita as checagens de integridade referencial
SET FOREIGN_KEY_CHECKS = 1;