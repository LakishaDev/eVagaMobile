import 'package:evaga/config/postavke_uredjaja.dart';
import 'package:evaga/screens/pocetna.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

final ThemeData evagaTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2E5D58), // tamno zelena
    onPrimary: Colors.white,
    secondary: Color.fromARGB(
      255,
      138,
      76,
      52,
    ), // braon akcenat
    onSecondary: Colors.white,
    background: Color(0xFFA8C8A2), // pastelna zelena
    onBackground: Colors.black,
    surface: Color.fromRGBO(203, 207, 187, 1),
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    tertiary: Color.fromRGBO(26, 52, 61, 1),
    surfaceContainer: Color.fromARGB(255, 110, 174, 162),
    surfaceContainerLowest: Color.fromARGB(255, 26, 52, 61),
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PostavkeUredjaja(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
