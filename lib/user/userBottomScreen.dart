import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmate/user/profileScreen.dart';
import 'package:travelmate/user/wishListScreen.dart';

import 'homeScreen.dart';

class UserBottomScreen extends StatefulWidget {
  const UserBottomScreen({super.key});

  @override
  State<UserBottomScreen> createState() => _UserBottomScreenState();
}

class _UserBottomScreenState extends State<UserBottomScreen> {

  int indexNum=0;
  @override

  List<Widget> getScreens(){
    return [
      UserHomePage(),
      WishlistScreen(),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    var Screens=getScreens();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          unselectedLabelStyle: TextStyle(fontFamily: "bakbak",fontSize: 10,color: Colors.white),
          selectedLabelStyle: TextStyle(fontFamily: "bakbak",fontSize: 10,color: Colors.white),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
              label: "Wish"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
              label: "Account"
            ),
          ],
        currentIndex: indexNum,
        onTap: (int index) {
          setState(() {
            indexNum=index;

          });
        },
      ),
      body: Screens[indexNum],
    );
  }
}