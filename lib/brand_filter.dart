import 'package:flutter/material.dart';

class BrandFilter extends StatefulWidget {

  final Function homeToFilterStateChangeFunction;
  const BrandFilter({super.key, required this.homeToFilterStateChangeFunction});


  @override
  State<BrandFilter> createState() => _BrandState();
}

class _BrandState extends State<BrandFilter> {
  List<String> brands = ["All", "Adidas", "Nike", "Puma", "DSI", "AVI"];
  late String _selectedBrand = brands[0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          itemBuilder: (context, index) {
            return Container(
              margin:EdgeInsets.only(right: 25),
              child: ElevatedButton(
                onPressed: () {
                  print("In Select Brand, Before change - Brand is : ${_selectedBrand}");
                  setState(() {
                    _selectedBrand = brands[index];
                  });
                  print("In Select Brand, After change - Brand is : ${_selectedBrand}");
                  widget.homeToFilterStateChangeFunction(brands[index]);
                },
                style: ElevatedButton.styleFrom(

                  backgroundColor: _selectedBrand == brands[index]? Colors.yellow : Colors.grey[200],
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