import 'package:agendapet/db/database_helper.dart';
import 'package:flutter/material.dart';

class CadastroServicoPage extends StatefulWidget {
  const CadastroServicoPage({super.key});

  @override
  State<CadastroServicoPage> createState() => _CadastroServicoPageState();
}

class _CadastroServicoPageState extends State<CadastroServicoPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController precoController = TextEditingController();

  List<Map<String, dynamic>> servicos = [];

  @override
  void initState() {
    super.initState();
    _carregarServicos();
  }

  @override
  void dispose() {
    // Garantindo que os controladores sejam descartados corretamente quando a tela for destruída
    nomeController.dispose();
    precoController.dispose();
    super.dispose();
  }

  Future<void> _carregarServicos() async {
    final data = await DatabaseHelper.instance.getServicos();
    setState(() {
      servicos = data;
    });
  }

  Future<void> _adicionarServico() async {
    final nome = nomeController.text.trim();
    final preco = precoController.text.trim();

    if (nome.isNotEmpty && preco.isNotEmpty) {
      await DatabaseHelper.instance.insertServico(nome, preco);
      nomeController.clear();
      precoController.clear();
      _carregarServicos();
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFFB8C00);
    const Color textColor = Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar Serviço',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              style: const TextStyle(color: textColor),
              decoration: const InputDecoration(
                labelText: 'Nome do Serviço',
                labelStyle: TextStyle(color: textColor),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: precoController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: textColor),
              decoration: const InputDecoration(
                labelText: 'Preço (R\$)',
                labelStyle: TextStyle(color: textColor),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _adicionarServico,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Adicionar Serviço',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Serviços Cadastrados:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: servicos.length,
                itemBuilder: (context, index) {
                  final servico = servicos[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(
                      servico['nome'],
                      style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'R\$ ${servico['preco']}',
                      style: const TextStyle(color: textColor),
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
