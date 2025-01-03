// screens/community/community_screen.dart
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Implement refresh
              },
              child: ListView.builder(
                itemCount: 10, // In production, use actual post count
                itemBuilder: (context, index) {
                  return CommunityPost(
                    author: 'User ${index + 1}',
                    content: 'This is a community post #${index + 1}',
                    timestamp: DateTime.now().subtract(Duration(hours: index)),
                    likes: index * 5,
                    comments: index * 3,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show new post dialog
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search community posts...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}

// screens/community/components/community_post.dart
class CommunityPost extends StatelessWidget {
  final String author;
  final String content;
  final DateTime timestamp;
  final int likes;
  final int comments;

  const CommunityPost({
    super.key,
    required this.author,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(author[0]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatTimestamp(timestamp),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Show post options
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(content),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_outlined),
                  onPressed: () {
                    // Implement like functionality
                  },
                ),
                Text('$likes'),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    // Show comments
                  },
                ),
                Text('$comments'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}