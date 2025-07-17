import 'dart:async';

import 'package:app/features/cart/data/models/cart_item.dart';
import 'package:collection/collection.dart';
import 'package:core/arch/repository.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_cart_item_repository.g.dart';

@riverpod
LocalCartItemRepository localCartItemRepository(Ref ref) {
  return LocalCartItemRepository(ref);
}

class LocalCartItemRepository extends CollectionRepository<CartItem> {
  final Ref ref;

  LocalCartItemRepository(this.ref);

  Preferences get sharedPreferences => ref.read(preferenceProvider);

  late final _controller = StreamController<List<CartItem>>();
  late final _stream = _controller.stream.asBroadcastStream();

  @override
  Future<void> save(List<CartItem> data) async {
    var cartItems = get();

    cartItems = {...cartItems, ...data}.toList();
    cartItems.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    await sharedPreferences.setValue<List<CartItem>>(
      'cartItems',
      data.cast<CartItem>(),
    );
  }

  // saveOne
  Future<void> saveOne(CartItem data) async {
    var cartItems = get();
    final index = cartItems.indexWhere(
      (item) => item.productId == data.productId,
    );

    if (index != -1) {
      cartItems[index] = data;
    } else {
      cartItems.add(data);
    }

    await sharedPreferences.setValue<List<CartItem>>(
      'cartItems',
      cartItems.cast<CartItem>(),
    );
  }

  @override
  Stream<List<CartItem>> watch() {
    sharedPreferences.watchValue<List<CartItem>>('cartItems').listen((
      List<CartItem>? event,
    ) {
      if (event != null) {
        _controller.add(event);
      }
    });

    _controller.add(get());

    return _stream;
  }

  @override
  List<CartItem> get() {
    var cartItems = sharedPreferences.getValue<List>('cartItems') ?? [];

    return cartItems.cast();
  }

  CartItem? getByProductId(int productId) {
    var cartItems = sharedPreferences.getValue<List>('cartItems') ?? [];
    var cartItemList = cartItems.cast();
    return cartItemList.firstWhereOrNull((item) => item.productId == productId);
  }

  @override
  Future<void> delete(CartItem? data) async {
    var cartItems = get();
    if (cartItems.isEmpty) {
      return;
    }

    cartItems.removeWhere((cartItem) => cartItem.productId == data!.productId);
    save(cartItems);
  }

  @override
  Future<void> deleteAll() async {
    await sharedPreferences.remove('cartItems');
  }
}
