
import 'package:an_agile_squad/backend/firebase%20methods/auth_methods.dart';
import 'package:an_agile_squad/backend/firebase%20methods/chat_methods.dart';
import 'package:an_agile_squad/backend/firebase%20methods/storage_methods.dart';
import 'package:an_agile_squad/provider/image_upload_provider.dart';
import 'package:an_agile_squad/provider/user_provider.dart';
import 'package:an_agile_squad/screens/home_screen.dart';
import 'package:an_agile_squad/screens/login_screen.dart';
import 'package:an_agile_squad/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   AuthMethods authMethods = AuthMethods();
  StorageMethods storageMethods = StorageMethods();
  ChatMethods chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: "An Agile Squad",
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: authMethods.getCurrentUser(),
            builder: (context, AsyncSnapshot<User> snapshot) {
              //returns home screen if the user isn't logged in, else login screen
              if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return LoginScreen();
              }
            }),
        initialRoute: '/',
        routes: {
          '/search_screen': (context) => SearchScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
