import 'package:flutter/material.dart';
import 'package:flutter_sesi_10/data/datasources/category_remote_datasource.dart';
import 'package:flutter_sesi_10/data/models/add_category_request.dart';
import 'package:flutter_sesi_10/data/models/category_response_model.dart';
import 'package:flutter_sesi_10/pages/home_page.dart';

class EditCategoryPage extends StatefulWidget {
  final CategoryResponseModel category;
  const EditCategoryPage({
    super.key,
    required this.category,
  });

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final namecontroller = TextEditingController();
  final imagecontroller = TextEditingController();

  @override
  void initState() {
    namecontroller.text = widget.category.name;
    imagecontroller.text = widget.category.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Category',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          TextField(
            // controller: namecontroller,
            decoration: const InputDecoration(
              hintText: 'Category Name',
              border: OutlineInputBorder(),
            ),
            controller: namecontroller,
          ),
          const SizedBox(height: 16),
          TextField(
            // controller: imagecontroller,
            decoration: const InputDecoration(
              hintText: 'Image Url',
              border: OutlineInputBorder(),
            ),
            controller: imagecontroller,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final newModel = AddCategoryRequest(
                name: namecontroller.text,
                image: imagecontroller.text,
              );
              await CategoryRemoteDatasource()
                  .updateCategory(widget.category.id, newModel);
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ),
              );
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}
