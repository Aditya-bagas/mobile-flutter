import 'package:flutter/material.dart';

/*
================================================================================
APLIKASI NAVIGASI DAN ROUTING AKADEMIK DENGAN FLUTTER
================================================================================

PENJELASAN UNTUK PEMULA:
========================
Aplikasi ini mendemonstrasikan 2 teknik navigasi utama di Flutter:
1. Push-Pop Navigation: Manual navigation dengan MaterialPageRoute
2. Named Routes Navigation: Named route dengan definisi di MaterialApp

Bagian ini cocok dipelajari setelah memahami dasar Flutter di tugas2april.dart

================================================================================
KONSEP PENTING NAVIGASI DI FLUTTER:
================================================================================

1. NAVIGATOR (Pengelola Halaman)
   ============================
   Navigator = class untuk manage halaman stack (tumpukan halaman)
   
   Analogi: Navigator seperti tumpukan piring
   - Push = menambah piring baru di atas
   - Pop = mengambil piring teratas
   
   Navigator Stack = list halaman yang sedang active
   
   Saat app dibuka:
   Stack = [BerandaPage]
   
   User klik mata kuliah → push DetailMataKuliahPage:
   Stack = [DetailMataKuliahPage, BerandaPage]
   
   User klik back → pop DetailMataKuliahPage:
   Stack = [BerandaPage]

2. ROUTE (Halaman/Layar)
   ====================
   Route = representasi satu halaman/screen
   Contoh: BerandaPage route, DetailMataKuliahPage route, ProfilDosenPage route
   
   Jenis Route:
   - MaterialPageRoute: Default Flutter route dengan animasi Material Design
   - CupertinoPageRoute: iOS-style route dengan animasi swipe
   - Custom PageRoute: Custom animation & transition
   
   Di aplikasi ini semua pakai MaterialPageRoute

3. PUSH vs POP
   ===========
   PUSH: Menambah halaman baru ke navigation stack
   - Halaman sebelumnya tetap ada di stack (tidak di-hapus)
   - User bisa back ke halaman sebelumnya
   - Contoh: Navigator.push(context, MaterialPageRoute(...))
   
   POP: Menghapus halaman saat ini dari stack
   - Kembali ke halaman sebelumnya
   - Halaman saat ini di-discard
   - Contoh: Navigator.pop(context)
   
   PUSH vs POP visualisasi:
   
   Initial:        After PUSH:      After POP:
   [Beranda]       [Detail]         [Beranda]
                   [Beranda]        (back to Beranda)

4. PUSH-POP NAVIGATION (Manual Navigation)
   ======================================
   Teknik: Manual navigation dengan MaterialPageRoute
   
   Cara pakai:
   Navigator.of(context).push(
     MaterialPageRoute(
       builder: (context) => DetailMataKuliahPage(mataKuliah: mk)
     )
   );
   
   Keuntungan:
   ✓ Flexible: Bisa customize animasi, duration, dll
   ✓ Explicit: Jelas apa yang terjadi (tidak magic)
   ✓ Direct data passing: Langsung ke constructor widget
   ✓ Easy debug: Semua di satu place
   
   Kerugian:
   ✗ Boilerplate: Banyak kode repetitif
   ✗ Hard to maintain: Susah maintain jika banyak routes
   ✗ Not standardized: Setiap navigation bisa beda implementasi

5. NAMED ROUTES NAVIGATION (Route dengan Nama)
   ==========================================
   Teknik: Navigation menggunakan nama route (string)
   
   Setup di MaterialApp:
   routes: {'/profil-dosen': (context) => ProfilDosenPage()}
   onGenerateRoute: (settings) { ... }
   
   Cara pakai:
   Navigator.of(context).pushNamed('/profil-dosen', arguments: data);
   
   Keuntungan:
   ✓ Clean: Centralized route definition
   ✓ Maintainable: Easy to manage routes
   ✓ Deep linking: Cocok untuk notifikasi & shared links
   ✓ Less boilerplate: Lebih sedikit kode
   
   Kerugian:
   ✗ Type-unsafe: Arguments harus di-cast (String → Object)
   ✗ Less flexible: Hard untuk custom animation
   ✗ Distributed: Route handling di MaterialApp

6. ARGUMENTS (Mengirim Data antar Halaman)
   =====================================
   Ada 2 cara kirim data ke halaman berikutnya:
   
   Cara 1: Direct Constructor (Push-Pop)
   Navigator.push(
     MaterialPageRoute(
       builder: (context) => DetailPage(data: myData)
     )
   );
   
   Cara 2: Arguments (Named Routes)
   Navigator.pushNamed('/detail', arguments: myData);
   
   Di halaman tujuan:
   onGenerateRoute: (settings) {
     final data = settings.arguments as MyData;
     return MaterialPageRoute(
       builder: (context) => DetailPage(data: data)
     );
   }

7. RECURSIVE NAVIGATION (Navigate ke Halaman Sama)
   ============================================
   Teknik: Push halaman yang sama dengan data berbeda
   
   Contoh: ProfilDosenPage → user klik dosen lain → push ProfilDosenPage lagi
   
   Stack akan jadi:
   [ProfilDosenPage (Dosen B)]  ← Top
   [ProfilDosenPage (Dosen A)]
   [DetailMataKuliahPage]
   [BerandaPage]
   [AcademicApp]
   
   Keuntungan:
   ✓ User bisa explore multiple items tanpa balik
   ✓ Stack tetap tracked untuk back navigation
   ✓ Natural user flow

================================================================================
VISUALIZATION STACK NAVIGASI:
================================================================================

Initial state (App baru dibuka):
┌──────────────────┐
│  BerandaPage     │ ← Top (current)
└──────────────────┘

User klik detail mata kuliah:
┌──────────────────────────┐
│  DetailMataKuliahPage    │ ← Top (current)
├──────────────────────────┤
│  BerandaPage             │ (masih di stack)
└──────────────────────────┘

User klik lihat profil dosen:
┌──────────────────────────┐
│  ProfilDosenPage         │ ← Top (current)
├──────────────────────────┤
│  DetailMataKuliahPage    │ (masih di stack)
├──────────────────────────┤
│  BerandaPage             │ (masih di stack)
└──────────────────────────┘

User klik back button / Navigator.pop():
┌──────────────────────────┐
│  DetailMataKuliahPage    │ ← Top (kembali ke sini)
├──────────────────────────┤
│  BerandaPage             │ (masih di stack)
└──────────────────────────┘

================================================================================
DAFTAR WIDGET YANG DIGUNAKAN:
================================================================================

SETUP APLIKASI:
1. MaterialApp - Setup aplikasi dengan routing & theme
2. AcademicApp - Root widget (StatelessWidget)

HALAMAN UTAMA:
3. Scaffold - Struktur dasar halaman (AppBar, body)
4. AppBar - Header dengan title dan navigation button
5. SingleChildScrollView - Scrollable container untuk konten panjang
6. FloatingActionButton - Tombol aksi di bawah kanan

HALAMAN DETAIL:
7. BerandaPage - Halaman beranda (StatelessWidget)
8. DetailMataKuliahPage - Halaman detail mata kuliah (StatelessWidget)
9. ProfilDosenPage - Halaman profil dosen (StatelessWidget)

LAYOUT:
10. Column - Atur widget secara vertikal
11. Row - Atur widget secara horizontal
12. Card - Box dengan elevation untuk visual grouping
13. Container - Custom styling box
14. ListView - Scrollable list (vertikal)
15. ListView.builder - Efficient list builder
16. Wrap - Layout yang wrap ke baris berikutnya
17. Padding - Add spacing di sekitar widget
18. SizedBox - Fixed spacing antar widget

TEXT & LABEL:
19. Text - Widget untuk menulis teks

BUTTONS & INTERACTION:
20. IconButton - Button dengan icon
21. ElevatedButton - Button dengan background color
22. ElevatedButton.icon - Button dengan icon + label
23. ListTile - List item dengan leading, title, subtitle

STYLING:
24. InputDecoration - Styling untuk TextFormField/Dropdown
25. BoxDecoration - Styling untuk Container
26. LinearGradient - Gradient background
27. RoundedRectangleBorder - Rounded rectangle border
28. CircleAvatar - Circular avatar widget
29. Chip - Small tag/label widget

DIALOG & FEEDBACK:
30. SnackBar - Notification bar di bawah
31. ScaffoldMessenger - Widget untuk tampilkan SnackBar

NAVIGATION:
32. Navigator - Navigate antar halaman
33. MaterialPageRoute - Default Flutter route
34. GlobalKey - Key untuk akses widget state

ICONS:
35. Icon - Widget untuk menampilkan icon
36. Icons - Pre-made Material Design icons

DATA STRUCTURES:
37. MataKuliah - Data model untuk mata kuliah
38. Dosen - Data model untuk dosen

================================================================================
FLOW APLIKASI:
================================================================================

Entry Point:
main() → AcademicApp (setup routing)

Routing Setup di MaterialApp:
- routes: {'/profil-dosen': (context) => ProfilDosenPage()}
- onGenerateRoute: Handle '/detail-matakuliah' dengan arguments

Home Page:
AcademicApp → BerandaPage (halaman pertama)

Navigation Flow:
1. BerandaPage (default home)
   ├─ User klik detail mata kuliah (index genap)
   │  └─ Push-Pop: Navigator.push(DetailMataKuliahPage)
   └─ User klik detail mata kuliah (index ganjil)
      └─ Named Routes: Navigator.pushNamed('/detail-matakuliah', arguments: mk)

2. DetailMataKuliahPage
   ├─ User klik "Lihat Profil Dosen"
   │  └─ Push-Pop: Navigator.push(ProfilDosenPage)
   └─ User klik back button
      └─ Pop: Navigator.pop() → kembali ke BerandaPage

3. ProfilDosenPage
   ├─ User klik dosen lain (recursive navigation)
   │  └─ Push-Pop: Navigator.push(ProfilDosenPage lagi dengan dosen baru)
   └─ User klik back button
      └─ Pop: Navigator.pop() → kembali ke DetailMataKuliahPage

================================================================================
WORKFLOW USER:
================================================================================

1. User buka aplikasi → Tampilkan BerandaPage
2. BerandaPage menampilkan:
   - Header dengan info mahasiswa (nama, IPK, semester, SKS)
   - List mata kuliah semester ini
   - Setiap item adalah card yang clickable
3. User klik item mata kuliah → Navigate ke DetailMataKuliahPage
   - Demonstrasi: index genap pakai push-pop, index ganjil pakai named routes
4. DetailMataKuliahPage menampilkan:
   - Info mata kuliah lengkap (nama, SKS, nilai, jadwal, ruangan)
   - Info dosen pengampu
   - Button "Lihat Profil Dosen"
5. User klik "Lihat Profil Dosen" → Navigate ke ProfilDosenPage
6. ProfilDosenPage menampilkan:
   - Avatar & nama dosen
   - Info kontak (email, telepon)
   - Pendidikan & keahlian
   - List dosen lain yang clickable
7. User klik dosen lain → Navigate ke ProfilDosenPage lagi (recursive)
   - ProfilDosenPage push ProfilDosenPage dengan dosen berbeda
8. User klik back → Pop kembali bertahap:
   - ProfilDosenPage → DetailMataKuliahPage → BerandaPage

================================================================================
*/

