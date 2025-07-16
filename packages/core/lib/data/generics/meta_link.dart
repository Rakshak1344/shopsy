import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta_link.g.dart';

part 'meta_link.freezed.dart';

@freezed
sealed class MetaLink with _$MetaLink {
  factory MetaLink({
    String? url,
    required String label,
    required bool active,
  }) = _MetaLink;

  factory MetaLink.fromJson(Map<String, dynamic> json) =>
      _$MetaLinkFromJson(json);
}
