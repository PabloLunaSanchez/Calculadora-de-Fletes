import 'package:proyectotrailer/services/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioManager {
  static const String _nombreKey = 'nombre';
  static const String _correoKey = 'correo';

  static Future<void> guardarUsuario(Usuario usuario) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_nombreKey, usuario.nombre);
    prefs.setString(_correoKey, usuario.correo);
  }

  static Future<Usuario?> obtenerUsuario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? nombre = prefs.getString(_nombreKey);
    final String? correo = prefs.getString(_correoKey);

    if (nombre != null && correo != null) {
      return Usuario(nombre, correo);
    } else {
      return null;
    }
  }
}
