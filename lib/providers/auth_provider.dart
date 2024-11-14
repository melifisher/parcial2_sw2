import 'package:flutter/foundation.dart';
import '../models/usuario.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Usuario? _user;
  final AuthService _authService = AuthService();

  Usuario? get user => _user;

// Al iniciar el proveedor, carga el user_id si está guardado
  AuthProvider() {
    _loadUserId();
  }
  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('user_id');
    if (userId != null) {
      // Aquí deberías cargar más detalles del usuario si tienes la función en AuthService
      _user = await _authService
          .getUserById(userId); // Suponiendo que tienes este método
      notifyListeners();
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      _user = await _authService.login(username, password);
      notifyListeners();
      return true;
    } catch (e) {
      print("Error en el provider login: $e");
      return false;
    }
  }

  Future<bool> register(String username, String password) async {
    try {
      _user = await _authService.register(username, password);
      notifyListeners();
      return true;
    } catch (e) {
      print("Error en el provider register: $e");
      return false;
    }
  }

  void logout() async {
    _user = null;
    notifyListeners();
  }
}
