import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class getData{
  Future categoryData()async{
    String url="https://newprod.zypher.co/ebooks/getHome";
    var response=await http.post(url,headers: {
      "userId": "5ec972e92d2da600109e8844"
    });
    var data=jsonDecode(response.body);
    print(data['category']);
    return data['category'];
  }
}