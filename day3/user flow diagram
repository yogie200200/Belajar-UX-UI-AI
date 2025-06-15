### Hasil akhir user flow diagram CeramiCalc App

START
  ↓
[Dashboard/Home]
  ↓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
│ Pilihan Aksi Awal:         │
│ 1. Buat Formulasi Baru     │ → lanjut ke FLOW 1  
│ 2. Hitung dari Formulasi   │ → lanjut ke FLOW 2  
│ 3. Cek Riwayat Trial       │ → lanjut ke FLOW 3  
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

═════════════════════════════
FLOW 1: Buat Formulasi Baru
═════════════════════════════
  ↓
[Pilih: Formulasi Management]
  ↓
[Pilih: Create New Formulasi]
  ↓
[Input Nama Formulasi] 
  (contoh: "Mix A - Trial 001")
  ↓
[Add Bahan Baku] (Loop Input)
  ├── Clay 40%
  ├── Feldspar 30%
  ├── Silika 20%
  └── Air 10%
  ↓
[Review & Save Formulasi]
  ↓
✅ Success: "Formulasi Created!"
  ↓
[Prompt: Start Calculation?]
  ├── YES → FLOW 2 langsung (dengan formulasi terpilih)
  └── NO  → END / kembali ke Home

═════════════════════════════
FLOW 2: Hitung Formulasi
═════════════════════════════
  ↓
[Pilih: Hitung Formulasi]
  ↓
[Select Formulasi] 
  └── bisa dari database / dari Flow 1
  ↓
[Review Data Formulasi]
  ↓
[Input Parameters]
  ├── Kadar Air
  └── Residu Slip
  ↓
[Validasi Input → Notifikasi jika error]
  ↓
[Auto Calculate]
  ↓
[Review Hasil Kalkulasi]
  ↓
[Add Catatan] (opsional)
  ↓
[Simpan Hasil]
  ↓
Decision: Update Formulasi?
  ├── YES → [Edit Formulasi] → Simpan → END
  └── NO  → END

═════════════════════════════
FLOW 3: Riwayat & Duplikasi
═════════════════════════════
  ↓
[Pilih: History / Database]
  ↓
[Search / Filter Trial]
  ├── Tanggal
  ├── Nama Formulasi
  └── Catatan / Keyword
  ↓
[Lihat Detail Trial]
  ├── Komposisi Formulasi
  ├── Parameter Input
  ├── Hasil Kalkulasi
  ├── Catatan
  └── Hasil Trial
  ↓
Decision: Tindak Lanjut?
  ├── Edit → ke FLOW 1 (Edit Formulasi)
  ├── Duplicate → ke FLOW 2 (Formulasi sudah terisi)
  └── Back to List
  ↓
END
