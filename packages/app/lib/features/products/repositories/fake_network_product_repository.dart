import 'package:app/features/products/data/models/product.dart';
import 'package:app/features/products/repositories/network_product_repository.dart';
import 'package:core/data/generics/links.dart';
import 'package:core/data/generics/meta.dart';
import 'package:core/data/generics/response.dart';
import 'package:dio/dio.dart';

///
/// This class mimics the behavior of the real network repository by returning
/// pre-defined mock data with a simulated network delay.
class FakeNetworkProductRepository implements NetworkProductRepository {

  /// A list of mock products to serve.
  final List<Product> _mockProducts = List.generate(
    25,
    (i) => Product(
      id: i + 1,
      name: 'Product ${i + 1}',
      description:
          'This is a detailed and engaging description for mock product number ${i + 1}.',
      imageUrl: 'https://picsum.photos/id/${i + 1}/600/400',
      availableQuantity: (i + 1) * 5,
      price: 19.99 * (i + 1), // Added the new price field
    ),
  );

  /// Simulates a network delay.
  final Duration delay;

  FakeNetworkProductRepository({
    this.delay = const Duration(milliseconds: 800),
  });

  @override
  Future<PagedResponse<Product>> getProducts(
    int page, [
    int perPage = 10,
  ]) async {
    await Future.delayed(delay);

    final int totalProducts = _mockProducts.length;
    final int totalPages = (totalProducts / perPage).ceil();

    // Simulate reaching the end of the data
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

    // Calculate the start and end index for the current page
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
    await Future.delayed(delay);

    final int? id = int.tryParse(productId);
    final product = _mockProducts.where((p) => p.id == id).firstOrNull;

    if (product != null) {
      // Simulate a successful response
      return ObjectResponse<Product>(product);
    } else {
      // Simulate a "404 Not Found" error, which is what a real API would do.
      // This makes your error handling logic in the app testable.
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
