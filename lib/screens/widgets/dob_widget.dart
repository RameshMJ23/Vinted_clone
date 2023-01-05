

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:vintedclone/screens/constants.dart';

class DOBWidget extends StatelessWidget {


  final ValueNotifier<DateTime?> _dateTimeNotif
                       = ValueNotifier<DateTime?>(null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 55.0,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                      valueListenable: _dateTimeNotif,
                      builder: (context, DateTime? dateTime, child){
                        return Text(
                          dateTime == null
                              ? "mm/dd/yyyy"
                              : _getDate(dateTime),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontFamily: "MaisonBook",
                            fontSize: 16.0
                          ),
                        );
                      }
                  ),
                  const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black87
                  )
                ],
              ),
            ),
            Divider(height: 0.0, color: Colors.grey.shade500,)
          ],
        ),
      ),
      onTap: () async{
        await showRoundedDatePicker(
            barrierDismissible: true,
            context: context,
            initialDate: _dateTimeNotif.value ?? DateTime(2004),
            firstDate: DateTime(1900),
            styleDatePicker: MaterialRoundedDatePickerStyle(
                textStyleButtonPositive: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: "MaisonMedium"
                ),
                textStyleButtonNegative : TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: "MaisonMedium"
                ),
                paddingMonthHeader: const EdgeInsets.all(12)
            ),
            borderRadius: 5.0,
            theme: ThemeData(
              primaryColor: getBlueColor(),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.grey.shade600, // button text color
                ),
              ),
              textTheme: TextTheme(
                  caption: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: "MaisonMedium"
                  )
              ),
              accentTextTheme: TextTheme(
                bodyText2: TextStyle(
                    color: getBlueColor(),
                    fontFamily: "MaisonMedium"
                ),
              ),
              primaryTextTheme: TextTheme(
                  caption: TextStyle(
                      color: getBlueColor()
                  )
              ),
              accentColor: getBlueColor(),
            ),
            height: 320.0
        ).then((value) {
          _dateTimeNotif.value = value;
        });
      },
    );
  }

  String _getDate(DateTime dateTime){
    final year = dateTime.year;
    final month = dateTime.month.toString().length < 2
        ? dateTime.month.toString().padLeft(2, "0"): dateTime.month.toString();
    final day = dateTime.day.toString().length < 2
        ? dateTime.day.toString().padLeft(2, "0"): dateTime.day.toString();

    return "$month/$day/$year";
  }
}
