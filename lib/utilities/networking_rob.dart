//RobM
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final Uri url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response httpResponse = await http.get(url);

    if (httpResponse.statusCode == 200) {
      // all good, JSON data found in the body
      String jsonData = httpResponse.body;
      return jsonDecode(jsonData);
    } else {
      String statusCode = httpResponse.statusCode.toString();
      return '{"statusCode": "$statusCode"}';
    }
  }
}
