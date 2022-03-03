import 'dart:convert';

import 'package:covid_19_demo/model/WorldStatesModel.dart';
import 'package:covid_19_demo/services/utils/api_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{
  Future<WorldStatesModel> fetchWorldStatesRecord()async{
    final response=await http.get(Uri.parse(ApiUrls.worldStatesApi));

    if(response.statusCode==200){
      var data=await jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchCountriesRecord()async{
    final response=await http.get(Uri.parse(ApiUrls.countriesList));

    var data=[];
    if(response.statusCode==200){
      data=await jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');
    }
  }
}