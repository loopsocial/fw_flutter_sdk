import 'package:flutter/material.dart';

enum TabIndex {
  shopping,
  cart,
  feedLayouts,
  more,
}

class TabIndexState extends ChangeNotifier {
  TabIndex _tabIndex = TabIndex.shopping;

  TabIndex get tabIndex => _tabIndex;

  set tabIndex(TabIndex tabIndex) {
    _tabIndex = tabIndex;
    notifyListeners();
  }
}
