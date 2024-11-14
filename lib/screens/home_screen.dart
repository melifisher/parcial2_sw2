import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laboratorios'),
        actions: authProvider.user == null
            ? [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Register'),
                ),
              ]
            : null,
      ),
      drawer: authProvider.user != null ? const DrawerWidget() : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/examenes_laboratorio.jpg',
              width: 150,
            ),
            const SizedBox(height: 20),
            const Text(
                '¡Bienvenido a la aplicación de exámenes de laboratorio!'),
          ],
        ),
      ),
    );
  }
}
