import 'package:flutter/material.dart';

class BrandFilter extends StatefulWidget {
  final Function(String) onBrandSelected;

  const BrandFilter({super.key, required this.onBrandSelected});


  @override
  State<BrandFilter> createState() => _BrandState();
}

class _BrandState extends State<BrandFilter> {
  List<String> brands = ["All", "Adidas", "Nike", "Puma", "DSI", "AVI"];
  String? _selectedBrand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedBrand = brands[index];
                  });
                  widget.onBrandSelected(_selectedBrand!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(brands[index]),
              ),
            );
          }),
    );
  }
}