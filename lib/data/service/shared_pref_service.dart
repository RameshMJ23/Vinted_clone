

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  final itemsListKey = "itemsListKey";

  final charityIndexKey = "charityIndex";

  final isFirstTimeKey = "isFirstTimeKey";

  final isDataRequestedKey = "isDataRequested";

  static late SharedPreferences _sharedPreferences;

  static Future<SharedPreferences> initSharedPref() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  Future setInitialValue(List<String> itemsIdList) async =>
     await _sharedPreferences.setStringList(itemsListKey, itemsIdList);

  List<String>? getInitialItemList() =>
      _sharedPreferences.getStringList(itemsListKey);

  Future setCharityIndex(int selectedIndex) async =>
      await _sharedPreferences.setInt(charityIndexKey, selectedIndex);

  int? getCharityIndex() =>
      _sharedPreferences.getInt(charityIndexKey);

  Future setIsFirstTime(bool isFirstTime) async =>
      await _sharedPreferences.setBool(isFirstTimeKey, isFirstTime);

  bool? getIsFirstTime() =>
      _sharedPreferences.getBool(isFirstTimeKey);

  Future<bool> clearSharedPref() async => await _sharedPreferences.clear();

  Future setIsDataRequested(bool isDataRequested) async =>
      await _sharedPreferences.setBool(isDataRequestedKey, isDataRequested);

  bool? getIsDataRequested() =>
      _sharedPreferences.getBool(isDataRequestedKey);

  Future clearCharityIndex() async =>
      await _sharedPreferences.remove(charityIndexKey);
}