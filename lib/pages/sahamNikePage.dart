import 'package:arsneakers/controller/sahamNikeController.dart';
import 'package:arsneakers/model/sahamNikeModel.dart';
import 'package:arsneakers/widgets/customAppBarWidget.dart';
import 'package:arsneakers/widgets/customDrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';

// Service
class StockService {
  final String apiKey = "baZz7duIPlx7QKptD6r34tTTcXxse2bD";
  final String apiUrl =
      "https://financialmodelingprep.com/api/v3/historical-price-full/NKE?apikey=";

  Future<List<Historical>> getStockPrices() async {
    var response = await Dio().get('$apiUrl$apiKey');
    SahamNike sahamNike = SahamNike.fromJson(response.data);
    return sahamNike.historical.take(30).toList();
  }
}

// View
class SahamNikePage extends GetView<SahamNikeController> {
  // final StockController controller = Get.put(StockController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SahamNikeController>(
        init: SahamNikeController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            appBar: CustomAppBar(scaffoldKey: scaffoldKey, title: 'Saham Nike'),
            drawer: CustomDrawer(),
            body: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget: (value, meta) {
                            return Text("\$${value.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 12));
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toInt().toString(),
                                style: const TextStyle(fontSize: 12));
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                        show: true, border: Border.all(color: Colors.grey)),
                    minX: controller.stockPrices.first.x,
                    maxX: controller.stockPrices.last.x,
                    minY: controller.stockPrices
                        .map((e) => e.y)
                        .reduce((a, b) => a < b ? a : b),
                    maxY: controller.stockPrices
                        .map((e) => e.y)
                        .reduce((a, b) => a > b ? a : b),
                    lineBarsData: [
                      LineChartBarData(
                        spots: controller.stockPrices,
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.blue,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.3),
                        ),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              );
            }),
            bottomNavigationBar: CustomBottomBar(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFFF0F4F8),
              onPressed: () {
                Get.toNamed('/product-manager');
              },
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        });
  }
}