void main() {
  // Entry point aplikasi Flutter
  // runApp() menjalankan aplikasi dengan root widget = AcademicApp
  // AcademicApp setup routing & theme aplikasi
  runApp(const AcademicApp());
}

// ============================================================================
// DATA MODEL 1: MATAKULIAH
// ============================================================================
// MataKuliah: Data model untuk representasi mata kuliah
// StatelessWidget: Data immutable (tidak berubah setelah dibuat)
//
// Kegunaan:
// - Type-safe data structure (berbeda dengan Map)
// - Autocomplete di IDE
// - Easier debugging & validation
// - Prevent runtime errors
//
// Properties (field):
// - id: Unique identifier (String)
// - nama: Nama mata kuliah (String)
// - dosen: Nama dosen pengampu (String)
// - sks: Satuan Kredit Semester (int)
// - hari: Hari kelas (String: Senin, Selasa, dll)
// - jam: Jam kelas (String: 08:00 - 10:00)
// - ruangan: Lokasi/ruangan kelas (String)
// - nilai: Score/nilai mata kuliah (double)
//
class MataKuliah {
  // final: Field tidak bisa diubah setelah object dibuat
  // Alasan: Immutable data lebih safe & predictable
  final String id;
  final String nama;
  final String dosen;
  final int sks;
  final String hari;
  final String jam;
  final String ruangan;
  final double nilai;

