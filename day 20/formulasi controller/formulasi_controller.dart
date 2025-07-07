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
    _isLoading = true;
    notifyListeners();

    try {
      _formulasiList = await FormulasiService.getFormulasiList();
    } catch (e) {
      print('Error loading formulasi: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  ///Tambah Formulasi Baru
  Future<bool> tambahFormulasi(Formulasi formulasi) async {
    try {
      _formulasiList.add(formulasi);
      await FormulasiService.saveFormulasi(formulasi);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error saving formulasi: $e');
      // Remove from list if save failed
      _formulasiList.removeLast();
      notifyListeners();
      return false;
    }
  }

  /// Hapus Formulasi
  Future<bool> hapusFormulasi(String id) async {
    try {
      final removedFormulasi = _formulasiList.firstWhere((f) => f.id == id);
      _formulasiList.removeWhere((f) => f.id == id);
      await FormulasiService.deleteFormulasi(id);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting formulasi: $e');
      return false;
    }
  }

  // Update formulasi
  Future<bool> updateFormulasi(Formulasi formulasi) async {
    try {
      final index = _formulasiList.indexWhere((f) => f.id == formulasi.id);
      if (index != -1) {
        _formulasiList[index] = formulasi;
        await FormulasiService.updateFormulasi(formulasi);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating formulasi: $e');
      return false;
    }
  }
}
