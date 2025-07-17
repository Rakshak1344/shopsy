import 'package:app/config/network_config.dart';
import 'package:app/features/products/data/models/product.dart';
import 'package:core/data/generics/response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_product_repository.g.dart';

@riverpod
NetworkProductRepository networkProductRepository(Ref ref) {
  return NetworkProductRepository(ref.read(dioProvider));
}

@RestApi()
abstract class NetworkProductRepository {
  factory NetworkProductRepository(Dio dio, {String baseUrl}) =
      _NetworkProductRepository;

  @GET('/products')
  Future<PagedResponse<Product>> getProducts(
    @Query('page') int page, [
    @Query('per_page') int perPage = 10,
  ]);

  @GET('/products/{productId}')
  Future<ObjectResponse<Product>> getById(@Path('productId') String productId);
}
