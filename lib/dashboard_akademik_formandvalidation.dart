import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const FormValidationApp());
}

class FormValidationApp extends StatelessWidget {
  const FormValidationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Peminjaman Buku',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const PeminjamanBukuPage(),
    );
  }
}

// ============ DATA MODEL ============
class DataPeminjaman {
  final String namaPeminjam;
  final String nim;
  final String judulBuku;
  final DateTime tanggalPeminjaman;
  final int durasiHari;
  final String noTelepon;
  final String email;
  final String jenisIdentitas;
  final bool setujuSyarat;

  DataPeminjaman({
    required this.namaPeminjam,
    required this.nim,
    required this.judulBuku,
    required this.tanggalPeminjaman,
    required this.durasiHari,
    required this.noTelepon,
    required this.email,
    required this.jenisIdentitas,
    required this.setujuSyarat,
  });

  @override
  String toString() {
    return '''
    DATA PEMINJAMAN
    ════════════════════════════════════
    Nama Peminjam: $namaPeminjam
    NIM/ID: $nim
    Jenis Identitas: $jenisIdentitas
    Email: $email
    Telepon: $noTelepon
    
    Judul Buku: $judulBuku
    Tgl Peminjaman: ${DateFormat('dd MMMM yyyy').format(tanggalPeminjaman)}
    Durasi: $durasiHari hari
    Est. Kembali: ${DateFormat('dd MMMM yyyy').format(tanggalPeminjaman.add(Duration(days: durasiHari)))}
    
    Setuju Syarat: ${setujuSyarat ? 'YA' : 'TIDAK'}
    ''';
  }
}

// ============ HALAMAN FORM PEMINJAMAN ============
class PeminjamanBukuPage extends StatefulWidget {
  const PeminjamanBukuPage({Key? key}) : super(key: key);

  @override
  State<PeminjamanBukuPage> createState() => _PeminjamanBukuPageState();
}

class _PeminjamanBukuPageState extends State<PeminjamanBukuPage> {
  // ===== FORM KEY & CONTROLLERS =====
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPeminjamController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _tanggalPeminjamanController =
      TextEditingController();

  // ===== STATE VARIABLES =====
  String? _judulBukuTerpilih;
  int? _durasiDipilih;
  String _jenisIdentitas = 'NIM';
  bool _setujuSyarat = false;
  DateTime? _tanggalPeminjaman;
  bool _isLoading = false;

  // ===== DATA DUMMY =====
  final List<String> _daftarBuku = [
    'Algoritma dan Struktur Data',
    'Basis Data Relasional',
    'Pemrograman Berorientasi Objek',
    'Web Development dengan Flutter',
    'Database Design Patterns',
    'Clean Code: A Handbook of Agile Software Craftsmanship',
  ];

  final List<int> _durasiOptions = [1, 3, 7, 14, 30];

