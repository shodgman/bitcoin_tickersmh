//TODO: Add your imports here.
import '../utilities/networking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinHostSite = 'rest.coinapi.io';
const coinExtended = '/v1/exchangerate';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '5F6AED68-1ED3-4F85-8D04-C46B32EBE12F';

class CoinData {
  //TODO: Create your getCoinData() method here.
  // getCoinData() method
  //
  // requires crypto currency and actual currency codes
  // Returns a Future dynamic that is JSON coded or a return error number
  ///////////////////////////////////
  Future getCoinData() async {
    // These will be parameters
    String crypto = 'BTC';
    String currency = 'USD';

    // Construct the url string
    String myExtended =
        'https://$coinHostSite$coinExtended/$crypto/$currency?apikey=$apiKey';
    print(myExtended);
    myExtended =
        'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=5F6AED68-1ED3-4F85-8D04-C46B32EBE12F';
    // Query and response
    // Await the http get response, then decode the json-formatted response.
    //http.Response response = await http.get(Uri.parse(myExtended));
    NetworkHelper httpHelper = NetworkHelper(myExtended);
    var response = await httpHelper.getData();
    // decode response: extract
    if (response.statusCode == 200) {
      print('Response = 200');
      String data = response.body;

      //print('JSON Version');
      //print(jsonDecode(data));
      //print(jsonDecode(data));
      return data;

      return jsonDecode(data) ?? '{}';
    } else {
      // error
      print('Error response ${response.statusCode}');
    }
    // return response
  }
}
//  Documentation of the coinAPI syntax
// curl https://rest.coinapi.io/v1/exchangerate/BTC/USD \
// --request GET
// --header "X-CoinAPI-Key: 73034021-THIS-IS-SAMPLE-KEY"
// The above command returns JSON structured like this:
//
// {
// "time": "2017-08-09T14:31:18.3150000Z",
// "asset_id_base": "BTC",
// "asset_id_quote": "USD",
// "rate": 3260.3514321215056208129867667
// }
