# Documentação Projeto Flutter

### **Projeto Xcanner**

### 📜 **Sobre o que é e qual sua importância?**

**Xcanner** é um sistema de controle de acesso de visitantes, que visa:

1. **A segurança do condomínio** de casas ou apartamentos.
2. **A eficiência e eficácia** na restrição e na entrada de visitantes.
3. **Facilitar a comunicação** da portaria com o morador.

---

### 🎯 **Objetivos Principais**

- **Melhora da Segurança** e restrição de visitantes.
- **Facilitar a entrada** e registro do visitante, mantendo um controle maior sobre a entrada de cada um.
- **Reduzir as filas** nas entradas dos condomínios.
- **Facilitar a comunicação** entre a portaria e o morador.

---

### ⚙️ **Funcionalidades**

**Funcionalidades atuais:**

- **Entrada do Morador** no sistema (Login).
- **Cadastro do Visitante** (Nome Completo e CPF).
- **Visualização dos Visitantes** cadastrados.
- Visitante cadastrado, será gerado um **QR-Code** com base no CPF.
- **Baixar o QR-Code** gerado, que será armazenado em sua galeria, para enviar ao visitante (e-mail, WhatsApp, etc.).
- **Leitura do QR-Code**, verificando e fazendo a autenticação no Firebase.

**Funcionalidades futuras:**

- **Notificar ao morador**:
    - Quando o visitante entrar, o morador será notificado em seu celular.
- **Expiração do QR-Code**:
    - Quando o visitante aproximar o QR-Code do leitor e for válido, o código passa de “true” para “false”, assim ficando inválido, tornando o acesso ao condomínio mais seguro. Se o visitante tentar compartilhar o QR-Code, não irá funcionar
- **Botão de Reload**:
    - Para visitantes que irão retornar, criar um botão de reload que altera o status do código de “false” para “true”.
### Cronograma
| Etapa                        | Duração     | Descrição                                                                          |
|------------------------------|-------------|------------------------------------------------------------------------------------|
| Pesquisa e Planejamento      | 24 Horas       | Levantamento de requisitos e necessidades.                                      |
| Desenvolvimento Estrutural   | 24 Horas       | Configuração Firebase.                                                          |
| Cadastro de Usuários e Visitantes | 24 Horas   | Implementação das funcionalidades de autenticação e cadastro no Firestore.        |
| Geração e Leitura de QR Codes          | 48 Horas   | Criação de QR Codes para identificação dos visitantes.                             |
| Testes e Ajustes             | 24 Horas   | Avaliação da usabilidade e ajustes necessários após testes.                        |


### Recursos

- **Humanos**: 4 Desenvolvedores Flutter
- **Técnicos**: Ferramentas de desenvolvimento (VS Code), controle de versão Git, Firebase para autenticação e Firestore, biblioteca qr_flutter, mobile_scanner.

- Diagrama de Fluxo
    - Leitor
  ```mermaid
  flowchart TD
    A["Início"] --> B["Abrir Câmera"]
    B --> C["Aproximar QR-CODE"]
    C --> D{"Código Válido?"}
    D -- Sim --> E["Acesso Liberado"]
    D -- Não --> F["Acesso Negado"]
    E --> O["Fim"]
    F --> O["Fim"]

    %% Estilo
    style A fill:#2c2c2c,stroke:#2c6f5c,stroke-width:2px,color:#ffffff
    style B fill:#2c2c2c,stroke:#2c6f5c,stroke-width:2px,color:#ffffff
    style C fill:#2c2c2c,stroke:#2c6f5c,stroke-width:2px,color:#ffffff
    style D fill:#2c2c2c,stroke:#2c6f5c,stroke-width:2px,color:#ffffff
    style E fill:#2c2c2c,stroke:#2c6f5c,stroke-width:2px,color:#ffffff
    style F fill:#2c2c2c,stroke:#2c6f5c,stroke-width:2px,color:#ffffff
    style O fill:#2c2c2c,stroke:#2c6f5c,stroke-width:2px,color:#ffffff

```mermaid
flowchart TD
    A["Início"] --> B["Morador faz login"]
    B --> C{"Cadastro de Visitante?"}
    C -- Sim --> D["Preencher Nome e CPF"]
    D --> E["Geração do QR-CODE"]
    C -- Não --> H{"Listar Visitantes"}
    H -- Sim --> I["Visualizar QR_CODE do Visitante"]
    I --> J["Baixar QR-CODE"]
    J --> K["Enviar QR-CODE"]
    H -- Não --> O["Fim"]
    E --> H
    K --> O

    %% Estilo
    style A fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
    style B fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
    style C fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
    style D fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
    style E fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
    style H fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
    style I fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
    style J fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
    style K fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
    style O fill:#7fd3b8,stroke:#2c6f5c,stroke-width:2px,color:#000000
