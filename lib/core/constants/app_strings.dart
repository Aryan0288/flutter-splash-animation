/// AppStrings provides localized/custom constants for all text copy
/// extracted from the Blinkit Money video analysis.
class AppStrings {
  AppStrings._();

  static const String appTitle = 'Blinkit Money';
  static const String brandingMain = 'blinkit';
  static const String brandingSub = 'MONEY';

  // Value Proposition Copy
  static const String feature1Title = 'Single tap payments';
  static const String feature1Subtitle = 'Enjoy seamless payments without the wait for OTPs';

  static const String feature2Title = 'Zero failures';
  static const String feature2Subtitle = 'Zero payment failures ensure you never miss an order';

  static const String feature3Title = 'Real-time refunds';
  static const String feature3Subtitle = 'No need to wait for refunds. Blinkit Money refunds are instant!';

  // Card & Wallet Details
  static const String walletBalanceLabel = 'Blinkit Money Balance';
  static const String activeWalletLabel = 'Active Wallet';
  static const String mockCardHolder = 'CARD HOLDER';

  // Key Interactive Actions
  static const String addMoney = 'Add Money';
  static const String addMoneySubtitle = 'Top up your digital wallet securely';
  static const String claimGiftCard = 'Claim Gift Card';
  static const String claimGiftCardSubtitle = 'Enter gift card details to claim your gift card';

  // Dialog & Form Inputs
  static const String giftCardCodeLabel = 'Gift Card Code';
  static const String giftCardCodeHint = 'GIFT-XXXX-XXXX';
  static const String giftCardPinLabel = 'Gift Card PIN';
  static const String giftCardPinHint = '4-Digit PIN';
  static const String amountLabel = 'Amount to Add';
  
  // Validation Warnings
  static const String fieldRequired = 'This field is required';
  static const String invalidCode = 'Invalid code. Format: GIFT-XXXX-XXXX';
  static const String invalidPin = 'Invalid PIN. Must be a 4-digit number';
  static const String invalidAmount = 'Amount must be greater than zero';

  // Buttons & Alerts
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String claim = 'Claim';
  static const String success = 'Success';
  static const String error = 'Error';
  static const String processing = 'Processing...';
}
