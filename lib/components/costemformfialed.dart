import 'package:flutter/material.dart';

class CostumFormFaildSing extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? valid;
  const CostumFormFaildSing({Key? key,required this.hinttext, required this.mycontroller, this.valid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator:valid ,
  controller: mycontroller,
        decoration: InputDecoration(
          hintText: hinttext,
          contentPadding: EdgeInsets.symmetric(vertical:4,horizontal:8 ),
          border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),

          borderSide: BorderSide(color: Colors.yellow,width:6,)
           )
        ),
      ),
    );
  }
}
