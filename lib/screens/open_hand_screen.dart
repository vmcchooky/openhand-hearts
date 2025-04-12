import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../models/post.dart';

class OpenHandScreen extends StatefulWidget {
  const OpenHandScreen({super.key});

  @override
  State<OpenHandScreen> createState() => _OpenHandScreenState();
}

class _OpenHandScreenState extends State<OpenHandScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedType = 'All';
  double _selectedDistance = 1000.0; // meters
  String _selectedTime = 'Hôm nay';

  final List<Post> posts = [
    Post(
      id: '1',
      title: 'Áo thun vintage',
      description: 'Áo thun đẹp, còn mới 90%, size M.',
      imageUrls: [
        'https://via.placeholder.com/300',
      ], // Sửa imageUrl thành imageUrls
      userName: 'User1',
      time: 'Hôm nay',
      distance: 500,
      type: 'Clothes',
    ),
    Post(
      id: '2',
      title: 'Máy ảnh Canon',
      description: 'Máy ảnh chất lượng cao, ít sử dụng.',
      imageUrls: [
        'https://via.placeholder.com/300',
      ], // Sửa imageUrl thành imageUrls
      userName: 'User2',
      time: '1 ngày trước',
      distance: 1200,
      type: 'Electronics',
    ),
  ];

  List<Post> _filteredPosts() {
    return posts.where((post) {
      final matchesSearch =
          _searchController.text.isEmpty ||
          post.title.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          post.description.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
      final matchesType = _selectedType == 'All' || post.type == _selectedType;
      final matchesDistance = post.distance <= _selectedDistance;
      final matchesTime =
          _selectedTime == 'Hôm nay' || post.time == _selectedTime;
      return matchesSearch && matchesType && matchesDistance && matchesTime;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Hand'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          // Bộ lọc
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedType,
                  items:
                      [
                        'All',
                        'Clothes',
                        'Electronics',
                        'Books',
                        'Food',
                        'Shoes',
                        'Stationery',
                        'Snacks',
                        'Drinks',
                        'Paper',
                        'Others',
                      ].map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
                DropdownButton<double>(
                  value: _selectedDistance,
                  items:
                      [100.0, 300.0, 500.0, 1000.0, 5000.0].map((distance) {
                        return DropdownMenuItem(
                          value: distance,
                          child: Text('${distance.toInt()}m'),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDistance = value!;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: _selectedTime,
                  items:
                      [
                        'Hôm nay',
                        '1 ngày trước',
                        '3 ngày trước',
                        '1 tuần trước',
                        '1 tháng trước',
                      ].map((time) {
                        return DropdownMenuItem(value: time, child: Text(time));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTime = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          // Danh sách bài viết
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPosts().length,
              itemBuilder: (context, index) {
                return PostCard(post: _filteredPosts()[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
