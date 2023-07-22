import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:path/path.dart';




String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'diana:diana12345'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};
class Curd {
  Future getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsedata = jsonDecode(response.body);
        return responsedata;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e ");
    }
  }

  Future postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data,headers: myheaders);
      if (response.statusCode == 200) {
        var responsedata = jsonDecode(response.body);
        return responsedata;
      } else {
        print("Errobbbr ${response.statusCode}");
      }
    } catch (e) {
      print("Errorrrrrr $e ");
    }
  }

  postRequestwithFile(String url, Map data, File file) async {
    //تستخدم هذه الدالة لرفع الملفات

    var request = await http.MultipartRequest("POST", Uri.parse(url));
    //انشئ متغيرات طول الملف وافتحه للقراءة
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    //تستخدم من اجل التعامل مع الملف
    var informationImage = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.headers.addAll(myheaders);
    //تعليمة رفع الملف وارساله مع لطلب
    request.files.add(informationImage);
    //لهنا تم رفع الملف ايضا
    //طريقة اخرى بدل loop
    //تستخدم من اجل رفع معلومات الملاحظة ايضا
    // request.fields['title ']= data['title'];
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    //ارسال الطلب بكافة الداتا من ملف ومعلومات
    var myrequest =await request.send();
    //تعتبر ستريم
    var response=await http.Response.fromStream(myrequest);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);

    } else {
      print("Error ${response.statusCode}");
    }

  }
}
