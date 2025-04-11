// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Social Sharing App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
//         useMaterial3: true,
//         scaffoldBackgroundColor: Colors.grey[100],
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.teal,
//           foregroundColor: Colors.white,
//           elevation: 0,
//         ),
//         cardTheme: CardTheme(
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         ),
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   static final List<Widget> _screens = <Widget>[
//     const NewsfeedScreen(),
//     const PostingScreen(),
//     const MapScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.feed),
//             label: 'Newsfeed',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.post_add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map),
//             label: 'Map',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.teal,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//         elevation: 8,
//         type: BottomNavigationBarType.fixed,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// // Màn hình Newsfeed
// class NewsfeedScreen extends StatelessWidget {
//   const NewsfeedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, String>> posts = [
//       {
//         'title': 'Áo thun vintage',
//         'description': 'Áo thun đẹp, còn mới 90%, size M.',
//         'image': 'https://via.placeholder.com/300',
//         'user': 'User1',
//         'time': '2 giờ trước',
//       },
//       {
//         'title': 'Máy ảnh Canon',
//         'description': 'Máy ảnh chất lượng cao, ít sử dụng.',
//         'image': 'https://via.placeholder.com/300',
//         'user': 'User2',
//         'time': '1 ngày trước',
//       },
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Newsfeed'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header bài viết
//                 ListTile(
//                   leading: const CircleAvatar(
//                     backgroundImage: NetworkImage('https://via.placeholder.com/50'),
//                   ),
//                   title: Text(
//                     posts[index]['user']!,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(posts[index]['time']!),
//                 ),
//                 // Hình ảnh
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       posts[index]['image']!,
//                       height: 200,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         height: 200,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.broken_image, size: 50),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Tiêu đề và mô tả
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         posts[index]['title']!,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         posts[index]['description']!,
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Nút tương tác
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.favorite_border, color: Colors.teal),
//                         onPressed: () {},
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.comment, color: Colors.teal),
//                         onPressed: () {},
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         icon: const Icon(Icons.share, color: Colors.teal),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Màn hình Posting
// class PostingScreen extends StatefulWidget {
//   const PostingScreen({super.key});

//   @override
//   State<PostingScreen> createState() => _PostingScreenState();
// }

// class _PostingScreenState extends State<PostingScreen> {
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Post'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Trường nhập tiêu đề
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(
//                 labelText: 'Item Name',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 prefixIcon: const Icon(Icons.title, color: Colors.teal),
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Trường nhập mô tả
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 prefixIcon: const Icon(Icons.description, color: Colors.teal),
//               ),
//               maxLines: 4,
//             ),
//             const SizedBox(height: 16),
//             // Nút chọn ảnh
//             OutlinedButton.icon(
//               onPressed: () {
//                 // Xử lý chọn ảnh (có thể tích hợp image_picker)
//               },
//               icon: const Icon(Icons.image, color: Colors.teal),
//               label: const Text('Add Image'),
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(color: Colors.teal),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Nút đăng bài
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_titleController.text.isNotEmpty &&
//                       _descriptionController.text.isNotEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Post created successfully!')),
//                     );
//                     _titleController.clear();
//                     _descriptionController.clear();
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: Colors.teal,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Post Item',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
// }

// // Màn hình Map
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(10.7769, 106.7009); // TP.HCM
//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     // Thêm marker mẫu
//     _markers.add(
//       Marker(
//         markerId: const MarkerId('item1'),
//         position: _center,
//         infoWindow: const InfoWindow(
//           title: 'Áo thun vintage',
//           snippet: 'Gần trung tâm TP.HCM',
//         ),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map'),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           // Bản đồ
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 12.0,
//             ),
//             markers: _markers,
//           ),
//           // Danh sách vật phẩm (nửa dưới màn hình)
//           DraggableScrollableSheet(
//             initialChildSize: 0.3,
//             minChildSize: 0.1,
//             maxChildSize: 0.5,
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       spreadRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: ListView(
//                   controller: scrollController,
//                   children: const [
//                     ListTile(
//                       leading: Icon(Icons.location_on, color: Colors.teal),
//                       title: Text('Áo thun vintage'),
//                       subtitle: Text('Gần trung tâm TP.HCM'),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.location_on, color: Colors.teal),
//                       title: Text('Máy ảnh Canon'),
//                       subtitle: Text('Quận 7, TP.HCM'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Sharing App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}