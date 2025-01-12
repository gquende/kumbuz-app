class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question": "Costuma a estabelecer limites para seus gastos mensais?",
    "options": [
      'Sim, sempre',
      'Às vezes',
      'Não',
    ],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "Como costuma a organizar as suas finanças?",
    "options": [
      'Uso planilha de controlo de gastos',
      'Tiro extrato bancário de vez em quando',
      'Nao acompanho meu orcamento'
    ],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "Como paga a suas contas",
    "options": [
      'Pago sempre em dia ou antecipado',
      'Algumas vezes atraso a pagar',
      'Sempre atraso'
    ],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question": "Como é o seu comportamento ao fazer compras",
    "options": [
      'Pesquiso os preços antes de comprar',
      'Costumo a parcelar minhas compras',
      'Faço compras por impulso',
    ],
    "answer_index": 2,
  },
  {
    "id": 5,
    "question": "Faz algum tipo de investimento no final do mês",
    "options": [
      'Sim, sempre',
      'Sim, quando sobra algum dinheiro',
      'Não, nunca tenho dinheiro a sobrar',
    ],
    "answer_index": 2,
  },
  {
    "id": 6,
    "question":
        "Por quanto tempo acredita que conseguiria manter seu padrão de vida actual se não tivesse nenhuma fonte de rendimento?",
    "options": [
      'Mais de um ano',
      '6 meses',
      'Não conseguiria manter o mesmo padrão de vida',
    ],
    "answer_index": 2,
  },
  {
    "id": 7,
    "question": "Costuma pedir dinheiro emprestado?",
    "options": [
      'Nunca peço',
      'Peço algumas vezes',
      'Peço com frequência',
    ],
    "answer_index": 2,
  },
];