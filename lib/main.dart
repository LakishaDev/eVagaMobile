import 'package:evaga/screens/pocetna.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData evagaTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2E5D58), // tamno zelena
    onPrimary: Colors.white,
    secondary: Color(0xFFC68642), // braon akcenat
    onSecondary: Colors.white,
    background: Color(0xFFA8C8A2), // pastelna zelena
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
  ),
  useMaterial3: true,
  fontFamily: 'Poppins',
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoMono',
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 4,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF2E5D58),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'eVaga',
      theme: evagaTheme,
      home: PocetnaEkran(),
    );
  }
}
