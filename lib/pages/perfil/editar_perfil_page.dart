import 'package:agendapet/widgets/botao_laranja.dart';
import 'package:flutter/material.dart';
import 'package:agendapet/db/database_helper.dart';
import 'package:agendapet/models/usuario.dart';

class EditarPerfilPage extends StatefulWidget {
  final int usuarioId;

  const EditarPerfilPage({super.key, required this.usuarioId});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  Usuario? _usuario;

  @override
  void initState() {
    super.initState();
    _carregarUsuario();
  }

  Future<void> _carregarUsuario() async {
    try {
      final usuario = await DatabaseHelper.instance.getUsuarioPorId(
        widget.usuarioId,
      );
      setState(() {
        _usuario = usuario;
        _nomeController.text = usuario.nome;
        _senhaController.text = usuario.senha;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar usuário')));
    }
  }

  Future<void> _salvar() async {
    if (_usuario == null) return;

    _usuario!.nome = _nomeController.text;
    _usuario!.senha = _senhaController.text;

    await DatabaseHelper.instance.atualizarUsuario(_usuario!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil atualizado com sucesso')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_usuario == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            BotaoLaranja(texto: 'Salvar Alterações', onPressed: _salvar),
          ],
        ),
      ),
    );
  }
}
