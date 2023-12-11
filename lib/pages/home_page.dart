import 'package:flutter/material.dart';
import 'package:flutter_sesi_10/pages/detail_category_page.dart';

import '../data/datasources/category_remote_datasource.dart';
import '../data/models/category_response_model.dart';
import 'add_category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<CategoryResponseModel> categories = [];

  Future<void> getCategories() async {
    setState(() {
      isLoading = true;
    });

    final List<CategoryResponseModel> model =
        await CategoryRemoteDatasource().getCategories();
    setState(() {
      categories = model;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Category',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blueGrey[200],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DetailCategoryPage(
                          category: category,
                        );
                      },
                    ));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(category.name),
                      subtitle: Image.network(
                        category.image,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              itemCount: categories.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddCategoryPage();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
