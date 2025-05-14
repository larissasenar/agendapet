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
  final petController = TextEditingController();
  final dataController = TextEditingController();
  String? _selectedServico; // Variável privada
  List<Servico> _servicos = [];

  @override
  void initState() {
    super.initState();
    _loadServicos(); // Carregar os serviços quando a tela for carregada
  }

  // Função para carregar os serviços do banco de dados
  Future<void> _loadServicos() async {
    final servicosData = await DatabaseHelper.instance.getServicos();
    setState(() {
      _servicos = servicosData.map((e) => Servico.fromMap(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar Agendamento',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFB8C00),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: petController,
              decoration: InputDecoration(
                labelText: 'Nome do Pet',
                labelStyle: TextStyle(color: Color(0xFFFB8C00)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFB8C00)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10),
            // Dropdown para selecionar o serviço
            _servicos.isEmpty
                ? CircularProgressIndicator() // Mostra um carregando enquanto os dados são carregados
                : DropdownButtonFormField<String>(
                  value: _selectedServico, // Usando a variável privada
                  decoration: InputDecoration(
                    labelText: 'Serviço',
                    labelStyle: TextStyle(color: Color(0xFFFB8C00)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFB8C00)),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedServico = newValue;
                    });
                  },
                  items:
                      _servicos.map((Servico servico) {
                        return DropdownMenuItem<String>(
                          value:
                              servico
                                  .nome, // Exibe o nome do serviço no dropdown
                          child: Text(servico.nome),
                        );
                      }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione um serviço';
                    }
                    return null;
                  },
                ),
            SizedBox(height: 10),
            TextField(
              controller: dataController,
              decoration: InputDecoration(
                labelText: 'Data',
                labelStyle: TextStyle(color: Color(0xFFFB8C00)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFB8C00)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (petController.text.isEmpty ||
                      _selectedServico == null ||
                      dataController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, preencha todos os campos.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final novo = Agendamento(
                    petNome: petController.text,
                    servico: _selectedServico!, // Usando a variável privada
                    data: dataController.text,
                  );
                  await DatabaseHelper.instance.insertAgendamento(novo);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Agendamento salvo com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pop(context);
                },
                label: Text(
                  'Salvar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFB8C00),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
