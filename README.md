# Documentação Projeto Flutter

## Objetivos Específicos

### 1. Implementar a Autenticação de Usuários

- Utilizar o Firebase Authentication para permitir que usuários façam login e cadastro com email e senha.

- Garantir a segurança e a validade dos dados fornecidos para acesso ao sistema.

### 2. Cadastrar e Gerenciar Informações de Usuários e Visitantes

- Armazenar dados adicionais dos usuários (nome, bloco, número do apartamento e CPF) e dos visitantes (nome e CPF) no Firebase Firestore.

- Facilitar o gerenciamento e acesso aos dados de forma organizada e segura.

### 3. Gerar e Exibir QR Code para Identificação

- Utilizar QR Codes para representar informações importantes, como o CPF do usuário, permitindo identificação rápida e fácil.

- Exibir o QR Code diretamente no aplicativo após o cadastro ou atualização de dados relevantes.

### 4. Facilitar o Cadastro de Visitantes

- Permitir que visitantes sejam registrados no sistema, com informações básicas armazenadas no Firestore.

- Utilizar o QR Code para a identificação de visitantes, otimizando a segurança e o controle de acesso.

### 5. Fornecer uma Interface de Usuário Intuitiva e Responsiva

- Criar uma experiência de usuário amigável e intuitiva, permitindo fácil navegação entre telas de login, cadastro, e visualização do QR Code.

- Manter uma estética visual simples, com foco na funcionalidade e usabilidade do aplicativo.

## Objetivos Mensuráveis

### 1. Cadastro e Autenticação de Usuários

- **Meta:** Implementar e testar o fluxo de autenticação com Firebase para cadastro e login de novos usuários.

- **Indicadores de Sucesso:**

  - Cadastro e login de pelo menos 95% dos usuários sem erros.

  - Tempo médio de resposta para login inferior a 2 segundos.

  - Feedback positivo em testes de usabilidade (mínimo de 80% de satisfação em testes com usuários).

### 2. Armazenamento de Dados no Firestore

- **Meta:** Armazenar informações dos usuários e visitantes no Firestore e garantir integridade e segurança dos dados.

- **Indicadores de Sucesso:**

  - Registro de dados para pelo menos 98% dos usuários sem erros de sincronização.

  - Teste de recuperação de dados com consistência e sem perda de informações para 100% dos usuários cadastrados.

  - Média de consultas e gravações ao Firestore inferior a 1 segundo.

### 3. Geração e Exibição de QR Codes

- **Meta:** Gerar QR Codes únicos para cada usuário e visitante, contendo informações de identificação como CPF.

- **Indicadores de Sucesso:**

  - QR Code gerado e exibido em menos de 1 segundo após o cadastro.

  - QR Codes legíveis e funcionais para pelo menos 99% dos usuários.

  - Feedback positivo dos usuários sobre a facilidade de exibição e uso do QR Code.

### 4. Cadastro de Visitantes e Controle de Acesso

- **Meta:** Permitir o registro e consulta de visitantes com base em dados como CPF e nome, e garantir identificação rápida através de QR Codes.

- **Indicadores de Sucesso:**

  - Registro de visitantes sem erros em pelo menos 95% dos casos.

  - Tempo médio de registro de visitante inferior a 3 segundos.

  - Satisfação dos usuários com o processo de cadastro de visitantes de pelo menos 80% em testes de usabilidade.

### 5. Interface de Usuário Intuitiva e Responsiva

- **Meta:** Criar uma interface que permita navegação intuitiva e fluida entre telas e exiba informações de forma clara e organizada.

- **Indicadores de Sucesso:**

  - Concluir 95% das ações padrão em menos de 3 cliques.

  - Tempo médio de carregamento de cada tela inferior a 2 segundos.

  - Obter pelo menos 85% de feedback positivo dos usuários em testes de usabilidade quanto à navegação e design da interface.

## Objetivos Atingíveis

### 1. Implementar Autenticação e Cadastro com Firebase

- **Meta:** Utilizar os serviços do Firebase Authentication para o cadastro e login de usuários com email e senha.

- **Ações:**

  - Configurar o Firebase no projeto, garantindo que as operações de autenticação sejam seguras e eficientes.

  - Fornecer mensagens de feedback claras para guiar o usuário em caso de erros de autenticação (como senha incorreta ou email inválido).

### 2. Gerenciamento de Dados de Usuários e Visitantes no Firestore

