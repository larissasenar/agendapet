//Declaração das Propriedades(Variáveis dentro da Classe)
class Agendamento {
  final int? id;
  final String petNome;
  final String servico;
  final String data;

  //Construtor que está atribuindo os valores passados como argumentos do construtor às propriedades da classe.
  Agendamento({
    this.id,
    required this.petNome,
    required this.servico,
    required this.data,
  });

  //Este método retorna um Map com as propriedades da classe
  Map<String, dynamic> toMap() {
    return {'id': id, 'petNome': petNome, 'servico': servico, 'data': data};
  }

  //Este método recebe um Map e retorna um Agendamento.
  factory Agendamento.fromMap(Map<String, dynamic> map) {
    return Agendamento(
      id: map['id'],
      petNome: map['petNome'],
      servico: map['servico'],
      data: map['data'],
    );
  }
}