  @override
  void dispose() {
    _namaPeminjamController.dispose();
    _nimController.dispose();
    _noTeleponController.dispose();
    _emailController.dispose();
    _tanggalPeminjamanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Peminjaman Buku'),
        elevation: 4,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER SECTION =====
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[300]!, Colors.blue[700]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.library_books, color: Colors.white, size: 40),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Formulir Peminjaman Buku',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Lengkapi form di bawah untuk peminjaman buku',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== FORM SECTION =====
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== SECTION 1: DATA PEMINJAM =====
                    const Text(
                      'Data Peminjam',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Input 1: Nama Peminjam
                    TextFormField(
                      controller: _namaPeminjamController,
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        hintText: 'Contoh: Ahmad Pratama',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama harus diisi';
                        }
                        if (value.length < 3) {
                          return 'Nama minimal 3 karakter';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Nama hanya boleh mengandung huruf';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Input 2: NIM / ID Numbers
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: _jenisIdentitas,
                            decoration: InputDecoration(
                              labelText: 'Jenis ID',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'NIM',
                                child: Text('NIM'),
                              ),
                              DropdownMenuItem(
                                value: 'NIK',
                                child: Text('NIK'),
                              ),
                              DropdownMenuItem(
                                value: 'Paspor',
                                child: Text('Paspor'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _jenisIdentitas = value ?? 'NIM';
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _nimController,
                            decoration: InputDecoration(
                              labelText: _jenisIdentitas,
                              hintText: 'Contoh: 2024001234',
                              prefixIcon: const Icon(Icons.credit_card),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '$_jenisIdentitas harus diisi';
                              }
                              if (value.length < 8) {
                                return '$_jenisIdentitas minimal 8 karakter';
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'Hanya boleh angka';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Input 3: Email
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'nama@universitas.ac.id',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email harus diisi';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Input 4: Nomor Telepon
                    TextFormField(
                      controller: _noTeleponController,
                      decoration: InputDecoration(
                        labelText: 'Nomor Telepon',
                        hintText: '08123456789',
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor telepon harus diisi';
                        }
                        if (!RegExp(r'^08[0-9]{8,11}$').hasMatch(value)) {
                          return 'Nomor telepon harus diawali 08 dan 10-13 digit';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // ===== SECTION 2: DATA PEMINJAMAN =====
                    const Text(
                      'Data Peminjaman',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Input 5: Judul Buku (Dropdown)
                    DropdownButtonFormField<String>(
                      value: _judulBukuTerpilih,
                      decoration: InputDecoration(
                        labelText: 'Judul Buku',
                        hintText: 'Pilih buku yang ingin dipinjam',
                        prefixIcon: const Icon(Icons.book),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _daftarBuku.map((buku) {
                        return DropdownMenuItem(value: buku, child: Text(buku));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _judulBukuTerpilih = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih judul buku';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Input 6: Tanggal Peminjaman (DatePicker)
                    TextFormField(
                      controller: _tanggalPeminjamanController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Peminjaman',
                        hintText: 'Pilih tanggal',
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.date_range),
                          onPressed: _selectTanggal,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih tanggal peminjaman';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Input 7: Durasi Peminjaman (Dropdown)
                    DropdownButtonFormField<int>(
                      value: _durasiDipilih,
                      decoration: InputDecoration(
                        labelText: 'Durasi Peminjaman',
                        hintText: 'Berapa lama ingin meminjam?',
                        prefixIcon: const Icon(Icons.timer),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _durasiOptions.map((durasi) {
                        return DropdownMenuItem(
                          value: durasi,
                          child: Text('$durasi hari'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _durasiDipilih = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih durasi peminjaman';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // ===== SECTION 3: SYARAT & KETENTUAN =====
                    const Text(
                      'Syarat & Ketentuan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: _setujuSyarat,
                                  onChanged: (value) {
                                    setState(() {
                                      _setujuSyarat = value ?? false;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _showSyaratDialog();
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Saya setuju dengan ',
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'syarat & ketentuan',
                                              style: TextStyle(
                                                color: Colors.blue[600],
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            const TextSpan(
                                              text:
                                                  ' peminjaman buku perpustakaan',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (!_setujuSyarat)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Anda harus menyetujui syarat & ketentuan',
                                  style: TextStyle(
                                    color: Colors.red[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ===== ACTION BUTTONS =====
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _submitForm,
                            icon: _isLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Icon(Icons.check),
                            label: Text(_isLoading ? 'Memproses...' : 'Kirim'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _resetForm,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== HELPER METHODS =====

  Future<void> _selectTanggal() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Colors.blue[600]!),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _tanggalPeminjaman = picked;
        _tanggalPeminjamanController.text = DateFormat(
          'dd MMMM yyyy',
        ).format(picked);
      });
    }
  }

  void _submitForm() {
    if (!_setujuSyarat) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda harus menyetujui syarat & ketentuan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        final dataPeminjaman = DataPeminjaman(
          namaPeminjam: _namaPeminjamController.text,
          nim: _nimController.text,
          judulBuku: _judulBukuTerpilih!,
          tanggalPeminjaman: _tanggalPeminjaman!,
          durasiHari: _durasiDipilih!,
          noTelepon: _noTeleponController.text,
          email: _emailController.text,
          jenisIdentitas: _jenisIdentitas,
          setujuSyarat: _setujuSyarat,
        );

        _showSuccessDialog(dataPeminjaman);
      });
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _namaPeminjamController.clear();
    _nimController.clear();
    _noTeleponController.clear();
    _emailController.clear();
    _tanggalPeminjamanController.clear();

    setState(() {
      _judulBukuTerpilih = null;
      _durasiDipilih = null;
      _jenisIdentitas = 'NIM';
      _setujuSyarat = false;
      _tanggalPeminjaman = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form telah direset'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showSuccessDialog(DataPeminjaman data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600]),
              const SizedBox(width: 8),
              const Text('Peminjaman Berhasil!'),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              data.toString(),
              style: const TextStyle(fontFamily: 'Courier'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _showSyaratDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Syarat & Ketentuan Peminjaman Buku'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '1. Durasi Peminjaman',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('   • Maksimal peminjaman 30 hari'),
                Text('   • Perpanjangan dapat dilakukan 1 kali'),
                SizedBox(height: 8),
                Text(
                  '2. Tanggung Jawab Peminjam',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('   • Peminjam bertanggung jawab atas kondisi buku'),
                Text('   • Denda Rp 5.000 per hari untuk keterlambatan'),
                Text('   • Buku yang hilang harus diganti'),
                SizedBox(height: 8),
                Text(
                  '3. Pengembalian',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('   • Kembalikan dalam kondisi baik'),
                Text('   • Tepat waktu sesuai jadwal yang ditentukan'),
                SizedBox(height: 8),
                Text(
                  '4. Sanksi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('   • Keterlambatan berulang akan didaftarkan'),
                Text('   • Hilangnya hak peminjaman sementara'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
