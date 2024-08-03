import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.value ?? 'Select ${widget.label}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[
                        800], // Darker grey for better readability on light background
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.grey[800],
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.items.map((item) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onChanged(item);
                      _isExpanded = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[
                            800], // Darker grey for better readability on light background
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