- **Meta:** Implementar a integração com o Firestore para armazenar dados de cada usuário e visitante, incluindo informações pessoais (nome, CPF, bloco, etc.).

- **Ações:**

  - Configurar e testar a recuperação de dados do Firestore para garantir que as informações estejam acessíveis e sejam corretamente exibidas nas telas apropriadas.

  - Estruturar a base de dados de forma organizada, com coleções e documentos para usuários e visitantes, mantendo a escalabilidade.

### 3. Geração de QR Codes para Identificação

- **Meta:** Utilizar uma biblioteca de geração de QR Code (como qr_flutter) para criar e exibir códigos únicos, baseados em informações do usuário como CPF.

- **Ações:**

  - Implementar QR Codes na interface de maneira visualmente acessível e fácil de identificar, garantindo que sejam legíveis e rápidos para escaneamento.

  - Testar a usabilidade dos QR Codes com múltiplos dispositivos para verificar compatibilidade e usabilidade em diferentes telas e resoluções.

### 4. Cadastro Simples de Visitantes e Controle de Acesso

- **Meta:** Desenvolver uma funcionalidade que permita aos usuários registrar visitantes rapidamente, preenchendo apenas as informações essenciais, como nome e CPF.

- **Ações:**

  - Garantir que o cadastro de visitantes seja armazenado no Firestore e possa ser acessado e atualizado com facilidade pelos usuários autorizados.

  - Implementar um controle de feedback para confirmar quando o cadastro for concluído com sucesso ou notificar em caso de erros.

### 5. Interface de Usuário Clara e Navegação Intuitiva

- **Meta:** Criar uma interface de fácil navegação utilizando widgets nativos do Flutter como TextField, ElevatedButton, e QrImageView para garantir a consistência visual e responsividade.

- **Ações:**

  - Dividir o fluxo de telas em ações claras e organizadas, como cadastro de usuário, geração de QR Code e cadastro de visitantes.

  - Testar o design com um grupo de usuários para receber feedback inicial e ajustar o layout, de forma a otimizar a experiência de usuário e facilitar o aprendizado da navegação.

## Objetivos Relevantes

### 1. Facilitar o Cadastro e Autenticação de Usuários

- **Relevância:** Este objetivo é crucial, pois permite que os usuários acessem o sistema de forma rápida e segura. A implementação da autenticação com Firebase não apenas garante a segurança dos dados, mas também simplifica o processo de login e registro, tornando o aplicativo mais acessível e atraente para os usuários.

### 2. Melhorar o Controle de Visitantes

- **Relevância:** O cadastro simples de visitantes é relevante para a gestão de acesso em ambientes que requerem monitoramento, como condomínios ou eventos. Isso promove uma maior segurança e organização, permitindo que os usuários registrem rapidamente visitantes e mantenham um histórico de entradas.

### 3. Integração com Firestore para Armazenamento de Dados

- **Relevância:** O uso do Firestore para armazenar dados de usuários e visitantes é um objetivo relevante, pois oferece uma solução escalável e em tempo real para gerenciar informações. Essa integração permite que o aplicativo mantenha dados consistentes e acessíveis, melhorando a experiência do usuário e a eficiência do sistema.

### 4. Implementação de QR Codes para Identificação Rápida

- **Relevância:** A geração de QR Codes para identificação é um recurso que agrega valor ao aplicativo, oferecendo uma maneira rápida e eficiente de acessar informações de usuários e visitantes. Essa funcionalidade pode reduzir filas e tempo de espera em entradas, aumentando a satisfação do usuário e a eficácia do controle de acesso.

### 5. Desenvolvimento de uma Interface Amigável e Intuitiva

- **Relevância:** Criar uma interface de usuário clara e intuitiva é relevante para garantir que usuários de diferentes níveis de habilidade tecnológica possam navegar no aplicativo sem dificuldades. Uma boa experiência do usuário pode aumentar a adoção do aplicativo e a retenção de usuários, impactando positivamente o sucesso do projeto.

### 6. Feedback e Mensagens de Erro Claras

- **Relevância:** Implementar feedback claro e mensagens de erro é relevante para melhorar a experiência do usuário e minimizar a frustração. Isso ajuda os usuários a entender o que está acontecendo no aplicativo e como corrigir eventuais problemas, contribuindo para uma interação mais fluida e satisfatória.

## Objetivos Temporais

### Pesquisa e Planejamento (1 mês)

Concluir a fase de pesquisa de mercado e planejamento do projeto, identificando as necessidades dos usuários e definindo os requisitos funcionais e não funcionais do aplicativo. **Prazo:** 1 mês após o início do projeto.

