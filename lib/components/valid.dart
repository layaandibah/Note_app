import '../constant/message.dart';

valid(int max, int min ,String val){
     if(val.length>max){
       return "$messageOutputMax $max";
     }
     if(val.isEmpty){
       return "$messageOutputEmpty";
     }
     if(val.length<min){
       return "$messageOutputMin $min";
     }

}