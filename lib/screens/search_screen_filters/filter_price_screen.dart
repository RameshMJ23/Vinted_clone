import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_price_bloc/filter_price_bloc.dart';
import 'package:vintedclone/screens/constants.dart';

class FilterPriceScreen extends StatefulWidget {
  @override
  _FilterPriceScreenState createState() => _FilterPriceScreenState();
}

class _FilterPriceScreenState extends State<FilterPriceScreen> {

  final TextEditingController _fromPriceController = TextEditingController();

  final  TextEditingController _toPriceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    _fromPriceController.text =
        BlocProvider.of<FilterPriceBloc>(context).state.fromPrice ?? "";

    _toPriceController.text =
        BlocProvider.of<FilterPriceBloc>(context).state.toPrice ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Price",
        trailingWidget: getFilterTrailingWidget((){

        }),
        leadingWidget: getCloseLeadingWidget(context: context)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  child: _buildPriceTextField(
                    'Price from',
                    _fromPriceController,
                  ),
                  width: MediaQuery.of(context).size.width * 0.46,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _buildPriceTextField('To ', _toPriceController),
                  ),
                )
              ],
            ),
            const Spacer(),
            buildButton(
              content: "Show result",
              buttonColor: getBlueColor(),
              contentColor: Colors.white,
              onPressed: (){
                if(_toPriceController.text.isNotEmpty){
                  BlocProvider.of<FilterPriceBloc>(context).changeToPrice(
                    double.parse(_toPriceController.text).toStringAsFixed(2)
                  );
                }else{
                  BlocProvider.of<FilterPriceBloc>(context).changeToPrice(
                    null
                  );
                }

                if(_fromPriceController.text.isNotEmpty){
                  BlocProvider.of<FilterPriceBloc>(context).changeFromPrice(
                    double.parse(_fromPriceController.text).toStringAsFixed(2)
                  );
                }else{
                  BlocProvider.of<FilterPriceBloc>(context).changeFromPrice(
                    null
                  );
                }

                Navigator.pop(context);
              },
              splashColor: Colors.white24
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPriceTextField(
      String label,
      TextEditingController controller
  ) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "MaisonBook",
            color: Colors.grey.shade600,
            fontSize: 14.0
          ),
        ),
        buildTextField(
          autoFocus: true,
          hintText: "€0.00",
          controller: controller,
          validatorFunc: (val) => null,
          marginPadding: 0.0,
          keyboardType: TextInputType.number
        )
      ],
    ),
  );
}
