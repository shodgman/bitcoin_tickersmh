import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class CryptoRateCard {
  // not used?
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedRate = '?';
  String bitcoinMessage = '1 BTC = ? USD';
  var cryptoRateMessage = Map<String, String>();

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value ?? 'AUD';
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        //print(selectedIndex);
        selectedCurrency = currenciesList[selectedIndex];
        getData();
      },
      children: pickerItems,
    );
  }

  // Does the retrieval of all current rates and does a setstate update
  // General try catch around everything
  // This is called when started and a currency is selected
  void getData() async {
    try {
      // Get Coin Data and update variables
      CoinData myCoinData = CoinData();
      double rate = 0.0;
      var myQuote;
      String myError = '';

      // Iterate the list of crypto currencies and update the rate for each
      for (String thisCrypto in cryptoList) {
        // Receive the JSON data.
        //print('Asking for $thisCrypto');
        myQuote = await myCoinData.getCoinData(
            crypto: thisCrypto, currency: selectedCurrency);

        if (myQuote['error'] != '') {
          // Error from coinAPI
          myError = myQuote['error'];
        } else if (myQuote['_ErrorCode'] != '') {
          // Error from http
          myError = myQuote['_ErrorCode'];
        } else {
          // All OK so get rate
          print('All OK');
          rate = myQuote['rate'];
        }

        setState(() {
          if (myError != '') {
            cryptoRateMessage[thisCrypto] = myError.substring(0, 20); // will not overflow GUI
          } else {
            cryptoRateMessage[thisCrypto] =
                '1 $thisCrypto = ${rate.toInt().toString()} $selectedCurrency';
            print(cryptoRateMessage[thisCrypto]);
          }
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Generate currency conversion buttons
  List<Widget> generateRateTabs() {
    List<Widget> children = [];

    for (String crypto in cryptoList) {
      // For each Crypto Currency Assign a variable
      children.add(Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            cryptoRateMessage[crypto]!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ));
    }
    return children;
  } //End of currency conversion buttons

  void populateRateMessageMap() {
    for (String crypto in cryptoList) {
      // Add this currency
      cryptoRateMessage[crypto] = '1 $crypto = ? $selectedCurrency';
    }
  }

  @override
  void initState() {
    super.initState();
    // dynamically generate cryptoRateMessage map
    populateRateMessageMap(); // done once
    // Get initial data
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: generateRateTabs(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Column(
              children: [
                Text(
                  'Select a currency:',
                  style: TextStyle(fontSize: 24, color: Colors.black45),
                ),
                SizedBox(
                  height: 20,
                ),
                Platform.isIOS ? iOSPicker() : androidDropdown(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
