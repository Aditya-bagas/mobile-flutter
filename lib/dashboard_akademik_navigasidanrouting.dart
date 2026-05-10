import 'package:flutter/material.dart';

void main() {
  runApp(const AcademicApp());
}

// ============ DATA MODEL ============
class MataKuliah {
  final String id;
  final String nama;
  final String dosen;
  final int sks;
  final String hari;
  final String jam;
  final String ruangan;
  final double nilai;

  MataKuliah({
    required this.id,
    required this.nama,
    required this.dosen,
    required this.sks,
    required this.hari,
    required this.jam,
    required this.ruangan,
    required this.nilai,
  });
}

class Dosen {
  final String id;
  final String nama;
  final String nidn;
  final String email;
  final String telepon;
  final String pendidikan;
  final String keahlian;

  Dosen({
    required this.id,
    required this.nama,
    required this.nidn,
    required this.email,
    required this.telepon,
    required this.pendidikan,
    required this.keahlian,
  });
}

// ============ MAIN APP - SETUP ROUTING ============
class AcademicApp extends StatelessWidget {
  const AcademicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Akademik',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      
      // ===== NAMED ROUTES CONFIGURATION =====
      routes: {
        '/profil-dosen': (context) => const ProfilDosenPage(),
      },

      // ===== DYNAMIC ROUTES DENGAN ARGUMENTS =====
      onGenerateRoute: (settings) {
        if (settings.name == '/detail-matakuliah') {
          final mataKuliah = settings.arguments as MataKuliah;
          return MaterialPageRoute(
            builder: (context) => DetailMataKuliahPage(
              mataKuliah: mataKuliah,
            ),
          );
        }
        return null;
      },

      home: const BerandaPage(),
    );
  }
}

// ============ HALAMAN 1: BERANDA ============
class BerandaPage extends StatelessWidget {
  const BerandaPage({Key? key}) : super(key: key);

