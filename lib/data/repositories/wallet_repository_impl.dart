import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../models/wallet_feature_model.dart';
import '../services/local_storage_service.dart';
import 'wallet_repository.dart';

/// WalletRepositoryImpl handles data-delivery logic.
/// It wraps the LocalStorageService and mocks network delays for a high-fidelity visual experience.
class WalletRepositoryImpl implements WalletRepository {
  final LocalStorageService _storageService;

  WalletRepositoryImpl(this._storageService);

  // Pre-configured list of features matching your video recording OCR
  @override
  List<WalletFeatureModel> getFeatures() {
    return const [
      WalletFeatureModel(
        title: AppStrings.feature1Title,
        subtitle: AppStrings.feature1Subtitle,
        icon: Icons.offline_bolt_rounded,
        iconColor: AppColors.walletGreen,
      ),
      WalletFeatureModel(
        title: AppStrings.feature2Title,
        subtitle: AppStrings.feature2Subtitle,
        icon: Icons.shield_rounded,
        iconColor: AppColors.walletGreen,
      ),
      WalletFeatureModel(
        title: AppStrings.feature3Title,
        subtitle: AppStrings.feature3Subtitle,
        icon: Icons.history_rounded,
        iconColor: AppColors.walletGreen,
      ),
    ];
  }

  @override
  Future<double> getWalletBalance() async {
    return await _storageService.getBalance();
  }

  @override
  Future<double> addBalance(double amount) async {
    // Simulate real network delay for high-end UI transitions
    await Future.delayed(const Duration(milliseconds: 1500));
    
    final currentBalance = await _storageService.getBalance();
    final newBalance = currentBalance + amount;
    
    await _storageService.saveBalance(newBalance);
    return newBalance;
  }

  @override
  Future<double> claimGiftCard(String code, String pin) async {
    // Simulate server-side verification delay
    await Future.delayed(const Duration(milliseconds: 1800));

    // Hardcoded mock valid gift cards
    final Map<String, _MockGiftCard> validCards = {
      'GIFT-1111-2222': const _MockGiftCard(pin: '1234', value: 500.0),
      'GIFT-5555-6666': const _MockGiftCard(pin: '5678', value: 1000.0),
      'GIFT-9999-0000': const _MockGiftCard(pin: '0000', value: 250.0),
    };

    final cleanCode = code.trim().toUpperCase();
    final cleanPin = pin.trim();

    if (validCards.containsKey(cleanCode)) {
      final card = validCards[cleanCode]!;
      if (card.pin == cleanPin) {
        final currentBalance = await _storageService.getBalance();
        final newBalance = currentBalance + card.value;
        await _storageService.saveBalance(newBalance);
        return card.value; // Return the claimed card's monetary value
      } else {
        throw Exception('Invalid Gift Card PIN');
      }
    } else {
      throw Exception('Gift Card not found or already claimed');
    }
  }
}

class _MockGiftCard {
  final String pin;
  final double value;

  const _MockGiftCard({required this.pin, required this.value});
}
