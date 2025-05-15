import 'package:agendapet/db/database_helper.dart';
import 'package:agendapet/models/agendamento.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditarAgendamento extends StatefulWidget {
  final Agendamento agendamento;
  const EditarAgendamento({super.key, required this.agendamento});

  @override
  State<EditarAgendamento> createState() => _EditarAgendamentoState();
}

class _EditarAgendamentoState extends State<EditarAgendamento> {
  late TextEditingController dataController;
  late TextEditingController observacoesController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    try {
      selectedDate = DateFormat('yyyy-MM-dd').parse(widget.agendamento.data);
    } catch (e) {
      try {
        selectedDate = DateFormat('dd/MM/yyyy').parse(widget.agendamento.data);
      } catch (e) {
        selectedDate = DateTime.now();
        debugPrint('Erro ao converter data: ${widget.agendamento.data}');
      }
    }

    dataController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(selectedDate),
    );

    observacoesController = TextEditingController(
      text: widget.agendamento.observacoes,
    );
  }

  @override
  void dispose() {
    dataController.dispose();
    observacoesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
      locale: const Locale('pt', 'BR'),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dataController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Agendamento',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pet: ${widget.agendamento.petNome}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Serviço: ${widget.agendamento.servico}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: dataController,
              decoration: InputDecoration(
                labelText: 'Data',
                prefixIcon: Icon(Icons.calendar_today, color: primaryColor),
                border: const OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: _pickDate,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: observacoesController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Observações',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.notes, color: primaryColor),
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 40),

            // Botão salvar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  'Salvar Alterações',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final atualizado = Agendamento(
                    id: widget.agendamento.id,
                    petNome: widget.agendamento.petNome,
                    servico: widget.agendamento.servico,
                    data: DateFormat('yyyy-MM-dd').format(selectedDate),
                    observacoes: observacoesController.text.trim(),
                  );

                  await DatabaseHelper.instance.updateAgendamento(atualizado);
                  Navigator.pop(context, true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
