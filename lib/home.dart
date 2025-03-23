import 'package:flutter/material.dart';
import 'package:nero_shoe_app/all_items.dart';
import 'package:nero_shoe_app/brand_filter.dart';
import 'package:nero_shoe_app/searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String selectedBrand = 'All';

  void _onBrandSelected(String brand) {
    setState(() {
      selectedBrand = brand;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: <Widget>[
            //----------------- Theme and Nav bar -------------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nero\nCollection",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 20),
                Expanded(child: Search(hintText: "Search Here", brand: selectedBrand)),
              ],
            ),
            SizedBox(height: 30),

            //----------------- Brand List -------------------------
            BrandFilter(onBrandSelected: _onBrandSelected),

            //----------------- All Item View -------------------------
            AllItems(),
          ],
        ),
      ),
    );
  }
}