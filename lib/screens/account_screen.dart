import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../models/post.dart';
import '../widgets/item_filter.dart';

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
        distance: 0,
        type: 'Clothes',
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
        distance: 800,
        type: 'Books',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Account'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Notifications
          ExpansionTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            children: [
              SwitchListTile(
                title: const Text('Receive nearby item notifications'),
                value: _receiveNotifications,
                onChanged: (value) {
                  setState(() {
                    _receiveNotifications = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ItemFilterDialog(),
                    );
                  },
                  child: const Text('Filter Item Types'),
                ),
              ),
            ],
          ),
          // User Information
          ExpansionTile(
            leading: const Icon(Icons.person),
            title: const Text('User Information'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/100',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Full Name'),
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
                      decoration: const InputDecoration(labelText: 'Nickname'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Information updated!')),
                        );
                      },
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Security
          ExpansionTile(
            leading: const Icon(Icons.lock),
            title: const Text('Security'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
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
                            const SnackBar(content: Text('Password updated!')),
                          );
                          _passwordController.clear();
                        }
                      },
                      child: const Text('Change Password'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Fire Heart
          ExpansionTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Fire Heart (Shared Items)'),
            children: sharedPosts.map((post) => PostCard(post: post)).toList(),
          ),
          // Received Items
          ExpansionTile(
            leading: const Icon(Icons.receipt),
            title: const Text('Received Items'),
            children:
                receivedPosts.map((post) => PostCard(post: post)).toList(),
          ),
          // Feedback
          ExpansionTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
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
            ],
          ),
          // Contact & Terms
          ExpansionTile(
            leading: const Icon(Icons.info),
            title: const Text('Contact & Terms'),
            children: [
              ListTile(
                leading: const Icon(Icons.contact_mail),
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
                leading: const Icon(Icons.description),
                title: const Text('Terms & Conditions'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing Terms...')),
                  );
                },
              ),
            ],
          ),
        ],
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