  // Constructor: Fungsi untuk membuat instance MataKuliah
  // required: Semua parameter wajib diberikan
  // { required this.id, ... }: Named parameters yang required
  //
  // Contoh pemanggilan:
  // MataKuliah(
  //   id: '1',
  //   nama: 'Pemrograman Lanjut',
  //   dosen: 'Dr. Budi Santoso',
  //   sks: 3,
  //   hari: 'Senin',
  //   jam: '08:00 - 10:00',
  //   ruangan: 'Lab 101',
  //   nilai: 3.7,
  // )
  //
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

// ============================================================================
// DATA MODEL 2: DOSEN
// ============================================================================
// Dosen: Data model untuk representasi dosen/instruktur
// Properties:
// - id: Unique identifier
// - nama: Nama lengkap dosen
// - nidn: Nomor Identitas Dosen Nasional
// - email: Email untuk komunikasi
// - telepon: Nomor telepon
// - pendidikan: Pendidikan terakhir (S3, S2, dll)
// - keahlian: Bidang keahlian (comma-separated)
//
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

// ============================================================================
// MAIN APP - ROUTING & THEME SETUP
// ============================================================================
// AcademicApp: Root widget untuk setup aplikasi
// StatelessWidget: Setup tidak berubah (fixed routes, fixed theme)
//
// Tanggung jawab:
// 1. Setup MaterialApp (theme, title, dll)
// 2. Define static routes (named routes)
// 3. Define dynamic routes (routes dengan arguments)
// 4. Set home page (halaman pertama)
//
class AcademicApp extends StatelessWidget {
  const AcademicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MaterialApp: Root widget untuk setup aplikasi Flutter
    // Properties penting:
    // - debugShowCheckedModeBanner: false → Hilangkan debug ribbon
    // - title: Nama aplikasi
    // - theme: Styling global (warna, font, dll)
    // - routes: Static named routes (simple routes, no arguments)
    // - onGenerateRoute: Dynamic routes handler (routes dengan arguments)
    // - home: Halaman pertama saat app dibuka
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Akademik',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

