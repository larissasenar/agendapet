import 'package:agendapet/db/database_helper.dart';
import 'package:agendapet/widgets/botao_laranja.dart';
import 'package:flutter/material.dart';

class CadastroPet extends StatefulWidget {
  const CadastroPet({super.key});

  @override
  State<CadastroPet> createState() => _CadastroPetState();
}

class _CadastroPetState extends State<CadastroPet> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _especieController = TextEditingController();
  int? _petEditandoId;

  List<Map<String, dynamic>> _listaPets = [];

  @override
  void initState() {
    super.initState();
    _carregarPets();
  }

  Future<void> _carregarPets() async {
    final pets = await DatabaseHelper.instance.getPets();
    setState(() {
      _listaPets = pets;
    });
  }

  Future<void> _salvarOuAtualizarPet() async {
    final nome = _nomeController.text.trim();
    final especie = _especieController.text.trim();

    if (nome.isEmpty || especie.isEmpty) return;

    if (_petEditandoId == null) {
      await DatabaseHelper.instance.insertPet({
        'nome': nome,
        'especie': especie,
      });
    } else {
      await DatabaseHelper.instance.database.then((db) {
        db.update(
          'pets',
          {'nome': nome, 'especie': especie},
          where: 'id = ?',
          whereArgs: [_petEditandoId],
        );
      });
    }

    _nomeController.clear();
    _especieController.clear();
    _petEditandoId = null;
    await _carregarPets();
  }

  Future<void> _editarPet(Map<String, dynamic> pet) async {
    setState(() {
      _petEditandoId = pet['id'];
      _nomeController.text = pet['nome'];
      _especieController.text = pet['especie'];
    });
  }

  Future<void> _excluirPet(int id) async {
    await DatabaseHelper.instance.database.then((db) {
      db.delete('pets', where: 'id = ?', whereArgs: [id]);
    });
    await _carregarPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Pet')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Pet',
                hintText: 'Digite o nome do pet',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _especieController,
              decoration: const InputDecoration(
                labelText: 'Espécie',
                hintText: 'Digite a espécie do pet',
              ),
            ),
            const SizedBox(height: 16),
            BotaoLaranja(
              texto: _petEditandoId == null ? 'Cadastrar Pet' : 'Atualizar Pet',
              onPressed: _salvarOuAtualizarPet,
            ),
            const SizedBox(height: 24),
            const Text(
              'Pets Cadastrados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _listaPets.length,
                itemBuilder: (context, index) {
                  final pet = _listaPets[index];
                  return ListTile(
                    title: Text(pet['nome']),
                    subtitle: Text('Espécie: ${pet['especie']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editarPet(pet),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _excluirPet(pet['id']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
