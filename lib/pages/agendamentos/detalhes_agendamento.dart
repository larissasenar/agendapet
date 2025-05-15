import 'package:agendapet/db/database_helper.dart';
import 'package:agendapet/models/agendamento.dart';
import 'package:flutter/material.dart';
import 'editar_agendamento.dart';

class DetalhesAgendamento extends StatelessWidget {
  final Agendamento agendamento;
  const DetalhesAgendamento({super.key, required this.agendamento});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final onSurfaceColor = theme.colorScheme.onSurface;
    final errorColor = theme.colorScheme.error;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes do Agendamento',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow(
              Icons.pets,
              'Pet: ${agendamento.petNome}',
              primaryColor,
              onSurfaceColor,
            ),
            const SizedBox(height: 10),
            _infoRow(
              Icons.miscellaneous_services,
              'Serviço: ${agendamento.servico}',
              primaryColor,
              onSurfaceColor,
            ),
            const SizedBox(height: 10),
            _infoRow(
              Icons.calendar_today,
              'Data: ${agendamento.data}',
              primaryColor,
              onSurfaceColor,
            ),
            const SizedBox(height: 20),

            // Observações (se houver)
            Row(
              children: [
                Icon(Icons.notes, color: primaryColor, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Observações:',
                  style: TextStyle(
                    fontSize: 20,
                    color: onSurfaceColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              agendamento.observacoes.trim().isNotEmpty == true
                  ? agendamento.observacoes
                  : 'Nenhuma',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    'Editar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    final resultado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => EditarAgendamento(agendamento: agendamento),
                      ),
                    );
                    if (resultado == true) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: errorColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text(
                    'Excluir',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Confirmar Exclusão'),
                            content: const Text(
                              'Deseja realmente excluir este agendamento?',
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () => Navigator.pop(context, false),
                              ),
                              TextButton(
                                child: Text(
                                  'Excluir',
                                  style: TextStyle(color: errorColor),
                                ),
                                onPressed: () => Navigator.pop(context, true),
                              ),
                            ],
                          ),
                    );

                    if (confirm == true) {
                      await DatabaseHelper.instance.deleteAgendamento(
                        agendamento.id!,
                      );
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String text,
    Color iconColor,
    Color textColor,
  ) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
