import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';

class EnableProductDetailsHydrationScreen extends StatefulWidget {
  const EnableProductDetailsHydrationScreen({Key? key}) : super(key: key);

  @override
  State<EnableProductDetailsHydrationScreen> createState() =>
      _EnableProductDetailsHydrationScreenState();
}

class _EnableProductDetailsHydrationScreenState
    extends State<EnableProductDetailsHydrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _enabled = HostAppService.getInstance().enableProductDetailsHydration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: '',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _enabled,
                onChanged: (value) {
                  setState(() {
                    _enabled = value ?? false;
                  });
                },
                title: const Text(
                  "Enable Product Details Hydration",
                ),
                subtitle: const Text(
                  "When enabled, uses local test data for product hydration instead of Shopify.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(S.of(context).cancel),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        HostAppService.getInstance()
                            .cacheProductDetailsHydration(_enabled);
                        if (_enabled) {
                          EasyLoading.showToast(
                              "Enable product details hydration successfully.");
                        } else {
                          EasyLoading.showToast(
                              "Disable product details hydration successfully.");
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(S.of(context).save),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
