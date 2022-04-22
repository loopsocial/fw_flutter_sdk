import 'package:flutter/material.dart';

AppBar fwAppBar({
  required BuildContext context,
  String? titleText,
  Widget? title,
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    centerTitle: true,
    title: title ?? Text(titleText ?? ""),
    actions: actions,
    leading: leading,
    automaticallyImplyLeading: leading != null ? false : true,
  );
}
