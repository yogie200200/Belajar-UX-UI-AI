import 'package:ceramicalc_app/screens/formulasi_baru_screen.dart';
import 'package:ceramicalc_app/screens/hitung_formulasi_screen.dart';
import 'package:ceramicalc_app/screens/home_screen.dart';
import 'package:ceramicalc_app/screens/riwayat_formulasi_screen.dart';
import 'package:ceramicalc_app/screens/help_screen.dart';
import 'package:ceramicalc_app/screens/profil_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/formulasi_Baru': (context) => FormulasiBaruScreen(),
        '/hitung_formulasi': (context) => HitungFormulasiScreen(),
        '/riwayat_formulasi': (context) => RiwayatFormulasiScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _ButtomNavigatorBarWidgetState();
}

class _ButtomNavigatorBarWidgetState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screen = [
    HomeScreen(),
    HelpScreen(),
    ProfilScreen(),
    RiwayatFormulasiScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Bantuan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Trial'),

        ],
      ),
    );
  }
}

