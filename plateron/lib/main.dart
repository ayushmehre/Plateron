import 'package:flutter/material.dart';
import 'package:plateron/providers/cart_provider.dart';
import 'package:plateron/providers/product_provider.dart';
import 'package:plateron/repositories/product_repository.dart';
import 'package:plateron/routes.dart';
import 'package:plateron/screens/menu_listing_screen.dart';
import 'package:plateron/screens/summary_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(ProductRepository()),
        ), // Move the ProductProvider here
      ],
      child: MaterialApp(
        routes: {
          Routes.menuListing: (context) => const MenuListingScreen(),
          Routes.orderSummary: (context) => const OrderSummaryScreen(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          scaffoldBackgroundColor: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        home: const MenuListingScreen(),
      ),
    );
  }
}
