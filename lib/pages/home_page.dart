import 'package:chatapp_firebase/pages/login_page.dart';
import 'package:chatapp_firebase/pages/settings_page.dart';
import 'package:chatapp_firebase/widgets/song_widget/home_widget.dart';
//import 'package:chatapp_firebase/models/new_songs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../widgets/song_widget/search_widget.dart';
import '../widgets/song_widget/song_library.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  // Create storage
  final storage = const FlutterSecureStorage();

  static const List _pages = [homeWidget(), SearchWidget(), SongLibrary()];
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  //redirect to Login page if user is not connected
  redirectToLoginPage() async {
    // Read value
    String? value = await storage.read(key: "token");
    if (value == null) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    redirectToLoginPage();
    onItemTapped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            label: 'Library',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: selectedIndex, //New
        onTap: onItemTapped,
      ),
    );
  }
}
