class Post {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String userName;
  final String time;
  final double distance; // meters
  final String type;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.userName,
    required this.time,
    required this.distance,
    required this.type,
  });
}
