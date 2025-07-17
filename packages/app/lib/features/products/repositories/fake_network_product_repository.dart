import 'dart:convert'; // Required for jsonDecode
import 'package:flutter/services.dart'; // Required for rootBundle

import 'package:app/features/products/data/models/product.dart';
import 'package:app/features/products/repositories/network_product_repository.dart';
import 'package:core/data/generics/links.dart';
import 'package:core/data/generics/meta.dart';
import 'package:core/data/generics/response.dart';
import 'package:dio/dio.dart';

///
/// This class mimics the behavior of the real network repository by returning
/// pre-defined mock data from a JSON file with a simulated network delay.
class FakeNetworkProductRepository implements NetworkProductRepository {
  /// A list of mock products loaded from the assets.
  List<Product> _mockProducts = [];

  /// Simulates a network delay.
  final Duration delay;

  FakeNetworkProductRepository({
    this.delay = const Duration(milliseconds: 800),
  });

  /// Loads and parses product data from the 'assets/products.json' file.
  /// This must be called before using the repository.
  Future<void> initialize() async {
    // Load the JSON string from the asset file
    final jsonString = await rootBundle.loadString('assets/products.json');
    // Decode the JSON string into a List<dynamic>
    final List<dynamic> jsonList = jsonDecode(jsonString);
    // Map the JSON list to a List<Product> using the fromJson factory
    _mockProducts = jsonList.map((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<PagedResponse<Product>> getProducts(
    int page, [
    int perPage = 10,
  ]) async {
    // Ensure data is loaded before proceeding
    if (_mockProducts.isEmpty) {
      await initialize();
    }
    await Future.delayed(delay);

    final int totalProducts = _mockProducts.length;
    final int totalPages = (totalProducts / perPage).ceil();

    if (page > totalPages) {
      return PagedResponse<Product>(
        [],
        Meta(
          currentPage: page,
          lastPage: totalPages,
          perPage: perPage,
          path: '/products',
          total: totalProducts,
        ),
        Links(
          first: '/products?page=1',
          last: '/products?page=$totalPages',
          prev: page > 1 ? '/products?page=${page - 1}' : null,
          next: null,
        ),
      );
    }

    final int startIndex = (page - 1) * perPage;
    final int endIndex =
        (startIndex + perPage > totalProducts)
            ? totalProducts
            : startIndex + perPage;

    final List<Product> pageData = _mockProducts.sublist(startIndex, endIndex);

    return PagedResponse<Product>(
      pageData,
      Meta(
        currentPage: page,
        from: startIndex + 1,
        to: endIndex,
        lastPage: totalPages,
        perPage: perPage,
        path: '/products',
        total: totalProducts,
      ),
      Links(
        first: '/products?page=1',
        last: '/products?page=$totalPages',
        prev: page > 1 ? '/products?page=${page - 1}' : null,
        next: page < totalPages ? '/products?page=${page + 1}' : null,
      ),
    );
  }

  @override
  Future<ObjectResponse<Product>> getById(String productId) async {
    // Ensure data is loaded before proceeding
    if (_mockProducts.isEmpty) {
      await initialize();
    }
    await Future.delayed(delay);

    final int? id = int.tryParse(productId);
    final product = _mockProducts.where((p) => p.id == id).firstOrNull;

    if (product != null) {
      return ObjectResponse<Product>(product);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: '/products/$productId'),
        response: Response(
          statusCode: 404,
          statusMessage: 'Not Found',
          requestOptions: RequestOptions(path: '/products/$productId'),
        ),
        error: 'Product not found',
        type: DioExceptionType.badResponse,
      );
    }
  }
}
