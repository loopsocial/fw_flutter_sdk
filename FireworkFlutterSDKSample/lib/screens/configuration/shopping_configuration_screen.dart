import 'package:flutter/cupertino.dart';
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';

import '../../generated/l10n.dart';
import '../../utils/validation_util.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class ShoppingConfigurationScreen extends StatefulWidget {
  const ShoppingConfigurationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShoppingConfigurationScreen> createState() =>
      _ShoppingConfigurationScreenState();
}

class _ShoppingConfigurationScreenState
    extends State<ShoppingConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _resultShowCartIcon = true;
  ShoppingCTAButtonConfiguration _initShoppingCTAButtonConfig =
      ShoppingCTAButtonConfiguration();
  ShoppingCTAButtonConfiguration _resultShoppingCTAButtonConfig =
      ShoppingCTAButtonConfiguration();
  LinkButtonConfiguration _resultLinkButtonConfig = LinkButtonConfiguration();
  ProductCardConfiguration _initProductCardConfig = ProductCardConfiguration();
  ProductCardConfiguration _resultProductCardConfig =
      ProductCardConfiguration();
  bool _resultCustomizeLinkButtonHandler = false;
  bool _resultCustomizeTapProductCardHandler = false;

  @override
  void initState() {
    super.initState();
    _resultShowCartIcon = FireworkSDK.getInstance().shopping.cartIconVisible;

    _initShoppingCTAButtonConfig = FireworkSDK.getInstance()
            .shopping
            .productInfoViewConfiguration
            ?.ctaButton ??
        ShoppingCTAButtonConfiguration();
    _resultShoppingCTAButtonConfig = _initShoppingCTAButtonConfig;
    _resultLinkButtonConfig = FireworkSDK.getInstance()
            .shopping
            .productInfoViewConfiguration
            ?.linkButton ??
        LinkButtonConfiguration();
    _initProductCardConfig = FireworkSDK.getInstance()
            .shopping
            .productInfoViewConfiguration
            ?.productCard ??
        ProductCardConfiguration();
    _resultProductCardConfig = FireworkSDK.getInstance()
            .shopping
            .productInfoViewConfiguration
            ?.productCard ??
        ProductCardConfiguration();
    _resultCustomizeLinkButtonHandler =
        FireworkSDK.getInstance().shopping.onCustomClickLinkButton != null;
    _resultCustomizeTapProductCardHandler =
        FireworkSDK.getInstance().shopping.onCustomTapProductCard != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fwAppBar(
        context: context,
        titleText: S.of(context).shoppingConfiguration,
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
            _buildShoppingCTAButtonTextSegmentedControl(context),
            const SizedBox(
              height: 20,
            ),
            _buildProductCardCTAButtonTextSegmentedControl(context),
            const SizedBox(
              height: 20,
            ),
            _buildProductCardThemeSegmentedControl(context),
            const SizedBox(
              height: 20,
            ),
            _buildProductCardCornerRadius(context),
            const SizedBox(
              height: 20,
            ),
            _buildProductCardPriceHidden(context),
            const SizedBox(
              height: 20,
            ),
            _buildProductCardCTAButtonHidden(context),
            const SizedBox(
              height: 20,
            ),
            _buildShoppingCTAButtonBackgroundColor(context),
            const SizedBox(
              height: 20,
            ),
            _buildShoppingCTAButtonTextColor(context),
            const SizedBox(
              height: 20,
            ),
            _buildShoppingCTAButtonFontSize(context),
            const SizedBox(
              height: 20,
            ),
            _buildUseIOSFontInfo(context),
            const SizedBox(
              height: 20,
            ),
            _buildCartIconButtonShow(context),
            const SizedBox(
              height: 20,
            ),
            _buildLinkButtonHidden(context),
            const SizedBox(
              height: 20,
            ),
            _buildCustomizeLinkButtonHandler(context),
            const SizedBox(
              height: 20,
            ),
            _buildCustomizeTapProductCardHandler(context),
            const SizedBox(
              height: 20,
            ),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildShoppingCTAButtonTextSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).shoppingCTAButtonText),
        const SizedBox(
          height: 20,
        ),
        CupertinoSegmentedControl<ShoppingCTAButtonText>(
          onValueChanged: (value) {
            setState(() {
              _resultShoppingCTAButtonConfig.text = value;
            });
          },
          children: {
            ShoppingCTAButtonText.addToCart: Text(
              S.of(context).addToCart,
              style: const TextStyle(fontSize: 13),
            ),
            ShoppingCTAButtonText.shopNow: Text(
              S.of(context).shopNow,
              style: const TextStyle(fontSize: 13),
            ),
          },
          groupValue: _resultShoppingCTAButtonConfig.text ??
              ShoppingCTAButtonText.addToCart,
        ),
      ],
    );
  }

  Widget _buildProductCardCTAButtonTextSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardCTAButtonText),
        const SizedBox(
          height: 20,
        ),
        CupertinoSegmentedControl<ProductCardCTAButtonText>(
          onValueChanged: (value) {
            setState(() {
              _resultProductCardConfig.ctaButtonText = value;
            });
          },
          children: {
            ProductCardCTAButtonText.shopNow: Text(
              S.of(context).shopNow,
              style: const TextStyle(fontSize: 13),
            ),
            ProductCardCTAButtonText.buyNow: Text(
              S.of(context).buyNow,
              style: const TextStyle(fontSize: 13),
            ),
          },
          groupValue: _resultProductCardConfig.ctaButtonText ??
              ProductCardCTAButtonText.shopNow,
        ),
      ],
    );
  }

  Widget _buildProductCardThemeSegmentedControl(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardTheme),
        const SizedBox(
          height: 20,
        ),
        CupertinoSegmentedControl<ProductCardTheme>(
          onValueChanged: (value) {
            setState(() {
              _resultProductCardConfig.theme = value;
            });
          },
          children: {
            ProductCardTheme.dark: Text(
              S.of(context).dark,
              style: const TextStyle(fontSize: 13),
            ),
            ProductCardTheme.light: Text(
              S.of(context).light,
              style: const TextStyle(fontSize: 13),
            ),
          },
          groupValue: _resultProductCardConfig.theme ?? ProductCardTheme.dark,
        ),
      ],
    );
  }

  Widget _buildProductCardCornerRadius(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardCornerRadius),
        FWTextFormField(
          initialValue: _initProductCardConfig.cornerRadius?.toStringAsFixed(0),
          hintText: S.of(context).cornerRadiusHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 0,
              max: 50,
              errorMessage: S.of(context).cornerRadiusError,
              rangeErrorMessage: S.of(context).cornerRadiusRangeError,
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.cornerRadius =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildProductCardPriceHidden(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultProductCardConfig.priceConfiguration?.isHidden ?? false,
      onChanged: (value) {
        setState(() {
          _resultProductCardConfig.priceConfiguration ??=
              ProductCardPriceConfiguration();
          _resultProductCardConfig.priceConfiguration?.isHidden = value;
        });
      },
      title: Text(
        S.of(context).hideProductCardPrice,
      ),
    );
  }

  Widget _buildProductCardCTAButtonHidden(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultProductCardConfig.isCtaButtonHidden ?? false,
      onChanged: (value) {
        setState(() {
          _resultProductCardConfig.isCtaButtonHidden = value;
        });
      },
      title: Text(
        S.of(context).hideProductCardCtaButton,
      ),
    );
  }

  Widget _buildShoppingCTAButtonBackgroundColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).shoppingCTAButtonBackgroundColor),
        FWTextFormField(
          initialValue: _initShoppingCTAButtonConfig.backgroundColor,
          hintText: S.of(context).backgroundColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultShoppingCTAButtonConfig.backgroundColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildShoppingCTAButtonTextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).shoppingCTAButtonTextColor),
        FWTextFormField(
          initialValue: _initShoppingCTAButtonConfig.textColor,
          hintText: S.of(context).shoppingCTAButtonTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultShoppingCTAButtonConfig.textColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildShoppingCTAButtonFontSize(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).shoppingCTAButtonFontSize),
        FWTextFormField(
          initialValue:
              _initShoppingCTAButtonConfig.fontSize?.toStringAsFixed(0) ?? '16',
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
            _initShoppingCTAButtonConfig.fontSize =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
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

  Widget _buildUseIOSFontInfo(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultShoppingCTAButtonConfig.iOSFontInfo != null,
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _resultShoppingCTAButtonConfig.iOSFontInfo = IOSFontInfo(
              fontName: "TimesNewRomanPS-ItalicMT",
            );
          } else {
            _resultShoppingCTAButtonConfig.iOSFontInfo = null;
          }
        });
      },
      title: Text(
        S.of(context).useIOSFontInfo,
      ),
    );
  }

  Widget _buildLinkButtonHidden(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultLinkButtonConfig.isHidden ?? false,
      onChanged: (value) {
        setState(() {
          _resultLinkButtonConfig.isHidden = value;
          if (_resultLinkButtonConfig.isHidden == true) {
            _resultCustomizeLinkButtonHandler = false;
          }
        });
      },
      title: Text(
        S.of(context).hideLinkButton,
      ),
    );
  }

  Widget _buildCustomizeLinkButtonHandler(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultCustomizeLinkButtonHandler,
      onChanged: (value) {
        setState(() {
          _resultCustomizeLinkButtonHandler = value ?? false;
          if (_resultCustomizeLinkButtonHandler) {
            _resultLinkButtonConfig.isHidden = false;
          }
        });
      },
      title: Text(
        S.of(context).customizeLinkButtonHandler,
      ),
    );
  }

  Widget _buildCustomizeTapProductCardHandler(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultCustomizeTapProductCardHandler,
      onChanged: (value) {
        setState(() {
          _resultCustomizeTapProductCardHandler = value ?? false;
        });
      },
      title: Text(
        S.of(context).enableCustomTapProductCard,
      ),
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
              FireworkSDK.getInstance().shopping.productInfoViewConfiguration =
                  ProductInfoViewConfiguration(
                ctaButton: _resultShoppingCTAButtonConfig,
                linkButton: _resultLinkButtonConfig,
                productCard: _resultProductCardConfig,
              );
              FireworkSDK.getInstance().shopping.cartIconVisible =
                  _resultShowCartIcon;
              if (_resultShoppingCTAButtonConfig.text ==
                  ShoppingCTAButtonText.shopNow) {
                FireworkSDK.getInstance().shopping.onShoppingCTA =
                    HostAppService.getInstance().onShopNow;
              } else {
                FireworkSDK.getInstance().shopping.onShoppingCTA =
                    HostAppService.getInstance().onAddToCart;
              }
              if (_resultCustomizeLinkButtonHandler) {
                FireworkSDK.getInstance().shopping.onCustomClickLinkButton =
                    HostAppService.getInstance().onCustomClickLinkButton;
              } else {
                FireworkSDK.getInstance().shopping.onCustomClickLinkButton =
                    null;
              }
              if (_resultCustomizeTapProductCardHandler) {
                FireworkSDK.getInstance().shopping.onCustomTapProductCard =
                    HostAppService.getInstance().onCustomTapProductCard;
              } else {
                FireworkSDK.getInstance().shopping.onCustomTapProductCard =
                    null;
              }
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
}
