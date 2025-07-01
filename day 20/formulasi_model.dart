class Formulasi {
  final String id;
  final String namaFormulasi;
  final String deskripsi;
  final List<Bahan> bahan;
  final DateTime tanggalDibuat;

  Formulasi({
    required this.id,
    required this.namaFormulasi,
    required this.deskripsi,
    required this.bahan,
    required this.tanggalDibuat,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaFormulasi': namaFormulasi,
      'deskripsi': deskripsi,
      'bahan': bahan.map((b) => b.toJson()).toList(),
      'tanggalDibuat': tanggalDibuat.toIso8601String(),
    };
  }

  factory Formulasi.fromJson(Map<String, dynamic> json) {
    return Formulasi(
      id: json['id'],
      namaFormulasi: json['namaFormulasi'],
      deskripsi: json['deskripsi'],
      bahan: (json['bahan'] as List).map((b) => Bahan.fromJson(b)).toList(),
      tanggalDibuat: DateTime.parse(json['tanggalDibuat']),
    );
  }
}

class Bahan {
  final String bahanBaku;
  final String persentasi;
  final String satuan;
  final double qtyKering;
  final double qtyBasah;

  Bahan({
    required this.bahanBaku,
    required this.persentasi,
    required this.satuan,
    required this.qtyKering,
    required this.qtyBasah,
  });
  Map<String, dynamic> toJson (){
    return{
      'bahanBaku': bahanBaku,
      'persentasi': persentasi,
      'satuan' : satuan,
      'qtyKering': qtyKering,
      'qtyBasah': qtyBasah,
    };
  }
  factory Bahan.fromJson(Map<String, dynamic>json){
    return Bahan(
      bahanBaku: json['bahanBaku'],
      persentasi: json['persentasi'],
      satuan: json['satuan'],
      qtyKering: json['qtyKering'].toDouble(),
      qtyBasah: json['qtyBasah'].toDouble(),
    );
  }
}
