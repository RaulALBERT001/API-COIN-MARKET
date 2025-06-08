import 'package:api_market_cap_coin/core/service/http_service.dart';
import 'package:api_market_cap_coin/domain/entities/crypto_currency_entity.dart';

abstract class ICryptoRemoteDataSource {
  Future<List<CryptoCurrencyEntity>> getCryptoCurrencies(String symbols);
}

class CryptoRemoteDataSource implements ICryptoRemoteDataSource {
  final HttpService _httpService;

  CryptoRemoteDataSource(this._httpService);

  @override
  Future<List<CryptoCurrencyEntity>> getCryptoCurrencies(String symbols) async {
    print('Fetching crypto currencies for symbols: $symbols');
    try {
      final response = await _httpService.request(
        endpoint: '/v2/cryptocurrency/quotes/latest?symbol=$symbols&convert=BRL',
      );

      print('Raw API Response: $response');

      if (response != null && response['data'] != null) {
        final Map<String, dynamic> data = response['data'];
        final List<CryptoCurrencyEntity> currencies = [];
        data.forEach((key, value) {
          if (value is List) { 
            for (var item in value) {
              if (item is Map<String, dynamic>) {
                 try {
                    currencies.add(CryptoCurrencyEntity.fromJson(item));
                 } catch (e) {
                    print('Error parsing item for key $key: $item. Error: $e');
                 }
              }
            }
          } else if (value is Map<String, dynamic>) {
             try {
                currencies.add(CryptoCurrencyEntity.fromJson(value));
             } catch (e) {
                print('Error parsing value for key $key: $value. Error: $e');
             }
          }
        });
        print('Parsed ${currencies.length} currencies.');
        return currencies;
      } else {
        print('No data found in response or response is null.');
        return [];
      }
    } catch (e) {
      print('Error in CryptoRemoteDataSource.getCryptoCurrencies: $e');
      throw Exception('Failed to fetch crypto currencies: $e');
    }
  }
}