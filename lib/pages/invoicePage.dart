import 'package:arsneakers/widgets/customAppBarWidget.dart';
import 'package:arsneakers/widgets/customButtonWidget.dart';
import 'package:arsneakers/widgets/customDrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  ValueNotifier<String> username = ValueNotifier<String>('Guest');
  ValueNotifier<String> email = ValueNotifier<String>('unknown@example.com');
  ValueNotifier<String> orderId = ValueNotifier<String>('');
  ValueNotifier<String> orderDate = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    generateOrderDetails();
    loadUserData();
  }

  void generateOrderDetails() {
    var uuid = Uuid();
    orderId.value = uuid.v4().substring(0, 10);
    orderDate.value = DateFormat('dd MMMM yyyy').format(DateTime.now());
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    String? storedEmail = prefs.getString('email');

    username.value =
        storedUsername?.isNotEmpty == true ? storedUsername! : 'Guest';
    email.value =
        storedEmail?.isNotEmpty == true ? storedEmail! : 'unknown@example.com';
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final Map<String, dynamic> args = Get.arguments ?? {};
    final double totalHarga = args['totalHarga'] ?? 0;
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey, title: "ARsneakers"),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.center,
              child: Lottie.network(
                'https://lottie.host/bb81e94e-bb4c-45e0-8aa6-74971b20d5f9/SqeF5tWmpP.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                animate: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFFAF6F6),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFFBDBDBD),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Invoice',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order Id',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Text(
                            'Dibayar',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable: orderId,
                            builder: (context, value, child) {
                              return Text(
                                value,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          ValueListenableBuilder<String>(
                            valueListenable: orderDate,
                            builder: (context, value, child) {
                              return Text(
                                value,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nama User',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Text(
                            'Email',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable: username,
                            builder: (context, value, child) {
                              return Text(
                                value,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          ValueListenableBuilder<String>(
                            valueListenable: email,
                            builder: (context, value, child) {
                              return Text(
                                value,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: Text(
                        'Total Belanja',
                        style: GoogleFonts.montserrat(
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    Text(
                      'Rp ${totalHarga.toStringAsFixed(0)}',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF004241),
                        fontSize: 25,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButtonWidget(
              text: 'Kembali',
              backgroundColor: Colors.black,
              textColor: Colors.white,
              borderColor: Colors.black,
              borderWidth: 3.0,
              pressedBackgroundColor: Colors.white,
              pressedTextColor: Colors.black,
              pressedBorderColor: Colors.black,
              onPressed: () {
                Get.offAllNamed('/home');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF0F4F8),
        onPressed: () {
          Get.toNamed('/product-manager');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
