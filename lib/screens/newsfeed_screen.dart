import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../models/post.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = [
      Post(
        id: '1',
        title: 'Áo thun vintage',
        description: 'Áo thun đẹp, còn mới 90%, size M.',
        imageUrl: 'https://via.placeholder.com/300',
        userName: 'User1',
        time: '2 giờ trước',
      ),
      Post(
        id: '2',
        title: 'Máy ảnh Canon',
        description: 'Máy ảnh chất lượng cao, ít sử dụng.',
        imageUrl: 'https://via.placeholder.com/300',
        userName: 'User2',
        time: '1 ngày trước',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Newsfeed'), centerTitle: true),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
    );
  }
}
