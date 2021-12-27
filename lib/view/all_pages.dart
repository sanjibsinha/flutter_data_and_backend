import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '/model/blogs.dart';
import '/model/blog.dart';
import 'edit.dart';
import 'detail.dart';
import '/controller/blog_card.dart';

class AllPages extends StatefulWidget {
  const AllPages({Key? key}) : super(key: key);

  @override
  _AllPagesState createState() => _AllPagesState();
}

class _AllPagesState extends State<AllPages> {
  late List<Blog> blogs;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshingAllBogs();
  }

  @override
  void dispose() {
    BlogDatabaseHandler.instance.close();

    super.dispose();
  }

  Future refreshingAllBogs() async {
    setState(() => isLoading = true);

    blogs = await BlogDatabaseHandler.instance.readAllBlogs();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Blogs',
            style: TextStyle(fontSize: 24),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.pink.shade900,
                ),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EditPage()),
                  );

                  refreshingAllBogs();
                },
                child: const Text(
                  'Add or Update Blog',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : blogs.isEmpty
                  ? const Text(
                      'No Blogs in the beginning...',
                      style: TextStyle(color: Colors.white, fontSize: 60),
                    )
                  : buildingAllBlogs(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          tooltip: 'Add or Update Blog',
          foregroundColor: Colors.white,
          backgroundColor: Colors.pink.shade900,
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EditPage()),
            );

            refreshingAllBogs();
          },
          label: const Text(
            'Add or Update Blog',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      );

  Widget buildingAllBlogs() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: blogs.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final blog = blogs[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailPage(blogId: blog.id!),
              ));

              refreshingAllBogs();
            },
            child: BlogCard(blog: blog, index: index),
          );
        },
      );
}
