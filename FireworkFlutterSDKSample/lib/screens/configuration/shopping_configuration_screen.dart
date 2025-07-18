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
  bool _resultCustomizeShoppingCTAHandler = false;
  bool _resultCustomizeShoppingSecondaryCTAHandler = false;

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
    _resultProductCardConfig.ctaButtonStyle ??= ProductCardCTAButtonStyle();
    _resultProductCardConfig.priceConfiguration ??=
        ProductCardPriceConfiguration();
    _resultProductCardConfig.priceConfiguration!.priceLabel ??=
        ProductCardLabelConfiguration();
    _resultProductCardConfig.priceConfiguration!.originalPriceLabel ??=
        ProductCardLabelConfiguration();
    _resultProductCardConfig.iconConfiguration ??=
        ProductCardIconConfiguration();
    _resultProductCardConfig.nameLabel ??= ProductCardLabelConfiguration();

    _resultCustomizeLinkButtonHandler =
        FireworkSDK.getInstance().shopping.onCustomClickLinkButton != null;
    _resultCustomizeTapProductCardHandler =
        FireworkSDK.getInstance().shopping.onCustomTapProductCard != null;
    _resultCustomizeShoppingCTAHandler =
        FireworkSDK.getInstance().shopping.onShoppingCTA != null;
    _resultCustomizeShoppingSecondaryCTAHandler =
        FireworkSDK.getInstance().shopping.onShoppingSecondaryCTA != null;
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              _buildProductCardCTAButtonTextColor(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardCTAButtonFontSize(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardCTAButtonHidden(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardWidth(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardHeight(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardBackgroundColor(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardIconCornerRadius(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardNameLabelTextColor(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardNameLabelFontSize(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardNameLabelLines(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardPriceLabelTextColor(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardPriceLabelFontSize(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardPriceLabelLines(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardOriginalPriceLabelTextColor(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardOriginalPriceLabelFontSize(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardOriginalPriceLabelLines(context),
              const SizedBox(
                height: 20,
              ),
              _buildProductCardIsPriceFirst(context),
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
              _buildCustomizeShoppingShoppingCTAHandler(context),
              const SizedBox(
                height: 20,
              ),
              _buildCustomizeShoppingSecondaryCTAHandler(context),
              const SizedBox(
                height: 20,
              ),
              _buildButtonList(context),
            ],
          ),
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

  Widget _buildProductCardCTAButtonTextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardCTAButtonTextColor),
        FWTextFormField(
          initialValue: _initProductCardConfig.ctaButtonStyle?.textColor,
          hintText: S.of(context).productCardCTAButtonTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.ctaButtonStyle!.textColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildProductCardCTAButtonFontSize(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardCTAButtonFontSize),
        FWTextFormField(
          initialValue: _initProductCardConfig.ctaButtonStyle?.fontSize
                  ?.toStringAsFixed(0) ??
              '16',
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
            _resultProductCardConfig.ctaButtonStyle!.fontSize =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
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

  Widget _buildProductCardWidth(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardWidth),
        FWTextFormField(
          initialValue: _initProductCardConfig.width?.toStringAsFixed(0),
          hintText: S.of(context).productCardWidthHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 218,
              max: 300,
              errorMessage: S.of(context).widthError,
              rangeErrorMessage: S.of(context).widthRangeError(218, 300),
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.width =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildProductCardHeight(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardHeight),
        FWTextFormField(
          initialValue: _initProductCardConfig.height?.toStringAsFixed(0),
          hintText: S.of(context).productCardHeightHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 88,
              max: 120,
              errorMessage: S.of(context).heightError,
              rangeErrorMessage: S.of(context).heightRangeError(88, 120),
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.height =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildProductCardBackgroundColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardBackgroundColor),
        FWTextFormField(
          initialValue: _initProductCardConfig.backgroundColor,
          hintText: S.of(context).backgroundColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.backgroundColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildProductCardIconCornerRadius(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardIconCornerRadius),
        FWTextFormField(
          initialValue: _initProductCardConfig.iconConfiguration?.cornerRadius
              ?.toStringAsFixed(0),
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
            _resultProductCardConfig.iconConfiguration!.cornerRadius =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildProductCardNameLabelTextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardNameLabelTextColor),
        FWTextFormField(
          initialValue: _initProductCardConfig.nameLabel?.textColor,
          hintText: S.of(context).productCardNameLabelTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.nameLabel!.textColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildProductCardNameLabelFontSize(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardNameLabelFontSize),
        FWTextFormField(
          initialValue:
              _initProductCardConfig.nameLabel?.fontSize?.toStringAsFixed(0) ??
                  '16',
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
            _resultProductCardConfig.nameLabel!.fontSize =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildProductCardNameLabelLines(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardNameLabelLines),
        FWTextFormField(
          initialValue: _initProductCardConfig.nameLabel?.numberOfLines
              ?.toStringAsFixed(0),
          hintText: S.of(context).numberOfTitleLinesHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 1,
              max: 5,
              errorMessage: S.of(context).numberOfTitleLinesError,
              rangeErrorMessage: S.of(context).numberOfTitleLinesRangeError,
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.nameLabel!.numberOfLines =
                int.tryParse(text ?? '');
          },
        )
      ],
    );
  }

  Widget _buildProductCardPriceLabelTextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardPriceLabelTextColor),
        FWTextFormField(
          initialValue:
              _initProductCardConfig.priceConfiguration?.priceLabel?.textColor,
          hintText: S.of(context).productCardPriceLabelTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.priceConfiguration!.priceLabel!.textColor =
                text;
          },
        ),
      ],
    );
  }

  Widget _buildProductCardPriceLabelFontSize(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardPriceLabelFontSize),
        FWTextFormField(
          initialValue: _initProductCardConfig
                  .priceConfiguration?.priceLabel?.fontSize
                  ?.toStringAsFixed(0) ??
              '16',
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
            _resultProductCardConfig.priceConfiguration!.priceLabel!.fontSize =
                int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildProductCardPriceLabelLines(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardPriceLabelLines),
        FWTextFormField(
          initialValue: _initProductCardConfig
              .priceConfiguration?.priceLabel?.numberOfLines
              ?.toStringAsFixed(0),
          hintText: S.of(context).numberOfTitleLinesHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 1,
              max: 5,
              errorMessage: S.of(context).numberOfTitleLinesError,
              rangeErrorMessage: S.of(context).numberOfTitleLinesRangeError,
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.priceConfiguration!.priceLabel!
                .numberOfLines = int.tryParse(text ?? '');
          },
        )
      ],
    );
  }

  Widget _buildProductCardOriginalPriceLabelTextColor(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardOriginalPriceLabelTextColor),
        FWTextFormField(
          initialValue: _initProductCardConfig
              .priceConfiguration?.originalPriceLabel?.textColor,
          hintText: S.of(context).productCardOriginalPriceLabelTextColorHint,
          validator: (text) {
            return ValidationUtil.validateColor(
              text,
              context,
            );
          },
          onSaved: (text) {
            _resultProductCardConfig
                .priceConfiguration!.originalPriceLabel!.textColor = text;
          },
        ),
      ],
    );
  }

  Widget _buildProductCardOriginalPriceLabelFontSize(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardOriginalPriceLabelFontSize),
        FWTextFormField(
          initialValue: _initProductCardConfig
                  .priceConfiguration?.originalPriceLabel?.fontSize
                  ?.toStringAsFixed(0) ??
              '16',
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
            _resultProductCardConfig.priceConfiguration!.originalPriceLabel!
                .fontSize = int.tryParse(text ?? '')?.toDouble();
          },
        )
      ],
    );
  }

  Widget _buildProductCardOriginalPriceLabelLines(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).productCardOriginalPriceLabelLines),
        FWTextFormField(
          initialValue: _initProductCardConfig
              .priceConfiguration?.originalPriceLabel?.numberOfLines
              ?.toStringAsFixed(0),
          hintText: S.of(context).numberOfTitleLinesHint,
          validator: (text) {
            return ValidationUtil.validateNumber(
              context: context,
              text: text,
              min: 1,
              max: 5,
              errorMessage: S.of(context).numberOfTitleLinesError,
              rangeErrorMessage: S.of(context).numberOfTitleLinesRangeError,
            );
          },
          onSaved: (text) {
            _resultProductCardConfig.priceConfiguration!.originalPriceLabel!
                .numberOfLines = int.tryParse(text ?? '');
          },
        )
      ],
    );
  }

  Widget _buildProductCardIsPriceFirst(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultProductCardConfig.priceConfiguration?.isPriceFirst ?? false,
      onChanged: (value) {
        setState(() {
          _resultProductCardConfig.priceConfiguration!.isPriceFirst = value;
        });
      },
      title: Text(
        S.of(context).productCardIsPriceFirst,
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

  Widget _buildUseIOSFontInfo(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultShoppingCTAButtonConfig.iOSFontInfo != null,
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _resultProductCardConfig.ctaButtonStyle!.iOSFontInfo = IOSFontInfo(
              fontName: "TimesNewRomanPS-ItalicMT",
            );
            _resultProductCardConfig
                .priceConfiguration!.priceLabel!.iOSFontInfo = IOSFontInfo(
              fontName: "TimesNewRomanPS-ItalicMT",
            );
            _resultProductCardConfig.priceConfiguration!.originalPriceLabel!
                .iOSFontInfo = IOSFontInfo(
              fontName: "TimesNewRomanPS-ItalicMT",
            );
            _resultProductCardConfig.nameLabel!.iOSFontInfo = IOSFontInfo(
              fontName: "TimesNewRomanPS-ItalicMT",
            );
            _resultShoppingCTAButtonConfig.iOSFontInfo = IOSFontInfo(
              fontName: "TimesNewRomanPS-ItalicMT",
            );
          } else {
            _resultProductCardConfig.ctaButtonStyle!.iOSFontInfo = null;
            _resultProductCardConfig
                .priceConfiguration!.priceLabel!.iOSFontInfo = null;
            _resultProductCardConfig
                .priceConfiguration!.originalPriceLabel!.iOSFontInfo = null;
            _resultProductCardConfig.nameLabel!.iOSFontInfo = null;
            _resultShoppingCTAButtonConfig.iOSFontInfo = null;
          }
        });
      },
      title: Text(
        S.of(context).useIOSFontInfo,
      ),
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

  Widget _buildCustomizeShoppingShoppingCTAHandler(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultCustomizeShoppingCTAHandler,
      onChanged: (value) {
        setState(() {
          _resultCustomizeShoppingCTAHandler = value ?? false;
        });
      },
      title: const Text(
        "Enable custom shopping CTA",
      ),
    );
  }

  Widget _buildCustomizeShoppingSecondaryCTAHandler(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _resultCustomizeShoppingSecondaryCTAHandler,
      onChanged: (value) {
        setState(() {
          _resultCustomizeShoppingSecondaryCTAHandler = value ?? false;
        });
      },
      title: const Text(
        "Enable custom shopping secondary CTA",
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
              if (_resultCustomizeShoppingCTAHandler) {
                if (_resultShoppingCTAButtonConfig.text ==
                    ShoppingCTAButtonText.shopNow) {
                  FireworkSDK.getInstance().shopping.onShoppingCTA =
                      HostAppService.getInstance().onShopNow;
                } else {
                  FireworkSDK.getInstance().shopping.onShoppingCTA =
                      HostAppService.getInstance().onAddToCart;
                }
              } else {
                FireworkSDK.getInstance().shopping.onShoppingCTA = null;
              }
              if (_resultCustomizeShoppingSecondaryCTAHandler) {
                FireworkSDK.getInstance().shopping.onShoppingSecondaryCTA =
                    HostAppService.getInstance().onShoppingSecondaryCTA;
              } else {
                FireworkSDK.getInstance().shopping.onShoppingSecondaryCTA =
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
