import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Dataprefs {
  static Future<bool> saveData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> dataHomePage = List<Map<String, dynamic>>.from(
        jsonDecode(prefs.getString('key') ?? '[]'));
    List<Map<String, dynamic>> dataYangSudahAda = dataHomePage;
    dataYangSudahAda.add(data);
    return await prefs.setString('key', jsonEncode(dataYangSudahAda));
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String saveData2 = prefs.getString('key') ?? '[]';
    var dataGet = List<Map<String, dynamic>>.from(jsonDecode(saveData2));
    List<Map<String, dynamic>> data1 = dataGet;
    return data1;
  }

  static Future<bool> editData(String id, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> dataYangsudahada2 =
        List<Map<String, dynamic>>.from(
            json.decode(prefs.getString('key') ?? '[]'));
    var edit = dataYangsudahada2.where((element) => element['id'] == id);
    var editing = edit.isEmpty ? null : edit.first;
    if (editing == null) {
      return false;
      //return harus var di atas
    }
    var index = dataYangsudahada2.indexOf(editing);
    editing['isCompleted'] = value;
    dataYangsudahada2.removeWhere((element) => element['id'] == id);
    dataYangsudahada2.insert(index, editing);

    return await prefs.setString('key', jsonEncode(dataYangsudahada2));
  }

  static Future<bool> removeData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> dataYangsudahada3 =
        List<Map<String, dynamic>>.from(
            json.decode(prefs.getString('key') ?? '[]'));
    dataYangsudahada3.removeWhere((element) => element['id'] == id);
    return await prefs.setString('key', jsonEncode(dataYangsudahada3));
  }
}
