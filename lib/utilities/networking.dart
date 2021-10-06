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

  // Return a JSON encoded string using the url we were initialised with
  Future getJsonData() async {
    Uri uri = Uri.parse(url);
    //print('Sending the GET');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String jsonBody = response.body;
      //print('Response = 200');
      var dyn = jsonDecode(jsonBody);
      //print('After Decode');
      return dyn;
    } else {
      // if (response.statusCode > 400) {
      //   print(response.body);
      //   var err = jsonDecode(response.body);
      //   return err;
      // }
      //String statusCode = response.statusCode.toString();
      print('StatusCode = ${response.statusCode}');
      var errorJson =
          '''[{"_ErrorCode": "HTTP Status ${response.statusCode}"}]''';
      var err = jsonDecode(errorJson);
      return err;
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
