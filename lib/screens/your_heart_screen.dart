import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../widgets/status_editor.dart';
import '../models/post.dart';

class YourHeartScreen extends StatefulWidget {
  const YourHeartScreen({super.key});

  @override
  State<YourHeartScreen> createState() => _YourHeartScreenState();
}

class _YourHeartScreenState extends State<YourHeartScreen>
    with SingleTickerProviderStateMixin {
  // Trạng thái RING
  bool _isRinging = false;
  // Hoạt ảnh cho nút RING
  late AnimationController _ringAnimationController;
  late Animation<double> _ringAnimation;

  // Tiểu sử người dùng
  String _bio = 'I love sharing and helping others!';
  // Màu nền ảnh bìa
  Color _coverColor = Colors.pink[100]!; // Mặc định hồng nhạt
  final List<Color> _coverColors = [
    Colors.pink[100]!, // Hồng nhạt
    Colors.blue[100]!, // Xanh biển nhạt
    Colors.purple[100]!, // Tím nhạt
  ];
  // Tên người dùng
  final String _userName = 'Nguyen Van A';

  @override
  void initState() {
    super.initState();
    // Khởi tạo AnimationController
    _ringAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // Thiết lập hoạt ảnh rung
    _ringAnimation = Tween<double>(begin: -0.02, end: 0.02).animate(
      CurvedAnimation(
        parent: _ringAnimationController,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _ringAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _ringAnimationController.forward();
        }
      });
  }

  void _toggleRinging() {
    setState(() {
      _isRinging = !_isRinging;
    });

    if (_isRinging) {
      // Bắt đầu hoạt ảnh rung
      _ringAnimationController.forward();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('RING started! Broadcasting for 1 hour.')),
      );
      // Tự động tắt sau 1 giờ
      Future.delayed(const Duration(hours: 1), () {
        if (mounted && _isRinging) {
          setState(() {
            _isRinging = false;
            _ringAnimationController.stop();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('RING stopped.')),
          );
        }
      });
    } else {
      // Dừng hoạt ảnh rung
      _ringAnimationController.stop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('RING stopped manually.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Post> myPosts = [
      Post(
        id: '3',
        title: 'Quần jeans',
        description: 'Quần jeans mới, size 32.',
        imageUrls: ['https://via.placeholder.com/300'], // Sửa imageUrl thành imageUrls
        userName: 'You',
        time: 'Hôm qua',
        distance: 0,
        type: 'Clothes',
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Header cá nhân
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(_userName),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(color: _coverColor),
                      // Nút chọn màu ảnh bìa
                      Positioned(
                        top: 40,
                        right: 16,
                        child: DropdownButton<Color>(
                          value: _coverColor,
                          items: _coverColors.map((color) {
                            return DropdownMenuItem(
                              value: color,
                              child: Container(
                                width: 24,
                                height: 24,
                                color: color,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _coverColor = value!;
                            });
                          },
                        ),
                      ),
                      // Avatar ở góc trái
                      Positioned(
                        bottom: 20,
                        left: 16,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Nội dung
              SliverList(
                delegate: SliverChildListDelegate([
                  // Tiểu sử
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _bio,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () async {
                            final newBio = await showDialog<String>(
                              context: context,
                              builder: (context) {
                                final controller = TextEditingController(text: _bio);
                                return AlertDialog(
                                  title: const Text('Edit Bio'),
                                  content: TextField(
                                    controller: controller,
                                    maxLines: 3,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your bio',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context, controller.text),
                                      child: const Text('Save'),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (newBio != null && newBio.isNotEmpty) {
                              setState(() {
                                _bio = newBio;
                              });
                            }
                          },
                          child: const Text('Edit Bio'),
                        ),
                      ],
                    ),
                  ),
                  // Nút Post Item và Posting Status
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => const StatusEditor(isItem: true),
                              );
                            },
                            icon: const Icon(Icons.card_giftcard),
                            label: const Text('Post Item'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => const StatusEditor(isItem: false),
                              );
                            },
                            icon: const Icon(Icons.favorite),
                            label: const Text('Post Status'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Danh sách bài viết
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Your Posts',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...myPosts.map((post) => PostCard(post: post)),
                ]),
              ),
            ],
          ),
          // Nút RING
          Positioned(
            bottom: 16,
            right: 16,
            child: AnimatedBuilder(
              animation: _ringAnimationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _isRinging ? _ringAnimation.value : 0,
                  child: FloatingActionButton(
                    onPressed: _toggleRinging,
                    backgroundColor: _isRinging ? Colors.redAccent : Colors.blueAccent,
                    child: Icon(
                      _isRinging ? Icons.notifications_active : Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ringAnimationController.dispose();
    super.dispose();
  }
}