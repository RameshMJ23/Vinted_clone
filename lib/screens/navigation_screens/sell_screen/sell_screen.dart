import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:vintedclone/bloc/book_info_bloc/book_info_state.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_state.dart';
import 'package:vintedclone/bloc/color_selection_bloc/color_selection_bloc.dart';
import 'package:vintedclone/bloc/color_selection_bloc/color_selection_state.dart';
import 'package:vintedclone/bloc/photo_selector_bloc/photo_selector_bloc.dart';
import 'package:vintedclone/bloc/photo_selector_bloc/photo_selector_state.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_state.dart';
import 'package:vintedclone/screens/navigation_screens/sell_screen/upload_photo_screen.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'condition_screen.dart';
import 'package:vintedclone/screens/constants.dart';
import '../../../bloc/book_info_bloc/book_info_bloc.dart';
import 'option_screen.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/widgets/custom_photo_validator.dart';
import 'package:vintedclone/screens/widgets/custom_validator_field.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../../bloc/auth_bloc/auth_state.dart';
import '../../../bloc/item_bloc/item_bloc.dart';
import '../../../data/model/item_model.dart';


final pageBucket = PageStorageBucket();

class SellScreen extends StatefulWidget {

  Widget mainScreenInstance;

  PhotoSelectorBloc photoSelectorBloc;

  CategorySelectionBloc categorySelectionBloc;

  SellBloc sellBloc;

  ColorSelectionBloc colorSelectionBloc;

  AuthBloc authBloc;

  BookInfoBloc bookInfoBloc;

