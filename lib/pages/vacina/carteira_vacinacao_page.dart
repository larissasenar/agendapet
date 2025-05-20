import 'package:flutter/material.dart';
import 'package:agendapet/db/database_helper.dart';
import 'package:agendapet/models/vacina.dart';

class CarteiraVacinacaoPage extends StatefulWidget {
  final int petId;

  const CarteiraVacinacaoPage({super.key, required this.petId});

  @override
  State<CarteiraVacinacaoPage> createState() => _CarteiraVacinacaoPageState();
}

class _CarteiraVacinacaoPageState extends State<CarteiraVacinacaoPage> {
  List<Vacina> _vacinas = [];

  @override
  void initState() {
    super.initState();
    _carregarVacinas();
  }

  Future<void> _carregarVacinas() async {
    final vacinas = await DatabaseHelper.instance.getVacinasPorPet(
      widget.petId,
    );
    setState(() {
      _vacinas = vacinas;
    });
  }

  Future<void> _adicionarVacina() async {
    final nomeController = TextEditingController();
    final dataController = TextEditingController();

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Nova Vacina'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome da vacina',
                  ),
                ),
                TextField(
                  controller: dataController,
                  decoration: const InputDecoration(
                    labelText: 'Data de aplicação',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  final novaVacina = Vacina(
                    petId: widget.petId,
                    nome: nomeController.text,
                    dataAplicacao: dataController.text,
                    aplicada: true,
                  );
                  await DatabaseHelper.instance.insertVacina(novaVacina);
                  Navigator.pop(context);
                  _carregarVacinas();
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
    );
  }

  Future<void> _editarVacina(Vacina vacina) async {
    final nomeController = TextEditingController(text: vacina.nome);
    final dataController = TextEditingController(text: vacina.dataAplicacao);

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Editar Vacina'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome da vacina',
                  ),
                ),
                TextField(
                  controller: dataController,
                  decoration: const InputDecoration(
                    labelText: 'Data de aplicação',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  final vacinaAtualizada = Vacina(
                    id: vacina.id,
                    petId: vacina.petId,
                    nome: nomeController.text,
                    dataAplicacao: dataController.text,
                    aplicada: vacina.aplicada,
                  );
                  await DatabaseHelper.instance.updateVacina(vacinaAtualizada);
                  Navigator.pop(context);
                  _carregarVacinas();
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carteira de Vacinação')),
      body:
          _vacinas.isEmpty
              ? const Center(child: Text('Nenhuma vacina registrada.'))
              : ListView.builder(
                itemCount: _vacinas.length,
                itemBuilder: (context, index) {
                  final vacina = _vacinas[index];
                  return ListTile(
                    leading: const Icon(Icons.medical_services),
                    title: Text(vacina.nome),
                    subtitle: Text('Data: ${vacina.dataAplicacao}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editarVacina(vacina),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await DatabaseHelper.instance.deleteVacina(
                              vacina.id!,
                            );
                            _carregarVacinas();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarVacina,
        child: const Icon(Icons.add),
      ),
    );
  }
}
