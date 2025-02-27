import 'dart:convert';

import 'package:arsneakers/model/sahamNikeModel.dart';
import 'package:arsneakers/pages/sahamNikePage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SahamNikeController extends GetxController {
// Controller
  var stockPrices = <FlSpot>[].obs;
  var isLoading = true.obs;
  final StockService _stockService = StockService();

  @override
  void onInit() {
    loadCachedStockData();
    fetchStockData();
    super.onInit();
  }

  Future<void> loadCachedStockData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('stock_data');
    if (cachedData != null) {
      List<dynamic> decodedData = json.decode(cachedData);
      stockPrices.value =
          decodedData.map((e) => FlSpot(e["x"], e["y"])).toList();
    }
  }

  Future<void> fetchStockData() async {
    try {
      isLoading(true);
      List<Historical> prices = await _stockService.getStockPrices();
      stockPrices.value = prices
          .asMap()
          .entries
          .map((e) => FlSpot(e.key.toDouble(), e.value.close))
          .toList();
      saveToCache(prices);
    } catch (e) {
      print('Error fetching stock data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> saveToCache(List<Historical> prices) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(prices
        .asMap()
        .entries
        .map((e) => {"x": e.key.toDouble(), "y": e.value.close})
        .toList());
    prefs.setString('stock_data', encodedData);
  }
}
