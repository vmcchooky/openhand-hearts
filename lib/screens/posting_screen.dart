import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../models/post.dart';

class PostingScreen extends StatefulWidget {
  const PostingScreen({super.key});

  @override
  State<PostingScreen> createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isRinging = false;

  void _startRinging() {
    setState(() {
      _isRinging = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('RING started! Broadcasting for 1 hour.')),
    );
    Future.delayed(const Duration(hours: 1), () {
      if (mounted) {
        setState(() {
          _isRinging = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('RING stopped.')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Post> myPosts = [
      Post(
        id: '3',
        title: 'Quần jeans',
        description: 'Quần jeans mới, size 32.',
        imageUrl: 'https://via.placeholder.com/300',
        userName: 'You',
        time: 'Hôm qua',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Posts'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phần đăng bài mới
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Item Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.title,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.description,
                            color: Colors.teal,
                          ),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.image, color: Colors.teal),
                              label: const Text('Add Image'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.teal),
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
                                if (_titleController.text.isNotEmpty &&
                                    _descriptionController.text.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Post created!'),
                                    ),
                                  );
                                  _titleController.clear();
                                  _descriptionController.clear();
                                }
                              },
                              child: const Text('Post'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Nút RING
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: _isRinging ? null : _startRinging,
                icon: Icon(
                  _isRinging ? Icons.notifications_active : Icons.notifications,
                ),
                label: Text(
                  _isRinging ? 'Ringing...' : 'RING (Broadcast 300m)',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRinging ? Colors.grey : Colors.redAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
            // Danh sách bài viết của người dùng
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Your Posts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: myPosts.length,
              itemBuilder: (context, index) {
                return PostCard(post: myPosts[index]);
              },
            ),
          ],
        ),
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
