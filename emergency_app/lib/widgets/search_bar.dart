import 'package:flutter/material.dart';

class SearchBbar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  SearchBbar({required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Search Emergency Numbers',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () => onSearch(controller.text),
          ),
        ),
        onSubmitted: (query) => onSearch(query),
      ),
    );
  }
}
