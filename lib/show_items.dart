import 'package:flutter/material.dart';
import 'package:nero_shoe_app/product_card.dart';
import 'all_Items.dart';

class ShowItems extends StatelessWidget {
  final String selectedBrand;

  const ShowItems(this.selectedBrand, {super.key});

  @override
  Widget build(BuildContext context) {
    // Filter products based on selected brand
    final filteredProducts = selectedBrand == "All"
        ? allItems
        : allItems.where((item) => item['brand'].toLowerCase() == selectedBrand.toLowerCase()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Collection",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                child: ProductCard(product: product),
              );
            },
          ),
        ),
      ],
    );
  }
}

