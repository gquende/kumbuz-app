# Kumbuz

O Kumbuz é uma aplicação inovadora de gestão de finanças pessoais, desenvolvida para ajudar os utilizadores a organizar,
monitorizar e otimizar as suas finanças de forma simples e eficiente. Com uma interface intuitiva e funcionalidades
avançadas, o Kumbuz é a solução ideal para quem deseja ter um maior controlo sobre os seus rendimentos.

## Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento para interfaces nativas em Android e iOS.
- **GetX**: Biblioteca para gerenciamento de estado, navegação e injeção de dependências.
- **GetIt e Injectable**: Ferramentas para injeção de dependência.

## Estrutura do Projeto

O Kumbuz adota o padrão MVC (Model-View-Control) para separar lógica de apresentação da lógica de negócios, promovendo a
manutenibilidade e testabilidade do código.

A estrutura do projeto segue a seguinte organização:

- `lib/`
    - `models/`: Contém as classes de modelo usadas no aplicativo.
    - `views/`: Define as interfaces gráficas do usuário.
    - `controllers/`: Gerencia a lógica da interface e interage com os modelos.
    - `data/`: Contém serviços de API e integrações externas.
    - `routes/`: Define as rotas de navegação.
    - `resources/`: Utilitários e funções auxiliares.
    - `injector/`: Configurações do GetIt para injeção de dependências.

## Funcionalidades Principais

## Pré-requisitos

Certifique-se de ter os seguintes pré-requisitos instalados:

- Flutter SDK
- Android Studio / Xcode

## Instalação

1. Clone este repositório:
   ```bash
   git clone https://github.com/gquende/kumbuz-app.git
   cd kumbuz-app
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

4. Execute build runner para gerar arquivo g.dart:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. Execute o aplicativo:
   ```bash
   flutter run
   ```

## Estrutura de Pastas

- **Modelos**: `lib/models/`
- **Views**: `lib/views/`
- **Controller**: `lib/controllers/`
- **repository**: `lib/repository/`
- **Rotas**: `lib/routes/`
- **Injeção de Dependência**: `lib/injector/`


