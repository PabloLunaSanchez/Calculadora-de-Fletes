import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistant {
  static Future<dynamic> getRequest(Uri url) async {
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);
        return decodeData;
      } else {
        return "Failed";
      }
    } catch (exp) {
      return "Failed";
    }
  }
}
