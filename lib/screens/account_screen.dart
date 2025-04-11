import 'package:flutter/material.dart';
import '../widgets/item_filter.dart';
import '../models/post.dart';
import '../widgets/post_card.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _receiveNotifications = true;
  final TextEditingController _nameController = TextEditingController(
    text: 'Nguyen Van A',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '0123456789',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'user@example.com',
  );
  final TextEditingController _nicknameController = TextEditingController(
    text: 'UserA',
  );
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Post> sharedPosts = [
      Post(
        id: '3',
        title: 'Quần jeans',
        description: 'Quần jeans mới, size 32.',
        imageUrl: 'https://via.placeholder.com/300',
        userName: 'You',
        time: 'Hôm qua',
      ),
    ];
    final List<Post> receivedPosts = [
      Post(
        id: '4',
        title: 'Sách cũ',
        description: 'Sách văn học, còn tốt.',
        imageUrl: 'https://via.placeholder.com/300',
        userName: 'UserB',
        time: '2 ngày trước',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Account'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông báo
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SwitchListTile(
                        title: const Text('Receive nearby item notifications'),
                        value: _receiveNotifications,
                        onChanged: (value) {
                          setState(() {
                            _receiveNotifications = value;
                          });
                        },
                        activeColor: Colors.teal,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const ItemFilterDialog(),
                          );
                        },
                        child: const Text('Filter Item Types'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Thông tin người dùng
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'User Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/100',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                      ),
                      TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      TextField(
                        controller: _nicknameController,
                        decoration: const InputDecoration(
                          labelText: 'Nickname',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Information updated!'),
                              ),
                            );
                          },
                          child: const Text('Save Changes'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Bảo mật
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Security',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'New Password',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_passwordController.text.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password updated!'),
                              ),
                            );
                            _passwordController.clear();
                          }
                        },
                        child: const Text('Change Password'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Fire Heart (Vật phẩm đã chia sẻ)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fire Heart (Shared Items)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...sharedPosts
                          .map((post) => PostCard(post: post))
                          .toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Receive (Vật phẩm đã nhận)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Received Items',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...receivedPosts
                          .map((post) => PostCard(post: post))
                          .toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Góp ý
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Feedback',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: _feedbackController,
                        decoration: const InputDecoration(
                          labelText: 'Your Feedback',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_feedbackController.text.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Feedback sent!')),
                            );
                            _feedbackController.clear();
                          }
                        },
                        child: const Text('Send Feedback'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Liên hệ & Điều khoản
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact & Terms',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.contact_mail,
                          color: Colors.teal,
                        ),
                        title: const Text('Contact Us'),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Contact: support@example.com'),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.description,
                          color: Colors.teal,
                        ),
                        title: const Text('Terms & Conditions'),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Viewing Terms...')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nicknameController.dispose();
    _passwordController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }
}
