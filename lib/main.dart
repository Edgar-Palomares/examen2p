
import 'package:flutter/material.dart';

// Clase Usuario
class Usuario {
  final String nombre;
  final String login;
  final String password;
  final String email;

  Usuario({
    required this.nombre,
    required this.login,
    required this.password,
    required this.email,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Segunda Parcial 5°A',
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int intentos = 0;

  List<Usuario> _usuarios = [
    Usuario(nombre: 'José Natan', login: 'pepe', password: '1234', email: 'pepe@mail.com'),
    Usuario(nombre: 'Ana Juarez', login: 'ana', password: '5678', email: 'ana@mail.com'),
  ];

  void _iniciarSesion() {
    String login = _loginController.text;
    String password = _passwordController.text;

    setState(() {
      intentos++;
    });

    if (login.isEmpty || password.isEmpty) {
      _mostrarMensaje('Los campos no deben estar vacíos');
      return;
    }

    Usuario? usuarioEncontrado;
    for (Usuario usuario in _usuarios) {
      if (usuario.login == login && usuario.password == password) {
        usuarioEncontrado = usuario;
        break;
      }
    }

    if (usuarioEncontrado != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetalleUsuarioScreen(usuario: usuarioEncontrado!),
        ),
      );
    } else {
      _mostrarMensaje('Login o password incorrectos');
    }
  }

  void _mostrarMensaje(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: InputDecoration(labelText: 'Login'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _iniciarSesion,
              child: Text('Entrar'),
            ),
            SizedBox(height: 16),
            Text('Intentos: $intentos'),
          ],
        ),
      ),
    );
  }
}

class DetalleUsuarioScreen extends StatelessWidget {
  final Usuario usuario;

  DetalleUsuarioScreen({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login del usuario: ${usuario.login}'),
            Text('Nombre: ${usuario.nombre}'),
            Text('Email: ${usuario.email}'),
            SizedBox(height: 20),
            Text('Encontrado!!!'),
          ],
        ),
      ),
    );
  }
}
