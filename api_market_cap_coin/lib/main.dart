import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_market_cap_coin/core/service/http_service.dart';
import 'package:api_market_cap_coin/data/datasources/crypto_remote_data_source.dart';
import 'package:api_market_cap_coin/data/repositories/crypto_repository.dart';
import 'package:api_market_cap_coin/domain/repositories/i_crypto_repository.dart';
import 'package:api_market_cap_coin/ui/view_models/crypto_view_model.dart';
import 'package:api_market_cap_coin/ui/pages/crypto_list_page.dart';


void main() async {
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    final HttpService httpService = HttpService();
    final ICryptoRemoteDataSource remoteDataSource = CryptoRemoteDataSource(httpService);
    final ICryptoRepository cryptoRepository = CryptoRepository(remoteDataSource);

    return ChangeNotifierProvider(
      create: (context) => CryptoViewModel(cryptoRepository),
      child: MaterialApp(
        title: 'CoinMarketCap API Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepPurple[400],
            foregroundColor: Colors.white,
            elevation: 4,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)
            )
          )
        ),
        home: const CryptoListPage(),
      ),
    );
  }
}
