import 'package:agendapet/db/database_helper.dart';
import 'package:agendapet/models/agendamento.dart';
import 'package:flutter/material.dart';
import 'detalhes_agendamento.dart';

class ListaAgendamentos extends StatefulWidget {
  const ListaAgendamentos({super.key});

  @override
  State<ListaAgendamentos> createState() => _ListaAgendamentosState();
}

class _ListaAgendamentosState extends State<ListaAgendamentos> {
  List<Agendamento> agendamentos = [];
  bool isLoading = true;

  Future<void> _loadAgendamentos() async {
    final data = await DatabaseHelper.instance.getAgendamentos();
    setState(() {
      agendamentos = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAgendamentos();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agendamentos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : agendamentos.isEmpty
              ? const Center(
                child: Text(
                  'Nenhum agendamento encontrado',
                  style: TextStyle(fontSize: 18),
                ),
              )
              : RefreshIndicator(
                onRefresh: _loadAgendamentos,
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: agendamentos.length,
                  itemBuilder: (context, index) {
                    final item = agendamentos[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        leading: Icon(
                          Icons.pets,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                        title: Text(
                          item.petNome,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        subtitle: Text(
                          '${item.servico} - ${item.data}',
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () async {
                          final resultado = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => DetalhesAgendamento(agendamento: item),
                            ),
                          );
                          if (resultado == true) {
                            _loadAgendamentos();
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
