import 'package:flutter/material.dart';
import 'package:nero_shoe_app/searchbar.dart';

import 'brand_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});



  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
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

                  Expanded(
                    child: Search()
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0,0),
            child: BrandFilter(),
          )

        ],
      ),
    );
  }
}