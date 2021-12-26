const String tableOfBlogs = 'Blogs';

class BlogFields {
  static final List<String> values = [
    /// Adding all fields
    id, title, description, time
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Blog {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;

  const Blog({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Blog copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Blog(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Blog fromJson(Map<String, Object?> json) => Blog(
        id: json[BlogFields.id] as int?,
        title: json[BlogFields.title] as String,
        description: json[BlogFields.description] as String,
        createdTime: DateTime.parse(json[BlogFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        BlogFields.id: id,
        BlogFields.title: title,
        BlogFields.description: description,
        BlogFields.time: createdTime.toIso8601String(),
      };
}
