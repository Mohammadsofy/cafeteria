import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/admin_page.dart';
import 'pages/menu_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مطعم الذكاء ',
      theme: ThemeData(primarySwatch: Colors.orange),
      home:  HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("اختيار الصفحة")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) =>  MenuPage(tableNumber: 1),
                ));
              },
              child:  Text(" طاولة 1"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) =>  MenuPage(tableNumber: 2),
                ));
              },
              child:  Text(" طاولة 2"),
            ),//
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) =>  MenuPage(tableNumber: 3),
                ));
              },
              child:  Text(" طاولة 3"),
            ),
             SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) =>  AdminPage(),
                ));
              },
              child:  Text(" صفحة الأدمن"),
            ),
          ],
        ),
      ),
    );
  }
}
