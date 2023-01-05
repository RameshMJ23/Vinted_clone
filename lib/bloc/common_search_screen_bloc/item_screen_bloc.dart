

import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/common_search_screen_bloc/item_screen_search_state.dart';
import 'package:vintedclone/data/model/search_item_model.dart';

class ItemScreenBloc extends Cubit<ItemScreenSearchState>{

  static List<SearchItemModel> itemsList = [
    SearchItemModel(
      searchTerm: "Accessories",
      categoryPath: ["Women", "Accessories"],
      route: ["Women"],
      categoryName: "All",
      otherOption: "size_option_1"
    ),
    SearchItemModel(
      searchTerm: "Accessories",
      categoryPath: ["Kids", "Girls' clothing"],
      route: ["Kids", "Girls' clothing", "Accessories"],
      categoryName: "All",
      otherOption: "size_option_1"
    ),
    SearchItemModel(
      searchTerm: "Accessories",
      categoryPath: ["Men", "Accessories"],
      route: ["Men", "Accessories"],
      categoryName: "All",
      otherOption: "size_option_1",
    ),
    SearchItemModel(
      searchTerm: "Accessories",
      categoryPath: ["Pet care", "Dogs"],
      route: ["Pet care", "Dogs"],
      categoryName: "All",
      otherOption: "material_option_1",
      noBrand: true
    ),
    SearchItemModel(
      searchTerm: "Accessories",
      categoryPath: ["Home", "Home accessories"],
      route: ["Home", "Home accessories"],
      categoryName: "Home accessories",
      otherOption: "material_option_2",
      noBrand: true
    ),
    SearchItemModel(
      searchTerm: "ABOUT YOU",
      categoryPath:["Women", "Clothes"],
      route: ["Women", "Clothes"],
      categoryName: "All",
      otherOption: "size_option_1"
    ),
    SearchItemModel(
      searchTerm: "ABOUT YOU",
      categoryPath: ["Men", "Clothes"],
      route: ["Men", "Clothes"],
      categoryName: "All",
      otherOption: "size_option_4"
    ),
    SearchItemModel(
      searchTerm: "ABOUT YOU",
      categoryPath: ["Kids", "Girls' clothing"],
      route: ["Kids", "Girls' clothing"],
      categoryName: "All",
      otherOption: "size_option_6"
    ),
    SearchItemModel(
      searchTerm: "Aftershave & cologne",
      categoryPath: ["Men", "Grooming"],
      route: ["Men", "Grooming"],
      categoryName: "Aftershave & cologne",
      noBrand: true
    ),
    SearchItemModel(
      searchTerm: "Aftershave & cologne",
      categoryPath: ["Women", "Beauty"],
      route: ["Women", "Beauty"],
      categoryName: "Aftershave & cologne",
      noBrand: true
    ),
    SearchItemModel(
      searchTerm: "Boys' clothing",
      categoryPath: ["Kids", "Boy's clothing"],
      route: ["Kids", "Boy's clothing"],
      categoryName: "All",
      otherOption: "size_option_6"
    ),
    SearchItemModel(
      searchTerm: "Books",
      categoryPath: ["Entertainment", "Books"],
      route: ["Men", "Accessories"],
      categoryName: "All",
      isbnField: true,
      noBrand: true
    ),
    SearchItemModel(
      searchTerm: "Baby care",
      categoryPath: ["Kids", "Baby care"],
      route: ["Men", "Accessories"],
      categoryName: "All",
      noBrand: true,
    ),
    SearchItemModel(
      searchTerm: "Buggies",
      categoryPath: ["Kids", "Buggies"],
      route: ["Kids", "Buggies"],
      categoryName: "All",
      noBrand: true
    ),
    SearchItemModel(
      searchTerm: "Clothes",
      categoryPath: ["Women", "Clothes"],
      route: ["Women", "Clothes"],
      categoryName: "All",
      otherOption: "size_option_1"
    ),
    SearchItemModel(
      searchTerm: "Clothes",
      categoryPath: ["Men", "Clothes"],
      route: ["Men", "Clothes"],
      categoryName: "All",
      otherOption: "size_option_4"
    ),
    SearchItemModel(
      searchTerm: "Clothes",
      categoryPath: ["Kids", "Girls' clothing"],
      route: ["Kids", "Girls' clothing"],
      categoryName: "All",
      otherOption: "size_option_6"
    ),
    SearchItemModel(
      searchTerm: "Clothes",
      categoryPath: ["Entertainment", "Books"],
      route: ["Entertainment", "Books"],
      categoryName: "All",
      isbnField: true,
      noBrand: true
    ),
    SearchItemModel(
      searchTerm: "Costumes & special outfits",
      categoryPath: ["Women", "Clothes"],
      route: ["Women", "Clothes"],
      categoryName:  "Costumes & special outfits",
      otherOption: "size_option_1"
    ),
    SearchItemModel(
      searchTerm: "Other clothing",
      categoryPath: ["Women", "Clothes",],
      route: ["Women", "Clothes",],
      categoryName: "Other clothing",
      otherOption: "size_option_1"
    ),
    SearchItemModel(
      searchTerm: "Textiles",
      categoryPath: ["Home", "Textiles"],
      materialOption: "material_option_1",
      route: ["Home", "Textiles"],
      categoryName: "All",
      noBrand: true
    ),
    SearchItemModel(
      searchTerm: "Tableware",
      categoryPath: ["Home", "Tableware"],
      materialOption: "material_option_1",
      route: ["Home", "Tableware"],
      categoryName: "All",
      noBrand: true
    ),
    SearchItemModel(
      searchTerm: "Games & puzzles",
      categoryPath: ["Entertainment", "Games & puzzles"],
      route: ["Entertainment", "Games & puzzles"],
      categoryName: "All",
      noBrand: true
    )
  ];

  /*
    BlocProvider.of<CategorySelectionBloc>(context).selectOption(
      index: index,
      categoryName: optionList[index].name,
      unisex: optionList[index].unisex,
      color: optionList[index].color,
      materialOption: optionList[index].materialOption,
      otherOption: optionList[index].otherOption,
      isbnField: optionList[index].isbnField,
      route: BlocProvider.of<CategorySelectionBloc>(context).state.temporaryRoute,
      noBrand: optionList[index].no_brand
    );*/

  ItemScreenBloc():super(ItemScreenSearchState(searchText: "", itemList: null));

  filterSearch(String searchText){

    List<SearchItemModel> filteredList = itemsList.where(
      (element) => element.searchTerm.toLowerCase().contains(
        searchText.toLowerCase()
      )
    ).toList();

    emit(ItemScreenSearchState(searchText: searchText, itemList: filteredList));
  }

  resetSearch(){
    emit(ItemScreenSearchState(searchText: "", itemList: null));
  }
}