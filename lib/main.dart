import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(HargaCryptoApp());
}

class HargaCryptoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harga Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HargaCryptoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HargaCryptoHomePage extends StatefulWidget {
  @override
  _HargaCryptoHomePageState createState() => _HargaCryptoHomePageState();
}

class _HargaCryptoHomePageState extends State<HargaCryptoHomePage> {
  List<dynamic> cryptoData = [];

  @override
  void initState() {
    super.initState();
    fetchHargaCryptos();
  }

  Future<void> fetchHargaCryptos() async {
    final response =
        await http.get(Uri.parse('https://api.coinlore.net/api/tickers/'));

    if (response.statusCode == 200) {
      setState(() {
        cryptoData = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load crypto prices');
    }
  }

  String getCryptoIconUrl(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'BTC':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/1.png';
      case 'ETH':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png';
      case 'LTC':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/2.png';
      case 'XRP':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/52.png';
      case 'USDT':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/825.png'; // Tether
      case 'BNB':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/1839.png'; // Binance Coin
      case 'SOL':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/5426.png'; // Solana
      case 'USDC':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png'; // USD Coin
      case 'STETH':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/8085.png'; // Staked Ether
      case 'TON':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/11419.png'; // Toncoin
      case 'DOGE':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/74.png'; // Dogecoin
      case 'ADA':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/2010.png'; // Cardano
      case 'TRX':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/1958.png'; // TRON
      case 'AVAX':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/5805.png'; // Avalanche
      case 'WBTC':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/3717.png'; // Wrapped Bitcoin
      case 'SHIB':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/5994.png'; // Shiba Inu
      case 'DOT':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/6636.png'; // Polkadot
      case 'LINK':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/1975.png'; // Chainlink
      case 'BCH':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/1831.png'; // Bitcoin Cash
      case 'LEO':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/3957.png'; // Unus Sed Leo
      case 'NEAR':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/6535.png'; // NEAR Protocol
      case 'UNI':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/7083.png'; // Uniswap
      case 'KAS':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/1966.png'; // Kaspa
      case 'PEPE':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/10000.png'; // Pepe
      case 'FDUSD':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/10001.png'; // First Digital USD
      case 'ETC':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/1321.png'; // Ethereum Classic
      case 'WBETH':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/10002.png'; // Wrapped Beacon ETH
      case 'XMR':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/328.png'; // Monero
      case 'RNDR':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/10003.png'; // Render Token
      case 'XLM':
        return 'https://s2.coinmarketcap.com/static/img/coins/64x64/512.png'; // Stellar
      default:
        return 'https://via.placeholder.com/64'; // Placeholder image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Harga Crypto'),
      ),
      body: cryptoData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 4 : 2,
                  childAspectRatio: 2.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: cryptoData.length > 30 ? 30 : cryptoData.length,
                itemBuilder: (context, index) {
                  final crypto = cryptoData[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 99, 113, 136)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: Image.network(
                        getCryptoIconUrl(crypto['symbol']),
                        width: 40,
                        height: 40,
                      ),
                      title: Text(crypto['name']),
                      subtitle: Text('Price: \$${crypto['price_usd']}'),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
