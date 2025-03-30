import 'package:flutter/material.dart';
import 'package:nero_shoe_app/brand_filter.dart';
import 'package:nero_shoe_app/searchbar.dart';
import 'package:nero_shoe_app/show_items.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String selectedBrand = "All";

  void stateChanger(String brand) {
    setState(() {
      selectedBrand = brand;
    });
    //print("In home, Brand is : ${selectedBrand}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
              child: Row(
                children: [
                  Text(
                    "Nero\nShoes",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                  ),
                  SizedBox(width: 30),
                  Expanded(child: Search(selectedType: selectedBrand)),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: BrandFilter(homeToFilterStateChangeFunction: stateChanger),
          ),

          Expanded(child: ShowItems(selectedBrand)),

          // Footer Buttons
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home Button
                TextButton(
                  onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context)=>HomePage())
                   );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.home, color: Colors.black87,size: 30),
                    ],
                  ),
                ),

                // Cart Button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.black87,size: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
