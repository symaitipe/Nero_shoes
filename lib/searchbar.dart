import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'all_Items.dart';

class Search extends StatelessWidget {

  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField<Map<String, dynamic>>(
        textFieldConfiguration: const TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: 'Search',
            border:OutlineInputBorder(),
          ),

        ),

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

        onSuggestionSelected: (suggestion) {
          print('Selected: ${suggestion['name']}');
        },
      ),
    );
  }
}