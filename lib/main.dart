import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'config/environment/environment.dart';
import 'screens/auth/login_page.dart';
import 'screens/auth/register_page.dart';
import 'screens/home_screen.dart';
import 'screens/pdf/pdf_generator_page.dart';
import 'screens/pdf/pdf_list_page.dart';
import 'screens/recommendations_screen.dart';
import 'screens/resultado/resultado_detail_screen.dart';
import 'screens/resultado/resultado_edit_screen.dart';
import 'screens/resultado/resultados_list_screen.dart';
import 'models/resultado.dart';

void main() async {
  await Environment.initEnvironment();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generador de PDF',
      debugShowCheckedModeBanner: false,
      //theme: AppTheme().getTheme(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginView());
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterView());
          case '/pdfgenerator':
            return MaterialPageRoute(
                builder: (context) => const PDFGeneratorPage());
          case '/pdfs':
            return MaterialPageRoute(builder: (context) => PDFListPage());
          case '/ia':
            final resultado = settings.arguments as Resultado;
            return MaterialPageRoute(
                builder: (context) =>
                    RecommendationsScreen(resultado: resultado));
          case '/resultados':
            return MaterialPageRoute(
                builder: (context) => const ResultadoListScreen());
          case '/resultado':
            final resultado = settings.arguments as Resultado;
            return MaterialPageRoute(
                builder: (context) =>
                    ResultadoDetailScreen(resultado: resultado));
          case '/resultado/edit':
            return MaterialPageRoute(
                builder: (context) => const ResultadoEditScreen());
          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ),
            );
        }
      },
    );
  }
}
