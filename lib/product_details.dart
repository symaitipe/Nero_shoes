import 'package:flutter/material.dart';
import 'cart_manager.dart';
import 'cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final sizesMap = widget.product['sizes'] as Map<String, dynamic>;
    final availableSizes = sizesMap.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[100],
              child: Image.asset(
                widget.product['image'],
                fit: BoxFit.contain,
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Price
                  Text(
                    widget.product['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product['price'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sizes Selection
                  const Text(
                    'Sizes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: availableSizes.map((size) {
                      final availableQty = int.parse(sizesMap[size]);
                      final isAvailable = availableQty > 0;

                      return GestureDetector(
                        onTap: isAvailable
                            ? () => setState(() => selectedSize = size)
                            : null,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: selectedSize == size
                                ? Colors.blue[100]
                                : Colors.transparent,
                            border: Border.all(
                              color:
                                  isAvailable ? Colors.grey : Colors.grey[300]!,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                size,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      isAvailable ? Colors.black : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),

                  // Quantity Selector
                  Row(
                    children: [
                      const Text('Quantity:'),
                      IconButton(
                        onPressed: selectedSize != null
                            ? () => setState(() {
                                  if (selectedQuantity > 1) selectedQuantity--;
                                })
                            : null,
                        icon: const Icon(Icons.remove),
                      ),
                      Text('$selectedQuantity'),
                      IconButton(
                        onPressed: selectedSize != null
                            ? () {
                                final maxQty =
                                    int.parse(sizesMap[selectedSize]!);
                                if (selectedQuantity < maxQty) {
                                  setState(() => selectedQuantity++);
                                }
                              }
                            : null,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: selectedSize != null
                          ? () {
                              // Add to cart logic
                              CartManager.addToCart(
                                product: widget.product,
                                size: selectedSize!,
                                quantity: selectedQuantity,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to cart!'),
                                ),
                              );
                            }
                          : null,
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black87,
                    width: 1.5,
                  ),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    );
                  },
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black87,
                    size: 30,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
