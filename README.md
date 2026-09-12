# Mini Projeto Todos

Aplicativo mobile em Flutter para gerenciamento de tarefas (to-dos), desenvolvido como projeto avaliativo do Módulo 02 do curso de Mobile Flutter.

## Problema que resolve

Simula um app real de produtividade: o usuário faz login, visualiza suas tarefas puxadas de uma API pública, filtra por status ou por texto, e marca tarefas como concluídas — com os dados persistidos localmente para uso offline.

## Tecnologias e técnicas utilizadas

- **Flutter/Dart** — framework e linguagem principais
- **Arquitetura MVVM** — separação em camadas Model, View e ViewModel
- **Padrão Result** — tratamento de sucesso/erro sem depender de exceptions soltas
- **http** — consumo da API [dummyjson.com](https://dummyjson.com) (`/auth/login` e `/todos`)
- **sqflite** — persistência local das tarefas (SQLite)
- **shared_preferences** — persistência da sessão do usuário logado
- **ChangeNotifier + ListenableBuilder** — gerência de estado reativa entre ViewModel e View

## Estrutura do projeto
lib/
├── data/
│ ├── datasources/ # Consumo de API e SQLite
│ ├── repositories/ # Regras de negócio + padrão Result
│ └── models/ # Entidades: TodoModel, UserModel
├── view/ # Telas: Splash, Login, Home
└── viewModel/ # Lógica de estado das telas


## Como executar

1. Clone o repositório
2. Rode `flutter pub get` para instalar as dependências
3. Conecte um dispositivo/emulador Android
4. Rode `flutter run`

**Login de teste** (API dummyjson):
- Usuário: `emilys`
- Senha: `emilyspass`

## Funcionalidades

- [x] Splash screen com verificação de sessão
- [x] Login com validação de campos e mostrar/ocultar senha
- [x] Tratamento de erro de login (snackbar)
- [x] Listagem de tarefas com persistência em SQLite
- [x] Filtro por status (todas/completadas/pendentes) e por texto
- [x] Marcar/desmarcar tarefa como concluída
- [x] Logout

## Possíveis melhorias futuras

- Adicionar testes automatizados
- Adicionar tela de detalhes da tarefa e ícones
- Tratar paginação da lista de tarefas
