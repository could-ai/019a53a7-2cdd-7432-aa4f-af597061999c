import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/badge.dart';
import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Product> products = [
    Product(
      id: 'p1',
      name: 'Smartphone A',
      price: 299.99,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'High-end smartphone with excellent camera.',
    ),
    Product(
      id: 'p2',
      name: 'Laptop B',
      price: 799.99,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Powerful laptop for work and gaming.',
    ),
    Product(
      id: 'p3',
      name: 'Headphones C',
      price: 49.99,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Noise-cancelling over-ear headphones.',
    ),
    Product(
      id: 'p4',
      name: 'Smartwatch D',
      price: 199.99,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Track your fitness and notifications.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Andy Cell'),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, child) => Badge(
              child: child!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (ctx, index) => ProductCard(product: products[index]),
        ),
      ),
    );
  }
}