import 'dart:convert';

SahamNike sahamNikeFromJson(String str) => SahamNike.fromJson(json.decode(str));

String sahamNikeToJson(SahamNike data) => json.encode(data.toJson());

class SahamNike {
  String symbol;
  List<Historical> historical;

  SahamNike({
    required this.symbol,
    required this.historical,
  });

  factory SahamNike.fromJson(Map<String, dynamic> json) => SahamNike(
        symbol: json["symbol"],
        historical: List<Historical>.from(
            json["historical"].map((x) => Historical.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "historical": List<dynamic>.from(historical.map((x) => x.toJson())),
      };
}

class Historical {
  DateTime date;
  double open;
  double high;
  double low;
  double close;
  double adjClose;
  int volume;
  int unadjustedVolume;
  double change;
  double changePercent;
  double vwap;
  String label;
  double changeOverTime;

  Historical({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.adjClose,
    required this.volume,
    required this.unadjustedVolume,
    required this.change,
    required this.changePercent,
    required this.vwap,
    required this.label,
    required this.changeOverTime,
  });

  factory Historical.fromJson(Map<String, dynamic> json) => Historical(
        date: DateTime.parse(json["date"]),
        open: json["open"]?.toDouble(),
        high: json["high"]?.toDouble(),
        low: json["low"]?.toDouble(),
        close: json["close"]?.toDouble(),
        adjClose: json["adjClose"]?.toDouble(),
        volume: json["volume"],
        unadjustedVolume: json["unadjustedVolume"],
        change: json["change"]?.toDouble(),
        changePercent: json["changePercent"]?.toDouble(),
        vwap: json["vwap"]?.toDouble(),
        label: json["label"],
        changeOverTime: json["changeOverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "adjClose": adjClose,
        "volume": volume,
        "unadjustedVolume": unadjustedVolume,
        "change": change,
        "changePercent": changePercent,
        "vwap": vwap,
        "label": label,
        "changeOverTime": changeOverTime,
      };
}
