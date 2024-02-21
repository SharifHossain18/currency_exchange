
import 'dart:convert';

import 'package:currency_converter/Constant/constant.dart';
import 'package:http/http.dart' as http;
import '../Model/currency_model.dart';

class ApiServices{

  Future<List<CurrencyModel>> getLatest(String baseCurrency) async{
    List<CurrencyModel>currencyModelList=[];
    String url="${base_url}apikey=$api_key&base_currency=$baseCurrency";

    try{
      http.Response response=await http.get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String,dynamic> json=jsonDecode(response.body);
        Map<String,dynamic> body=json['data'];
        body.forEach((key, value) {
          CurrencyModel currencyModel=CurrencyModel.fromJson(value);
          currencyModelList.add(currencyModel);
        });
        return currencyModelList;

      }
      else{
        return [];
      }
    }
    catch(e){
      throw Exception(e.toString());
    }



  }
  Future<List<CurrencyModel>> getExchange(String baseCurrency, String targetCurrency) async{
    List<CurrencyModel>currencyModelList=[];
    String url="${base_url}apikey=$api_key&base_currency=$baseCurrency&currencies=$targetCurrency";

    try{
      http.Response response=await http.get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String,dynamic> json=jsonDecode(response.body);
        Map<String,dynamic> body=json['data'];
        body.forEach((key, value) {
          CurrencyModel currencyModel=CurrencyModel.fromJson(value);
          currencyModelList.add(currencyModel);
        });
        return currencyModelList;

      }
      else{
        return [];
      }
    }
    catch(e){
      throw Exception(e.toString());
    }



  }

}