  SellScreen({
    required this.mainScreenInstance,
    required this.photoSelectorBloc,
    required this.categorySelectionBloc,
    required this.sellBloc,
    required this.colorSelectionBloc,
    required this.authBloc,
    required this.bookInfoBloc
  });

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> with AutomaticKeepAliveClientMixin<SellScreen>{
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late final GlobalKey<FormState> _key;
  late final GlobalKey<FormFieldState> _photoKey;


  @override
  void initState() {
    // TODO: implement initState
     _key = GlobalKey<FormState>();
     _photoKey = GlobalKey<FormFieldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return showPopDialogue(context);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: widget.photoSelectorBloc,
          ),
          BlocProvider.value(
            value: widget.categorySelectionBloc,
          ),
          BlocProvider.value(
            value: widget.sellBloc,
          ),
          BlocProvider.value(
            value: widget.colorSelectionBloc,
          ),
          BlocProvider.value(
            value: ItemBloc(),
          ),
          BlocProvider.value(
            value: widget.authBloc,
          ),
          BlocProvider.value(
            value: widget.bookInfoBloc,
          )
        ],
        child: Scaffold(
          appBar: getAppBar(
            showLeading: true,
            context: context,
            title: AppLocalizations.of(context)!.sellAnItem,
            leadingWidget: getCloseLeadingWidget(
              context: context,
              onPressed: (){
                showPopDialogue(context).then((value){
                  Navigator.pop(context);
                });
              }
            ),
            doPop: false
          ),
          body: Form(
            key: _key,
            child: PageStorage(
              bucket: pageBucket,
              child: ListView(
                key: const PageStorageKey<String>("sellScreenList"),
                controller: ScrollController(
                  keepScrollOffset: true,
                  initialScrollOffset: 0.0
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.addUpTo20Photos + " ",
                          style: TextStyle(
                            fontFamily: "MaisonBook",
                            fontSize: 18.0,
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.none
                          ),
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.seePhotoTips,
                              style: TextStyle(
                                fontFamily: "MaisonBook",
                                fontSize: 18.0,
                                color: getBlueColor(),
                                decoration: TextDecoration.underline
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                showTipsBottomSheet(context);
                              }
                            )
                          ]
                        )
                    ),
                  ),
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: BlocBuilder<PhotoSelectorBloc, PhotoSelectorState>(
                      builder: (context, state){
                        return Column(
                          children: [
                            Expanded(
                              child: state.photoList.isEmpty
                              ? Align(
                                alignment: Alignment.center,
                                child:  MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: getBlueColor())
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                  splashColor: getBlueColor().withOpacity(0.2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add, color: getBlueColor(),),
                                      Text(
                                        AppLocalizations.of(context)!.uploadPhotos,
                                        style: TextStyle(
                                          color: getBlueColor(),
                                          fontFamily: "MaisonBook"
                                        ),
                                      )
                                    ],
                                  ),
                                  onPressed: () async{
                                    await Permission.storage.request().then((value) async{
                                      if(value == PermissionStatus.granted){
                                        await PhotoGallery.listAlbums(
                                          mediumType: MediumType.image,
                                        ).then((albumValue) {
                                          albumValue[0].listMedia().then((mediaValue){
                                            Navigator.pushNamed(
                                              context,
                                              RouteNames.photoSelectionScreen,
                                              arguments: {
                                                "albumName": albumValue[0].name!,
                                                "mediaList": mediaValue,
                                                "uploadPhotoScreenEnum": UploadPhotoScreenEnum.sellScreen
                                            });
                                          });
                                        });
                                      }
                                    });
                                  },
                                ),
                              )
                              : ListView.builder(
                                itemCount: state.photoList.length + 1,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return (state.photoList.length == index )
                                  ? Align(
                                    child: Padding(
                                      child: SizedBox(
                                        height: 60.0,
                                        width: 60.0,
                                        child: MaterialButton(
                                          child: Align(
                                            child: Icon(Icons.add, color: getBlueColor(), size: 25.0,),
                                            alignment: Alignment.center,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(color: getBlueColor()),
                                            borderRadius: BorderRadius.circular(5.0)
                                          ),
                                          onPressed: () async{
                                            await Permission.storage.request().then((value) async{
                                              if(value == PermissionStatus.granted){
                                                await PhotoGallery.listAlbums(
                                                  mediumType: MediumType.image,
                                                ).then((albumValue) {
                                                  albumValue[0].listMedia().then((mediaValue) async{
                                                    await Navigator.pushNamed(
                                                      context,
                                                      RouteNames.photoSelectionScreen,
                                                      arguments: {
                                                        "albumName": albumValue[0].name!,
                                                        "mediaList": mediaValue,
                                                        "childCurrent": widget,
                                                      }
                                                    );
                                                  });
                                                });
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    ),
                                    alignment: Alignment.center,
                                  )
                                  : Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(state.photoList[index]),
                                        ),
                                        fit: BoxFit.cover,
                                        opacity: 0.5
                                      )
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 5.0,
                                          right: 5.0,
                                          child: GestureDetector(
                                            child: const CircleAvatar(
                                              child: Icon(Icons.close, color: Colors.black87,size: 15.0,),
                                              backgroundColor: Colors.white,
                                              radius: 12.0,
                                            ),
                                            onTap: (){
                                              BlocProvider.of<PhotoSelectorBloc>(
                                                context
                                              ).removePhotos(state.photoList[index]);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  );
                                },
                              ),
                            ),
                            CustomPhotoValidator(
                              key: _photoKey,
                              validator: (val) => state.photoList.isEmpty
                                ? "Please upload atleast 1 photo"
                                : null
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  getSpacingWidget(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.titleTextField,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "MaisonBook",
                            color: Colors.grey.shade600
                          ),
                        ),
                        buildTextField(
                          errorTextSize: 13.0,
                          errorTextColor: Colors.red.shade300,
                          hintText: AppLocalizations.of(context)!.titleFieldHint,
                          controller: _titleController,
                          validatorFunc: (val) {
                            if(val!.isEmpty){
                              return "Title is required";
                            }else if(val.length <= 5){
                              return "Please add a title with at least 5 characters";
                            }else{
                              return null;
                            }
                          },
                          helperText: "e.g. White COS Jumper"
                        )
                      ],
                    ),
                  ),
                  const Divider(thickness: 1.5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.describeItem,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "MaisonBook",
                            color: Colors.grey.shade600
                          )
                        ),
                        SizedBox(
                          height: 100.0,
                          child: buildTextField(
                            errorTextSize: 13.0,
                            errorTextColor: Colors.red.shade300,
                            hintText: AppLocalizations.of(context)!.describeItemHint,
                            controller: _descriptionController,
                            validatorFunc: (val) {
                              if(val!.isEmpty){
                                return "Please enter a description";
                              }else if(val.length <= 5){
                                return "Please describe your item in 5 characters or more";
                              }else{
                                return null;
                              }
                            },
                            helperText: "e.g. Only worn a few imes, true to size",
                            multiLine: true
                          ),
                        )
                      ],
                    ),
                  ),
                  getSpacingWidget(context),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                    builder: (context, state){
                      return CustomValidatorOptionField(
                        optionName: AppLocalizations.of(context)!.categoryTab,
                        onPressed: () async{
                          Navigator.pushNamed(context, RouteNames.categoryScreen, arguments: {
                            "optionScreen" : true,
                            "childCurrent": widget,
                            "screeType": CategoryScreenType.categoryInSellScreen
                          });
                        },
                        selectedText: state.categoryName,
                        validator: (val) =>
                        (state.categoryName.isEmpty || state.categoryName == null)
                            ? "You need to select a category": null,
                      );
                    },
                  ),
                  const Divider(height: 0.5,),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                    builder: (context, state){
                      return (state.isbnField != null) ? BlocBuilder<SellBloc, SellState>(
                        builder: (context, sellState){
                          return CustomValidatorOptionField(
                            optionName: "ISBN",
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.isbnScreen,
                                arguments: {
                                  "childCurrent" : widget,
                                  "initialIsbnValue": sellState.isbnNumber ?? ""
                                }
                              );
                            },
                            selectedText: sellState.isbnNumber,
                            validator: (val) =>
                              (sellState.isbnNumber == null || sellState.isbnNumber!.isEmpty)
                                 ? "Please enter an ISBN to continue" : null,
                          );
                        },
                      ): const SizedBox(height: 0.0, width: 0.0);
                    },
                  ),
                  const Divider(height: 0.5,),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                    builder: (context, state){
                      return (state.isbnField != null) ? BlocBuilder<BookInfoBloc, BookInfoState>(
                        builder: (context, bookState){
                          return (bookState is FoundBookInfoState) ? CustomValidatorOptionField(
                            optionName: "Author",
                            onPressed: () {},
                            selectedText: bookState.bookInfoModel.authorName,
                            validator: (val) => null,
                            optionColor: Colors.grey.shade600,
                          ) : const SizedBox(height: 0.0, width: 0.0);
                        },
                      ): const SizedBox(height: 0.0, width: 0.0);
                    },
                  ),
                  const Divider(height: 0.5,),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                    builder: (context, state){
                      return (state.isbnField != null) ? BlocBuilder<BookInfoBloc, BookInfoState>(
                        builder: (context, bookState){
                          return (bookState is FoundBookInfoState) ? CustomValidatorOptionField(
                            optionName: "Title",
                            onPressed: () {},
                            selectedText: bookState.bookInfoModel.bookName,
                            validator: (val) => null,
                            optionColor: Colors.grey.shade600
                          ):const SizedBox(height: 0.0, width: 0.0);
                        },
                      ): const SizedBox(height: 0.0, width: 0.0);
                    },
                  ),
                  const Divider(height: 0.5,),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                    builder: (context, state){
                      return (state.noBrand == null) ? BlocBuilder<SellBloc, SellState>(
                        builder: (context, sellState){
                          return CustomValidatorOptionField(
                            optionName: AppLocalizations.of(context)!.brandTab,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.brandScreen,
                                arguments: {
                                  "childCurrent" : widget
                                }
                              );
                            },
                            selectedText: sellState.brand,
                            validator: (val) =>
                            (sellState.brand == null || sellState.brand!.isEmpty)
                              ? "Please select a brand" : null,
                          );
                        },
                      ): const SizedBox(height: 0.0, width: 0.0);
                    },
                  ),
                  const Divider(height: 0.5,),
                  BlocBuilder<SellBloc, SellState>(
                    builder: (context, state){
                      return CustomValidatorOptionField(
                        optionName: AppLocalizations.of(context)!.conditionTab,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.conditionScreen,
                            arguments: {
                             "childCurrent" : widget,
                              "conditionEnum": ConditionScreenEnum.sellScreen
                            }
                          );
                        },
                        selectedText: state.condition,
                        validator: (val) =>
                        (state.brand == null || state.brand!.isEmpty)
                            ? "Please select item condition" : null,
                      );
                    },
                  ),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                    builder: (context, state){
                      return (state.color != null)
                      ? BlocBuilder<ColorSelectionBloc, ColorSelectionState>(
                        builder: (context, colorState){
                          return CustomValidatorOptionField(
                              optionName: AppLocalizations.of(context)!.colorTab,
                              onPressed: () {
                                Navigator.pushNamed(context, RouteNames.coloursScreen, arguments: {
                                  "childCurrent": widget
                                });
                              },
                              validator: (val) =>
                              (colorState.colorList == null || colorState.colorList.isEmpty)
                                 ? "Please pick a colour" : null,
                              selectedText: _listToColor(colorState.colorList.toString())
                          );
                        },
                      )
                      : const SizedBox(height: 0.0, width: 0.0,);
                    },
                  ),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                    builder: (context, state){
                      return (state.otherOption != null) ? BlocBuilder<SellBloc, SellState>(
                        builder: (context, sizeState){
                          return CustomValidatorOptionField(
                              optionName: AppLocalizations.of(context)!.sizeTab,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.optionsScreen,
                                  arguments: {
                                    "screenTitle": "Size",
                                    "optionJson": state.otherOption!,
                                    "screenEnum": OptionScreenEnum.sizeScreen,
                                    "childCurrent": widget,
                                    "height": MediaQuery.of(context).size.height,
                                    "width":MediaQuery.of(context).size.width,
                                  }
                                );
                              },
                              validator: (val) =>
                              (sizeState.size == null || sizeState.size!.isEmpty)
                                  ? "Please choose a size" : null,
                              selectedText: sizeState.size
                          );
                        },
                      ): const SizedBox(height: 0.0, width: 0.0,);
                    },
                  ),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                    builder: (context, state){
                      return (state.materialOption != null) ? BlocBuilder<SellBloc, SellState>(
                        builder: (context, materialState){
                          return CustomValidatorOptionField(
                              optionName: AppLocalizations.of(context)!.materialTab,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.optionsScreen,
                                  arguments: {
                                    "screenTitle": "Material",
                                    "optionJson": state.materialOption!,
                                    "screenEnum": OptionScreenEnum.materialScreen,
                                    "childCurrent": widget
                                  }
                                );
                              },
                              validator: (val) =>
                              (materialState.material == null || materialState.material!.isEmpty)
                                  ? "Please choose a material" : null,
                              selectedText: materialState.material
                          );
                        },
                      ): const SizedBox(height: 0.0, width: 0.0,);
                    },
                  ),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                      builder: (context, state){
                        return (state.unisex != null && state.unisex!) ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                          child:  buildCheckBoxTileWidget(
                              onTap: () {
                                BlocProvider.of<SellBloc>(
                                  context
                                ).changeUnisex(
                                  !BlocProvider.of<SellBloc>(context).state.unisex
                                );
                              },
                              trailingWidget: BlocBuilder<SellBloc, SellState>(
                                builder: (context, sellState){
                                  return buildCustomCheckBox(sellState.unisex);
                                },
                              ),
                              tileName: "Unisex"
                          ),
                        ): const SizedBox(height: 0.0, width: 0.0,);
                      }
                  ),
                  getSpacingWidget(context),
                  BlocBuilder<SellBloc, SellState>(
                    builder: (context, state){
                      return CustomValidatorOptionField(
                        optionName: AppLocalizations.of(context)!.priceTab,
                        onPressed:  () async{
                          var price = await Navigator.pushNamed(context, RouteNames.priceScreen, arguments: {
                            "enteredPrice": state.price,
                            "childCurrent": widget
                          });

                          BlocProvider.of<SellBloc>(context).changePrice(price as String);
                        },
                        validator: (val) =>
                        (state.price == null || state.price!.isEmpty)
                            ? "Please enter a price" : null,
                        selectedText: state.price != null ? "€ ${state.price}" : null
                      );
                    },
                  ),
                  const Divider(height: 0.5,),
                  Builder(
                    builder: (blocContext){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                        child: buildCheckBoxTileWidget(
                          onTap: () {
                            BlocProvider.of<SellBloc>(blocContext).changeSwapping();
                          },
                          trailingWidget: BlocBuilder<SellBloc, SellState>(
                            builder: (context, state){
                              return buildCustomCheckBox(state.swapping);
                            },
                          ),
                          tileName: AppLocalizations.of(context)!.interestedInSwapping
                        ),
                      );
                    },
                  ),
                  getSpacingWidget(context),
                  BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                    builder: (context, state){
                      return state.isSelected
                      ?  Column(
                        children: [
                          BlocBuilder<SellBloc, SellState>(
                            builder: (context, parcelState){
                              return CustomValidatorOptionField(
                                optionName: "Parcel size",
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.parcelScreen,
                                    arguments: {
                                      "recommendedSizeIndex": 1,
                                      "childCurrent": widget
                                    }
                                  );
                                },
                                validator: (val) =>
                                (parcelState.price == null || parcelState.price!.isEmpty)
                                  ? "Please select parcel size" : null,
                                selectedText: parcelState.isParcelSelected ? parcelState.parcelSize: null
                              );
                            },
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Text(
                              "The buyer always pays for the postage",
                              style: TextStyle(
                                fontFamily: "MaisonMedium",
                                fontSize: 12.0,
                                color: Colors.grey.shade600
                              ),
                            ),
                          )
                        ],
                      )
                      : const SizedBox(height: 0.0,width: 0.0,);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: BlocBuilder<SellBloc, SellState>(
                            builder: (context, sellState){
                              return BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                                builder: (context, categoryState){
                                  return BlocBuilder<ColorSelectionBloc, ColorSelectionState>(
                                    builder: (context, colorState){
                                      return BlocBuilder<PhotoSelectorBloc, PhotoSelectorState>(
                                        builder: (context, state){
                                          return buildButton(
                                            content: AppLocalizations.of(context)!.uploadButton,
                                            buttonColor: getBlueColor(),
                                            contentColor: Colors.white,
                                            onPressed: () async{

                                              if(_key.currentState!.validate()){

                                                showDialog(
                                                    context: context,
                                                    builder: (dialogContext){

                                                      BlocProvider.of<ItemBloc>(context).uploadImage(state.photoList).then((photoList) {
                                                        BlocProvider.of<ItemBloc>(context).uploadItem(
                                                          ItemModel(
                                                            brand: sellState.brand ?? "",
                                                            category: categoryState.categoryName,
                                                            color: colorState.colorList,
                                                            cost: sellState.price ?? "",
                                                            interested: "0",
                                                            item_condition: sellState.condition ?? "",
                                                            item_description: _descriptionController.text,
                                                            item_title: _titleController.text,
                                                            photo: photoList,
                                                            saved: "0",
                                                            swapping: sellState.swapping,
                                                            time: DateTime.now(),
                                                            user_id: (BlocProvider.of<AuthBloc>(context).state as UserState).userId,
                                                            views: "0",
                                                            size: sellState.size,
                                                            product_id: null
                                                          )
                                                        ).then((value){
                                                          Navigator.pop(dialogContext);
                                                          Navigator.pop(context);
                                                        });
                                                      });

                                                      return Dialog(
                                                        insetPadding: const EdgeInsets.symmetric(
                                                            horizontal: 155.0
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                            vertical: 18.0
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              CircularProgressIndicator(
                                                                color: getBlueColor(),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                );
                                              }

                                            },
                                            splashColor: Colors.white.withOpacity(0.2)
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        _buildBottomDisclaimer(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildBottomDisclaimer(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Text(
      AppLocalizations.of(context)!.sellScreenDisclaimer,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 12.0
      ),
      textAlign: TextAlign.left,
    ),
  );

  showTipsBottomSheet(BuildContext context){
    showModalBottomSheet(
        isScrollControlled: false,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (sheetContext){
          return Column(
            children: [
              getBottomSheetScrollHeader(),
              Expanded(
                  child: Container(
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                      ),
                      color: Colors.grey.shade50
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: getBottomSheetContentHeader("Photo tips", sheetContext),
                        ),
                        Divider(color: Colors.grey.shade500, height: 0.5,),
                        Expanded(
                          child: ListView.separated(
                            itemCount: getPhotoTipList().length,
                            itemBuilder: (context, index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text(
                                      getPhotoTipList()[index].heading,
                                      style: const TextStyle(
                                        fontFamily: "MaisonMedium",
                                        fontSize: 22.0,
                                        color: Colors.black87
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Image.network(
                                        getPhotoTipList()[index].imageUrl
                                    ),
                                  ),
                                  Text(
                                    getPhotoTipList()[index].definition,
                                    style: TextStyle(
                                      fontFamily: "MaisonMedium",
                                      fontSize: 16.0,
                                      color: Colors.grey.shade600
                                    ),
                                    maxLines: 3,
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index){
                              return const SizedBox(
                                height: 20.0,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          );
        }
    );
  }

  String _listToColor(String listString){
    return listString.replaceAll("[", "").replaceAll("]", "");
  }

  Future<bool> showPopDialogue(BuildContext context) {

    Completer<bool> canPop = Completer();

    showDialog(
        useRootNavigator: true,
        context: context,
        builder: (dialogueContext){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.saveChangesBeforeClosing,
                    style: const TextStyle(
                      fontFamily: "MaisonMedium",
                      fontSize: 22.0,
                      color: Colors.black87
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildButton(
                          content: AppLocalizations.of(context)!.save,
                          buttonColor: getBlueColor(),
                          contentColor: Colors.white,
                          onPressed: (){
                            canPop.complete(true);
                            Navigator.pop(dialogueContext);
                          },
                          splashColor: Colors.white.withOpacity(0.2)
                        ),
                        buildButton(
                          content: AppLocalizations.of(context)!.discard,
                          buttonColor: Colors.transparent,
                          contentColor: Colors.red.shade300,
                          onPressed: (){
                            BlocProvider.of<PhotoSelectorBloc>(context).clearBloc();
                            canPop.complete(true);
                            Navigator.pop(dialogueContext);
                          },
                          splashColor: Colors.grey.withOpacity(0.2)
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );

    return canPop.future;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
