// Mudança de _Servico para Servico
class Servico {
  final int id;
  final String nome;
  final String preco;

  Servico({required this.id, required this.nome, required this.preco});

  // Método para converter o objeto em um mapa para inserção no banco de dados
  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'preco': preco};
  }

  // Método para converter um mapa para um objeto Servico
  factory Servico.fromMap(Map<String, dynamic> map) {
    return Servico(id: map['id'], nome: map['nome'], preco: map['preco']);
  }
}