### Desenvolvimento da Estrutura Inicial (1 mês)

Criar a estrutura básica do aplicativo, incluindo a configuração do Firebase e a implementação das primeiras telas de login e cadastro. **Prazo:** 2 meses após o início do projeto.

### Implementação da Funcionalidade de Cadastro de Usuários (2 semanas)

Implementar a funcionalidade de registro de usuários com autenticação via Firebase, incluindo a validação de dados e o tratamento de erros. **Prazo:** 2 meses e 2 semanas após o início do projeto.

### Implementação da Funcionalidade de Cadastro de Visitantes (2 semanas)

Desenvolver a funcionalidade para o cadastro de visitantes, incluindo a interface e o armazenamento de dados no Firestore. **Prazo:** 3 meses após o início do projeto.

### Desenvolvimento da Geração de QR Codes (2 semanas)

Implementar a funcionalidade de geração de QR Codes para identificação de usuários e visitantes, testando a usabilidade e a eficiência dessa funcionalidade. **Prazo:** 3 meses e 2 semanas após o início do projeto.

### Teste de Usabilidade e Ajustes (3 semanas)

Realizar testes de usabilidade com um grupo de usuários para identificar pontos de melhoria e corrigir problemas antes do lançamento. **Prazo:** 4 meses após o início do projeto.

### Preparação para Lançamento e Marketing (2 semanas)

Criar uma estratégia de marketing para promover o aplicativo, incluindo a preparação de materiais promocionais e a definição de canais de divulgação. **Prazo:** 4 meses e 3 semanas após o início do projeto.

### Lançamento do Aplicativo (1 semana)

Publicar o aplicativo nas lojas digitais (Google Play e Apple App Store) e monitorar a recepção inicial dos usuários. **Prazo:** 5 meses após o início do projeto.

### Coleta de Feedback e Atualizações (Contínuo)

Após o lançamento, coletar feedback dos usuários e realizar atualizações contínuas para melhorar o aplicativo com base nas sugestões e necessidades identificadas. **Prazo:** contínuo, iniciando uma semana após o lançamento.

## Cronograma do Projeto

1. **Pesquisa e Planejamento**

   - **Duração:** 4 semanas
   - **Data de Início:** 01/11/2024
   - **Data de Término:** 29/11/2024
   - Nesta fase, serão coletadas informações sobre as necessidades dos usuários e definidos os requisitos do aplicativo.

2. **Desenvolvimento da Estrutura Inicial**

   - **Duração:** 4 semanas
   - **Data de Início:** 30/11/2024
   - **Data de Término:** 27/12/2024
   - Nesta etapa, será feita a configuração do Firebase e a criação das telas básicas de login e cadastro.

3. **Implementação da Funcionalidade de Cadastro de Usuários**

   - **Duração:** 2 semanas
   - **Data de Início:** 28/12/2024
   - **Data de Término:** 11/01/2025
   - Aqui, será criada a funcionalidade de registro de usuários com validação de dados.

4. **Implementação da Funcionalidade de Cadastro de Visitantes**

   - **Duração:** 2 semanas
   - **Data de Início:** 12/01/2025
   - **Data de Término:** 26/01/2025
   - Nesta fase, será desenvolvida a funcionalidade para o cadastro de visitantes.

5. **Desenvolvimento da Geração de QR Codes**

   - **Duração:** 2 semanas
   - **Data de Início:** 27/01/2025
   - **Data de Término:** 10/02/2025
   - Aqui, será implementada a funcionalidade de geração de QR Codes para identificação.

6. **Teste de Usabilidade e Ajustes**

   - **Duração:** 3 semanas
   - **Data de Início:** 11/02/2025
   - **Data de Término:** 03/03/2025
   - Nesta etapa, serão realizados testes de usabilidade e correções com base no feedback dos usuários.

7. **Preparação para Lançamento e Marketing**

   - **Duração:** 2 semanas
   - **Data de Início:** 04/03/2025
   - **Data de Término:** 17/03/2025
   - Aqui, serão criados materiais de divulgação e definidos os canais de marketing.

8. **Lançamento do Aplicativo**

   - **Duração:** 1 semana
   - **Data de Início:** 18/03/2025
   - **Data de Término:** 24/03/2025
   - Nesta fase, o aplicativo será publicado nas lojas digitais.

