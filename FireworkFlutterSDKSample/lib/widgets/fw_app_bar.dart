import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

AppBar fwAppBar({
  required BuildContext context,
  String? titleText,
  Widget? title,
  List<Widget>? actions,
  bool? isNewContainer,
}) {
  bool canPop = Navigator.of(context).canPop();

  return AppBar(
    centerTitle: true,
    title: title ?? Text(titleText ?? ""),
    actions: actions,
    automaticallyImplyLeading: false,
    leading: isNewContainer == true || canPop
        ? IconButton(
            onPressed: () {
              if (isNewContainer == true) {
                // we need to use popNativeContainer if isNewContainer equal to true
                FireworkSDK.getInstance().navigator.popNativeContainer();
              } else {
                Navigator.of(context).maybePop();
              }
            },
            icon: const Icon(Icons.arrow_back),
          )
        : null,
  );
}
