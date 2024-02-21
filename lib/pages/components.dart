
import 'package:currency_converter/Model/currency_model.dart';
import 'package:flutter/material.dart';

class AllCurrencyListItem extends StatelessWidget {
  final CurrencyModel currencyModel;
  const AllCurrencyListItem({super.key,
  required this.currencyModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(currencyModel.code.toString(),
          style: TextStyle(
            fontSize: 17,
            color: Colors.white
          ),
          ),
          Text(currencyModel.value!.toStringAsFixed(2).toString(),
            style: TextStyle(
                fontSize: 17,
                color: Colors.white
            ),
          )
        ],
      ),

    );
  }
}