      // ===== STATIC NAMED ROUTES =====
      // routes: Map<String, WidgetBuilder>
      // Digunakan untuk: Routes yang tidak memerlukan arguments
      // Contoh: '/profil-dosen', '/settings', '/about'
      //
      // Keuntungan routes:
      // ✓ Simple & clean
      // ✓ Tidak perlu type-cast arguments
      // ✓ Cocok untuk fixed routes
      //
      // Cara pakai:
      // Navigator.pushNamed(context, '/profil-dosen');
      //
      routes: {'/profil-dosen': (context) => const ProfilDosenPage()},

      // ===== DYNAMIC ROUTES DENGAN ARGUMENTS =====
      // onGenerateRoute: Function untuk handle dynamic routes
      // Dipanggil ketika Navigator.pushNamed() dipanggil dengan route name
      // yang tidak ada di routes map
      //
      // Parameter settings:
      // - settings.name: Nama route (String)
      // - settings.arguments: Data yang dikirim (Object)
      //
      // Workflow:
      // 1. User action → Navigator.pushNamed('/detail-matakuliah', arguments: mk)
      // 2. MaterialApp call onGenerateRoute(settings)
      // 3. settings.name = '/detail-matakuliah'
      // 4. settings.arguments = mk (MataKuliah object)
      // 5. Extract & type-cast: final mk = settings.arguments as MataKuliah
      // 6. Return MaterialPageRoute dengan DetailMataKuliahPage(mk)
      // 7. Halaman ditampilkan dengan data yang tepat
      //
      // Keuntungan onGenerateRoute:
      // ✓ Dynamic routes dengan data berbeda
      // ✓ Centralized route handling
      // ✓ Cocok untuk deep linking
      //
      // Kerugian:
      // ✗ Arguments harus di-cast (Object → MataKuliah)
      // ✗ Type-unsafe
      //
      onGenerateRoute: (settings) {
        // Cek jika route name adalah '/detail-matakuliah'
        if (settings.name == '/detail-matakuliah') {
          // Extract arguments dari settings
          // as MataKuliah: Type-cast Object ke MataKuliah
          final mataKuliah = settings.arguments as MataKuliah;
          // Return MaterialPageRoute dengan widget yang tepat
          return MaterialPageRoute(
            builder: (context) => DetailMataKuliahPage(mataKuliah: mataKuliah),
          );
        }
        // Jika route tidak ditemukan, return null
        return null;
      },

