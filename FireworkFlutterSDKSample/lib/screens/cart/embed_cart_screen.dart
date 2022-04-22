import 'dart:async';

import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/models/cart_item.dart';
import 'package:fw_flutter_sdk_example/screens/cart/widgets/cart_widget.dart';
import 'package:fw_flutter_sdk_example/utils/fw_example_logger_util.dart';
import 'package:flutter/material.dart';
import '../../constants/fw_example_event_name.dart';
import '../../generated/l10n.dart';
import '../../utils/host_app_shopping_service.dart';
import '../../widgets/fw_app_bar.dart';

class EmbedCartScreen extends StatefulWidget {
  const EmbedCartScreen({Key? key}) : super(key: key);

  @override
  _EmbedCartScreenState createState() => _EmbedCartScreenState();
}

class _EmbedCartScreenState extends State<EmbedCartScreen> {
  List<CartItem> _cartItemList = [];
  StreamSubscription? _cartItemCountUpdateEventSubscription;

  @override
  void initState() {
    super.initState();
    _syncCartItems();
    _cartItemCountUpdateEventSubscription =
        FWEventBus.getInstance().on().listen((event) {
      FWExampleLoggerUtil.log(
          "_EmbedCartScreenState eventName ${event.eventName} event.arguments ${event.arguments}");
      if (event.eventName == FWExampleEventName.cartItemCountUpdateEvent) {
        _syncCartItems();
      }
    });
  }

  @override
  void dispose() {
    _cartItemCountUpdateEventSubscription?.cancel();
    super.dispose();
  }

  Future<void> _syncCartItems() async {
    final cartItemList =
        await HostAppShoppingService.getInstance().getAllCartItems();
    FWExampleLoggerUtil.log(
        '_EmbedCartScreenState _cartItemList $cartItemList');
    setState(() {
      _cartItemList = cartItemList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: fwAppBar(
            context: context,
            titleText: S.of(context).cartPage,
            leading: IconButton(
              onPressed: () {
                FireworkSDK.getInstance().shopping.exitCartPage();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: CartWidget(
            cartItemList: _cartItemList,
            onCheckout: _handleCheckout,
          ),
        ),
        onWillPop: () async {
          return true;
        });
  }

  void _handleCheckout() async {
    Navigator.of(context).pushNamed("/checkout");
  }
}
