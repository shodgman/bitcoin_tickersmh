import '../utilities/networking.dart';

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '5F6AED68-1ED3-4F85-8D04-C46B32EBE12F';

class CoinData {
  // getCoinData() method
  //
  // requires crypto currency and actual currency codes
  // Returns a Future dynamic that is JSON coded or a return error number
  ///////////////////////////////////
  Future getCoinData({String crypto = 'BTC', String currency = 'USD'}) async {
    // Construct the url string as per the API REST interface
    String myExtended = '$coinAPIURL/$crypto/$currency?apikey=$apiKey';
    //print(myExtended);
    // Create our network helper class and init with this url
    NetworkHelper httpHelper = NetworkHelper(myExtended);
    // Do the Get based on the url. NB: Returns a dynamic variable, encoded JSON
    var response = await httpHelper.getJsonData();
    //print('Returned response');
    // TODO Ignore errors for now
    return response;
  }
}
