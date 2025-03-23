import 'package:flutter/material.dart';

class AllItems extends StatefulWidget {
  const AllItems({super.key});
  @override
  State<AllItems> createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  List<Map<String, dynamic>> allItemList = [
    {
      "gender": "Male",
      "name": "Adidas Running Shoes",
      "price": "Rs 1220.00",
      "sizes": [7, 8, 9],
      "available_qty": 12,
      "image": "assets/adidas.jpg",
    },
    {
      "gender": "Female",
      "name": "Nike Air Max",
      "price": "Rs 1500.00",
      "sizes": [6, 7, 8],
      "available_qty": 10,
      "image": "assets/nike.jpg",
    },
    {
      "gender": "Unisex",
      "name": "Puma Sneakers",
      "price": "Rs 1300.00",
      "sizes": [8, 9, 10],
      "available_qty": 15,
      "image": "assets/puma.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: allItemList.length,
            itemBuilder: (context, index) {
              final item = allItemList[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(10),

                child: Container(
                  width: 150,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10),
                        child: Image.asset(
                          item["image"],
                          height: 200,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Product Name
                      Text(
                        item["name"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        item["price"],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
    );
  }
}
