import 'package:flutter/material.dart';

class SearchIcon extends StatefulWidget {
  final Function(String) onSearchChanged;

  const SearchIcon({required this.onSearchChanged, super.key});

  @override
  State<SearchIcon> createState() => _SearchIconState();
}

class _SearchIconState extends State<SearchIcon> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    if (_isSearching) {
      return Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.4, // 40% of screen width
        constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search exams...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          onChanged: widget.onSearchChanged,
          onSubmitted: (_) => _toggleSearch(),
        ),
      );
    }

    return GestureDetector(
      onTap: _toggleSearch,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Icon(Icons.search)),
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearchChanged('');
      }
    });
  }
}
