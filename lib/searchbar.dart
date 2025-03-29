import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'all_Items.dart';

class Search extends StatelessWidget {
  final String selectedType;
  const Search({super.key, required this.selectedType});



  @override
  Widget build(BuildContext context) {

    OutlineInputBorder borderStyles =  OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black,width: 1.0),
      borderRadius:BorderRadius.circular(10),
    );

    final typeAheadKey = Key(selectedType);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField<Map<String, dynamic>>(
        key: typeAheadKey,
        builder: (context, controller, focusNode) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search ${selectedType != "All" ? selectedType : ""} products",
              border: borderStyles,
              enabledBorder: borderStyles,
              focusedBorder: borderStyles,
            ),
          );
        },
        suggestionsCallback: (pattern) {
          if (selectedType != "All") {
            return allItems.where((item) =>
            item['name'].toLowerCase().contains(pattern.toLowerCase()) &&
                item['brand'].toLowerCase() == selectedType.toLowerCase()
            ).toList();
          } else {
            return allItems.where((item) =>
                item['name'].toLowerCase().contains(pattern.toLowerCase())
            ).toList();
          }
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            leading: Image.asset(
              suggestion['image'],
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            title: Text(suggestion['name']),
            subtitle: Text(suggestion['price']),
          );
        },
        onSelected: (suggestion) {
          print("Selected ${suggestion['name']} from brand: ${suggestion['brand']}");
        },
      ),
    );
  }
}
