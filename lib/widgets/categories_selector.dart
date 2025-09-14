import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  String selectedCategory = '';
  final Function(String) onCategorySelected;

  CategorySelector({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    super.key,
  });
  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categories.map((category) {
        final isSelected = category == selectedCategory;
        return GestureDetector(
          onTap: () => onCategorySelected(category),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? Color(0xff379c8a).withOpacity(0.7)
                  : Color(0xffdae9e6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xff379c8a),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
