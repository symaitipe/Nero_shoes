import 'package:flutter/material.dart';
import 'package:nero_shoe_app/home.dart';

class CartManager {
  static List<Map<String, dynamic>> cartItems = [];

  static void addToCart({
    required Map<String, dynamic> product,
    required String size,
    required int quantity,
  }) {
    // Check if item already exists in cart
    final existingIndex = cartItems.indexWhere(
          (item) => item['product'] == product && item['size'] == size,
    );

    if (existingIndex >= 0) {
      // Update quantity if already exists
      cartItems[existingIndex]['quantity'] += quantity;
    } else {
      // Add new item
      cartItems.add({
        'product': product,
        'size': size,
        'quantity': quantity,
      });
    }
  }

  static void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  static double getTotalPrice() {
    return cartItems.fold(0, (total, item) {
      final price = double.parse(item['product']['price'].replaceAll('Rs ', ''));
      return total + (price * item['quantity']);
    });
  }

  static void checkout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout Successful'),
          content: const Text('Thank you for your purchase!'),
          actions: [
            TextButton(
              onPressed: () {
                cartItems.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>HomePage()
                    )
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}