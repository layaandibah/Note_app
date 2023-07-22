import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesphpapp/components/costemformfialed.dart';
import 'package:notesphpapp/components/curd.dart';
import 'package:notesphpapp/components/valid.dart';
import 'package:notesphpapp/constant/linkes.dart';
import 'package:notesphpapp/main.dart';

class Editenote extends StatefulWidget {
  final notes;

  const Editenote({Key? key, this.notes}) : super(key: key);

  @override
  State<Editenote> createState() => _EditenoteState();
}

class _EditenoteState extends State<Editenote> {
  File? file;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Curd _curd = Curd();

  editenote() async {
    if (formstate.currentState!.validate()) {
      var res;
      //للتأكد من انه تم رفع صورة من جديد والتعديل عليها
      if (file == null) {
        res = _curd.postRequest(linkEditeNote, {
          'title': title.text,
          'content': content.text,
          "userid": sharedPrf.get('id'),
          "notes_id":widget.notes['notes_id'].toString(),
          "note_image": widget.notes['note_image'].toString()
        });
      } else {
        res = _curd.postRequestwithFile(
            linkEditeNote,
            {
              'title': title.text,
              'content': content.text,
              "userid": sharedPrf.get('id'),
              "notes_id":widget.notes['notes_id'].toString(),
              "note_image": widget.notes['note_image'].toString()
            },
            file!);
      }
      setState(() {

      });
      Navigator.of(context).pushReplacementNamed("home");
      return res;
    }
  }

  @override
  void initState() {
    title.text = widget.notes['title'];
    content.text = widget.notes['content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edite note"),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formstate,
            child: Column(
              children: [
                CostumFormFaildSing(
                  valid: (val) {
                    valid(30, 5, val!);
                  },
                  hinttext: 'title',
                  mycontroller: title,
                ),
                CostumFormFaildSing(
                  valid: (val) {
                    valid(20000, 2, val!);
                  },
                  hinttext: 'content',
                  mycontroller: content,
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
                                        setState(() {});
                                      },
                                      child: Text("From Gallary")),
                                  TextButton(
                                      onPressed: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        file = File(xfile!.path);
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                      child: Text("From Camera")),
                                ],
                              ),
                            ));
                  },
                  child: Text('Upload image'),
                  color: file == null ? Colors.blue : Colors.cyanAccent,
                  textColor: Colors.white,
                ),
                MaterialButton(
                  onPressed: () async {
                    await editenote();
                  },
                  child: Text('Edite note'),
                  color: Colors.blue,
                  textColor: Colors.white,
                )
              ],
            ),
          )),
    );
  }
}
