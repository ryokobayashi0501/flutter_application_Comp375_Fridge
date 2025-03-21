import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAuth{
  static const String baseUrl = "https://localhost:7138/api/Auth";

  static Future<Map<String, dynamic>?> signup(String username, String email, String password) async{
    final url = Uri.parse("$baseUrl/signup");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password
      }),
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return {"error": jsonDecode(response.body)["message"]};
    }
  }

  static Future<String?> signin(String email, String password) async{
    final url = Uri.parse("$baseUrl/signin");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      String token = data["token"];
      await _saveToken(token);
      return token;
    }else{
      return null;
    }
  } 
  /// **5. JWT トークンの保存**
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);
  }

  /// **6. JWT トークンの取得**
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  /// **7. 認証付きリクエスト**
  static Future<Map<String, dynamic>?> fetchProtectedData() async {
    final token = await getToken();
    if (token == null) return {"error": "User not authenticated"};

    final url = Uri.parse("http://localhost:5000/api/protected");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {"error": "Access denied"};
    }
  }
}