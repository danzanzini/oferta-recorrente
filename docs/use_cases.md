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

Para evoluir o caso de uso de produtos para "Gerenciar Produtos", considerando que os produtos têm nome, descrição e principais usos, sem mencionar o preço, podemos expandir o caso de uso para incluir não apenas o cadastro, mas também a edição e remoção de produtos. Além disso, ajustaremos a descrição para refletir as novas informações sobre os produtos.

### Gerenciar Produtos

#### Cadastrar um Novo Produto
- **Descrição:** Permitir que o produtor adicione um novo produto ao catálogo, incluindo seu nome, descrição e principais usos.
- **Pré-condições:** Estar logado como produtor.
- **Fluxo Principal:**
  1. O produtor acessa a seção de cadastro de produtos.
  2. O produtor insere informações do novo produto (nome, descrição, principais usos).
  3. O sistema valida as informações inseridas.
  4. O sistema registra o novo produto no catálogo.
- **Pós-condições:** O produto é adicionado ao catálogo e disponível para ser associado a oferendas ou kits.

#### Editar um Produto Existente
- **Descrição:** Permitir que o produtor altere as informações de um produto já cadastrado no sistema.
- **Pré-condições:** Estar logado como produtor e o produto deve estar previamente cadastrado.
- **Fluxo Principal:**
  1. O produtor acessa a lista de produtos cadastrados.
  2. O produtor seleciona o produto que deseja editar.
  3. O produtor atualiza as informações necessárias (nome, descrição, principais usos).
  4. O sistema valida as informações atualizadas.
  5. O sistema aplica as alterações ao produto.
- **Pós-condições:** As informações do produto são atualizadas no catálogo.

#### Remover um Produto
- **Descrição:** Permitir que o produtor remova um produto do catálogo.
- **Pré-condições:** Estar logado como produtor e o produto não deve estar associado a nenhuma oferenda ou kit ativo.
- **Fluxo Principal:**
  1. O produtor acessa a lista de produtos cadastrados.
  2. O produtor seleciona o produto que deseja remover.
  3. O sistema solicita confirmação para a remoção do produto.
  4. Após confirmação, o sistema remove o produto do catálogo.
- **Fluxo Alternativo:** Produto associado a oferenda ou kit.
  - O sistema informa que o produto está associado e não pode ser removido.
- **Pós-condições:** O produto é removido do catálogo, caso não esteja associado a oferendas ou kits ativos.

**Regras de Negócio:**
- RN1: Produtos só podem ser removidos se não estiverem associados a oferendas ou kits ativos.
- RN2: Todas as alterações devem ser validadas para garantir a integridade das informações.

### Cadastrar um Novo Kit
- **Descrição:** Permitir que o produtor crie kits de produtos para venda.
- **Pré-condições:** Estar logado como produtor e ter produtos cadastrados.
- **Fluxo Principal:**
  1. O produtor acessa a seção de cadastro de kits.
  2. O produtor seleciona produtos do catálogo para compor o kit.
  3. O sistema registra o novo kit.
- **Pós-condições:** O kit é adicionado ao catálogo.

### Gerenciar Oferendas
- **Descrição:** Permitir que o produtor gerencie de forma abrangente as oferendas, desde a criação, edição, publicação até a impressão de listas de itens coletados, com a capacidade de gerenciar múltiplas oferendas ativas simultaneamente em diferentes locais.
- **Pré-condições:** Estar logado como produtor.

#### Criar uma Nova Oferenda
1. O produtor acessa a seção de oferendas.
2. O sistema oferece a opção de criar uma nova oferenda, podendo usar a última oferenda como base.
3. O produtor modifica/adiciona informações para criar a nova oferenda.
4. O sistema valida as informações e registra a nova oferenda.
- **Pós-condições:** A nova oferenda é criada e registrada no sistema.

#### Editar uma Oferenda
1. O produtor seleciona uma oferenda existente da lista de oferendas.
2. O sistema permite a edição de informações da oferenda selecionada (nome, descrição, itens incluídos, datas de abertura e fechamento, locais específicos).
3. O produtor realiza as alterações desejadas.
4. O sistema valida as alterações e atualiza a oferenda.
- **Pós-condições:** A oferenda é atualizada com as novas informações.

#### Publicar uma Oferenda
1. O produtor seleciona uma oferenda editada ou recém-criada para publicação.
2. Define parâmetros de publicação, incluindo datas de abertura e fechamento e locais específicos.
3. O sistema processa a publicação, tornando a oferenda visível para os consumidores conforme definido.
- **Pós-condições:** A oferenda é publicada e disponível para os consumidores nos locais especificados.

#### Imprimir Lista de Itens Coletados
1. O produtor acessa a lista de oferendas fechadas.
2. Seleciona uma oferenda para a qual deseja imprimir a lista de itens coletados.
3. O sistema gera a lista dos itens coletados para essa oferenda.
4. O produtor imprime a lista.
- **Pós-condições:** O produtor obtém a lista de itens para a oferenda selecionada.

#### Regras de Negócio
- RN1: Oferendas podem ser criadas e editadas em partes, permitindo a adição ou alteração de informações em diferentes momentos.
- RN2: Múltiplas oferendas podem estar ativas simultaneamente, desde que sejam para locais diferentes, evitando sobreposições no mesmo local.
- RN3: A publicação de uma oferenda requer a validação completa de todas as informações, incluindo locais e datas específicas, para garantir a organização e evitar conflitos.

#### Fluxo Alternativo
- **Oferenda com Informações Incompletas:** Caso o produtor tente publicar uma oferenda com informações incompletas, o sistema exibirá uma mensagem de erro, solicitando a conclusão das informações faltantes.
- **Conflito de Localização:** Se o produtor tentar ativar uma oferenda em um local que já possui uma oferenda ativa no mesmo período, o sistema alertará sobre o conflito e solicitará a revisão das informações de localização ou datas.

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
- **Objetivo:** Permitir que o administrador gerencie (adicione, edite e remova) localizações disponíveis para as assinaturas dos usuários.
- **Pré-condições:** O administrador deve estar logado no sistema.
- **Fluxo Principal:**
  #### Adicionar Nova Localização
  1. O administrador acessa o painel de controle de localizações.
  2. O administrador seleciona a opção para adicionar uma nova localização.
  3. O administrador insere os detalhes da localização (nome, descrição, link e endereço).
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
