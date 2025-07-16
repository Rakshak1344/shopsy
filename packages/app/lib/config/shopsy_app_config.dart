import 'package:app/config/observer.dart';
import 'package:app/storage/hive/hive_helper.dart';
import 'package:app/storage/hive/hive_preference.dart';
import 'package:core/arch/app_config.dart';
import 'package:core/arch/storage/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ShopsyAppConfig extends AppConfig {
  late HivePreference hivePreferencesInstance;

  @override
  Future<void> initDependencies() async {
    await HiveHelper.init();
    hivePreferencesInstance = await HivePreference.getInstance();
  }

  @override
  FutureOr<Widget> onInit({required Widget child}) {
    return child;
  }

  @override
  FutureOr<List<Override>> overrides() async {
    return [
      preferenceProvider.overrideWithValue(hivePreferencesInstance),
      // networkCategoriesRepositoryProvider.overrideWithValue(
      //   FakeNetworkCategoriesRepository(),
      // ),
    ];
  }

  @override
  FutureOr<List<ProviderObserver>> observers() {
    return [ObserverState()];
  }
}
