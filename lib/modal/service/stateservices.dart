import 'dart:convert';
import 'package:covid_19/modal/model.dart';
import 'package:covid_19/modal/service/utiliti/App_uri.dart';
import 'package:http/http.dart'as http;

class Stateservices{
Future<welcome> fetchdata()async{
  final Response = await http.get(Uri.parse(Appurl.worldStateApi));
  if (Response.statusCode == 200) {
    var data = jsonDecode(Response.body.toString());
    return welcome.fromJson(data);
  }else{
 throw Exception('Error');
  }
}
Future<List<dynamic>> Countrydata()async{
  var data;
  final Response = await http.get(Uri.parse(Appurl.countrieslist));
  if (Response.statusCode == 200) {
     data = jsonDecode(Response.body);
    return data;
  }else{
 throw Exception('Error');
  }

}
}

