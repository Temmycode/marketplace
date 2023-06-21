import 'package:flutter/widgets.dart';
import 'package:marketplace/views/tabs/cart_page/cart_page.dart';
import 'package:marketplace/views/tabs/discover_page/discover_page.dart';
import 'package:marketplace/views/tabs/sell_product_page/sell_product_page.dart';

const List<Widget> tabPages = [
  DiscoverPage(),
  CartPage(),
  SellProductPage(),
];