      // home: Halaman pertama saat app dibuka
      home: const BerandaPage(),
    );
  }
}

// ============================================================================
// HALAMAN 1: BERANDA PAGE
// ============================================================================
// BerandaPage: Halaman utama aplikasi akademik
// StatelessWidget: Data halaman fixed (mata kuliah list tidak berubah)
//
// Konten:
// - Header dengan info mahasiswa (nama, IPK, semester, SKS)
// - List mata kuliah semester ini
// - Setiap item adalah card clickable untuk lihat detail
//
// Navigasi dari halaman ini:
// 1. Item mata kuliah genap (index 0, 2, 4, ...) → Push-Pop ke Detail
// 2. Item mata kuliah ganjil (index 1, 3, 5, ...) → Named Routes ke Detail
// 3. Button "Lihat Profil Dosen" → Named Routes ke Profil Dosen
// 4. Button "Unduh Transkrip" → Snackbar (no navigation)
//
// DEMONSTRASI KEDUA TEKNIK NAVIGASI:
// Dalam ListView item, ditunjukkan kedua teknik untuk pembelajaran
//
class BerandaPage extends StatelessWidget {
  const BerandaPage({Key? key}) : super(key: key);

  // ========== DUMMY DATA MATA KULIAH ==========
  // static: Data shared across all BerandaPage instances
  // Alasan: Data ini fixed (tidak perlu di-buat ulang setiap render)
  //
  // List<MataKuliah>: Type-safe list berisi MataKuliah objects
  // final: Reference list tidak bisa diubah (tapi items bisa)
  //
  // Dummy data = test data (bukan dari API/database)
  // Di aplikasi real, data akan fetch dari API atau database
  //
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
    // Scaffold: Struktur dasar halaman
    // - appBar: Header dengan title
    // - body: Konten utama (header + list mata kuliah + buttons)
    return Scaffold(
      // AppBar: Header dengan title dan styling
      appBar: AppBar(
        title: const Text('Beranda - Dashboard Akademik'),
        elevation: 4, // Shadow depth
        backgroundColor: Colors.blue,
      ),
      // body: Konten utama halaman
      // SingleChildScrollView: Jika konten panjang, bisa di-scroll ke bawah
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER CARD =====
              // Menampilkan: Nama mahasiswa, IPK, semester, SKS
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  // LinearGradient: Gradient background (blue-400 → blue-800)
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
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
                      // Row: 3 columns untuk IPK, Semester, SKS
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

              // ===== SECTION TITLE: MATA KULIAH =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mata Kuliah Semester Ini',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${daftarMataKuliah.length} Kelas',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ===== LIST MATA KULIAH =====
              // ListView.builder: Efficient list builder (render only visible items)
              // itemCount: Jumlah items
              // itemBuilder: Function yang build setiap item
              // shrinkWrap: true → ListView ukuran sesuai children (parent scroll)
              // physics: NeverScrollableScrollPhysics → Disable internal scroll
              //
              // DEMONSTRASI NAVIGASI:
              // - index genap (0, 2, 4, ...) → Push-Pop navigation
              // - index ganjil (1, 3, 5, ...) → Named routes navigation
              //
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: daftarMataKuliah.length,
                itemBuilder: (context, index) {
                  final mataKuliah = daftarMataKuliah[index];
                  // isEven: Check apakah index genap (0, 2, 4, ...)
                  final isPushPop = index.isEven;

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // ListTile: List item widget (leading, title, subtitle, trailing)
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      // leading: Widget di sebelah kiri (avatar/icon)
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
                      // title: Judul utama (nama mata kuliah)
                      title: Text(
                        mataKuliah.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      // subtitle: Info secondary (dosen, hari, jam)
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
                      // trailing: Widget di sebelah kanan (nilai, navigation method label)
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
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                      // onTap: Dipanggil saat user tap list item
                      onTap: () {
                        if (isPushPop) {
                          // ===== TEKNIK 1: PUSH-POP (Manual Navigation) =====
                          // Navigator.push(): Manual navigation dengan MaterialPageRoute
                          //
                          // Workflow:
                          // 1. Create MaterialPageRoute object
                          // 2. builder: Function yang return DetailMataKuliahPage
                          // 3. DetailMataKuliahPage(mataKuliah: mk) → pass data
                          // 4. Navigator.push() → add ke navigation stack
                          // 5. AnimatedTransition: Halaman slide/fade in
                          //
                          // Stack setelah push:
                          // [DetailMataKuliahPage]  ← Top (new)
                          // [BerandaPage]           ← Bottom
                          //
                          // Keuntungan:
                          // ✓ Explicit & clear code
                          // ✓ Flexible animation
                          // ✓ Easy debug
                          // ✓ Direct data passing
                          //
                          // Kerugian:
                          // ✗ Boilerplate code
                          // ✗ Hard to maintain
                          //
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailMataKuliahPage(mataKuliah: mataKuliah),
                            ),
                          );
                        } else {
                          // ===== TEKNIK 2: NAMED ROUTES (Centralized Navigation) =====
                          // Navigator.pushNamed(): Navigation dengan route name (string)
                          //
                          // Workflow:
                          // 1. Call pushNamed dengan route name dan arguments
                          // 2. MaterialApp.onGenerateRoute dipanggil
                          // 3. onGenerateRoute check settings.name
                          // 4. Extract arguments: final mk = settings.arguments as MataKuliah
                          // 5. Return MaterialPageRoute dengan DetailMataKuliahPage(mk)
                          // 6. Halaman ditampilkan
                          //
                          // Stack setelah pushNamed:
                          // [DetailMataKuliahPage]  ← Top (new)
                          // [BerandaPage]           ← Bottom
                          //
                          // Keuntungan:
                          // ✓ Clean & centralized
                          // ✓ Easy to maintain
                          // ✓ Deep linking support
                          // ✓ Less boilerplate
                          //
                          // Kerugian:
                          // ✗ Arguments harus di-cast (type-unsafe)
                          // ✗ Less flexible animation
                          //
                          Navigator.of(context).pushNamed(
                            '/detail-matakuliah',
                            arguments: mataKuliah, // Pass data via arguments
                          );
                        }
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // ===== ACTION BUTTONS =====
              // Row dengan 2 buttons: Lihat Profil Dosen & Unduh Transkrip
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // ===== NAVIGATION: NAMED ROUTES =====
                        // Navigator.pushNamed(): Navigate ke '/profil-dosen'
                        // Route '/profil-dosen' didefinisikan di MaterialApp.routes
                        // Tidak ada arguments → ProfilDosenPage tampil dengan default dosen
                        //
                        // Stack setelah pushNamed:
                        // [ProfilDosenPage]  ← Top (new)
                        // [BerandaPage]      ← Bottom
                        //
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
                        // Show snackbar (no navigation)
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

// ============================================================================
// HALAMAN 2: DETAIL MATA KULIAH PAGE
// ============================================================================
// DetailMataKuliahPage: Menampilkan detail satu mata kuliah
// StatelessWidget: Data halaman fixed (mata kuliah yang dipilih tidak berubah)
//
// Parameter:
// - mataKuliah: MataKuliah object yang dikirim dari BerandaPage
//   Data ini dikirim via:
//   1. Push-Pop: Langsung ke constructor DetailMataKuliahPage(mk)
//   2. Named Routes: Via arguments dalam onGenerateRoute
//
// Konten:
// - Header dengan nama, SKS, nilai mata kuliah
// - Info jadwal (hari, jam, ruangan)
// - Info dosen pengampu
// - Button "Lihat Profil Dosen"
// - Button "Tambah ke Favorit"
//
// Navigasi dari halaman ini:
// 1. Back button / AppBar leading → Pop ke BerandaPage
// 2. "Lihat Profil Dosen" button → Push ke ProfilDosenPage
// 3. "Tambah ke Favorit" button → Snackbar (no navigation)
//
class DetailMataKuliahPage extends StatelessWidget {
  // final: MataKuliah tidak bisa diubah setelah widget dibuat
  // required: Constructor harus menerima mataKuliah parameter
  final MataKuliah mataKuliah;

  const DetailMataKuliahPage({Key? key, required this.mataKuliah})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan back button
      appBar: AppBar(
        title: const Text('Detail Mata Kuliah'),
        elevation: 4,
        backgroundColor: Colors.blue,
        // leading: Widget di sebelah kiri AppBar (back button)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // ===== NAVIGATION: POP =====
            // Navigator.pop(): Remove halaman current dari stack
            //
            // Stack sebelum pop:
            // [DetailMataKuliahPage]  ← Top
            // [BerandaPage]           ← Back to here
            //
            // Stack setelah pop:
            // [BerandaPage]           ← Top
            //
            // Pop dapat di-trigger dari:
            // 1. Back button (AppBar leading) - di sini
            // 2. Physical back button (Android)
            // 3. Navigator.pop() programmatically
            //
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
              // ===== HEADER CARD =====
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

              // ===== JADWAL SECTION =====
              const Text(
                'Jadwal Kelas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

              // ===== DOSEN SECTION =====
              const Text(
                'Informasi Dosen',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          // CircleAvatar: Avatar widget (circular)
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
                          // ===== NAVIGATION: PUSH-POP =====
                          // Navigator.push(): Navigate ke ProfilDosenPage
                          //
                          // Pass parameter: namaDosenAwal = dosen dari mata kuliah ini
                          // ProfilDosenPage akan pre-select dosen sesuai nama
                          //
                          // Stack setelah push:
                          // [ProfilDosenPage]          ← Top (new)
                          // [DetailMataKuliahPage]     ← Bottom
                          // [BerandaPage]
                          //
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

              // ===== ACTION BUTTON =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Materi kuliah telah ditambahkan ke favorit',
                        ),
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

  // Helper widget untuk baris info (label + value)
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
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// ============================================================================
// HALAMAN 3: PROFIL DOSEN PAGE
// ============================================================================
// ProfilDosenPage: Menampilkan profil satu dosen
// StatelessWidget: Data profil fixed (dosen yang dipilih tidak berubah)
//
// Parameter:
// - namaDosenAwal: (Optional) Nama dosen yang dipre-select
//   null → Tampilkan dosen pertama (default)
//   "Dr. Budi Santoso" → Cari & tampilkan dosen dengan nama ini
//
// Konten:
// - Avatar & nama dosen
// - Info kontak (email, telepon)
// - Pendidikan terakhir
// - Keahlian (ditampilkan sebagai Chip tags)
// - List dosen lain yang clickable
//
// Navigasi dari halaman ini:
// 1. Back button → Pop ke DetailMataKuliahPage atau BerandaPage
// 2. Click dosen lain → Push ProfilDosenPage lagi (recursive navigation)
//
class ProfilDosenPage extends StatelessWidget {
  // final String?: Nullable (bisa null atau String value)
  // ? = null-safe indicator
  // Alasan nullable: Parameter ini optional (tidak wajib diberikan)
  final String? namaDosenAwal;

  const ProfilDosenPage({
    Key? key,
    this.namaDosenAwal, // Optional parameter (tidak required)
  }) : super(key: key);

  // ========== DATA DOSEN DUMMY ==========
  // static: List dosen sama untuk semua instance halaman
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
    // ===== LOGIC: SELECT DOSEN BERDASARKAN PARAMETER =====
    // Conditional logic untuk determine dosen mana yang ditampilkan
    //
    // Skenario 1: namaDosenAwal != null
    // - Ada nama dosen dari parameter
    // - Cari dosen dengan nama yang match
    // - firstWhere(): Return element pertama yang match kondisi
    // - orElse(): Jika tidak ada yang match, return dosen[0] (fallback)
    //
    // Skenario 2: namaDosenAwal == null
    // - Tidak ada parameter
    // - Tampilkan dosen pertama (default)
    //
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
            // ===== NAVIGATION: POP =====
            // Navigator.pop(): Kembali ke halaman sebelumnya
            // Bisa kembali ke: DetailMataKuliahPage atau BerandaPage
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

              // ===== KONTAK SECTION =====
              const Text(
                'Informasi Kontak',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

              // ===== PENDIDIKAN SECTION =====
              const Text(
                'Latar Belakang Akademik',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ===== KEAHLIAN SECTION =====
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
                      // Wrap: Layout yang wrap ke baris berikutnya jika melebihi width
                      // Berguna untuk display tags/chips yang responsif
                      Wrap(
                        spacing: 8, // Horizontal spacing antar chip
                        runSpacing: 8, // Vertical spacing antar rows
                        // map(): Transform setiap keahlian menjadi Chip
                        children: dosenTerpilih.keahlian.split(', ').map((
                          keahlian,
                        ) {
                          // Chip: Tag widget untuk display skill/label
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

              // ===== DOSEN LAIN SECTION =====
              const Text(
                'Dosen Lainnya',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // ===== LIST DOSEN LAIN =====
              // ListView.builder: Tampilkan daftar dosen lain
              // Setiap dosen adalah clickable ListTile
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
                        // ===== NAVIGATION: RECURSIVE PUSH =====
                        // Navigator.push(): Push ProfilDosenPage lagi!
                        // Ini disebut "recursive navigation"
                        //
                        // Kenapa recursive?
                        // - User klik dosen lain
                        // - Halaman yang sama (ProfilDosenPage)
                        // - Dengan data dosen yang berbeda
                        //
                        // Stack setelah tap dosen lain:
                        // [ProfilDosenPage (Dosen B)]  ← Top (new)
                        // [ProfilDosenPage (Dosen A)]
                        // [DetailMataKuliahPage]
                        // [BerandaPage]
                        //
                        // User bisa terus click dan stack grows
                        // Back button pop satu per satu
                        //
                        // Keuntungan recursive:
                        // ✓ User bisa explore multiple dosen
                        // ✓ Natural flow (tidak perlu balik ke list)
                        // ✓ Stack tetap tracked untuk back navigation
                        //
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfilDosenPage(namaDosenAwal: dosen.nama),
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

  // ===== HELPER WIDGET =====
  // _buildContactRow(): Build satu baris kontak (icon + label + value)
  Widget _buildContactRow(IconData icon, String label, String value) {
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
                style: const TextStyle(fontSize: 12, color: Colors.grey),
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
