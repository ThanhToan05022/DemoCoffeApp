import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('Token', token);
}

Future<String?> getToken() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('Token');
}
