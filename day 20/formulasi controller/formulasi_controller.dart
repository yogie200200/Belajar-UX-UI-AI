import 'package:ceramicalc_app/models/formulasi_model.dart';
import 'package:ceramicalc_app/services/formulasi_service.dart';
import 'package:flutter/cupertino.dart';

class FormulasiController extends ChangeNotifier {
  List<Formulasi> _formulasiList = [];
  bool _isLoading = false;

  List<Formulasi> get formulasiList => _formulasiList;
  bool get isLoading => _isLoading;

  ///Load Data Dari SharedPreferences
  Future<void> loadFormulasi() async {
    _formulasiList = await FormulasiService.getFormulasiList();
    notifyListeners();
  }

  ///Tambah Formulasi Baru
  Future<void> tambahFormulasi(Formulasi formulasi)async{
    _formulasiList.add(formulasi);
    await FormulasiService.saveFormulasi(formulasi);
    notifyListeners();
  }

  /// Hapus Formulasi
  Future<void> hapusFormulasi(String id)async{
    _formulasiList.removeWhere((f)=>f.id == id);
    await FormulasiService.deleteFormulasi(id);
    notifyListeners();
  }
}
