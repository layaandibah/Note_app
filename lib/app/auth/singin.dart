import 'package:flutter/material.dart';
import 'package:notesphpapp/constant/linkes.dart';

import '../../components/costemformfialed.dart';
import '../../components/curd.dart';
import 'package:notesphpapp/components/valid.dart';

class Singin extends StatefulWidget {
  const Singin({Key? key}) : super(key: key);

  @override
  State<Singin> createState() => _SinginState();
}

class _SinginState extends State<Singin> {
  bool isLoading = false;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  Curd _curd = Curd();

  singIn() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var res = await _curd.postRequest(linkSingin, {
        "username": username.text,
        "email": email.text,
        "password": password.text
      });

      if (res['status'] == 'success') {
        isLoading = false;
        setState(() {});
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("==================================");
        print(res["status"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SingIn"),
      ),
      body: isLoading == true
          ? CircularProgressIndicator()
          : Container(
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
                            return valid(20, 3, val!);
                          },
                          mycontroller: username,
                          hinttext: "username"),
                      CostumFormFaildSing(
                          valid: (val) {
                            return valid(50, 5, val!);
                          },
                          mycontroller: email,
                          hinttext: "email"),
                      CostumFormFaildSing(
                          valid: (val) {
                            return valid(30, 3, val!);
                          },
                          mycontroller: password,
                          hinttext: "password"),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await singIn();
                        },
                        child: Text("Singin"),
                        style: ButtonStyle(),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("login");
                          },
                          child: Text("Login"))
                    ],
                  ),
                ),
              ]),
            ),
    );
  }
}
