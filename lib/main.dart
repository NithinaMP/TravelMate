import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/admin/addDestinationDetails.dart';
import 'package:travelmate/admin/addEventDetailsScreen.dart';
import 'package:travelmate/admin/addEventScreen.dart';
import 'package:travelmate/provider/mainProvider.dart';
import 'package:travelmate/user/EventDetail.dart';
import 'package:travelmate/user/bookEvent.dart';
import 'package:travelmate/user/bookTicket.dart';
import 'package:travelmate/user/destinationScreen.dart';
import 'package:travelmate/user/getStartedScreen.dart';
import 'package:travelmate/user/homeScreen.dart';
import 'package:travelmate/user/loginScreen.dart';
import 'package:travelmate/user/myTicketScreen.dart';
import 'package:travelmate/user/review.dart';
import 'package:travelmate/user/signupScreen.dart';
import 'package:travelmate/user/splashScreen.dart';
import 'package:travelmate/user/wishListScreen.dart';

import 'admin/adminHomescreen.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyA2dXpTSL0zsnNWU8LYaA2QGVlIqHXnmfg",
        appId: "1:133733818670:android:775458077e1dcd420bdabf",
        messagingSenderId: "travelmate-44c92",
        projectId: "travelmate-44c92",
      storageBucket: "travelmate-44c92.appspot.com"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: MyTicketScreen(),
        //  home: SplashScreen(),
         home: adminhomeWidget(),

      ),
    );
  }
}


