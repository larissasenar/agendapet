import 'package:agendapet/pages/agendamentos/adicionar_agendamento.dart';
import 'package:agendapet/pages/agendamentos/lista_agendamentos.dart';
import 'package:agendapet/pages/perfil/editar_perfil_page.dart';
import 'package:agendapet/pages/pet/cadastro_pet_page.dart';
import 'package:agendapet/pages/pet/selecionar_pet_page.dart';
import 'package:agendapet/pages/servicos/cadastro_servico_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String nomeUsuario;

  const HomePage({super.key, required this.nomeUsuario});

  static const Color primaryColor = Color(0xFFFB8C00);
  static const Color secondaryColor = Color(0xFFFFA726); // tom mais claro

  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AgendaPet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo, $nomeUsuario!',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Gerencie os serviços do seu pet com praticidade.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // Grid de opções com todos os cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                // _buildOptionCard(
                //   context,
                //   'Perfil',
                //   Icons.person,
                //   () => EditarPerfilPage(usuarioId: 1),
                // ),
                _buildOptionCard(
                  context,
                  'Novo Agendamento',
                  Icons.add_circle_outline,
                  () => AdicionarAgendamento(),
                ),
                _buildOptionCard(
                  context,
                  'Ver Agendamentos',
                  Icons.calendar_today,
                  () => ListaAgendamentos(),
                ),
                _buildOptionCard(
                  context,
                  'Meus Pets',
                  Icons.pets,
                  () => CadastroPet(),
                ),
                _buildOptionCard(
                  context,
                  'Serviço',
                  Icons.local_offer,
                  () => CadastroServicoPage(),
                ),
                _buildOptionCard(
                  context,
                  'Histórico',
                  Icons.history,
                  () => ListaAgendamentos(),
                ),
                _buildOptionCard(
                  context,
                  'Carteira de Vacinação',
                  Icons.vaccines,
                  () => const SelecionarPetPage(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.pets, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                Text(
                  'Olá, $nomeUsuario!',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.person, 'Perfil', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EditarPerfilPage(usuarioId: 1)),
            );
          }),
          _buildDrawerItem(Icons.pets, 'Meus Pets', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CadastroPet()),
            );
          }),
          const Divider(),
          _buildDrawerItem(Icons.vaccines, 'Carteira de Vacinação', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SelecionarPetPage()),
            );
          }),

          const Divider(),
          _buildDrawerItem(Icons.local_offer, 'Serviços', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CadastroServicoPage()),
            );
          }),
          const Divider(),
          _buildDrawerItem(Icons.add_circle_outline, 'Novo Agendamento', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdicionarAgendamento()),
            );
          }),
          _buildDrawerItem(Icons.calendar_today, 'Ver Agendamentos', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ListaAgendamentos()),
            );
          }),
          const Divider(),
          _buildDrawerItem(Icons.history, 'Histórico', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ListaAgendamentos()),
            );
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: primaryColor),
            title: const Text('Sair', style: TextStyle(color: primaryColor)),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  Widget _buildOptionCard(
    BuildContext context,
    String label,
    IconData icon,
    Widget Function() page,
  ) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page()),
          ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
