import 'package:shared_preferences/shared_preferences.dart';

/// LocalStorageService handles lightweight data persistence
/// such as caching the user's wallet balance.
class LocalStorageService {
  static const String _keyBalance = 'blinkit_wallet_balance';
  static const double _defaultBalance = 500.00; // Simulated starter balance

  /// Fetches the cached balance from persistent store.
  Future<double> getBalance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(_keyBalance) ?? _defaultBalance;
    } catch (e) {
      // Fallback in case of storage failure or platform exceptions
      return _defaultBalance;
    }
  }

  /// Persists the updated balance in storage.
  Future<bool> saveBalance(double balance) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setDouble(_keyBalance, balance);
    } catch (e) {
      return false;
    }
  }

  /// Clears stored balance (optional utility).
  Future<bool> reset() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_keyBalance);
    } catch (e) {
      return false;
    }
  }
}
