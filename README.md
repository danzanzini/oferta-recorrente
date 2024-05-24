# README

## Visão Geral do Projeto

Este é um sistema desenvolvido para a CSA Recife, uma iniciativa de Comunidade que Sustenta a Agricultura. O objetivo do sistema é facilitar as rotinas da entidade na interação entre agricultores e co-agricultores, permitindo que os agricultores cadastrem seus produtos semanais através de ofertas, e que os co-agricultores possam escolher, dentre esses produtos, quais irão coletar.

## Sobre a CSA Recife

CSA Recife é uma iniciativa que promove um modelo de agricultura comunitária onde consumidores e produtores estabelecem uma parceria direta. Os consumidores se comprometem a apoiar financeiramente os produtores locais, geralmente pagando uma taxa mensal ou anual, e em troca, recebem uma parte da produção agrícola.

### Benefícios da CSA Recife:

- **Alimentos Frescos e Saudáveis:** Os membros recebem produtos frescos, muitas vezes colhidos no mesmo dia da entrega.
- **Apoio à Agricultura Local:** Fortalece a economia local e apoia pequenos agricultores.
- **Sustentabilidade Ambiental:** Incentiva práticas agrícolas que respeitam o meio ambiente.
- **Engajamento Comunitário:** Promove um senso de comunidade e colaboração entre os membros.

## Estrutura do Projeto

A estrutura do projeto segue o padrão MVC (Model-View-Controller) do [Ruby on Rails](https://rubyonrails.org/).

## Funcionalidades Principais

- **Cadastro de Produtos:** Agricultores podem cadastrar novos produtos e kits.
- **Criação de Oferendas:** Agricultores podem criar e publicar oferendas semanais.
- **Escolha de Produtos:** Co-agricultores podem escolher os produtos que desejam receber semanalmente.
- **Múltiplos pontos de coleta:** Administradores podem gerenciar vários locais de oferta e coleta de alimentos.
- **Gerenciamento de Usuários:** Administradores podem gerenciar usuários da organização.

## Dependências

### Ruby 3.3.0:

Certifique-se de que a versão correta do [Ruby](https://www.ruby-lang.org/) está instalada. Você pode usar o [chruby](https://github.com/postmodern/chruby) para gerenciar versões do Ruby.

### Outras Dependências do Sistema

1. **PostgreSQL:**
    - [Documentação Oficial do PostgreSQL](https://www.postgresql.org/docs/)

2. **Node.js e Yarn:**
    - [Node.js](https://nodejs.org/)
    - [Yarn](https://yarnpkg.com/)

3. **Redis (opcional):**
    - [Documentação Oficial do Redis](https://redis.io/documentation)

4. **Chromedriver:**
    - [Documentação Oficial do Chromedriver](https://sites.google.com/a/chromium.org/chromedriver/)

## Instalação

Para configurar o projeto localmente, siga os seguintes passos:

1. Clone o repositório:
    ```bash
    git clone <URL_DO_REPOSITORIO>
    cd <NOME_DO_PROJETO>
    ```

2. Instale as dependências:
    ```bash
    bundle install
    yarn install
    ```

3. Configure o banco de dados:
    ```bash
    rails db:create
    rails db:migrate
    ```

4. Inicie o servidor:
    ```bash
    rails server
    ```

5. Acesse o sistema no navegador:
    ```plaintext
    http://localhost:3000
    ```
   
6. Dados de teste: 
    ```bash
   rails db:seed
    ```
   Em abiente de desenvolvimento, gerará dados de teste.

## Contribuição

Se você deseja contribuir com o projeto, siga os passos abaixo:

1. Faça um fork do repositório.
2. Crie uma nova branch para sua feature ou correção de bug:
    ```bash
    git checkout -b minha-feature
    ```
3. Faça commit das suas alterações:
    ```bash
    git commit -m 'Adiciona minha feature'
    ```
4. Envie para o repositório remoto:
    ```bash
    git push origin minha-feature
    ```
5. Abra um Pull Request.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

Se tiver alguma dúvida ou precisar de mais informações, sinta-se à vontade para entrar em contato. Agradecemos por contribuir para a CSA Recife!
