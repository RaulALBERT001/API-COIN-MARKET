import 'package:flutter/material.dart';
import 'package:api_market_cap_coin/domain/entities/crypto_currency_entity.dart';
import 'package:api_market_cap_coin/domain/repositories/i_crypto_repository.dart';
import 'package:api_market_cap_coin/core/library/constants.dart';

enum ViewState { idle, loading, success, error }

class CryptoViewModel extends ChangeNotifier {
  final ICryptoRepository _cryptoRepository;

  CryptoViewModel(this._cryptoRepository);

  List<CryptoCurrencyEntity> _cryptocurrencies = [];
  List<CryptoCurrencyEntity> get cryptocurrencies => _cryptocurrencies;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchCryptoCurrencies({String? symbols}) async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final symbolsToFetch = symbols == null || symbols.trim().isEmpty 
          ? AppConstants.defaultSymbols 
          : symbols.trim();
      
      print('CryptoViewModel: Fetching with symbols: "$symbolsToFetch"');
      _cryptocurrencies = await _cryptoRepository.getCryptoCurrencies(symbolsToFetch);
      _state = ViewState.success;
      print('CryptoViewModel: Successfully fetched ${_cryptocurrencies.length} currencies.');
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
      print('CryptoViewModel: Error fetching currencies: $_errorMessage');
    }
    notifyListeners();
  }
}