import 'package:api_market_cap_coin/domain/entities/crypto_currency_entity.dart';

abstract class ICryptoRepository {
  Future<List<CryptoCurrencyEntity>> getCryptoCurrencies(String symbols);
}