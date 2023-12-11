import 'dart:convert';

import 'package:flutter_sesi_10/data/models/add_category_request.dart';
import 'package:flutter_sesi_10/data/models/add_category_response.dart';
import 'package:flutter_sesi_10/data/models/category_response_model.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  Future<List<CategoryResponseModel>> getCategories() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/categories'),
    );
    if (response.statusCode == 200) {
      // Ubah dari Map<String, dynamic> menjadi List<dynamic>
      final List<dynamic> jsonResponse = json.decode(response.body);

      // Gunakan map untuk mengonversi setiap elemen dalam list menjadi CategoryResponseModel
      final List<CategoryResponseModel> categories = jsonResponse
          .map((categoryJson) => CategoryResponseModel.fromJson(categoryJson))
          .toList();

      return categories;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<AddCategoryResponse> addCategory(AddCategoryRequest data) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/categories/'),
      body: data.toJson(),
      headers: {
        'Content-type': 'application/json',
      },
    );

    return AddCategoryResponse.fromJson(response.body);
  }

  Future<bool> deleteCategory(int id) async {
    final response = await http.delete(
      Uri.parse('https://api.escuelajs.co/api/v1/categories/$id'),
    );
    if (response.statusCode == 200) {
      return response.body.toLowerCase() == 'true';
    } else {
      throw Exception('Failed to delete category');
    }
  }

  Future<AddCategoryResponse> updateCategory(
      int id, AddCategoryRequest data) async {
    final response = await http.put(
      Uri.parse('https://api.escuelajs.co/api/v1/categories/$id'),
      body: data.toJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return AddCategoryResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to update category');
    }
  }
}
