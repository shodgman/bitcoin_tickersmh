import 'package:http/http.dart' as http;
import 'dart:convert';

////////////////////////////////////////////////
// A Network helper Class
//
//  Provides services for http stuff
//
//////////////////////////////////////////////

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Network returned ${response.statusCode}');
    }
  }

  // void Mymain(List<String> arguments) async {
  //   // This example uses the Google Books API to search for books about http.
  //   // https://developers.google.com/books/docs/overview
  //   var url =
  //       Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
  //
  //   // Await the http get response, then decode the json-formatted response.
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse =
  //         convert.jsonDecode(response.body) as Map<String, dynamic>;
  //     var itemCount = jsonResponse['totalItems'];
  //     print('Number of books about http: $itemCount.');
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //     throw Exception('API Request Failed');
  //   }
  // }
}