  // Data dummy mata kuliah
  static final List<MataKuliah> daftarMataKuliah = [
    MataKuliah(
      id: '1',
      nama: 'Pemrograman Lanjut',
      dosen: 'Dr. Budi Santoso',
      sks: 3,
      hari: 'Senin',
      jam: '08:00 - 10:00',
      ruangan: 'Lab 101',
      nilai: 3.7,
    ),
    MataKuliah(
      id: '2',
      nama: 'Basis Data',
      dosen: 'Prof. Siti Nurhaliza',
      sks: 4,
      hari: 'Selasa',
      jam: '10:00 - 12:00',
      ruangan: 'Ruang 205',
      nilai: 3.5,
    ),
    MataKuliah(
      id: '3',
      nama: 'Algoritma dan Struktur Data',
      dosen: 'Dr. Ahmad Ridho',
      sks: 3,
      hari: 'Rabu',
      jam: '13:00 - 15:00',
      ruangan: 'Lab 102',
      nilai: 3.8,
    ),
    MataKuliah(
      id: '4',
      nama: 'Keamanan Sistem',
      dosen: 'Drs. Eka Prasetya',
      sks: 3,
      hari: 'Kamis',
      jam: '08:00 - 10:00',
      ruangan: 'Ruang 301',
      nilai: 3.6,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda - Dashboard Akademik'),
        elevation: 4,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[400]!, Colors.blue[800]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selamat Datang Mahasiswa',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ahmad Pratama',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'IPK',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '3.65',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Semester',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '4',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'SKS Diambil',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '13',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== SECTION: DAFTAR MATA KULIAH =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mata Kuliah Semester Ini',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${daftarMataKuliah.length} Kelas',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ===== LISTA MATA KULIAH DENGAN DOFFERENT NAVIGATIONS =====
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: daftarMataKuliah.length,
                itemBuilder: (context, index) {
                  final mataKuliah = daftarMataKuliah[index];
                  final isPushPop = index.isEven; // Gunakan push-pop untuk index genap

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            mataKuliah.sks.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        mataKuliah.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            mataKuliah.dosen,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            '${mataKuliah.hari} • ${mataKuliah.jam}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mataKuliah.nilai.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue[700],
                            ),
                          ),
                          Text(
                            isPushPop ? 'Push-Pop' : 'Named',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (isPushPop) {
                          // ===== TEKNIK 1: PUSH-POP (Manual Navigation) =====
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailMataKuliahPage(
                                mataKuliah: mataKuliah,
                              ),
                            ),
                          );
                        } else {
                          // ===== TEKNIK 2: NAMED ROUTES (Push dengan Named Route) =====
                          Navigator.of(context).pushNamed(
                            '/detail-matakuliah',
                            arguments: mataKuliah,
                          );
                        }
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // ===== TOMBOL AKSI =====
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigasi ke Profil Dosen menggunakan Named Route
                        Navigator.of(context).pushNamed('/profil-dosen');
                      },
                      icon: const Icon(Icons.person),
                      label: const Text('Lihat Profil Dosen'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Named route ke profil dosen
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fitur unduh transkrip akan datang'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Unduh Transkrip'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ HALAMAN 2: DETAIL MATA KULIAH ============
class DetailMataKuliahPage extends StatelessWidget {
  final MataKuliah mataKuliah;

  const DetailMataKuliahPage({
    Key? key,
    required this.mataKuliah,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mata Kuliah'),
        elevation: 4,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Pop kembali ke halaman sebelumnya
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER INFO =====
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[400]!, Colors.green[800]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mataKuliah.nama,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SKS',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                mataKuliah.sks.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nilai',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                mataKuliah.nilai.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== INFORMASI JADWAL =====
              const Text(
                'Jadwal Kelas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildInfoRow('Hari', mataKuliah.hari),
                      const Divider(),
                      _buildInfoRow('Jam', mataKuliah.jam),
                      const Divider(),
                      _buildInfoRow('Ruangan', mataKuliah.ruangan),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== INFORMASI DOSEN =====
              const Text(
                'Informasi Dosen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue[100],
                            child: Text(
                              mataKuliah.dosen.split(' ')[0][0],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mataKuliah.dosen,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Dosen Pengampu',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigasi ke profil dosen menggunakan push-pop
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfilDosenPage(
                                namaDosenAwal: mataKuliah.dosen,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.person_outline),
                        label: const Text('Lihat Profil Dosen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== TOMBOL AKSI =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Materi kuliah telah ditambahkan ke favorit'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.star_outline),
                  label: const Text('Tambah ke Favorit'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ============ HALAMAN 3: PROFIL DOSEN ============
class ProfilDosenPage extends StatelessWidget {
  final String? namaDosenAwal;

  const ProfilDosenPage({
    Key? key,
    this.namaDosenAwal,
  }) : super(key: key);

  // Data dummy dosen - bisa dikembangkan lebih lanjut
  static final List<Dosen> daftarDosen = [
    Dosen(
      id: '1',
      nama: 'Dr. Budi Santoso',
      nidn: '001234567890',
      email: 'budi.santoso@universitas.ac.id',
      telepon: '08123456789',
      pendidikan: 'S3 Ilmu Komputer - ITB',
      keahlian: 'Pemrograman, Artificial Intelligence',
    ),
    Dosen(
      id: '2',
      nama: 'Prof. Siti Nurhaliza',
      nidn: '002345678901',
      email: 'siti.nurhaliza@universitas.ac.id',
      telepon: '08234567890',
      pendidikan: 'S3 Teknik Informatika - UI',
      keahlian: 'Database, Data Mining',
    ),
    Dosen(
      id: '3',
      nama: 'Dr. Ahmad Ridho',
      nidn: '003456789012',
      email: 'ahmad.ridho@universitas.ac.id',
      telepon: '08345678901',
      pendidikan: 'S3 Ilmu Komputer - USU',
      keahlian: 'Algoritma, Struktur Data',
    ),
    Dosen(
      id: '4',
      nama: 'Drs. Eka Prasetya',
      nidn: '004567890123',
      email: 'eka.prasetya@universitas.ac.id',
      telepon: '08456789012',
      pendidikan: 'S2 Sistem Informasi - BINUS',
      keahlian: 'Keamanan Siber, Forensik Digital',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter dosen berdasarkan nama jika ada parameter
    final Dosen dosenTerpilih = namaDosenAwal != null
        ? daftarDosen.firstWhere(
            (d) => d.nama == namaDosenAwal,
            orElse: () => daftarDosen[0],
          )
        : daftarDosen[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Dosen'),
        elevation: 4,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // ===== PROFIL HEADER =====
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple[400]!, Colors.purple[800]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Text(
                          dosenTerpilih.nama.split(' ')[0][0] +
                              dosenTerpilih.nama.split(' ').last[0],
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        dosenTerpilih.nama,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dosenTerpilih.nidn,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== INFORMASI KONTAK =====
              const Text(
                'Informasi Kontak',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildContactRow(
                        Icons.email,
                        'Email',
                        dosenTerpilih.email,
                      ),
                      const Divider(),
                      _buildContactRow(
                        Icons.phone,
                        'Telepon',
                        dosenTerpilih.telepon,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== PENDIDIKAN & KEAHLIAN =====
              const Text(
                'Latar Belakang Akademik',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pendidikan Terakhir',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dosenTerpilih.pendidikan,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Keahlian',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: dosenTerpilih.keahlian
                            .split(', ')
                            .map((keahlian) {
                          return Chip(
                            label: Text(keahlian),
                            backgroundColor: Colors.purple[100],
                            labelStyle: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 12,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== DAFTAR DOSEN LAIN =====
              const Text(
                'Dosen Lainnya',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: daftarDosen.length,
                itemBuilder: (context, index) {
                  final dosen = daftarDosen[index];
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple[100],
                        child: Text(
                          dosen.nama.split(' ')[0][0] +
                              dosen.nama.split(' ').last[0],
                          style: TextStyle(
                            color: Colors.purple[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(dosen.nama),
                      subtitle: Text(dosen.keahlian.split(',')[0]),
                      onTap: () {
                        // Navigasi ke profil dosen lain dengan push-pop
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilDosenPage(
                              namaDosenAwal: dosen.nama,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.purple[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
