# Casos de Uso

## Usuário

### Logar no Sistema
- **Descrição:** Permitir que um usuário acesse sua conta no sistema usando suas credenciais.
- **Pré-condições:** O usuário deve ter uma conta válida.
- **Fluxo Principal:**
  1. O usuário seleciona a opção de login.
  2. O usuário insere seu e-mail e senha.
  3. O sistema valida as credenciais.
  4. O usuário é redirecionado para a página inicial.
- **Fluxo Alternativo:** Credenciais inválidas.
  - O sistema exibe uma mensagem de erro.
- **Pós-condições:** O usuário está logado no sistema.

### Recuperar Senha
- **Descrição:** Permitir que um usuário recupere o acesso à sua conta através da redefinição de senha.
- **Pré-condições:** O usuário deve ter uma conta válida.
- **Fluxo Principal:**
  1. O usuário seleciona a opção "Esqueci minha senha".
  2. O usuário insere seu e-mail.
  3. O sistema envia um e-mail com instruções de redefinição de senha.
  4. O usuário segue as instruções para criar uma nova senha.
- **Pós-condições:** O usuário pode logar no sistema com a nova senha.

### Visualizar a Tela Inicial
- **Objetivo:** Fornecer ao usuário uma tela inicial personalizada, que apresenta informações e opções relevantes de acordo com o seu tipo.
- **Pré-condições:** O usuário deve estar logado no sistema.
- **Fluxo Principal:**
  1. Determinação da Tela Inicial. Com base no tipo de usuário identificado, o sistema seleciona a versão da tela inicial apropriada.
     - Apoiador: Mostra informações sobre colheitas recentes, tarefas pendentes e notificações relevantes.
     - Produtor: Exibe oferendas atuais, status de produtos e kits, além de ações rápidas para gerenciamento de ofertas.
     - Administrador: Fornece uma visão geral do sistema, incluindo gerenciamento de usuários, relatórios de atividades e configurações do sistema.
  2. Visualização da Tela Inicial. O sistema apresenta a tela inicial selecionada ao usuário, com as informações e opções disponíveis conforme seu tipo.
- **Pós-condições:** O usuário visualiza a tela inicial personalizada, que oferece uma experiência de usuário otimizada e acesso rápido às funcionalidades que mais lhe interessam.
- **Regras de Negócio:**
  - RN1: O sistema deve sempre verificar o tipo de usuário para determinar a tela inicial correta.
  - RN2: As informações e opções apresentadas na tela inicial devem estar de acordo com as permissões do usuário, garantindo a segurança e a relevância dos dados exibidos.

## Apoiador

### Realizar a Colheita do Dia
- **Descrição:** Permitir que o apoiador escolha os itens e quantidades da colheita atualmente aberta.
- **Pré-condições:** Estar logado como apoiador. Existir uma colheita aberta pra localização do apoiador.
- **Fluxo Principal:**
  1. O apoiador acessa a página inicial.
  2. O apoiador acessa a página disponível para a colheita.
  3. O apoiador insere informações da colheita (produtos colhidos, quantidades).
  4. O sistema deve informar sobre os limites de quantidade.
  5. O sistema registra a colheita.
- **Fluxo Alternativo:** Colheita com quantidades inválidas ou indisponíveis.
  - O sistema exibe uma mensagem de erro identificando os itens a serem alterados.
- **Pós-condições:** A colheita do dia é registrada no sistema.

### Ver/Editar uma Colheita Realizada
- **Descrição:** Permitir que o apoiador visualize e edite informações de colheitas já realizadas.
- **Pré-condições:** Estar logado como apoiador. A colheita ainda deve estar aberta.
- **Fluxo Principal:**
  1. O apoiador acessa a página principal.
  2. O apoiador clica no botão de ver/editar colheita atualmente aberta.
  3. O apoiador visualiza os detalhes da colheita e, se necessário, edita informações.
  4. O sistema salva as alterações.
- **Fluxo Alternativo:** Colheita com quantidades inválidas ou indisponíveis.
  - O sistema exibe uma mensagem de erro identificando os itens a serem alterados.
- **Pós-condições:** As informações da colheita são atualizadas no sistema.

## Produtor

### Cadastrar um Novo Produto
- **Descrição:** Permitir que o produtor adicione um novo produto ao catálogo.
- **Pré-condições:** Estar logado como produtor.
- **Fluxo Principal:**
  1. O produtor acessa a seção de cadastro de produtos.
  2. O produtor insere informações do novo produto (nome, descrição, preço).
  3. O sistema registra o novo produto.
- **Pós-condições:** O produto é adicionado ao catálogo.

### Cadastrar um Novo Kit
- **Descrição:** Permitir que o produtor crie kits de produtos para venda.
- **Pré-condições:** Estar logado como produtor e ter produtos cadastrados.
- **Fluxo Principal:**
  1. O produtor acessa a seção de cadastro de kits.
  2. O produtor seleciona produtos do catálogo para compor o kit.
  3. O sistema registra o novo kit.
