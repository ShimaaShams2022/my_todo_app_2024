import 'package:flutter/material.dart';
import 'package:to_do_app_c11/ui/home/home_screen.dart';
import 'package:to_do_app_c11/ui/login/LoginScreen.dart';
import 'package:to_do_app_c11/ui/register/RegisterScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
            titleSmall: TextStyle(
              fontWeight: FontWeight.normal,
            color: Colors.white,
              fontSize: 18,
            )
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Color(0xffC8C9CB),
        ),
        scaffoldBackgroundColor: const Color(0xffDFECDB),
appBarTheme: const AppBarTheme(
  backgroundColor: Colors.blue
),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),

      routes: {
        HomeScreen.routeName:(_)=>HomeScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
