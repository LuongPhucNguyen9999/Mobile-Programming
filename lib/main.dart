import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/profile.dart';
import 'package:flutter_application_2/providers/diachimodel.dart';
import 'package:flutter_application_2/providers/forgotviewmodel.dart';
import 'package:flutter_application_2/providers/loginviewmodel.dart';
import 'package:flutter_application_2/providers/mainviewmodel.dart';
import 'package:flutter_application_2/providers/menubarviewmodel.dart';
import 'package:flutter_application_2/providers/profileviewmodel.dart';
import 'package:flutter_application_2/providers/registerviewmodel.dart';
import 'package:flutter_application_2/services/api_service.dart';
import 'package:flutter_application_2/ui/page_forgot.dart';
import 'package:flutter_application_2/ui/page_main.dart';
import 'package:flutter_application_2/ui/page_register.dart';
import 'package:provider/provider.dart';
import 'ui/page_dklop.dart';
import 'ui/page_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService api = ApiService();
  api.initialize();
  Profile profile = Profile();
  profile.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(),
      ),
      ChangeNotifierProvider<RegisterViewModel>(
        create: (context) => RegisterViewModel(),
      ),
      ChangeNotifierProvider<ForgotViewModel>(
        create: (context) => ForgotViewModel(),
      ),
      ChangeNotifierProvider<MainViewModel>(
        create: (context) => MainViewModel(),
      ),
      ChangeNotifierProvider<MenuBarViewModel>(
        create: (context) => MenuBarViewModel(),
      ),
      ChangeNotifierProvider<ProfileViewModel>(
        create: (context) => ProfileViewModel(),
      ),
      ChangeNotifierProvider<DiachiModel>(
        create: (context) => DiachiModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => PageMain(),
        '/login': (context) => PageLogin(),
        '/register': (context) => PageRegister(),
        '/forgot': (context) => PageForgot(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFC8132B)),
        useMaterial3: true,
      ),
      home: PageMain(),
    );
  }
}
