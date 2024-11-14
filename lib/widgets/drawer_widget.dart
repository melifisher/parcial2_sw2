import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/profile',
              );
            },
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user?.fotopath ?? ''),
                    child: null,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    user?.user ?? 'Guest',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/',
              );
            },
          ),
          ListTile(
              leading: const Icon(Icons.edit_document),
              title: const Text('Generador PDF'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/pdfgenerator',
                );
              }),
          ListTile(
            leading: const Icon(Icons.receipt),
            title: const Text('Lista de Resultados'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/resultados',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              authProvider.logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
