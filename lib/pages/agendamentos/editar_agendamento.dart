import 'package:agendapet/db/database_helper.dart';
import 'package:agendapet/models/agendamento.dart';
import 'package:flutter/material.dart';

class EditarAgendamento extends StatefulWidget {
  final Agendamento agendamento;
  const EditarAgendamento({super.key, required this.agendamento});

  @override
  State<EditarAgendamento> createState() => _EditarAgendamentoState();
}

class _EditarAgendamentoState extends State<EditarAgendamento> {
  late TextEditingController petController;
  late TextEditingController servicoController;
  late TextEditingController dataController;

  @override
  void initState() {
    super.initState();
    petController = TextEditingController(text: widget.agendamento.petNome);
    servicoController = TextEditingController(text: widget.agendamento.servico);
    dataController = TextEditingController(text: widget.agendamento.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Agendamento',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFB8C00),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome do Pet
            TextField(
              controller: petController,
              decoration: InputDecoration(
                labelText: 'Nome do Pet',
                prefixIcon: const Icon(Icons.pets, color: Color(0xFFFB8C00)),
                border: const OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16),

            // Serviço
            TextField(
              controller: servicoController,
              decoration: InputDecoration(
                labelText: 'Serviço',
                prefixIcon: const Icon(
                  Icons.miscellaneous_services,
                  color: Color(0xFFFB8C00),
                ),
                border: const OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16),

            // Data
            TextField(
              controller: dataController,
              decoration: InputDecoration(
                labelText: 'Data',
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFFFB8C00),
                ),
                border: const OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 30),

            // Botão Salvar
            ElevatedButton.icon(
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'Salvar Alterações',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFB8C00),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                final atualizado = Agendamento(
                  id: widget.agendamento.id,
                  petNome: petController.text,
                  servico: servicoController.text,
                  data: dataController.text,
                );

                await DatabaseHelper.instance.updateAgendamento(atualizado);
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
