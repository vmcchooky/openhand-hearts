import 'package:flutter/material.dart';

class ItemFilterDialog extends StatefulWidget {
  const ItemFilterDialog({super.key});

  @override
  State<ItemFilterDialog> createState() => _ItemFilterDialogState();
}

class _ItemFilterDialogState extends State<ItemFilterDialog> {
  final Map<String, bool> _filters = {
    'Clothes': false,
    'Electronics': false,
    'Books': false,
    'Food': false,
    'Others': false,
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Item Types'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              _filters.keys.map((item) {
                return CheckboxListTile(
                  title: Text(item),
                  value: _filters[item],
                  onChanged: (value) {
                    setState(() {
                      _filters[item] = value!;
                    });
                  },
                  activeColor: Colors.teal,
                );
              }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Filters updated!')));
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
