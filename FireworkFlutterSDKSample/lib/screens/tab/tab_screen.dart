import 'dart:async';

import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/constants/fw_example_event_name.dart';
import 'package:fw_flutter_sdk_example/screens/cart/cart_screen.dart';
import 'package:fw_flutter_sdk_example/screens/feed_layouts/feed_layouts_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/more_screen.dart';
import 'package:fw_flutter_sdk_example/screens/shopping/shopping_screen.dart';
import 'package:fw_flutter_sdk_example/states/tab_index_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../utils/fw_example_logger_util.dart';
import '../../utils/host_app_shopping_service.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _children = [
    const ShoppingScreen(),
    const CartScreen(),
    const FeedLayoutsScreen(),
    const MoreScreen(),
  ];
  int _cartItemCount = 0;
  StreamSubscription? _cartItemCountUpdateEventSubscription;

  @override
  void initState() {
    super.initState();

    _initCartItems();
  }

  @override
  void dispose() {
    _cartItemCountUpdateEventSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initCartItems() async {
    final cartItems =
        await HostAppShoppingService.getInstance().getAllCartItems();
    // sync cart items count to FireworkSDK
    FireworkSDK.getInstance().shopping.setCartItemCount(cartItems.length);
    setState(() {
      _cartItemCount = cartItems.length;
    });

    _cartItemCountUpdateEventSubscription =
        FWEventBus.getInstance().on().listen((event) {
      FWExampleLoggerUtil.log(
          "_TabScreenState eventName ${event.eventName} event.arguments ${event.arguments}");
      if (event.eventName == FWExampleEventName.cartItemCountUpdateEvent &&
          event.arguments != null) {
        final arguments = event.arguments!;
        if (arguments["count"] is int) {
          setState(() {
            _cartItemCount = arguments["count"] as int;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<TabIndexState>().tabIndex.index;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag),
            label: S.of(context).shopping,
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (_cartItemCount > 0)
                  const Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Icon(
                      Icons.brightness_1,
                      size: 10.0,
                      color: Colors.red,
                    ),
                  )
              ],
            ),
            label: S.of(context).cartPage,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.grid_view),
            label: S.of(context).feedLayouts,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.more_horiz),
            label: S.of(context).more,
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index < TabIndex.values.length) {
      context.read<TabIndexState>().tabIndex = TabIndex.values[index];
    }
  }
}
