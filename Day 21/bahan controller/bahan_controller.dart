import 'package:ceramicalc_app/models/formulasi_model.dart';
import 'package:flutter/material.dart';

class BahanInputController extends ChangeNotifier {
  List<BahanInput> _bahanInputs = [BahanInput()];

  List<BahanInput> get bahanInputs => _bahanInputs;

  void tambahBahanInput() {
    _bahanInputs.add(BahanInput());
    notifyListeners();
  }

  void hapusBahanBaku(int index) {
    if (_bahanInputs.length > 1) {
      _bahanInputs[index].dispose();
      _bahanInputs.removeAt(index);
      notifyListeners();
    }
  }

  void updateBahan(
    int index,
    String bahanBaku,
    String persentase,
    String satuan,
    double qtyKering,
    double qtyBasah,
  ) {
    if (index < _bahanInputs.length) {
      _bahanInputs[index].bahanBaku = bahanBaku;
      _bahanInputs[index].persentase = persentase;
      _bahanInputs[index].satuan = satuan;
      _bahanInputs[index].qtyKering = qtyKering;
      _bahanInputs[index].qtyBasah = qtyBasah;
      notifyListeners();
    }
  }

  bool validateAllBahan() {
    for (var bahan in _bahanInputs) {
      if (bahan.bahanBaku.isEmpty ||
          bahan.persentase.isEmpty ||
          bahan.satuan.isEmpty ||
          bahan.qtyKering == 0.0 ||
          bahan.qtyBasah == 0.0) {
        return false;
      }
    }
    return true;
  }

  List<Bahan> toBahanList(){
    return _bahanInputs.map((input)=> Bahan(
      bahanBaku: input.bahanBaku,
      persentase: input.persentase,
      satuan: input.satuan,
      qtyKering: input.qtyKering,
      qtyBasah: input.qtyBasah
    )).toList();
  }

  void reset(){
    for(var input in _bahanInputs){
      input.dispose();
    }
    _bahanInputs = [BahanInput()];
    notifyListeners();
  }

  @override
  void dispose(){
    for (var input in _bahanInputs){
      input.dispose();
    }
    super.dispose();
  }
}

class BahanInput{
  final TextEditingController bahanBakuController = TextEditingController();
  final TextEditingController persentaseController = TextEditingController();
  final TextEditingController satuanController = TextEditingController();
  final TextEditingController qtyKeringController = TextEditingController();
  final TextEditingController qtyBasahController = TextEditingController();

  String get bahanBaku => bahanBakuController.text;
  String get persentase => persentaseController.text;
  String get satuan => satuanController.text;
  double get qtyKering => double.tryParse(qtyKeringController.text) ?? 0.0;
  double get qtyBasah => double.tryParse(qtyBasahController.text) ?? 0.0;

  set bahanBaku(String value) => bahanBakuController.text = value;
  set persentase(String value) => persentaseController.text = value;
  set satuan(String value) => satuanController.text = value;
  set qtyKering(double value) => qtyKeringController.text = value.toString();
  set qtyBasah(double value) => qtyBasahController.text = value.toString();

  void dispose(){
    bahanBakuController.dispose();
    persentaseController.dispose();
    satuanController.dispose();
    qtyKeringController.dispose();
    qtyBasahController.dispose();
  }
}