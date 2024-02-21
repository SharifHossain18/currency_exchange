
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_converter/Model/currency_model.dart';
import 'package:currency_converter/Servicees/api_services.dart';
import 'package:flutter/material.dart';

import 'components.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCurrency="Usd";
  ApiServices apiServices=ApiServices();

  Widget _dropDownItem(Country country){
    return Container(
      child: Row(
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8,),
          Text(country.currencyName.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(height: 8,),
        Text("Base Currency",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white
        ),
        ),
        SizedBox(height: 8,),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: CountryPickerDropdown(initialValue: "Us",
          itemBuilder: _dropDownItem,
            onValuePicked: (Country? country){
            setState(() {
              _selectedCurrency=country!.currencyCode.toString();
            });
            },
          ),
        ),
        SizedBox(height: 8,),
        Text("All Currency",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white
          ),
        ),
        SizedBox(height: 8,),
        FutureBuilder(
            future: apiServices.getLatest(_selectedCurrency),
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<CurrencyModel>? currencyModelList=snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      itemCount: currencyModelList!.length,
                      itemBuilder: (context,index){
                        return AllCurrencyListItem(currencyModel: currencyModelList[index],);
                      }),
                );
              }
              if(snapshot.hasError){
                return Center(child: Text("Error Occured"),);
              }
              return Center(child: CircularProgressIndicator(),);

            })
      ],
    );
  }
}
