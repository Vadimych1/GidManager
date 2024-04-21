import 'package:flutter/material.dart';
import "package:gid_manager/view/vw_splash.dart";
import 'package:gid_manager/view/auth/vw_login.dart';
import 'package:gid_manager/view/auth/vw_register_s1.dart';
import 'package:gid_manager/view/auth/vw_register_s2.dart';
import 'package:gid_manager/view/main/vw_home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gid_manager/logic/lg_server.dart';

final supabase = Supabase.instance;
const String _url = "https://vzjwylkhgxzwwzdagdhx.supabase.co";
const String _anonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ6and5bGtoZ3h6d3d6ZGFnZGh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA4NjQ4OTcsImV4cCI6MjAyNjQ0MDg5N30.RMAOP6CbJntC8fPM35hT9fOP4b1wRJTV8j0rr_t6ayA";
const SupabaseC supabaseC = SupabaseC(address: _url, anonKey: _anonKey);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Supabase.initialize(url: _url, anonKey: _anonKey);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Roboto",
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF688513),
          onPrimary: Color(0xFF688513),
          secondary: Color(0xFF000000),
          onSecondary: Color(0xFF000000),
          error: Color(0xFFFF5544),
          onError: Color(0xFFFF5544),
          background: Color(0xFFFFFFFF),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xff000000),
          onSurface: Color(0xff000000),
        ),
      ),
      routes: {
        "/login": (context) => const LoginStep1(),
        "/register": (context) => const RegisterStep1(),
        "/register/step2": (context) => const RegisterStep2(),
        "/home": (context) => const HomePage(),
        // "favorite": (context) => const FavoritePage(),
        // "settings": (context) => const SettingsPage(),
      },
      home: const Scaffold(
        body: Center(
          child: Splash(),
        ),
      ),
    );
  }
}
