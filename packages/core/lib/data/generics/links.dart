import 'package:freezed_annotation/freezed_annotation.dart';

part 'links.g.dart';

part 'links.freezed.dart';

@freezed
sealed class Links with _$Links {
  factory Links({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) = _Links;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
}
