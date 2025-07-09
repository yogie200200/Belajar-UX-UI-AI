import 'package:ceramicalc_app/controller/bahan_input_controller.dart';
import 'package:ceramicalc_app/controller/formulasi_controller.dart';
import 'package:ceramicalc_app/models/formulasi_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormulasiBaruScreen extends StatefulWidget {
  const FormulasiBaruScreen({super.key});

  @override
  State<FormulasiBaruScreen> createState() => _FormulasiBaruScreenState();
}

class _FormulasiBaruScreenState extends State<FormulasiBaruScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaFormulasiController = TextEditingController();
  final _qtyTotalController = TextEditingController();
  final _deskripsiController = TextEditingController();
  late BahanInputController _bahanController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _bahanController = BahanInputController();
  }

  @override
  void dispose() {
    _namaFormulasiController.dispose();
    _qtyTotalController.dispose();
    _deskripsiController.dispose();
    _bahanController.dispose();
    super.dispose();
  }

  Future<void> _simpanFormulasi() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!_bahanController.validateAllBahan()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Mohon Lengkapi Semua Bahan"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final formulasi = Formulasi(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        namaFormulasi: _namaFormulasiController.text,
        qtyTotal: double.tryParse(_qtyTotalController.text) ?? 00,
        deskripsi: _deskripsiController.text,
        bahan: _bahanController.toBahanList(),
        tanggalDibuat: DateTime.now(),
      );
      final success = await context
          .read<FormulasiController>()
          .tambahFormulasi(formulasi);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Formulasi Berhasil Disimpan"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal Menyimpan Informasi"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          "Buat Formulasi",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Ayo Kita Buat Formulasi Baru Dengan Isi Form Berikut",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),

              /// Form controller nama formulasi
              TextFormField(
                controller: _namaFormulasiController,
                decoration: InputDecoration(
                  labelText: "Nama Formulasi",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.science),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama Formulasi Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 14),

              /// form controller deskkripsi
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: "Masukkan Deskripsi",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              /// form qty total
              TextFormField(
                controller: _qtyTotalController,
                decoration: InputDecoration(
                  labelText: "Masukkan Quantyty Total",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.production_quantity_limits),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Quantyty Total Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 26),

              /// section bahan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Daftar Bahan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _bahanController.tambahBahanInput();
                    },
                    icon: Icon(Icons.add),
                    label: Text("Tambah Bahan"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              /// list input bahan
              Expanded(
                child: ChangeNotifierProvider.value(
                  value: _bahanController,
                  child: Consumer<BahanInputController>(
                    builder: (context, controller, child) {
                      return ListView.builder(
                        itemCount: controller.bahanInputs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white12,
                            margin: EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Bahan ${index + 1}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (controller.bahanInputs.length > 1)
                                        IconButton(
                                          onPressed: () {
                                            controller.hapusBahanBaku(index);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    controller:
                                        controller
                                            .bahanInputs[index]
                                            .bahanBakuController,
                                    decoration: InputDecoration(
                                      labelText: "Masukkan Bahan Baku",
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    controller:
                                        controller
                                            .bahanInputs[index]
                                            .persentaseController,
                                    decoration: InputDecoration(
                                      labelText: "Masukkan Persentase",
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    controller:
                                        controller
                                            .bahanInputs[index]
                                            .satuanController,
                                    decoration: InputDecoration(
                                      labelText: "Satuan 'KG/Gr'",
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),

              /// tombol simpan
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _simpanFormulasi,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child:
                      _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                            "Simpan Formulasi",
                            style: TextStyle(fontSize: 16),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
