
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

import '../Servicees/api_services.dart';

class Exchange extends StatefulWidget {
  const Exchange({super.key});

  @override
  State<Exchange> createState() => _ExchangeState();
}

class _ExchangeState extends State<Exchange> {
  String _selectedBaseCurrency="Usd";
  String _selectedTargetCurrency="Usd";
  String _totalValue='';
  ApiServices apiServices=ApiServices();
  final currencyController=TextEditingController();

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

    return Container(
      child: Column(
        children: [
          SizedBox(height: 8,),
          Center(
            child: Text("Base Currency",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
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
                  _selectedBaseCurrency=country!.currencyCode.toString();
                });
              },
            ),
          ),
          SizedBox(height: 8,),
          Container(
            width: 300,
            child: TextField(
              controller:currencyController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50)
                )
              ),
            ),
          ),
          SizedBox(height: 8,),
          Center(
            child: Text("Target Currency",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
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
            child: CountryPickerDropdown(initialValue: "GB",
              itemBuilder: _dropDownItem,
              onValuePicked: (Country? country){
                setState(() {
                  _selectedTargetCurrency=country!.currencyCode.toString();
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async{
                if(currencyController.text.isNotEmpty){
                    await apiServices.getExchange(_selectedBaseCurrency, _selectedTargetCurrency).then((result) {
                      double value=double.parse(currencyController.text);
                      double exchangeRate=double.parse(result[0].value.toString());
                      double total =value*exchangeRate;
                      print(value);
                      print(exchangeRate);

                      _totalValue=total.toStringAsFixed(2).toString();
                      setState(() {

                      });

                    });
                }

              },
              child: Text("Excahnge")),
          SizedBox(height: 10,),
          Text(_totalValue,
          style: TextStyle(
            fontSize: 60,
            color: Colors.green,
            fontWeight: FontWeight.bold
          ),
          )
        ],
      ),
    );
  }
}