- **Pós-condições:** O kit é adicionado ao catálogo.

### Criar uma Nova Oferenda
- **Descrição:** Permitir que o produtor crie oferendas baseadas em oferendas anteriores.
- **Pré-condições:** Estar logado como produtor.
- **Fluxo Principal:**
  1. O produtor acessa a seção de oferendas.
  2. O sistema usa a última oferenda como base pra compor uma nova.
  3. O produtor modifica/adiciona informações para criar a nova oferenda.
  4. O sistema registra a nova oferenda.
- **Pós-condições:** A nova oferenda é criada e registrada no sistema.

### Publicar uma Oferenda
- **Descrição:** Automatizar a publicação de oferendas para os consumidores.
- **Pré-condições:** Estar logado como produtor e ter uma oferenda pronta para publicação.
- **Fluxo Principal:**
  1. O produtor seleciona a oferenda a ser publicada.
  2. O produtor define uma data de abertura e fechamento.
  3. O produtor confirma a publicação.
  4. O sistema automaticamente disponibiliza a oferenda para os consumidores durante o período selecionado.
- **Pós-condições:** A oferenda é publicada e visível para os consumidores durante o período selecionado.

### Imprimir Lista de Itens Coletados de Determinada Oferenda
- **Descrição:** Permitir que o produtor imprima uma lista de itens coletados para uma oferenda específica.
- **Pré-condições:** Estar logado como produtor e ter oferendas registradas e fechadas.
- **Fluxo Principal:**
  1. O produtor acessa a seção de oferendas.
  2. O produtor seleciona uma oferenda.
  3. O produtor solicita a impressão da lista de itens coletados.
  4. O sistema gera e disponibiliza a lista para impressão.
- **Pós-condições:** O produtor obtém a lista de itens para a oferenda selecionada.

## Administrador

### Gerenciar Usuários da Organização
- **Descrição:** Permitir que o administrador adicione, remova ou altere informações dos usuários da organização.
- **Pré-condições:** Estar logado como administrador.
- **Informações do usuário:** Nome, e-mail.
- **Ações possíveis:** Ativar/Desativar, Restaurar Senha (opcional), Trocar Plano
- **Fluxo Principal:**
  1. O administrador acessa o painel de gerenciamento de usuários.
  2. O administrador realiza as ações necessárias (adicionar, remover, editar).
  3. O sistema aplica as alterações.
- **Pós-condições:** As informações dos usuários são atualizadas conforme as ações do administrador.

### Gerenciar Oferendas e Colheitas
- **Descrição:** Permitir que o administrador visualize, edite ou remova oferendas e registros de colheitas.
- **Pré-condições:** Estar logado como administrador.
- **Fluxo Principal:**
  1. O administrador acessa o painel de gerenciamento de oferendas e colheitas.
  2. O administrador seleciona uma oferenda ou colheita para gerenciar.
  3. O administrador realiza as ações necessárias (visualizar, editar, remover).
- **Pós-condições:** As oferendas e colheitas são gerenciadas conforme as ações do administrador.

### Gerenciar Localizações
- **Ator:** Administrador
- **Objetivo:** Permitir que o administrador gerencie (adicione, edite e remova) localizações disponíveis para as assinaturas dos usuários.
- **Pré-condições:** O administrador deve estar logado no sistema.
- **Fluxo Principal:**
  #### Adicionar Nova Localização
  1. O administrador acessa o painel de controle de localizações.
  2. O administrador seleciona a opção para adicionar uma nova localização.
  3. O administrador insere os detalhes da localização (nome, descrição, coordenadas).
  4. O sistema valida as informações e salva a nova localização.
  5. **Pós-condições:** A nova localização está disponível para ser associada a assinaturas de usuários.
  #### Editar Localização Existente
  1. O administrador acessa a lista de localizações cadastradas.
  2. O administrador seleciona uma localização para editar.
  3. O administrador modifica os detalhes da localização conforme necessário (nome, descrição, coordenadas).
  4. O sistema valida as informações atualizadas e aplica as alterações.
  5. **Pós-condições:** As informações da localização são atualizadas no sistema.
  #### Remover Localização
  1. O administrador acessa a lista de localizações cadastradas.
  2. O administrador seleciona uma localização para remover.
  3. O sistema solicita confirmação para evitar exclusões acidentais.
  4. Após confirmação, o sistema remove a localização selecionada.
  5. **Pós-condições:** A localização é removida do sistema e não está mais disponível para associação com novas assinaturas.
- **Fluxo Alternativo: Localização em Uso**
  - Se a localização selecionada para remoção estiver associada a uma ou mais assinaturas ativas, o sistema alerta o administrador e sugere ações alternativas, como reatribuir as assinaturas existentes para outra localização antes da remoção.
- **Regras de Negócio:**
  - Localizações não podem ser removidas se estiverem associadas a assinaturas ativas, a menos que uma reatribuição seja realizada.
  - Todas as alterações nas localizações devem ser auditadas para rastrear quem fez a alteração e quando.
