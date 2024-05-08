import 'dart:async';

import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/constants/fw_example_event_name.dart';
import 'package:fw_flutter_sdk_example/screens/cart/cart_screen.dart';
import 'package:fw_flutter_sdk_example/screens/feed_layouts/feed_layouts_screen.dart';
import 'package:fw_flutter_sdk_example/screens/more/more_screen.dart';
import 'package:fw_flutter_sdk_example/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../utils/fw_example_logger_util.dart';
import '../../utils/host_app_service.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> _children = [
    const HomeScreen(),
    const FeedLayoutsScreen(),
    const MoreScreen(),
  ];
  int _cartItemCount = 0;
  StreamSubscription? _cartItemCountUpdateEventSubscription;
  bool _showCart = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    FWExampleLoggerUtil.log('_TabScreenState initState');
    Future.microtask(() {
      _initCartInfo();
    });
  }

  @override
  void dispose() {
    _cartItemCountUpdateEventSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initCartInfo() async {
    final showCart = await HostAppService.getInstance().shouldShowCart();
    if (mounted) {
      setState(() {
        _showCart = showCart;
        if (showCart) {
          _children = [
            const HomeScreen(),
            const CartScreen(),
            const FeedLayoutsScreen(),
            const MoreScreen(),
          ];
        }
      });
    }

    if (showCart) {
      final cartItems = await HostAppService.getInstance().getAllCartItems();
      // sync cart items count to FireworkSDK
      FireworkSDK.getInstance().shopping.setCartItemCount(cartItems.length);
      if (mounted) {
        setState(() {
          _cartItemCount = cartItems.length;
        });
      }

      _cartItemCountUpdateEventSubscription =
          FWEventBus.getInstance().on().listen((event) {
        FWExampleLoggerUtil.log(
            "_TabScreenState eventName ${event.eventName} event.arguments ${event.arguments}");
        if (event.eventName == FWExampleEventName.cartItemCountUpdateEvent &&
            event.arguments != null) {
          final arguments = event.arguments!;
          if (arguments["count"] is int && mounted) {
            setState(() {
              _cartItemCount = arguments["count"] as int;
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).home,
          ),
          if (_showCart)
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/log");
        },
        child: Text(
          S.of(context).log,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