9. **Coleta de Feedback e Atualizações**
   - **Duração:** Contínuo
   - **Data de Início:** 25/03/2025
   - **Data de Término:** Contínuo
   - Após o lançamento, será feita a coleta de feedback dos usuários e realizadas atualizações contínuas.

## Recursos Necessários para o Projeto

1. **Recursos Humanos**

   - **Desenvolvedores:**
     - 2 Desenvolvedores Flutter para a criação do aplicativo.
     - 1 Desenvolvedor Backend para integração com o Firebase.
   - **Designer:**
     - 1 Designer UI/UX para desenvolver a interface do usuário e garantir uma experiência de uso intuitiva.
   - **Testadores:**
     - 1 ou 2 testadores para conduzir os testes de usabilidade e garantir a qualidade do aplicativo.

2. **Recursos Técnicos**

   - **Ambiente de Desenvolvimento:**
     - IDE: Android Studio ou Visual Studio Code, ambos com suporte para Flutter.
     - Sistema de Controle de Versão: Git para versionamento do código.
   - **Infraestrutura de Backend:**
     - Firebase: Utilização do Firebase para autenticação, Firestore para armazenamento de dados e geração de QR Codes.
   - **Bibliotecas e Ferramentas:**
     - QR Code Generator: Biblioteca `qr_flutter` para a geração de QR Codes.
     - Pacotes Flutter: Dependências como `firebase_auth` e `cloud_firestore` para integração com o Firebase.

3. **Recursos Financeiros**

   - **Custo de Licenças:**
     - Considerar custos com serviços pagos do Firebase, se necessário, como uso acima do plano gratuito.
   - **Marketing:**
     - Orçamento para campanhas de marketing digital para promover o aplicativo após o lançamento.

4. **Recursos Materiais**

   - **Equipamentos:**
     - Computadores com especificações adequadas para desenvolvimento e testes de aplicativos móveis.
   - **Dispositivos de Teste:**
     - Smartphones e tablets para testes de usabilidade em diferentes tamanhos de tela e sistemas operacionais.

5. **Recursos de Tempo**
   - **Tempo de Desenvolvimento:**
     - Atribuir um cronograma realista para cada fase do projeto, conforme descrito anteriormente, garantindo que todas as atividades sejam concluídas dentro do prazo.

## Análise de Risco

A análise de risco é uma parte essencial do planejamento do projeto, permitindo identificar potenciais riscos que possam afetar o desenvolvimento do aplicativo e criar estratégias para mitigá-los. A seguir, apresentamos uma identificação dos riscos, sua avaliação e os planos de mitigação correspondentes.

### Identificação de Riscos

Foram identificados os seguintes riscos:

1. **Risco de Atraso no Cronograma:** Existe a possibilidade de atrasos no desenvolvimento devido à subestimação do tempo necessário para as tarefas.
2. **Problemas de Integração com Firebase:** Dificuldades na integração com os serviços do Firebase podem resultar em atrasos ou falhas de funcionalidade.
3. **Erros de Código:** Bugs ou falhas no código podem afetar a funcionalidade do aplicativo e a experiência do usuário.
4. **Alterações nos Requisitos:** Mudanças nos requisitos do projeto durante o desenvolvimento podem causar retrabalho e atraso.
5. **Falta de Testes Adequados:** Insuficiência nos testes pode levar a falhas não detectadas na aplicação.
6. **Dependência de Tecnologias Externas:** Problemas relacionados à disponibilidade ou alterações em serviços de terceiros, como o Firebase, podem afetar o projeto.
7. **Recursos Humanos:** Pode haver dificuldades em encontrar e reter desenvolvedores qualificados, afetando a qualidade e o tempo do projeto.
8. **Problemas de Comunicação:** Falhas na comunicação entre os membros da equipe podem levar a mal-entendidos e erros.

### Avaliação de Riscos

Os riscos identificados foram avaliados em termos de probabilidade e impacto, resultando nos seguintes níveis de risco:

1. **Risco de Atraso no Cronograma:** Alto (Crítico)
2. **Problemas de Integração com Firebase:** Médio (Alto)
3. **Erros de Código:** Alto (Alto)
4. **Alterações nos Requisitos:** Médio (Alto)
5. **Falta de Testes Adequados:** Médio (Alto)
6. **Dependência de Tecnologias Externas:** Baixo (Médio)
7. **Recursos Humanos:** Médio (Médio)
8. **Problemas de Comunicação:** Médio (Médio)

### Planos de Mitigação

