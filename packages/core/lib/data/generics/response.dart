import 'package:core/data/generics/links.dart';
import 'package:core/data/generics/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

// ignore_for_file: avoid_annotating_with_dynamic
@JsonSerializable(genericArgumentFactories: true)
class ObjectResponse<T> {
  final T data;

  ObjectResponse(this.data);

  factory ObjectResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$ObjectResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) =>
      _$ObjectResponseToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class CollectionResponse<T> {
  final List<T> data;

  CollectionResponse(this.data);

  factory CollectionResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$CollectionResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) =>
      _$CollectionResponseToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class PagedResponse<T> {
  final List<T> data;
  final Meta meta;
  final Links links;

  PagedResponse(
    this.data,
    this.meta,
    this.links,
  );

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$PagedResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) =>
      _$PagedResponseToJson(this, toJsonT);
}
