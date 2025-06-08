import 'package:api_market_cap_coin/data/datasources/crypto_remote_data_source.dart';
import 'package:api_market_cap_coin/domain/entities/crypto_currency_entity.dart';
import 'package:api_market_cap_coin/domain/repositories/i_crypto_repository.dart';

class CryptoRepository implements ICryptoRepository {
  final ICryptoRemoteDataSource _remoteDataSource;

  CryptoRepository(this._remoteDataSource);

  @override
  Future<List<CryptoCurrencyEntity>> getCryptoCurrencies(String symbols) async {
    print('CryptoRepository: getting crypto currencies for symbols: $symbols');
    try {
      final result = await _remoteDataSource.getCryptoCurrencies(symbols);
      print('CryptoRepository: received ${result.length} currencies from data source.');
      return result;
    } catch (e) {
      print('CryptoRepository: Error fetching crypto currencies: $e');
     
      rethrow;
    }
  }
}