Para cada risco identificado, foram elaboradas estratégias de mitigação:

1. **Atraso no Cronograma:** Estabelecer um cronograma realista e realizar reuniões semanais para acompanhar o progresso e ajustar prazos conforme necessário.
2. **Integração com Firebase:** Designar um membro da equipe como especialista em Firebase, realizando testes de integração em etapas.
3. **Erros de Código:** Implementar revisões de código regulares e testes unitários para detectar bugs antecipadamente.
4. **Alterações nos Requisitos:** Manter documentação clara e implementar um processo formal de controle de mudanças.
5. **Falta de Testes Adequados:** Definir um plano de testes abrangente que inclua testes manuais e automatizados.
6. **Dependência de Tecnologias Externas:** Planejar alternativas e backups para serviços críticos, mantendo comunicação regular com fornecedores.
7. **Recursos Humanos:** Investir em treinamento e desenvolvimento contínuo da equipe, além de estabelecer um ambiente de trabalho positivo para retenção de talentos.
8. **Problemas de Comunicação:** Estabelecer canais de comunicação claros e realizar reuniões regulares para manter todos na mesma página.

## Designs do Figma

Os designs do aplicativo estão disponíveis no Figma. Você pode acessar os arquivos de design através do link a seguir: [https://www.figma.com/design/fiLX65iIj1q2fC2ZzWkJMd/Untitled?node-id=0-1&t=zOwCTmk0YqaeKShZ-1](#).

# Manual do Usuário do Aplicativo QR Code

## Introdução

Bem-vindo ao aplicativo QR Code! Este aplicativo foi desenvolvido para facilitar o cadastro de usuários e visitantes, gerando QR Codes que podem ser utilizados para identificação. Este manual fornecerá orientações sobre como usar as funcionalidades do aplicativo.

## Índice

1. [Requisitos do Sistema](#requisitos-do-sistema)
2. [Instalação do Aplicativo](#instalação-do-aplicativo)
3. [Tela de Login](#tela-de-login)
4. [Tela de Cadastro](#tela-de-cadastro)
5. [Geração de QR Code](#geração-de-qr-code)
6. [Tela de Visitas](#tela-de-visitas)
7. [Suporte e Contato](#suporte-e-contato)

## Requisitos do Sistema

- **Sistema Operacional:** Android ou iOS
- **Versão do Firebase:** Configurada no projeto
- **Conexão com a Internet:** Necessária para autenticação e armazenamento em nuvem

## Instalação do Aplicativo

1. Acesse a loja de aplicativos do seu dispositivo (Google Play Store ou Apple App Store).
2. Pesquise por "QR Code App".
3. Baixe e instale o aplicativo no seu dispositivo.
4. Abra o aplicativo após a instalação.

## Tela de Login

- **Abrindo o Aplicativo:** Ao abrir o aplicativo, você verá a tela de login.
- **Entrar:**
  - Insira seu email e senha.
  - Toque no botão "Entrar".
- **Cadastrar:** Se você não tem uma conta, toque em "Cadastrar" para ser redirecionado à tela de cadastro.

## Tela de Cadastro

- **Preenchimento dos Campos:**
  - Preencha todos os campos obrigatórios: Nome, Email, Senha, Bloco, Número do Apartamento e CPF.
  - Certifique-se de que os dados estão corretos.
- **Cadastrar:**
  - Após preencher os campos, toque no botão "Cadastrar".
  - O aplicativo exibirá uma mensagem de confirmação ou erro.
- **Limpar Campos:** Você pode limpar os campos tocando no botão "Limpar".

## Geração de QR Code

- **Após o Cadastro:** Depois de se cadastrar, o aplicativo gera automaticamente um QR Code.
- **Visualização do QR Code:** Você pode visualizar o QR Code na tela principal após o login.
- **Salvar/Compartilhar:**
  - Para salvar ou compartilhar o QR Code, toque no botão correspondente.

## Tela de Visitas

- **Cadastrar Visitantes:**
  - Navegue até a tela de visitantes.
  - Preencha os campos de Nome e CPF.
  - Toque em "Cadastrar Visitante" para registrar.
- **Visualização de Visitantes:** Você pode visualizar a lista de visitantes cadastrados.
- **Gerar QR Code para Visitantes:** Assim como os usuários, os visitantes também terão QR Codes gerados para identificação.

## Suporte e Contato

Para suporte técnico ou dúvidas sobre o aplicativo, entre em contato com nossa equipe através do email: suporte@qrcodeapp.com.
