import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OneFileAPI {

  Future<bool> login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse("https://login.onefile.co.uk/api/authentication"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      await Future.delayed(const Duration(seconds: 1));

      var result = jsonDecode(response.body);
      return result["result"] == 1;

    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Future<List<dynamic>> getJournalEntries() async {
    try {
      var entries = [];

      var cookie = await _getCookie();


      final response = await http.get(
        Uri.parse('https://learning.onefile.co.uk/api/journalEntry'),
        headers: {
          "Accept": "application/json",
        },
      );

      print(response.body.substring(0, 500));

      return entries;
    } catch (exception) {
      print('Exception during getJournalEntries: $exception');
      return [];
    }
  }

  Future<String> _getCookie() async {
    final prefs = await SharedPreferences.getInstance();
    var cookie = prefs.getString('OneFile-Cookie') ?? '';

    print(cookie);

    return cookie;
  }
}
