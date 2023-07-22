import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notesphpapp/app/editnote.dart';
import 'package:notesphpapp/components/cardnotes.dart';
import 'package:notesphpapp/constant/linkes.dart';
import 'package:notesphpapp/main.dart';
import 'package:notesphpapp/model/notemodel.dart';
import '../../components/curd.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Curd curd = Curd();

  getNote() async {
    var res = await curd
        .postRequest(linkViewNote, {"userid": sharedPrf.getString("id")});

    return res;
  }

  deletenote(int id, String note_image) async {
    var res = await curd.postRequest(
        linkDeleteNote, {"notes_id": id.toString(), "imagename": note_image});
    setState(() {});
    return res;
  }

  @override
  void initState() {
    getNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed("addnote");
          },
          label: Text(
            "add",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          elevation: 0.0,
          tooltip: "add a note",
          foregroundColor: Colors.orangeAccent,
          backgroundColor: Colors.orange,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.amberAccent)),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                sharedPrf.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app),
            )
          ],
          title: Text("Home"),
        ),
        body: ListView(
          children: [
            FutureBuilder(
                future: getNote(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshote) {
                  if (snapshote.hasData) {
                    if (snapshote.data['status'] == 'failed')
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Notes is empty"),
                          ],
                        ),
                      );
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshote.data['data'].length,
                        itemBuilder: (context, i) {
                          return CardNotes(
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                AwesomeDialog(
                                  body: Text("Are you sure to delete? "),
                                  context: context,
                                  dialogType: DialogType.question,
                                  btnOk: MaterialButton(
                                    color: Colors.blue,
                                    child: Text("Delete"),
                                    onPressed: () async {
                                      await deletenote(
                                          snapshote.data['data'][i]["notes_id"],
                                          snapshote.data['data'][i]["note_image"]);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  btnCancel: MaterialButton(
                                    color: Colors.blue,
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ).show();
                              },
                            ),
                            ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Editenote(
                                        notes: snapshote.data['data'][i],
                                      )));
                            },
                            noteModel:
                                NoteModel.fromJson(snapshote.data['data'][i]),
                          );
                        });
                  }
                  if (snapshote.connectionState == ConnectionState.waiting) {
                    print('=============');
                    //print(sharedPrf.getString("id"));
                    return Center(
                      child: Text("Loading..."),
                    );
                  }
                  return Center(
                    child: Text("Loading..."),
                  );
                })
          ],
        ));
  }
}
