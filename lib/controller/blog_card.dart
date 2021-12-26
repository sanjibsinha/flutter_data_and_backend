import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/blog.dart';

final shadeOfColors = [
  Colors.yellow.shade100,
  Colors.purple.shade100,
  Colors.teal.shade200,
  Colors.orange.shade200,
  Colors.white10,
];

class BlogCard extends StatelessWidget {
  const BlogCard({
    Key? key,
    required this.blog,
    required this.index,
  }) : super(key: key);

  final Blog blog;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = shadeOfColors[index % shadeOfColors.length];
    final time = DateFormat.yMMMd().format(blog.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 4),
            Text(
              blog.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
