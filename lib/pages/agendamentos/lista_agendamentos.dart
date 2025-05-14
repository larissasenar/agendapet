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

  void _loadAgendamentos() async {
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
        backgroundColor: const Color(0xFFFB8C00),
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : agendamentos.isEmpty
              ? const Center(child: Text('Nenhum agendamento encontrado'))
              : ListView.builder(
                itemCount: agendamentos.length,
                itemBuilder: (context, index) {
                  final item = agendamentos[index];
                  return ListTile(
                    leading: const Icon(Icons.pets, color: Color(0xFFFB8C00)),
                    title: Text(item.petNome),
                    subtitle: Text('${item.servico} - ${item.data}'),
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
                  );
                },
              ),
    );
  }
}
