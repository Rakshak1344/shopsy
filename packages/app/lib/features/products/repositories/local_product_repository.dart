import 'dart:async';

import 'package:app/features/products/data/models/product.dart';
import 'package:collection/collection.dart';
import 'package:core/arch/repository.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_product_repository.g.dart';

@riverpod
LocalProductRepository localProductRepository(Ref ref) {
  return LocalProductRepository(ref);
}

class LocalProductRepository extends CollectionRepository<Product> {
  final Ref ref;

  LocalProductRepository(this.ref);

  Preferences get sharedPreferences => ref.read(preferenceProvider);

  late final _controller = StreamController<List<Product>>();
  late final _stream = _controller.stream.asBroadcastStream();

  @override
  Future<void> save(List<Product> data) async {
    var products = get();

    products = {...data, ...products}.toList();

    await sharedPreferences.setValue<List<Product>>(
      'products',
      data.cast<Product>(),
    );
  }

  @override
  Stream<List<Product>> watch() {
    sharedPreferences.watchValue<List<Product>>('products').listen((
      List<Product>? event,
    ) {
      if (event != null) {
        _controller.add(event);
      }
    });

    _controller.add(get());

    return _stream;
  }

  Stream<Product> getById(int id) {
    return _stream.transform(
      StreamTransformer<List<Product>, Product>.fromHandlers(
        handleData: (data, sink) {
          var transaction = data.firstWhereOrNull(
            (element) => element.id == id,
          );
          sink.add(transaction!);
        },
      ),
    );
  }

  @override
  List<Product> get() {
    var products = sharedPreferences.getValue<List>('products') ?? [];

    return products.cast();
  }

  @override
  Future<void> delete(Product? data) async {
    var products = get();
    if (products.isEmpty) {
      return;
    }

    products.remove(data);
  }

  @override
  Future<void> deleteAll() async {
    await sharedPreferences.remove('products');
  }
}
