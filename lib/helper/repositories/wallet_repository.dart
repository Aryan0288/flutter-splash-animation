import 'package:blinkit_money_wallet/presentation/wallet/models/wallet_feature_model.dart';


/// WalletRepository outlines the helper-layer contracts.
/// Separating this interface promotes clean MVVM mocking and testing practices.
abstract class WalletRepository {
  /// Retrieves list of standard Blinkit Money features.
  List<WalletFeatureModel> getFeatures();

  /// Retrieves persistent wallet balance.
  Future<double> getWalletBalance();

  /// Simulates deposits securely.
  Future<double> addBalance(double amount);

  /// Validates and claims a specific gift card, returning its face value.
  Future<double> claimGiftCard(String code, String pin);
}
