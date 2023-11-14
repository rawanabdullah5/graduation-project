import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences ? sharedPreferences;
  static init()async
  {
    sharedPreferences=await SharedPreferences.getInstance();
  }
  static  saveStringData({required String key, required String value})async
  {
    return await sharedPreferences?.setString(key, value);
  }
  static  saveBoolData({required String key, required bool value})async
  {
    return await sharedPreferences?.setBool(key, value);
  }
  static getData({required String key})
  {
    return sharedPreferences?.get(key);
  }
  static deleteData({required String key})async
  {
    return await sharedPreferences!.remove(key);
  }
}