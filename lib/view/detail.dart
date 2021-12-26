import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/blogs.dart';
import '../model/blog.dart';
import 'edit.dart';

class DetailPage extends StatefulWidget {
  final int noteId;

  const DetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Blog blog;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshBlog();
  }

  Future refreshBlog() async {
    setState(() => isLoading = true);

    blog = await BlogDatabase.instance.readBlog(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      blog.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(blog.createdTime),
                      style: const TextStyle(color: Colors.white38),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      blog.description,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditPage(blog: blog),
        ));

        refreshBlog();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await BlogDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
