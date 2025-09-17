import 'dart:math';

import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';
import 'package:fw_flutter_sdk_example/utils/host_app_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../generated/l10n.dart';
import '../../widgets/fw_app_bar.dart';
import '../../widgets/fw_text_form_field.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                children: [
                  _buildTotalAmount(context),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildSeperator(context),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildCreditCardInfo(context),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildShippingInfo(context),
                ],
              ),
            ),
            _buildBuyNowButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmount(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          S.of(context).total,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "\$ 423.42",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSeperator(BuildContext context) {
    return Container(
      height: 1,
      color: const Color.fromARGB(255, 202, 200, 200),
    );
  }

  Widget _buildCreditCardInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S.of(context).creditCardInfo,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FWTextFormField(
            hintText: S.of(context).cardNumber,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: FWTextFormField(
                  hintText: S.of(context).MM,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: FWTextFormField(
                  hintText: S.of(context).YY,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: FWTextFormField(
                  hintText: S.of(context).CVC,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.credit_card),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FWTextFormField(
            hintText: S.of(context).nameOnCard,
          )
        ],
      ),
    );
  }

  Widget _buildShippingInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S.of(context).shippingInfo,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FWTextFormField(
            hintText: S.of(context).name,
          ),
          const SizedBox(
            height: 10,
          ),
          FWTextFormField(
            hintText: S.of(context).street,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: FWTextFormField(
                  hintText: S.of(context).city,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: FWTextFormField(
                  hintText: S.of(context).state,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBuyNowButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          const uuid = Uuid();
          final random = Random();
          FireworkSDK.getInstance().trackPurchase(
            TrackPurchaseParameters(
              orderId: uuid.v4(),
              value: random.nextInt(100) + 1,
              currencyCode: "USD",
              countryCode: "US",
              shippingPrice: 1,
              subtotal: 9,
              products: [
                PurchaseProduct(
                    extProductId: "test_product_id", price: 10, quantity: 1),
              ],
              additionalInfo: <String, String>{
                "additionalKey1": "additionalValue1",
                "additionalKey2": "additionalValue2",
                "additionalKey3": "additionalValue3"
              },
            ),
          );
          HostAppService.getInstance().removeAllCartItems();
          Navigator.of(context).pop();
        },
        child: Text(
          S.of(context).buyNow,
        ),
      ),
    );
  }
}
