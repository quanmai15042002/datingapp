import 'dart:io';

import 'package:country_code_picker/country_localizations.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/models/app_model.dart';
import 'package:dating_app/screens/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/constants/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // For play billing library 2.0 on Android, it is mandatory to call
  // [enablePendingPurchases](https://developer.android.com/reference/com/android/billingclient/api/BillingClient.Builder.html#enablependingpurchases)
  // as part of initializing the app.
  // InAppPurchaseConnection.enablePendingPurchases();
  // Initialized before calling runApp to init firebase app
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize firebase app
  await Firebase.initializeApp();
  // Initialize Google Mobile Ads SDK
  await MobileAds.instance.initialize();

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  /// Check iOS device
  if (Platform.isIOS) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MyApp());
}

// Define the Navigator global key state to be used when the build context is not available!
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: APP_NAME,
          debugShowCheckedModeBanner: false,

          /// Setup translations
          localizationsDelegates: [
            // AppLocalizations is where the lang translations is loaded
            AppLocalizations.delegate,
            CountryLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: SUPPORTED_LOCALES,

          /// Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode) {
                return supportedLocale;
              }
            }

            /// If the locale of the device is not supported, use the first one
            /// from the list (English, in this case).
            return supportedLocales.first;
          },
          home: SplashScreen(),
          theme: _appTheme(),
        ),
      ),
    );
  }
}

/// App theme
ThemeData _appTheme() {
  return ThemeData(
    primaryColor: APP_PRIMARY_COLOR,
    accentColor: APP_ACCENT_COLOR,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        )),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: Platform.isIOS ? 0 : 4.0,
      iconTheme: IconThemeData(color: Colors.black),
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.grey, fontSize: 18),
      ),
    ),
  );
}
