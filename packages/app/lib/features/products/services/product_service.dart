import 'package:app/features/products/data/models/product.dart';
import 'package:app/features/products/repositories/local_product_repository.dart';
import 'package:app/features/products/repositories/network_product_repository.dart';
import 'package:core/error/no_more_data_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_service.g.dart';

@Riverpod(keepAlive: true)
ProductService productService(Ref ref) {
  return ProductService(ref);
}

class ProductService {
  final Ref ref;
  final NetworkProductRepository _networkProductRepository;
  final LocalProductRepository _localProductRepository;

  ProductService(this.ref)
    : _networkProductRepository = ref.read(networkProductRepositoryProvider),
      _localProductRepository = ref.read(localProductRepositoryProvider);

  Stream<List<Product>> watch() => _localProductRepository.watch();

  Stream<Product> fetchProductById(int id) {
    _networkProductRepository
        .getById(id.toString())
        .then((response) => _localProductRepository.save([response.data]));

    return _localProductRepository.getById(id);
  }



  Future<void> getProducts(int page, [int perPage = 20]) async {
    var response = await _networkProductRepository.getProducts(page, perPage);

    if (page == 1) {
      await _localProductRepository.deleteAll();
    }

    await _localProductRepository.save(response.data);

    if (response.meta.currentPage == response.meta.lastPage) {
      throw NoMoreDataException();
    }
  }
}
