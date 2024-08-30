import 'dart:convert';

import 'package:http/http.dart' as http;

class OneFileAPI {

  Future<bool> login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse("https://login.onefile.co.uk/api/authentication"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password})
      );
      
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



      return entries;
    } catch (exception) {
      return [];
    }
  }
}