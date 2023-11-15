class Post {
  final String user_uid;
  final String caption;
  final String uid;
  final DateTime timestamp;
  final String privacy_status;

  Post({
    required this.user_uid,
    required this.caption,
    required this.uid,
    required this.timestamp,
    required this.privacy_status,
  });
}
