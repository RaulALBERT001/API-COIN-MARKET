import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_market_cap_coin/configs/api_config.dart';

enum HttpMethod { get, post, put, delete }

class HttpService {
  Future<dynamic> request({
    required String endpoint,
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? body,
    Map<String, String>? customHeaders,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': ApiConfig.apiKey,
      ...?customHeaders, //permite adicionar headers ou sobreescreve-los :)
    };

    http.Response response;

    // Adiciona um delay de 2 segundos para simular o carregamento(para aparecer o loading)
    await Future.delayed(const Duration(seconds: 2));

    print('Request URL: $url');
    print('Request Method: $method');
    print('Request Headers: $headers');
    if (body != null) {
      print('Request Body: ${jsonEncode(body)}');
    }

    try {
      switch (method) {
        case HttpMethod.post:
          await Future.delayed(const Duration(seconds: 2));
          response = await http.post(url, headers: headers, body: jsonEncode(body));
          break;
        case HttpMethod.put:
         await Future.delayed(const Duration(seconds: 2));
          response = await http.put(url, headers: headers, body: jsonEncode(body));
          break;
        case HttpMethod.delete:
           await Future.delayed(const Duration(seconds: 2));
          response = await http.delete(url, headers: headers);
          break;
        case HttpMethod.get:
           await Future.delayed(const Duration(seconds: 2));
          response = await http.get(url, headers: headers);
          break;
      }

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        print('Error Body: ${response.body}');
        
        throw Exception('Dados não carregados: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Exception during HTTP request: $e');
      print('Stack trace: $stackTrace');
      if (e == null) {
        
        throw Exception('HTTP request failed with a null error. This might be a network issue or CORS problem on web.');
      }
      
      throw Exception('Failed to make HTTP request: $e');
    }
  }
}