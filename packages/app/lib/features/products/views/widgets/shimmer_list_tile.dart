import 'package:core/ui/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerListTile extends StatelessWidget {
  final double avatarSize;
  final double titleWidth;
  final double subtitleWidth;
  final double trailingWidth;

  const ShimmerListTile({
    super.key,
    this.avatarSize = 48.0,
    this.titleWidth = 120.0,
    this.subtitleWidth = 80.0,
    this.trailingWidth = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ShimmerWidget.circular(
        height: avatarSize,
        width: avatarSize,
      ),
      title: ShimmerWidget.rectangular(
        height: 12.0,
        width: titleWidth,
      ),
      subtitle: ShimmerWidget.rectangular(
        height: 12.0,
        width: subtitleWidth,
      ),
      trailing: ShimmerWidget.rectangular(
        height: 12.0,
        width: trailingWidth,
      ),
    );
  }
}
