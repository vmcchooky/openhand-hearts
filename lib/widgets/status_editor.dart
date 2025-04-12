import 'package:flutter/material.dart';

class StatusEditor extends StatefulWidget {
  final bool isItem;

  const StatusEditor({super.key, required this.isItem});

  @override
  State<StatusEditor> createState() => _StatusEditorState();
}

class _StatusEditorState extends State<StatusEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isItem)
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          if (widget.isItem) const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: widget.isItem ? 'Description' : 'Status',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          // Định dạng chữ
          if (!widget.isItem)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.format_bold,
                    color: _isBold ? Colors.blueAccent : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isBold = !_isBold;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.format_italic,
                    color: _isItalic ? Colors.blueAccent : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isItalic = !_isItalic;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.format_underline,
                    color: _isUnderline ? Colors.blueAccent : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isUnderline = !_isUnderline;
                    });
                  },
                ),
              ],
            ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.image),
                  label: const Text('Add Image'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blueAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_descriptionController.text.isNotEmpty &&
                        (widget.isItem
                            ? _titleController.text.isNotEmpty
                            : true)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            widget.isItem ? 'Item posted!' : 'Status posted!',
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.isItem ? 'Post Item' : 'Post Status'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
