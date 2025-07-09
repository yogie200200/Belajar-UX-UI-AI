import 'package:ceramicalc_app/models/formulasi_model.dart';
import 'package:ceramicalc_app/screens/formulasi_baru_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/formulasi_controller.dart';

class DaftarFormulasi extends StatefulWidget {
  const DaftarFormulasi({super.key});

  @override
  State<DaftarFormulasi> createState() => _DaftarFormulasiState();
}

class _DaftarFormulasiState extends State<DaftarFormulasi> {
  @override
  void initstate() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FormulasiController>().loadFormulasi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Formulasi'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<FormulasiController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.formulasiList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.science_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada formulasi',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: controller.formulasiList.length,
            itemBuilder: (context, index) {
              final formulasi = controller.formulasiList[index];
              return Card(
                margin: EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    formulasi.namaFormulasi,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formulasi.deskripsi,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${formulasi.bahan.length} bahan • ${formulasi.tanggalDibuat.day}/${formulasi.tanggalDibuat.month}/${formulasi.tanggalDibuat.year}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Hapus Formulasi'),
                          content: Text('Yakin ingin menghapus formulasi "${formulasi.namaFormulasi}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Hapus', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        final success = await controller.hapusFormulasi(formulasi.id);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Formulasi berhasil dihapus')),
                          );
                        }
                      }
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                  onTap: () {
                    // Bisa ditambahkan navigasi ke detail page
                    _showDetailDialog(context, formulasi);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormulasiBaruScreen()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, Formulasi formulasi) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(formulasi.namaFormulasi),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(formulasi.deskripsi),
              SizedBox(height: 16),
              Text('Bahan:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...formulasi.bahan.map((bahan) => Padding(
                padding: EdgeInsets.only(left: 8, top: 4),
                child: Text('• ${bahan.bahanBaku}: ${bahan.persentase} ${bahan.satuan}'),
              )),
              SizedBox(height: 16),
              Text(
                'Dibuat: ${formulasi.tanggalDibuat.day}/${formulasi.tanggalDibuat.month}/${formulasi.tanggalDibuat.year}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
