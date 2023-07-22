import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesphpapp/components/costemformfialed.dart';
import 'package:notesphpapp/components/curd.dart';
import 'package:notesphpapp/components/valid.dart';
import 'package:notesphpapp/constant/linkes.dart';
import 'package:notesphpapp/main.dart';

class Addnote extends StatefulWidget {
  const Addnote({Key? key}) : super(key: key);

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  File? file;
  bool isLoding=false;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Curd _curd = Curd();

  addnote() async {
    if(file==null)
      return AwesomeDialog(context: context,body: Text("Please insert image"),dialogType: DialogType.warning)..show();
    if (formstate.currentState!.validate()) {
      isLoding=true;
      setState(() {

      });
      var res =await _curd.postRequestwithFile(
          linkInsertNote,
          {
            'title': title.text,
            'content': content.text,
            "userid": sharedPrf.get('id'),


          },
          file!);
      isLoding=false;
          setState(() {
          });
     if(res['status']=='success'){
       Navigator.of(context).pushReplacementNamed("home");
       return res;
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add note"),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formstate,
            child: Column(
              children: [
                CostumFormFaildSing(
                  valid: (val) {
                    return valid(30, 5, val!);
                  },
                  hinttext: 'title',
                  mycontroller: title,
                ),
                CostumFormFaildSing(
                  valid: (val) {
                    return valid(20000, 2, val!);
                  },
                  hinttext: 'content',
                  mycontroller: content,
                ),
                MaterialButton(
                  onPressed: () async {
                    await addnote();
                  },
                  child: Text('Add note'),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
                MaterialButton(
                  onPressed: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                              height: 150,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Please Choose Image ",
                                      textAlign: TextAlign.start),
                                  TextButton(
                                      onPressed: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        file = File(xfile!.path);
                                        Navigator.of(context).pop();
                                        setState(() {

                                        });

                                      },
                                      child: Text("From Gallary")),
                                  TextButton(
                                      onPressed: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        file = File(xfile!.path);
                                        Navigator.of(context).pop();
                                        setState(() {

                                        });
                                      },
                                      child: Text("From Camera")),
                                ],
                              ),
                            ));
                  },
                  child:Text('Upload image'),
                  color:file==null?  Colors.blue:Colors.cyanAccent,
                  textColor: Colors.white,
                )
              ],
            ),
          )),
    );
  }
}
