class Agendamento {
  final int? id;
  final String petNome;
  final String servico;
  final String data; // formato: yyyy-MM-dd
  final String observacoes;

  Agendamento({
    this.id,
    required this.petNome,
    required this.servico,
    required this.data,
    required this.observacoes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petNome': petNome,
      'servico': servico,
      'data': data,
      'observacoes': observacoes,
    };
  }

  factory Agendamento.fromMap(Map<String, dynamic> map) {
    return Agendamento(
      id: map['id'],
      petNome: map['petNome'],
      servico: map['servico'],
      data: map['data'],
      observacoes: map['observacoes'] ?? '',
    );
  }
}
