# StudyFlow

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)

App em Flutter para auxiliar nos estudos para o ENEM. O conteúdo é organizado por áreas do conhecimento, com filtro por nível de dificuldade, além de uma seção de questões reais consumidas de uma API pública.

## Sobre

O projeto possui dados locais com 4 matérias (Matemática, Linguagens, Ciências Humanas e Ciências da Natureza) e 13 conteúdos cadastrados em `lib/data/dados_estudo.dart`.

As questões do ENEM são buscadas em tempo de execução através da API `api.enem.dev`:

    GET https://api.enem.dev/v1/exams/{ano}/questions?limit=10&offset=0

O serviço responsável está em `lib/services/enem_service.dart` e por padrão busca questões do ano de 2022.

## Funcionalidades

- Listagem de matérias na tela inicial com acesso para as questões do ENEM
- Detalhamento da matéria com filtro por nível (Todos, Básico, Intermediário, Avançado)
- Detalhamento do conteúdo selecionado
- Listagem de questões do ENEM com estado de carregamento e tratamento de erro
- Visualização da questão com enunciado, imagens, alternativas e conferência com o gabarito

## Estrutura

    lib/
    ├── main.dart
    ├── data/dados_estudo.dart
    ├── models/materia.dart
    ├── models/conteudo.dart
    ├── models/questao_enem.dart
    ├── services/enem_service.dart
    ├── screens/home_page.dart
    ├── screens/materia_page.dart
    ├── screens/conteudo_page.dart
    ├── screens/enem_page.dart
    ├── screens/questao_enem_page.dart
    ├── widgets/materia_card.dart
    └── widgets/conteudo_card.dart

Dependências principais: `http`, `cupertino_icons`. Dependência de desenvolvimento: `flutter_lints`. SDK Dart: `^3.12.2`.

## Como executar

    cd study_flow
    flutter pub get
    flutter run

Para validar o projeto:

    flutter analyze
    flutter test

