import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        Text("your account has been created succesfuly..please log in to your account"),
          ElevatedButton(onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
          }, child:Text("log in"))
      ],
      ),
    );
  }
}
