import 'package:flutter/material.dart';

AppBar fwAppBar({
  required BuildContext context,
  String? titleText,
  Widget? title,
  List<Widget>? actions,
}) {
  bool canPop = Navigator.of(context).canPop();

  return AppBar(
    centerTitle: true,
    title: title ?? Text(titleText ?? ""),
    actions: actions,
    automaticallyImplyLeading: false,
    leading: canPop
        ? Semantics(
              label: 'Back',
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                icon: const Icon(Icons.arrow_back),
              )
          )
        : null,
  );
}
