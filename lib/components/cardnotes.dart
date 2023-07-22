import 'package:flutter/material.dart';
import 'package:notesphpapp/constant/linkes.dart';
import 'package:notesphpapp/model/notemodel.dart';

class CardNotes extends StatelessWidget {
  final void Function() ontap;
  final NoteModel noteModel;
  final Widget trailing;
  const CardNotes({Key? key,required this.ontap,required this.trailing, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:ontap ,
      child: Card(
        child: Row(children: [
          Expanded(
            child: Image.network("$linkImageUpload/${noteModel.noteImage}",height: 100,width: 100,fit: BoxFit.fill, ),

            flex: 1,
          ),
          Expanded(
            flex: 3,
            child: ListTile(
                title: Text("${noteModel.title}"),
                subtitle: Text("${noteModel.content}"),
                trailing:trailing
            ),
          )
        ]),
      ),
    );
  }
}
