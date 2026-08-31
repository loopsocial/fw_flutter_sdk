/// How the example app answers Player Deck one-tap Add to Cart requests.
///
/// Products in the test feeds are not always linked to the Shopify test store,
/// so QA can bypass Shopify and force the result the host reports back to the
/// SDK. This only affects the example app; the SDK still shows the button
/// based on the deck configuration and the product's own addability.
enum PlayerDeckAddToCartTestResult {
  /// Look the product up in the Shopify test store and add the matching
  /// variant to the local cart. Fails when the product is not in the store.
  shopify('Shopify'),

  /// Skip Shopify, add the requested product unit to the local cart and
  /// report success.
  success('Always Success'),

  /// Skip Shopify and report failure.
  failure('Always Failure'),

  /// Never answer. The SDK's own watchdog restores the button after 10 s
  /// without showing a success or failure result.
  timeout('No Response');

  final String label;

  const PlayerDeckAddToCartTestResult(this.label);

  /// Whether this mode answers after the configured simulated delay.
  bool get usesDelay => this == success || this == failure;
}
