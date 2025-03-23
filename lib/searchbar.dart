import 'dart:async';

import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String hintText;
  final String brand;

  const Search({super.key, required this.hintText, required this.brand});

  @override
  State<Search> createState() => _SearchBarState();
}

class _SearchBarState extends State<Search> {
  List<Map<String, dynamic>> allItemList = [
    {
      "gender": "Male",
      "brand": "Adidas",
      "name": "Running shoes",
      "title": "Adidas Running Shoes",
      "price": "Rs 1220.00",
      "sizes": [7, 8, 9],
      "available_qty": 12,
      "image": "assets/adidas.jpg",
    },
    {
      "gender": "Female",
      "brand": "Nike",
      "name": "Air Max",
      "title": "Nike Air Max",
      "price": "Rs 1500.00",
      "sizes": [6, 7, 8],
      "available_qty": 10,
      "image": "assets/nike.jpg",
    },
    {
      "gender": "Unisex",
      "brand": "Puma",
      "name": "Sneakers",
      "title": "Puma Sneakers",
      "price": "Rs 1300.00",
      "sizes": [8, 9, 10],
      "available_qty": 15,
      "image": "assets/puma.jpg",
    },
  ];

  String _searchText = '';
  List<Map<String, dynamic>> _searchResults = [];
  OverlayEntry? _overlayEntry;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _overlayEntry?.remove();
    _debounceTimer?.cancel();
    super.dispose();
  }

  // Show or update the overlay with search results
  void _updateOverlay(BuildContext context) {
    if (_overlayEntry == null) {
      // Create the overlay if it doesn't exist
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 150,
          left: 200,
          width: 300,
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 1),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
                  return ListTile(
                    title: Text(item["name"]),
                    subtitle: Text(item["brand"]),
                  );
                },
              ),
            ),
          ),
        ),
      );

      // Insert the overlay into the Overlay
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      // Update the existing overlay
      _overlayEntry!.markNeedsBuild();
    }
  }

  // Hide the overlay
  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // Debounced search function
  void _onSearchTextChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchText = value;
        _searchResults = searchFunction(_searchText, widget.brand);
      });

      if (_searchText.isNotEmpty) {
        _updateOverlay(context);
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: widget.hintText,
          ),
          onChanged: _onSearchTextChanged,
        ),
        SizedBox(height: 10),
      ],
    );
  }

  // Optimized search function
  List<Map<String, dynamic>> searchFunction(String searchText, String brand) {
    List<Map<String, dynamic>> results = [];

    // Return empty list if search text is empty
    if (searchText.isEmpty) {
      return results;
    }

    // Convert search text to lowercase for case-insensitive search
    final searchQuery = searchText.toLowerCase();

    // Filter items based on search text and brand
    for (var item in allItemList) {
      final itemName = item["name"].toString().toLowerCase();
      final itemBrand = item["brand"].toString().toLowerCase();

      // Check if the item matches the search text and brand
      bool matchesSearchText = itemName.contains(searchQuery);
      bool matchesBrand = brand == "All" || itemBrand == brand.toLowerCase();

      if (matchesSearchText && matchesBrand) {
        results.add(item);
      }
    }

    // If no results are found, add a "No Item Found" placeholder
    if (results.isEmpty) {
      results.add({
        "name": "No Item Found",
        "brand": "",
        "title": "",
        "price": "",
        "sizes": [],
        "available_qty": 0,
        "image": "",
      });
    }

    return results;
  }
}