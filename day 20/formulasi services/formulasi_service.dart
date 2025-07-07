import 'dart:convert';
import 'package:ceramicalc_app/models/formulasi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormulasiService {
  static const String _keyFormulasi = 'formulasi_list';

  ///Simpan Formulasi
  static Future<void> saveFormulasiList(List<Formulasi> formulasiList) async {
    final prefs = await SharedPreferences.getInstance();

    /// Convert list ke JSON String
    final jsonList = formulasiList.map((f) => f.toJson()).toList();
    final jsonString = jsonEncode(jsonList);

    await prefs.setString(_keyFormulasi, jsonString);
  }

  ///Ambil List Formulasi
  static Future<List<Formulasi>> getFormulasiList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyFormulasi);
    if (jsonString == null) return [];

    try {
      ///Convert JSON String Ke List
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => Formulasi.fromJson(json)).toList();
    } catch (e) {
      print("Error  Loading Formulasi: $e");
      return[];
    }
  }

  ///Simipan Satu Formulasi Baru
  static Future<void> saveFormulasi(Formulasi formulasi) async {
    final currentList = await getFormulasiList();
    currentList.add(formulasi);
    await saveFormulasiList(currentList);
  }

  ///Hapus Formulasi
  static Future<void> deleteFormulasi(String id) async {
    final currentList = await getFormulasiList();
    currentList.removeWhere((f) => f.id == id);
    await saveFormulasiList(currentList);
  }
}
