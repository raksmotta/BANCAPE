# BANCAPE - Banco de Dados da Casa de Acolhida Padre Eustáquio

🚀 **Projeto final da disciplina de Banco de Dados**
🎯 **Tecnologia a serviço da solidariedade**

## 📚 Sobre o projeto

O **BANCAPE** foi desenvolvido como trabalho final da disciplina de Banco de Dados, com o objetivo de modelar, implementar e popular um banco de dados relacional para gerenciar as atividades da **Casa de Acolhida Padre Eustáquio (CAPE)** — uma ONG que oferece suporte a crianças em tratamento médico em Belo Horizonte.

O projeto busca demonstrar como a tecnologia pode apoiar causas sociais, facilitando o gerenciamento de dados essenciais para o funcionamento de uma instituição que depende do rastreio e da distribuição correta de doações.

---

## 🏗️ Escopo do banco de dados

O banco de dados gerencia informações sobre:

* **Cadastro de crianças e seus responsáveis**
* **Hospedagens durante o tratamento**
* **Doações recebidas e entregas realizadas**
* **Funcionários e voluntários que atuam na ONG**
* **ONGs e hospitais parceiros**
* **Doadores (pessoas físicas ou jurídicas)**

---

## 📝 Documentação do projeto

Este repositório contém:

* `perguntas_visita.pdf`: Perguntas que nortearam a coleta de informações durante a visita à instituição.
* `descricao_minimundo.txt`: Descrição textual do minimundo, que serviu como base para o projeto.
* `modelo_conceitual_DER.png`: Diagrama Entidade-Relacionamento (notação Peter Chen).
* `modelo_logico_esquema.png`: Diagrama de Esquema Lógico.
* `modelo_implementacao.png`: Diagrama em Notação Pé-de-Galinha (implementação).
* `bancape.sql`: Script SQL para criação das tabelas do banco de dados.
* `populate_bancape.sql`: Script SQL para popular o banco com dados fictícios.
* `bancape_paraWorkbench.sql`: Script SQL utilizado para realizar engenharia reversa no MySQL Workbench e produzir o diagrama de implementação.
* `TP_BD_raquel_bancape.pdf`: Documento que reúne todos os produtos do trabalho e também apresenta considerações finais.

---

## 💡 Principais desafios e aprendizados

* **Modelagem de dados complexos**, traduzindo relacionamentos densos em estruturas claras e eficientes.
* **Conexão com o mundo real**, ao visitar a CAPE e entender as necessidades concretas da instituição.
* **Uso da TI como ferramenta social**, para rastrear doações e garantir que cheguem a quem realmente precisa.

---

## 🚀 Como utilizar este projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/seu-usuario/BANCAPE.git
   cd BANCAPE
   ```

2. Execute o script de criação do banco:

   ```sql
   SOURCE bancape.sql;
   ```

3. Em seguida, popule o banco:

   ```sql
   SOURCE populate_bancape.sql;
   ```

✅ O banco de dados estará pronto para consultas, simulações ou futuras integrações com aplicações.

---

## 🤝 Agradecimentos

* À **Casa de Acolhida Padre Eustáquio (CAPE)**, por abrir as portas e compartilhar seu trabalho inspirador.
* Ao professor **Wladmir Brandão**, pela orientação e por incentivar projetos com impacto social.

---

## 📌 Licença

Este projeto foi desenvolvido para fins acadêmicos. Sinta-se à vontade para explorar, adaptar e evoluir o código para outras iniciativas sociais.
