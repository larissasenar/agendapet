import 'package:flutter/material.dart';
import 'package:agendapet/db/database_helper.dart';
import 'package:agendapet/models/agendamento.dart';
import 'package:agendapet/models/servico.dart';

class AdicionarAgendamento extends StatefulWidget {
  const AdicionarAgendamento({super.key});

  @override
  _AdicionarAgendamentoState createState() => _AdicionarAgendamentoState();
}

class _AdicionarAgendamentoState extends State<AdicionarAgendamento> {
  final dataController = TextEditingController();
  final observacoesController = TextEditingController();
  String? _selectedPet;
  String? _selectedServico;

  List<String> _pets = [];
  List<Servico> _servicos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadServicosEPets();
  }

  @override
  void dispose() {
    dataController.dispose();
    observacoesController.dispose();
    super.dispose();
  }

  Future<void> _loadServicosEPets() async {
    setState(() => _isLoading = true);

    final petsData = await DatabaseHelper.instance.getPets();
    final servicosData = await DatabaseHelper.instance.getServicos();

    setState(() {
      _pets = petsData.map((e) => e['nome'] as String).toList();
      _servicos = servicosData.map((e) => Servico.fromMap(e)).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Agendamento'),
        centerTitle: true,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedPet,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Pet',
                      ),
                      items:
                          _pets
                              .map(
                                (nomePet) => DropdownMenuItem(
                                  value: nomePet,
                                  child: Text(nomePet),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() => _selectedPet = value);
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedServico,
                      decoration: const InputDecoration(labelText: 'Serviço'),
                      items:
                          _servicos
                              .map(
                                (servico) => DropdownMenuItem(
                                  value: servico.nome,
                                  child: Text(servico.nome),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() => _selectedServico = value);
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: dataController,
                      decoration: const InputDecoration(labelText: 'Data'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: observacoesController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Observações (opcional)',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_selectedPet == null ||
                              _selectedServico == null ||
                              dataController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Por favor, preencha todos os campos.',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          final novo = Agendamento(
                            petNome: _selectedPet!,
                            servico: _selectedServico!,
                            data: dataController.text,
                            observacoes: observacoesController.text.trim(),
                          );

                          await DatabaseHelper.instance.insertAgendamento(novo);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Agendamento salvo com sucesso!'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          Navigator.pop(context);
                        },
                        child: const Text('Salvar'),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
