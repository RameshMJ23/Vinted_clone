import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vintedclone/bloc/text_field_bloc/text_field_state.dart';
import 'package:vintedclone/data/service/shared_pref_service.dart';

import '../../constants.dart';

class SetupDonationsDetail extends StatelessWidget {

  final List<int> donationPercentages = List.generate(
    20,
    (index) => (index + 1) * 5
  );
  
  ValueNotifier<int> loadingNotifier = ValueNotifier<int>(0);

  ValueNotifier<bool?> isCharitySelected = ValueNotifier<bool?>(null);

  ValueNotifier<int?> selectedCharityIndex = ValueNotifier<int?>(null);

  @override
  Widget build(BuildContext context) {

    isCharitySelected.value = SharedPref().getCharityIndex() != null;

    selectedCharityIndex.value = SharedPref().getCharityIndex() ?? 2;

    log(isCharitySelected.toString() + "------------------From setup screen");

    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Set up Recurring donations",
        titleFontSize: 16.0
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDonationsHeader(
            headerTitle: "Donation",
            titleHorizontalPadding: 15.0,
            titleVertPadding: 5.0,
            headerTopPadding: 10.0
          ),
          const Divider(height: 0.5,),
          const SizedBox(height: 15.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ValueListenableBuilder(
              valueListenable: isCharitySelected,
              builder: (context, bool? isSelected, child){
                return (isSelected != null && isSelected)
                  ? child!
                  : const SizedBox.shrink();
              },
              child: buildButton(
                  verticalPadding: 5.0,
                  content: "Change my charity",
                  buttonColor: Colors.transparent,
                  contentColor: getBlueColor(),
                  onPressed: (){

                  },
                  splashColor: getBlueColor().withOpacity(0.2),
                  side: true
              ),
            ),
          ),
          buildDonationHeaderTitle(
            headerTitle: "Donation rate",
            horizontalPadding: 15.0
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: SizedBox(
              height: 60.0,
              child: ListView.builder(
                itemCount: donationPercentages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return ValueListenableBuilder(
                    valueListenable: selectedCharityIndex,
                    builder: (context, int? charityIndex, child){

                      bool isSelected = (
                          charityIndex != null &&
                          charityIndex == index
                      );

                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5.0
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${donationPercentages[index]} %",
                            style: TextStyle(
                              fontFamily: "MaisonMedium",
                              fontSize: 16.0,
                              color: isSelected
                                ? Colors.white
                                : Colors.black87
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: isSelected
                                ? getBlueColor()
                                : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                  ? Colors.transparent
                                  : Colors.grey.shade300
                              )
                          ),
                        ),
                        onTap: (){
                          selectedCharityIndex.value = index;
                        },
                      );
                    }
                  );
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                "This is the percentage of all of your future sales that will be donated to the charity on your behalf. "
                    "You can cancel Recurring Donations at any time in 'Profile -> Donations'.",
                style: TextStyle(
                  fontFamily: "MaisonBook",
                  fontSize: 12.0,
                  color: Colors.grey.shade600
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isCharitySelected,
            builder: (context, bool? isCharitySelected, child){
              return ( isCharitySelected != null && isCharitySelected)
                ? child!
                : const SizedBox();
            },
            child: Center(
              child: buildTextButton(
                vertPadding: 5.0,
                content: "Stop Recurring Donations",
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (dialogContext){
                        return Dialog(
                          insetPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Cancel donations",
                                    style: TextStyle(
                                      fontFamily: "MaisonMedium",
                                      fontSize: 25.0,
                                      color: Colors.black87
                                    ),
                                  ),
                                ),
                                Text(
                                  "Are you sure you want to canl recurring donations?",
                                  style: TextStyle(
                                    fontFamily: "MaisonMedium",
                                    fontSize: 16.0,
                                    color: Colors.grey.shade600
                                  ),
                                ),
                                const SizedBox(height: 10.0,),
                                buildButton(
                                  content: "Yes, I'd like to cancel",
                                  buttonColor: getBlueColor(),
                                  contentColor: Colors.white,
                                  onPressed: () async{
                                    await SharedPref().clearCharityIndex().then((value){
                                      Navigator.pop(dialogContext);
                                      Navigator.pop(context);
                                    });
                                  },
                                  splashColor: Colors.white24
                                ),
                                buildButton(
                                  content: "No, continue donations",
                                  buttonColor: Colors.transparent,
                                  contentColor: getBlueColor(),
                                  onPressed: (){
                                    Navigator.pop(dialogContext);
                                  },
                                  splashColor: getBlueColor().withOpacity(0.2)
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ValueListenableBuilder(
              valueListenable: isCharitySelected,
              builder: (context, bool? isSelected, child){
                return buildButton(
                    content: (isSelected != null && isSelected)
                      ? "Save chages"
                      : "Start Recurring donations",
                    buttonColor: getBlueColor(),
                    contentColor: Colors.white,
                    verticalPadding: 0.0,
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (dialogContext){

                            Future.delayed(const Duration(seconds: 1), () async{

                              await SharedPref().setCharityIndex(
                                selectedCharityIndex.value!
                              );

                              loadingNotifier.value = 1;
                            });

                            Future.delayed(const Duration(seconds: 3), (){
                              Navigator.pop(dialogContext);
                            }).then((value){
                              Navigator.pop(context);
                            });

                            return SizedBox(
                              height: 65.0,
                              width: 65.0,
                              child: Dialog(
                                insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 150.0
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: ValueListenableBuilder(
                                  valueListenable: loadingNotifier,
                                  builder: (context, int loadingVal, child){
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: SizedBox(
                                        height: 60.0,
                                        width: 60.0,
                                        child:  loadingVal == 0
                                        ? Center(
                                          child: CircularProgressIndicator(
                                            color: getBlueColor(),
                                          ),
                                        )
                                        : const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 35.0,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );

                          }
                      );
                    },
                    splashColor: Colors.white24
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
