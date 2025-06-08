class CryptoCurrencyEntity {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final DateTime dateAdded;
  final Map<String, QuoteEntity> quote;

  CryptoCurrencyEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.dateAdded,
    required this.quote,
  });

  factory CryptoCurrencyEntity.fromJson(Map<String, dynamic> json) {
    return CryptoCurrencyEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      slug: json['slug'] ?? '',
      dateAdded: json['date_added'] != null
          ? DateTime.parse(json['date_added'])
          : DateTime.now(),
      quote: (json['quote'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, QuoteEntity.fromJson(value)),
          ) ??
          {},
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'symbol': symbol,
    'slug': slug,
    'date_added': dateAdded.toIso8601String(),
    'quote': quote.map((key, value) => MapEntry(key, value.toJson())),
  };
}

class QuoteEntity {
  final double price;
  final double volume24h;
  final double percentChange1h;
  final double percentChange24h;
  final double percentChange7d;
  final double marketCap;
  final DateTime lastUpdated;

  QuoteEntity({
    required this.price,
    required this.volume24h,
    required this.percentChange1h,
    required this.percentChange24h,
    required this.percentChange7d,
    required this.marketCap,
    required this.lastUpdated,
  });

  factory QuoteEntity.fromJson(Map<String, dynamic> json) {
    return QuoteEntity(
      price: (json['price'] ?? 0.0).toDouble(),
      volume24h: (json['volume_24h'] ?? 0.0).toDouble(),
      percentChange1h: (json['percent_change_1h'] ?? 0.0).toDouble(),
      percentChange24h: (json['percent_change_24h'] ?? 0.0).toDouble(),
      percentChange7d: (json['percent_change_7d'] ?? 0.0).toDouble(),
      marketCap: (json['market_cap'] ?? 0.0).toDouble(),
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'])
          : DateTime.now(),
    );
  }
   Map<String, dynamic> toJson() => {
    'price': price,
    'volume_24h': volume24h,
    'percent_change_1h': percentChange1h,
    'percent_change_24h': percentChange24h,
    'percent_change_7d': percentChange7d,
    'market_cap': marketCap,
    'last_updated': lastUpdated.toIso8601String(),
  };
}