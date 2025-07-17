import 'package:app/features/products/data/models/product.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductListTile extends StatelessWidget {
  final Product product;

  const ProductListTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildAvatar(),
      dense: true,
      onTap: () => onTileTap(context),
      isThreeLine: true,
      visualDensity: VisualDensity.compact,
      minVerticalPadding: 8,
      title: buildTitle(context),
      subtitle: buildSubtitle(context),
    );
  }

  void onTileTap(BuildContext context) {
    context.goNamed(
      AppRouteName.productDetail,
      pathParameters: {'productId': product.id.toString()},
    );
  }

  // Map<String, String> getSenderFormat() {
  //   var sender = product.senderName;
  //   var receivedFrom = "receivedFrom".tr(args: [sender]);
  //   var splitString = receivedFrom.split(sender);
  //   var beforeSender = splitString[0];
  //   var afterSender = splitString[1];
  //
  //   return {"before": beforeSender, "after": afterSender};
  // }

  Widget buildTitle(BuildContext context) {
    return Text(
      product.name,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900),
    );
  }

  Widget buildSubtitle(BuildContext context) {
    var subtitleStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: const Color(0xff9791a8));

    return Text(product.description, style: subtitleStyle);
  }

  CircleAvatar buildAvatar() {
    return CircleAvatar(radius: 18, child: Text(product.name[0]));
  }
}
