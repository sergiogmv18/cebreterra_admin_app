import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/utils/services/navigation_service.dart';
import 'package:flutter/material.dart';

class Cebreterra extends StatelessWidget {
  const Cebreterra({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cebreterra',
      color: CustomColors.kSecondaryColor,
      navigatorKey: NavigationService.navigatorKey,
      routes: routes,
      theme: CebreterraStyle().theme.copyWith(
        colorScheme:  CebreterraStyle().theme.colorScheme.copyWith(secondary: Colors.grey[300]),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}