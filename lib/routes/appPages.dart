import 'package:arsneakers/bindings/cartBinding.dart';
import 'package:arsneakers/bindings/detailProductBinding.dart';
import 'package:arsneakers/bindings/homeBinding.dart';
import 'package:arsneakers/bindings/invoiceBinding.dart';
import 'package:arsneakers/bindings/loginBinding.dart';
import 'package:arsneakers/bindings/productManagerBinding.dart';
import 'package:arsneakers/bindings/profileBinding.dart';
import 'package:arsneakers/bindings/registerBinding.dart';
import 'package:arsneakers/bindings/sahamNikebInding.dart';
import 'package:arsneakers/bindings/welcomeBinding.dart';
import 'package:arsneakers/pages/cartPage.dart';
import 'package:arsneakers/pages/detailProductPage.dart';
import 'package:arsneakers/pages/homePage.dart';
import 'package:arsneakers/pages/invoicePage.dart';
import 'package:arsneakers/pages/loginPage.dart';
import 'package:arsneakers/pages/productManagerPage.dart';
import 'package:arsneakers/pages/profilePage.dart';
import 'package:arsneakers/pages/registerPage.dart';
import 'package:arsneakers/pages/sahamNikePage.dart';
import 'package:arsneakers/pages/welcomePage.dart';
import 'package:arsneakers/widgets/addProductScreenWidget.dart';
import 'package:get/get.dart';

part 'appRoutes.dart';

class AppPages {
  AppPages._();

  // Initial route
  static const INITIAL = _Paths.WELCOME;

  // Application routes
  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT,
      page: () => DetailProductPage(productId: Get.parameters['id'] ?? ''),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE,
      page: () => const InvoicePage(),
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_MANAGER,
      page: () => const ProductManagerPage(),
      binding: ProductManagerBinding(),
    ),
    GetPage(
      name: _Paths.SAHAM_NIKE,
      page: () => SahamNikePage(),
      binding: SahamNikeBinding(),
    ),
    GetPage(
      name: _Paths.ADDPRODUCT,
      page: () => AddProductScreen(),
      binding: ProductManagerBinding(),
    ),
  ];
}
