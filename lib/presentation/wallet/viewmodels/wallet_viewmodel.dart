import 'package:blinkit_money_wallet/helper/repositories/wallet_repository.dart';
import 'package:blinkit_money_wallet/presentation/wallet/models/wallet_feature_model.dart';
import 'package:flutter/foundation.dart';

/// WalletViewModel encapsulates business logic for the digital wallet.
/// It reactive-drives state changes to the UI views via ChangeNotifier.
class WalletViewModel with ChangeNotifier {
  final WalletRepository _repository;

  WalletViewModel(this._repository);

  // States
  double _balance = 500.00;
  bool _isInitLoading = true;
  bool _isProcessingAction = false;
  String? _statusMessage;
  String? _errorAlert;
  String? _successAlert;
  List<WalletFeatureModel> _features = [];

  // Getters
  double get balance => _balance;
  bool get isInitLoading => _isInitLoading;
  bool get isProcessingAction => _isProcessingAction;
  String? get statusMessage => _statusMessage;
  String? get errorAlert => _errorAlert;
  String? get successAlert => _successAlert;
  List<WalletFeatureModel> get features => _features;

  /// Loads features and retrieves the cached wallet balance from storage.
  Future<void> loadWalletData() async {
    _isInitLoading = true;
    notifyListeners();

    // Populate static features from repository
    _features = _repository.getFeatures();

    try {
      // Add simulated loading delay for startup presentation skeleton
      await Future.delayed(const Duration(milliseconds: 1000));
      _balance = await _repository.getWalletBalance();
    } catch (e) {
      _errorAlert = 'Failed to load wallet balance';
    } finally {
      _isInitLoading = false;
      notifyListeners();
    }
  }

  /// Initiates simulated payment deposit flow.
  Future<bool> deposit(double amount) async {
    if (amount <= 0) {
      _errorAlert = 'Please enter a valid deposit amount';
      notifyListeners();
      return false;
    }

    _isProcessingAction = true;
    _errorAlert = null;
    _successAlert = null;

    // Staggered status updates to mimic real-world gateway sync
    _statusMessage = 'Connecting to payment gateway...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));
    _statusMessage = 'Authorizing transaction securely...';
    notifyListeners();

    try {
      _balance = await _repository.addBalance(amount);
      _successAlert =
          'Successfully added ₹${amount.toStringAsFixed(2)} to your wallet!';
      return true;
    } catch (e) {
      _errorAlert = 'Transaction failed. Please try again.';
      return false;
    } finally {
      _isProcessingAction = false;
      _statusMessage = null;
      notifyListeners();
    }
  }

  /// Claims value from preset valid gift cards.
  Future<bool> claimGiftCard(String code, String pin) async {
    if (code.isEmpty || pin.isEmpty) {
      _errorAlert = 'Please fill out all gift card fields';
      notifyListeners();
      return false;
    }

    _isProcessingAction = true;
    _errorAlert = null;
    _successAlert = null;
    _statusMessage = 'Validating gift card details...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));
    _statusMessage = 'Claiming wallet credits...';
    notifyListeners();

    try {
      final claimedValue = await _repository.claimGiftCard(code, pin);
      // Reload balance to sync
      _balance = await _repository.getWalletBalance();
      _successAlert =
          'Successfully claimed! ₹${claimedValue.toStringAsFixed(2)} added to your wallet.';
      return true;
    } catch (e) {
      _errorAlert = e.toString().replaceAll('Exception: ', '');
      return false;
    } finally {
      _isProcessingAction = false;
      _statusMessage = null;
      notifyListeners();
    }
  }

  /// Clears notifications to prevent double alerts.
  void clearAlerts() {
    _errorAlert = null;
    _successAlert = null;
  }
}
