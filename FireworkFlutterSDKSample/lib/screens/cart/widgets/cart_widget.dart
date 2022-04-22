import 'package:fw_flutter_sdk_example/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../generated/l10n.dart';

class CartWidget extends StatefulWidget {
  final List<CartItem> cartItemList;
  final VoidCallback onCheckout;

  const CartWidget({
    Key? key,
    required this.cartItemList,
    required this.onCheckout,
  }) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final widgetList = widget.cartItemList.map((e) {
      return _buildCartItemWidget(
        context: context,
        item: e,
      );
    }).toList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            children: [
              for (var w in widgetList) w,
            ],
          ),
        ),
        _buildCheckoutButton(context),
      ],
    );
  }

  Widget _buildCartItemWidget({
    required BuildContext context,
    required CartItem item,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: item.imageURL ?? "",
            width: 80,
            height: 80,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.title ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  item.subTitle ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 110, 109, 109),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: widget.onCheckout,
        child: Text(
          S.of(context).checkout,
        ),
      ),
    );
  }
}
