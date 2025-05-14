import 'package:flutter/material.dart';

class CadastroPet extends StatefulWidget {
  const CadastroPet({super.key});

  @override
  CadastroPetState createState() => CadastroPetState(); // Tornar a classe pública
}

class CadastroPetState extends State<CadastroPet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _especieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Pet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFB8C00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo para Nome do Pet
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome do Pet',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do pet';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo para Espécie do Pet
              TextFormField(
                controller: _especieController,
                decoration: InputDecoration(
                  labelText: 'Espécie',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a espécie do pet';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Botão Adicionar Pet
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final nomePet = _nomeController.text;
                    final especiePet = _especieController.text;

                    // Exibe um diálogo de confirmação
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text('Pet Adicionado'),
                            content: Text(
                              'Pet $nomePet de espécie $especiePet foi adicionado.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Limpar os campos após o fechamento do diálogo
                                  _nomeController.clear();
                                  _especieController.clear();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFB8C00),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Adicionar Pet'),
              ),
              SizedBox(height: 16),

              // Botão Cancelar
              OutlinedButton(
                onPressed: () {
                  // Limpar os campos e voltar para a tela anterior
                  _nomeController.clear();
                  _especieController.clear();
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFFFB8C00)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Color(0xFFFB8C00)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
