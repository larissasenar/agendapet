import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/agendamento.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('petagenda.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        senha TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE agendamentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        petNome TEXT NOT NULL,
        servico TEXT NOT NULL,
        data TEXT NOT NULL,
        observacoes TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE servicos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        preco TEXT NOT NULL
      )
    ''');

    // ✅ TABELA DE PETS
    await db.execute('''
      CREATE TABLE pets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        especie TEXT NOT NULL
      )
    ''');
  }

  // ------------------------ MÉTODOS DE USUÁRIO ------------------------
  Future<bool> emailJaCadastrado(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  Future<bool> autenticarUsuario(String email, String senha) async {
    final db = await instance.database;
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return result.isNotEmpty;
  }

  Future<int> insertUsuario(String nome, String email, String senha) async {
    final db = await instance.database;
    return await db.insert('usuarios', {
      'nome': nome,
      'email': email,
      'senha': senha,
    });
  }

  Future<Map<String, dynamic>?> getUsuarioPorEmailSenha(
    String email,
    String senha,
  ) async {
    final db = await instance.database;
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ---------------------- MÉTODOS DE AGENDAMENTO ----------------------
  Future<int> insertAgendamento(Agendamento agendamento) async {
    final db = await instance.database;
    return await db.insert('agendamentos', agendamento.toMap());
  }

  Future<List<Agendamento>> getAgendamentos() async {
    final db = await instance.database;
    final result = await db.query('agendamentos');
    return result.map((map) => Agendamento.fromMap(map)).toList();
  }

  Future<int> updateAgendamento(Agendamento agendamento) async {
    final db = await instance.database;
    return await db.update(
      'agendamentos',
      agendamento.toMap(),
      where: 'id = ?',
      whereArgs: [agendamento.id],
    );
  }

  Future<int> deleteAgendamento(int id) async {
    final db = await instance.database;
    return await db.delete('agendamentos', where: 'id = ?', whereArgs: [id]);
  }

  // ------------------------- MÉTODOS DE PETS --------------------------
  Future<int> insertPet(Map<String, dynamic> pet) async {
    final db = await instance.database;
    return await db.insert('pets', pet);
  }

  Future<List<Map<String, dynamic>>> getPets() async {
    final db = await instance.database;
    return await db.query('pets');
  }

  // ------------------------ MÉTODOS DE SERVIÇOS -----------------------
  Future<int> insertServico(String nome, String preco) async {
    final db = await instance.database;
    return await db.insert('servicos', {'nome': nome, 'preco': preco});
  }

  Future<List<Map<String, dynamic>>> getServicos() async {
    final db = await instance.database;
    return await db.query('servicos');
  }
}
