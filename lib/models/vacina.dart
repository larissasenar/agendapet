class Vacina {
  int? id;
  int petId; // ID do pet relacionado
  String nome;
  String dataAplicacao;
  bool aplicada;

  Vacina({
    this.id,
    required this.petId,
    required this.nome,
    required this.dataAplicacao,
    required this.aplicada,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'nome': nome,
      'dataAplicacao': dataAplicacao,
      'aplicada': aplicada ? 1 : 0,
    };
  }

  factory Vacina.fromMap(Map<String, dynamic> map) {
    return Vacina(
      id: map['id'],
      petId: map['petId'],
      nome: map['nome'],
      dataAplicacao: map['dataAplicacao'],
      aplicada: map['aplicada'] == 1,
    );
  }
}
