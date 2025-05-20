class Usuario {
  int? id;
  String nome;
  String email;
  String senha;

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });

  // Converte um objeto Usuario em um Map para salvar no banco
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'nome': nome, 'email': email, 'senha': senha};

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  // Converte um Map em um objeto Usuario
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );
  }
}
