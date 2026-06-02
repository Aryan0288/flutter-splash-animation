import 'package:blinkit_money_wallet/helper/local_storage/local_storage_service.dart';
import 'package:blinkit_money_wallet/helper/repositories/wallet_repository_impl.dart';
import 'package:blinkit_money_wallet/presentation/wallet/viewmodels/wallet_viewmodel.dart';
import 'package:blinkit_money_wallet/presentation/wallet/views/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

void main() async {
  // Ensure framework local_storage are initialized prior to loading preferences
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI configurations for immersive feel
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  ));

  // Initialize service clients
  final storageService = LocalStorageService();
  
  // Initialize repository adapters
  final walletRepository = WalletRepositoryImpl(storageService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WalletViewModel>(
          create: (_) => WalletViewModel(walletRepository),
        ),
      ],
      child: const BlinkitMoneyApp(),
    ),
  );
}

class BlinkitMoneyApp extends StatelessWidget {
  const BlinkitMoneyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blinkit Money Wallet',
      debugShowCheckedModeBanner: false,
      
      // Use clean custom Light and Dark configurations
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Dynamically fits system preference

      home: const WalletScreen(),
    );
  }
}
