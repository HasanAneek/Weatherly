import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final Uri url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('Failed to load weather data');
      print('Status Code: ${response.statusCode}');
      return null;
    }
  }
}
