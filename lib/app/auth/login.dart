import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notesphpapp/components/valid.dart';

import 'package:notesphpapp/constant/linkes.dart';
import 'package:notesphpapp/main.dart';
import '../../components/costemformfialed.dart';
import '../../components/curd.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Curd crud = Curd();
  bool isLoading = false;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var res = await crud.postRequest(
          linkLogin, {"email": email.text, "password": password.text});
      if (res['status'] == 'success') {
        sharedPrf.setString("id",res['data']['id'].toString() );
        sharedPrf.setString("username",res['data']['username']);
        sharedPrf.setString("email",res['data']['email']);
        sharedPrf.setString("password",res['data']['password'] );
        isLoading = false;

        setState(() {});
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
        AwesomeDialog(
          //btnCancel: Text("Cancel"),
          dialogType:DialogType.error ,
          context: context,
          title: "What's wrong",
          btnCancel: Text("Cancel"),
          btnCancelOnPress:(){
            Navigator.of(context).pop();
          } ,
          btnCancelColor: Colors.white10,
          body: Container(
            height: 100,
            child: Column(
              children: [
                Text("your password or email is incorrect"),
                Text("Please enter correct information")
              ],
            ),
          ),

        )..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LogIn"),
      ),
      body:isLoading==true?CircularProgressIndicator(): Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(children: [
          Form(
            key: formstate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/logo.png"),
                CostumFormFaildSing(
                    valid: (val) {
                      return valid(20, 5, val!);
                    },
                    mycontroller: email,
                    hinttext: "email"),
                CostumFormFaildSing(
                    valid: (val) {
                      return valid(20, 5, val!);
                    },
                    mycontroller: password,
                    hinttext: "password"),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async{
                   await login();
                  },
                  child: Text("Login"),
                  style: ButtonStyle(),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("singin");
                    },
                    child: Text("Sing in"))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
