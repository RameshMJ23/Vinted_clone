import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vintedclone/bloc/book_info_bloc/book_info_bloc.dart';
import 'package:vintedclone/bloc/book_info_bloc/book_info_state.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_bloc.dart';
import 'package:vintedclone/data/model/book_info_model.dart';
import 'package:vintedclone/data/service/book_info_service.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';

class IsbnScreen extends StatefulWidget {

  @override
  _IsbnScreenState createState() => _IsbnScreenState();

  BookInfoBloc bookInfoBloc;

  SellBloc sellBloc;

  String initialIsbnValue;

  IsbnScreen({
    required this.bookInfoBloc,
    required this.sellBloc,
    required this.initialIsbnValue
  });

}

class _IsbnScreenState extends State<IsbnScreen> {

  late final TextEditingController _isbnFieldController;

  late final GlobalKey<FormFieldState> _isbnFieldKey;

  @override
  void initState() {

    // TODO: implement initState
    _isbnFieldController = TextEditingController();
    _isbnFieldKey = GlobalKey<FormFieldState>();

    _isbnFieldController.text = widget.initialIsbnValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.bookInfoBloc),
        BlocProvider.value(value: widget.sellBloc),
      ],
      child: Builder(
        builder: (blocContext){
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: getAppBar(
              context: context,
              title: "ISBN"
            ),
            persistentFooterButtons: [
              buildButton(
                  content: "Submit",
                  buttonColor: getBlueColor(),
                  contentColor: Colors.white,
                  onPressed: (){
                    if(_isbnFieldKey.currentState!.validate()){

                      BlocProvider.of<SellBloc>(blocContext).changeIsbnNum(
                        _isbnFieldController.text
                      );

                      BlocProvider.of<BookInfoBloc>(blocContext).checkBook(
                        _isbnFieldController.text
                      );

                      showDialog(
                          context: context,
                          builder: (dialogContext){
                            return Dialog(
                              child: BlocBuilder<BookInfoBloc, BookInfoState>(
                                bloc: BlocProvider.of<BookInfoBloc>(blocContext),
                                builder: (blocContext, bookState){

                                  if(bookState is FoundBookInfoState
                                      || bookState is NoBookFoundState){
                                    Future.delayed(const Duration(seconds: 1), (){
                                      Navigator.pop(dialogContext);
                                    });
                                  }

                                  if(bookState is CheckingBookInfoState){
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 8.0
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(
                                            color: getBlueColor(),
                                          ),
                                          const SizedBox(height: 10.0,),
                                          const Text(
                                            "Hold on a moment, checking for ISBN",
                                            style: TextStyle(
                                                fontFamily: "MaisonMedium",
                                                fontSize: 15.0,
                                                color: Colors.black87
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }else if(bookState is VerifiedBookInfoState || bookState is NoBookFoundState){
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 8.0
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 50.0,
                                          ),
                                          Text(
                                            "ISBN confirmed",
                                            style: TextStyle(
                                              fontFamily: "Maisonmedium",
                                              fontSize: 15.0,
                                              color: Colors.black87
                                            ),
                                          ),
                                          Text(
                                            "Please continue with you listing",
                                            style: TextStyle(
                                              fontFamily: "Maisonmedium",
                                              fontSize: 14.0,
                                              color: Colors.black87
                                            )
                                          )
                                        ],
                                      ),
                                    );
                                  }else if(bookState is FoundBookInfoState){
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 8.0
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 50.0,
                                          ),
                                          Text(
                                            "Found it!",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: "Maisonmedium",
                                              color: Colors.black87
                                            ),
                                          ),
                                          Text(
                                            "To save our time, we have auto-filled"
                                                " some info from publisher",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "Maisonmedium"
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    );
                                  }else{
                                    return const SizedBox();
                                  }

                                },
                              ),
                            );
                          }
                      ).then((value){
                        Navigator.pop(context);
                      });

                    }
                  },
                  splashColor: Colors.white24
              )
            ],
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                            key: _isbnFieldKey,
                            hintText: "978-3-16-148410-0",
                            controller: _isbnFieldController,
                            errorTextColor: Colors.red.shade300,
                            validatorFunc: (val) => (
                                val == null || val.isEmpty || !(val.length == 10 || val.length == 13)
                            )
                              ? "ISBN must be 10 or 13 digits in length"
                              : null
                        ),
                      ),
                      IconButton(
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        color: getBlueColor(),
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: () async{
                          await Permission.camera.request().then((status){
                            if(status == PermissionStatus.granted){

                              FocusManager.instance.primaryFocus!.unfocus();

                              Navigator.pushNamed(
                                  context,
                                  RouteNames.barcodeScannerScreen,
                                  arguments: {
                                    "childCurrent" : this
                                  }
                              ).then((value) async{
                                _isbnFieldController.text = (value as String);
                              });
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
                const Divider(height: 0.5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Example of the number",
                        style: TextStyle(
                          fontFamily: "MaisonBook",
                          color: Colors.grey.shade600,
                          fontSize: 16.0
                        )
                      ),
                      Center(
                        child: Image.asset(
                          "assets/isbn_image.jpg",
                          height: 150.0,
                          width: 250.0,
                        ),
                      ),
                      Text(
                        "The ISBN is usually located on the copyright page, but it can "
                            "be placed above the book's bar code or on its back cover",
                        style: TextStyle(
                          fontFamily: "MaisonBook",
                          color: Colors.grey.shade600,
                          fontSize: 14.0
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
