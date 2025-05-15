import 'package:agendapet/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:agendapet/theme/theme.dart';
import 'package:agendapet/pages/welcome_screen.dart';
import 'package:agendapet/pages/cadastro/cadastro_page.dart';
import 'package:agendapet/pages/login/login_page.dart';
import 'package:agendapet/auth_choice_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // APAGAR O BANCO DE DADOS ANTIGO (apenas na primeira execução)
  final dbPath = await getDatabasesPath();
  await deleteDatabase(join(dbPath, 'petagenda.db'));

  runApp(const PetAgendaApp());
}

class PetAgendaApp extends StatelessWidget {
  const PetAgendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetAgenda',
      theme: customTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/auth': (context) => AuthChoicePage(),
        '/login': (context) => LoginPage(),
        '/cadastro': (context) => CadastroPage(),
        '/home': (context) => HomePage(nomeUsuario: 'Nome do Usuário'),
      },
    );
  }
}
