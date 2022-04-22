import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/states/product_info_view_configuration_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class CartConfigurationScreen extends StatefulWidget {
  const CartConfigurationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartConfigurationScreenState createState() =>
      _CartConfigurationScreenState();
}

class _CartConfigurationScreenState extends State<CartConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _resultShowCartIcon = true;
  AddToCartButtonConfiguration _initAddToCartConfig =
      AddToCartButtonConfiguration();
  AddToCartButtonConfiguration _resultAddToCartConfig =
      AddToCartButtonConfiguration();

  @override
  void initState() {
    super.initState();
    _resultShowCartIcon = FireworkSDK.getInstance().shopping.cartIconVisible;

    _initAddToCartConfig = context
            .read<ProductInfoViewConfigurationState>()
            .productInfoViewConfiguration
            .addToCartButton ??
        AddToCartButtonConfiguration();
    _resultAddToCartConfig = _initAddToCartConfig;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).cartConfiguration,
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
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildAddToCartButtonBackgroundColor(context),
            const SizedBox(
              height: 20,
            ),
            _buildAddToCartButtonTextColor(context),
            const SizedBox(
              height: 20,
            ),
            _buildAddToCartButtonFontSize(context),
            const SizedBox(
              height: 20,
            ),
            _buildCartIconButtonShow(context),
            const SizedBox(
              height: 20,
            ),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButtonBackgroundColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).addToCartButtonBackgroundColor),
        FWTextFormField(
          initialValue: _initAddToCartConfig.backgroundColor,
          hintText: S.of(context).backgroundColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultAddToCartConfig.backgroundColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildAddToCartButtonTextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).addToCartButtonTextColor),
        FWTextFormField(
          initialValue: _initAddToCartConfig.textColor,
          hintText: S.of(context).addToCartButtonTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultAddToCartConfig.textColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildAddToCartButtonFontSize(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).addToCartButtonTextColor),
        FWTextFormField(
          initialValue: _initAddToCartConfig.fontSize?.toStringAsFixed(0),
          hintText: S.of(context).titleFontSizeHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 8,
              max: 30,
              errorMessage: S.of(context).fontSizeError,
              rangeErrorMessage: S.of(context).fontSizeRangeError,
            );
          },
          onSaved: (text) {
            _initAddToCartConfig.fontSize =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildButtonList(BuildContext context) {
    return Row(children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            S.of(context).cancel,
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context
                  .read<ProductInfoViewConfigurationState>()
                  .productInfoViewConfiguration = ProductInfoViewConfiguration(
                addToCartButton: _resultAddToCartConfig,
              );
              FireworkSDK.getInstance().shopping.cartIconVisible =
                  _resultShowCartIcon;
              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
            }
          },
          child: Text(
            S.of(context).use,
          ),
        ),
      ),
    ]);
  }

  Widget _buildCartIconButtonShow(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultShowCartIcon,
      onChanged: (value) {
        setState(() {
          _resultShowCartIcon = value ?? true;
        });
      },
      title: Text(
        S.of(context).showCartIcon,
      ),
    );
  }
}
