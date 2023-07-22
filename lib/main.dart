import 'package:flutter/material.dart';
import 'package:notesphpapp/app/editnote.dart';
import 'package:notesphpapp/app/success.dart';

import 'app/addnote.dart';
import 'app/auth/login.dart';
import 'app/auth/singin.dart';
import 'app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences sharedPrf;
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   sharedPrf=await SharedPreferences.getInstance();
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
      initialRoute:sharedPrf.getString("id")==null?"login":"home",
      routes:{
        "login":(context)=>Login(),
        "singin":(context)=>Singin(),
        "home":(context)=>Home(),
        "addnote":(context)=>Addnote(),
        "success":(context)=>Success(),
        "editenote":(context)=>Editenote(),

      } ,
    );
  }
}
