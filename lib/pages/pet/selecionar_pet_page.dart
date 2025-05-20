import 'package:flutter/material.dart';
import 'package:agendapet/db/database_helper.dart';
import 'package:agendapet/pages/vacina/carteira_vacinacao_page.dart';

class SelecionarPetPage extends StatefulWidget {
  const SelecionarPetPage({super.key});

  @override
  State<SelecionarPetPage> createState() => _SelecionarPetPageState();
}

class _SelecionarPetPageState extends State<SelecionarPetPage> {
  List<Map<String, dynamic>> _pets = [];

  @override
  void initState() {
    super.initState();
    _carregarPets();
  }

  Future<void> _carregarPets() async {
    final pets = await DatabaseHelper.instance.getPets();
    setState(() {
      _pets = pets;
    });
  }

  void _selecionarPet(int petId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CarteiraVacinacaoPage(petId: petId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecionar Pet')),
      body:
          _pets.isEmpty
              ? const Center(child: Text('Nenhum pet cadastrado.'))
              : ListView.builder(
                itemCount: _pets.length,
                itemBuilder: (context, index) {
                  final pet = _pets[index];
                  return ListTile(
                    leading: const Icon(Icons.pets),
                    title: Text(pet['nome']),
                    subtitle: Text('Raça: ${pet['raca']}'),
                    onTap: () => _selecionarPet(pet['id']),
                  );
                },
              ),
    );
  }
}
