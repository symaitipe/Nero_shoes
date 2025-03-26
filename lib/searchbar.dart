import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'all_Items.dart';

class Search extends StatelessWidget {

  final String selectedType;

  const Search({super.key, required this.selectedType});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField<Map<String, dynamic>>(

        suggestionsCallback: (pattern) async {
          return allItems.where((item) =>
              item['name'].toLowerCase().contains(pattern.toLowerCase())).toList();
        },

        itemBuilder: (context, suggestion) {
          return ListTile(
            leading: Image.asset(suggestion['image'],height: 50,width: 50,),
            title: Text(suggestion['name']),
          );
        },

        onSelected: (suggestion) {
          print("In Search,Brand is : ${selectedType}");

        },
      ),
    );
  }
}