import 'package:flutter/material.dart';

/*
================================================================================
DOKUMENTASI DASHBOARD AKADEMIK SEDERHANA - FLUTTER
================================================================================

PENJELASAN UNTUK PEMULA:
========================
Halaman ini adalah contoh aplikasi Flutter yang menampilkan dashboard akademik.
Flutter adalah framework untuk membuat aplikasi mobile yang bekerja di iOS, Android,
Web, dan platform lainnya dengan satu kode.

KONSEP PENTING DALAM FLUTTER:
=============================
1. Widget: Blok dasar UI di Flutter. Semua yang terlihat adalah widget.
2. StatelessWidget: Widget yang tidak berubah setelah dibuat
3. StatefulWidget: Widget yang bisa berubah state/kondisinya
4. Build Method: Fungsi yang menggambar widget ke layar
5. Material Design: Design system dari Google untuk UI yang konsisten

DAFTAR WIDGET YANG DIGUNAKAN:
==============================
1. MaterialApp - Setup aplikasi dengan theme dan home page
2. Scaffold - Struktur dasar halaman (AppBar, body, FAB)
3. AppBar - Header/judul di atas halaman
4. ListView - Container yang bisa di-scroll ke bawah
5. Card - Box/kotak untuk menampilkan informasi
6. Row - Atur widget secara horizontal (kiri-kanan)
7. Column - Atur widget secara vertikal (atas-bawah)
8. Container - Box kosong untuk styling dan dekorasi
9. GridView - Layout grid (tabel) untuk banyak item
10. FloatingActionButton - Tombol bulat di pojok bawah kanan
11. IconButton - Tombol kecil dengan icon
12. ElevatedButton - Tombol dengan background warna
13. OutlinedButton - Tombol dengan border outline saja
14. Text - Widget untuk menulis teks
15. Icon - Widget untuk menampilkan icon/simbol
16. SizedBox - Box untuk spacing/jarak antar widget
17. Expanded - Widget yang mengisi space kosong

FLOW APLIKASI:
==============
main() -> MyApp (setup) -> AcademicDashboard (halaman utama)
             -> _AcademicDashboardState (manajemen data)
                -> build() (menggambar widget)
*/

void main() {
  // Entry point aplikasi Flutter
  // main() dipanggil pertama kali ketika app dijalankan
  // runApp() menjalankan aplikasi dengan root widget = MyApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // StatelessWidget: Widget yang tidak berubah/statis
  // Digunakan ketika tampilan tidak perlu update berdasarkan user input
  // MyApp adalah root widget yang setup aplikasi

  const MyApp({super.key});

  @override
  // build() method: Fungsi yang menggambar widget ke layar
  // Setiap kali Flutter perlu menggambar ulang, fungsi ini dipanggil
  // Return value harus berupa Widget
  Widget build(BuildContext context) {
    // MaterialApp: Setup utama aplikasi Flutter
    // - title: Nama aplikasi di task switcher / recent apps
    // - theme: Styling global (warna, font, dll)
    // - home: Halaman utama yang ditampilkan saat app dibuka
    // - useMaterial3: Menggunakan design system Material Design 3 (terbaru)
    // MaterialApp: Root widget untuk app Flutter
    // Alasan: Menyediakan Material Design theme, routing, dan config aplikasi
    return MaterialApp(
      title: 'Dashboard Akademik',
      // ThemeData: Konfigurasi desain global aplikasi
      // primarySwatch: Warna utama yang digunakan di seluruh app
      // useMaterial3: Mengaktifkan Material Design 3 (modern style)
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // home: Halaman pertama yang ditampilkan saat app dibuka
      home: const AcademicDashboard(),
    );
  }
}

class AcademicDashboard extends StatefulWidget {
  // StatefulWidget: Widget yang bisa berubah/dinamis
  // Digunakan ketika halaman perlu update berdasarkan user action atau data change
  // Contoh: Button diklik, data berubah, scroll positions, dll

  const AcademicDashboard({super.key});

  @override
  // createState(): Fungsi yang membuat State object
  // State object menyimpan data yang bisa berubah untuk widget ini
  // Berbeda dengan StatelessWidget yang tidak punya State
  State<AcademicDashboard> createState() => _AcademicDashboardState();
}

class _AcademicDashboardState extends State<AcademicDashboard> {
  // State class: Menyimpan data yang bisa berubah
  // _ di awal nama: Private class (hanya bisa diakses di file ini)
  // Dalam class ini, kita bisa:
  // 1. Define variabel data (studentName, gpa, dll)
  // 2. Define methods (fungsi)
  // 3. Override build() untuk menggambar UI

  // ========== DATA MAHASISWA (DUMMY DATA) ==========
  // Dummy data = data palsu untuk testing/demo
  // Di aplikasi real, data ini akan datang dari server/database

  final String studentName = "Aditya Bagas Prakoso"; // Nama mahasiswa
  final String studentNIM = "2024001"; // Nomor Identitas Mahasiswa
  final String semester = "Semester 4"; // Semester aktif

  // ========== DATA AKADEMIK ==========
  final double gpa = 3.75; // Grade Point Average (nilai rata-rata)
  final int attendancePercentage = 92; // Persentase kehadiran kuliah
  final int tasksCompleted = 8; // Jumlah tugas yang sudah selesai
  final int tasksTotal = 10; // Total jumlah tugas

  @override
  // build() method: Menggambar UI halaman
  // Method ini dipanggil setiap kali widget perlu di-update
  Widget build(BuildContext context) {
    // Scaffold: Struktur dasar halaman Material Design
    // Seperti kerangka halaman yang memiliki:
    // - appBar: Header di atas
    // - body: Konten utama
    // - floatingActionButton: Tombol bulat di bawah kanan
    // - drawer: Menu slide dari kiri (optional)
    // - bottomNavigationBar: Menu di bawah (optional)
    //
    // Struktur Scaffold:
    // ┌─────────────────────┐
    // │    AppBar (Header)  │ ← Title, buttons
    // ├─────────────────────┤
    // │                     │
    // │   Body (Isi Page)   │ ← ListView, Column, dll
    // │                     │
    // └─────────────────────┘
    //              ⊕ FAB (Floating Action Button)
    return Scaffold(
      // ============================================================================
      // APPBAR - Header halaman dengan judul, profil, dan aksi
      // ============================================================================
      // Struktur AppBar:
      // ┌────────────────────────────────────────┐
      // │ [Leading] Title              [Actions]│  ← AppBar
      // └────────────────────────────────────────┘
      // leading: Icon/button di sebelah kiri (biasanya menu hamburger)
      // title: Judul halaman (di tengah atau kiri)
      // actions: Buttons di sebelah kanan (profile, settings, dll)
      //
      // AppBar: Header dengan title dan action buttons
      // Alasan: Standard header di mobile apps, tempat ideal untuk branding & quick actions
      appBar: AppBar(
        elevation: 0, // No shadow untuk design flat/modern
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Dashboard Akademik',
          style: TextStyle(
            fontSize: 22, // Ukuran font: 22 pixel
            fontWeight: FontWeight.bold, // Bold = tebal
            color: Colors.white, // Warna: Putih
          ),
        ),
        // centerTitle: false berarti judul di sebelah kiri
        centerTitle: false,
        // actions: List of buttons/icons di sebelah kanan AppBar
        actions: [
          // IconButton: Tombol kecil dengan icon untuk AppBar
          // Alasan: Space-efficient, ideal untuk quick access actions
          IconButton(
            icon: const Icon(Icons.account_circle), // Profile icon
            onPressed: () {
              // onPressed: Fungsi yang dijalankan saat button diklik
              // ScaffoldMessenger: Menampilkan notifikasi (snackbar) di bottom
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile icon tapped')),
              );
            },
            tooltip: 'Profil Pengguna', // Text yang muncul saat long-press
          ),
          // IconButton: Settings button
          // Alasan: Quick access ke pengaturan aplikasi, non-intrusive
          IconButton(
            icon: const Icon(Icons.settings), // Settings/gear icon
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Settings tapped')));
            },
            tooltip: 'Pengaturan',
          ),
        ],
      ),

      // ============================================================================
      // BODY - ListView: Container scrollable untuk konten vertikal
      // Alasan: Dashboard content lebih panjang dari screen, otomatis scrollable
      // ============================================================================
      // ListView: Widget untuk menampilkan list item yang bisa di-scroll
      // Seperti daftar items yang bisa di-swipe ke atas untuk lihat lebih banyak
      //
      // Mengapa ListView?
      // - Kalau konten panjang melebihi screen height, perlu scrollable
      // - ListView otomatis handle scrolling ke bawah
      // - Lebih baik daripada Column yang akan overflow
      //
      // Alternative: Column (tidak scrollable), SingleChildScrollView (scrollable)
      // ListView dipilih karena efficient untuk banyak item
      body: ListView(
        // padding: Jarak antara konten dan edge layar (kiri, kanan, atas, bawah)
        // EdgeInsets.all(16.0): 16 pixel di semua sisi (kiri, kanan, atas, bawah)
        padding: const EdgeInsets.all(16.0),
        // children: List of widgets yang akan ditampilkan dalam ListView
        // Urutan items: dari atas ke bawah sesuai order di sini
        children: [
          // Card: Container dengan elevation/shadow untuk visual grouping
          // Alasan: Menonjolkan informasi penting, standard Material Design untuk data
          // Section 1: Kartu Profil Mahasiswa
          _buildProfileCard(),

          // SizedBox: Fixed spacing antar sections
          // Alasan: Consistent whitespace, improve visual hierarchy & readability
          const SizedBox(height: 24),

          // GridView.count: Layout grid dengan jumlah kolom tetap (2 kolom)
          // Alasan: Optimal untuk multiple data items, lebih efisien visual daripada list panjang
          // Section 2: Kartu Informasi Akademik (Grid 2x2)
          _buildAcademicInfoGrid(),

          const SizedBox(height: 24),

          // SingleChildScrollView: Horizontal scrollable container
          // Alasan: Menu buttons dapat scroll ke kanan jika melebihi screen width
          // Prevent overflow pada small devices
          // Section 3: Menu Horizontal Scrollable
          _buildMenuBar(),

          const SizedBox(height: 24),

          // ElevatedButton & OutlinedButton: Material Design buttons
          // Alasan: ElevatedButton untuk primary action (prominent),
          //         OutlinedButton untuk secondary actions (less prominent)
          // Section 4: Tombol Aksi (Jadwal, Hubungi Dosen, Download)
          _buildActionButtons(),

          const SizedBox(height: 32),
        ],
      ),

      // ============================================================================
      // FloatingActionButton (FAB): Primary action button yang mengapung
      // Alasan: Standard UI pattern untuk highlight main action, easy access & prominent
      // FAB adalah cara terbaik showcase primary action di mobile apps
      // ============================================================================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Buat permohonan baru')));
        },
        tooltip: 'Buat Permohonan',
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // ============================================================================
  // HELPER WIDGET 1: Kartu Profil Mahasiswa (Card + Row + Column)
  // ============================================================================
  // Helper function/method: Fungsi kecil yang return Widget
  // Digunakan untuk:
  // 1. Membuat kode lebih rapi dan terorganisir
  // 2. Menghindari build() method yang terlalu panjang
  // 3. Reusable: bisa dipanggil berkali-kali
  // 4. Mudah di-maintain: kalau ada bug, fix di satu tempat saja
  //
  // Struktur Card:
  // ┌───────────────────────────┐
  // │  [CARD dengan elevation]  │ ← Shadow/shadow effect
  // │  ┌─────────────────────┐  │
  // │  │ Avatar │ Info Text  │  │ ← Row (horizontal layout)
  // │  └─────────────────────┘  │
  // └───────────────────────────┘
  //
  // Card: Container dengan elevation untuk visual grouping
  // Alasan: Menonjolkan informasi penting, standard Material Design untuk data
  // Section 1: Kartu Profil Mahasiswa
  // _buildProfileCard(),

  Widget _buildProfileCard() {
    return Card(
      // Card: Memberikan elevation/shadow dan rounded corners
      // Alasan: Elevation = depth perception, Card = standard Material Design
      elevation: 4, // Shadow depth untuk membuat card terlihat terangkat
      // shape: Border shape dari card (default: rounded rectangle)
      // RoundedRectangleBorder: Membuat corner menggunakan BorderRadius
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // child: Widget yang ada dalam Card
      // Bisa berupa satu widget saja (Container di sini)
      child: Container(
        // Container: Widget untuk styling custom (padding, decoration, gradient)
        // Alasan: Flexible untuk styling complex, background, border, gradient
        // Container seperti div di HTML - bisa di-style dengan BoxDecoration
        padding: const EdgeInsets.all(16.0), // Internal padding di semua sisi
        // BoxDecoration: Styling untuk Container
        // Bisa set: warna, gradient, border, shadow, border-radius, dll
        decoration: BoxDecoration(
          // LinearGradient: Gradient background dari blue-300 ke blue-600
          // Alasan: Professional look, visual appeal lebih tinggi dari solid color
          // Gradient = perpaduan 2 atau lebih warna yang smooth transition
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[600]!],
            // ! = null assertion operator (mengatakan value tidak null)
            begin: Alignment.topLeft, // Gradient mulai dari atas-kiri
            end: Alignment.bottomRight, // Gradient berakhir di bawah-kanan
          ),
          borderRadius: BorderRadius.circular(12), // Rounded corner 12 pixel
        ),
        // child: Widget isi dari Container
        // Bisa berisi Row, Column, Text, Image, atau widget lain
        child: Row(
          // Row: Layout horizontal - atur widget dari kiri ke kanan
          // Row: Layout horizontal untuk avatar + info side-by-side
          // Alasan: Efficient space usage, photo di kiri, informasi di kanan
          //
          // Row vs Column:
          // Row = layout horizontal (→)
          // Column = layout vertikal (↓)
          //
          // Struktur Row:
          // ┌─────────────────────────────┐
          // │ [Item1]  [Item2]  [Item3]   │
          // └─────────────────────────────┘
          //
          // mainAxisAlignment: Align items di sumbu horizontal
          // - start (default): items di sebelah kiri
          // - end: items di sebelah kanan
          // - center: items di tengah
          // - spaceBetween: items rata kanan-kiri dengan jarak
          // - spaceAround: items dengan jarak di sekitar
          //
          // crossAxisAlignment: Align items di sumbu vertikal
          // - start: items di atas
          // - end: items di bawah
          // - center: items di tengah
          // - stretch: items mengisi full height
          //
          children: [
            // Avatar Container: Icon dalam shape circle
            // Alasan: Visual representation dari user, common UI pattern
            Container(
              width: 70, // Lebar = 70 pixel
              height: 70, // Tinggi = 70 pixel (square shape)
              // BoxDecoration: Styling untuk Container
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle, // Circular/rounded avatar
                // BoxShape.circle: Membuat Container menjadi lingkaran
              ),
              // child: Widget isi Container
              // Icon: Menampilkan icon/symbol dari Material Icons
              child: const Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            // SizedBox: Horizontal spacing antar avatar dan info
            // Alasan: Consistent spacing, membuat layout tidak terlalu rapat
            // SizedBox seperti spacer/jarak kosong
            const SizedBox(width: 16), // Jarak kosong 16 pixel ke kanan
            // Expanded: Flexible width container
            // Alasan: Student info mengambil available space setelah avatar
            // Prevent overflow dan fill empty space
            //
            // Expanded vs Container:
            // Container: Punya fixed size (width, height)
            // Expanded: Flexible, mengisi sisa space yang available
            //
            // Berguna ketika:
            // - Punya Row/Column dengan beberapa item
            // - Ingin beberapa item fixed size, sisanya fill available space
            Expanded(
              // child: Widget yang di-expand
              // flex: Proporsi space (default = 1)
              // Contoh: flex 2 = ambil space 2x lebih besar dari flex 1
              // Column: Layout vertikal untuk nama, NIM, semester
              // Alasan: Natural stacking untuk related information
              child: Column(
                // crossAxisAlignment: Align text di sebelah kiri
                // CrossAxisAlignment.start = left align (di sebelah kiri)
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: Align text di atas (default)
                // MainAxisAlignment.start = top align
                // children: List of widgets dalam Column (dari atas ke bawah)
                children: [
                  Text(
                    studentName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NIM: $studentNIM',
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    semester,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // HELPER WIDGET 2: Grid Informasi Akademik (GridView.count)
  // GridView.count: Layout grid dengan jumlah kolom tetap (2 kolom)
  // ============================================================================
  // GridView: Widget untuk menampilkan items dalam layout grid (seperti tabel)
  // Berguna untuk: Galeri foto, produk listing, data cards, dll
  //
  // GridView vs ListView:
  // ListView = 1 kolom saja (vertical scrolling)
  // GridView = banyak kolom (2D layout, vertical + horizontal)
  //
  // GridView.count:
  // GridView.count = mudah membuat grid dengan fixed column count
  // GridView.builder = lebih flexible, buat grid dengan builder function
  //
  // Struktur GridView 2 kolom:
  // ┌───────────────────┐
  // │ [Item 1] [Item 2] │  ← Row 1
  // │ [Item 3] [Item 4] │  ← Row 2
  // │ [Item 5] [Item 6] │  ← Row 3
  // └───────────────────┘
  //
  // Contoh: IPK, Kehadiran, Tugas Selesai, Status = 4 items dalam 2 kolom
  //
  // Card: Container dengan elevation untuk visual grouping
  // Alasan: Menonjolkan informasi penting, standard Material Design untuk data
  // Section 2: Kartu Informasi Akademik (Grid 2x2)
  // _buildAcademicInfoGrid(),

  Widget _buildAcademicInfoGrid() {
    return Column(
      // Column: Grouping title + grid items secara vertikal
      // mainAxisSize: MainAxisSize.min = Column minimal size
      // mainAxisAlignment: MainAxisAlignment.start = align ke atas (default)
      // crossAxisAlignment: CrossAxisAlignment.start = align ke kiri
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text: Judul section "Informasi Akademik"
        const Text(
          'Informasi Akademik',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        // SizedBox: Spacing antara title dan grid
        const SizedBox(height: 12),
        // GridView.count: 2-kolom responsive grid layout
        // Alasan: Optimal untuk multiple data items, efficient space usage
        // crossAxisCount: 2 = 2 kolom layout
        // shrinkWrap: true = tidak scrollable sendiri
        // physics: NeverScrollableScrollPhysics() = disable internal scroll
        // childAspectRatio: 1.5 = kontrol tinggi item (lebar:tinggi = 1.5:1)
        GridView.count(
          // crossAxisCount: Jumlah kolom dalam grid
          // Nilai 2 = 2 kolom layout
          // Nilai 3 = 3 kolom layout (tergantung screen width)
          crossAxisCount: 2,
          // shrinkWrap: Penting! Jangan scrollable sendiri
          // Jika false: GridView akan handle scroll sendiri (conflict dengan ListView parent)
          // Jika true: GridView ukuran sesuai children, parent (ListView) yang handle scroll
          shrinkWrap: true,
          // physics: ScrollPhysics untuk GridView scrolling behavior
          // NeverScrollableScrollPhysics() = disable scroll
          // BouncingScrollPhysics() = iOS bouncy scroll
          // ClampingScrollPhysics() = Android clamp scroll
          physics: const NeverScrollableScrollPhysics(),
          // crossAxisSpacing: Jarak horizontal antar items (kiri-kanan)
          // Contoh: Item 1 di kiri, jarak 12px, Item 2 di kanan
          crossAxisSpacing: 12,
          // mainAxisSpacing: Jarak vertikal antar items (atas-bawah)
          // Contoh: Row 1, jarak 12px, Row 2
          mainAxisSpacing: 12,
          // childAspectRatio: Rasio lebar:tinggi item
          // Nilai 1.5 = lebar 1.5x lebih panjang dari tinggi
          // Nilai 1.0 = square (lebar = tinggi)
          // Contoh: lebar 100px, tinggi = 100/1.5 = 66px
          childAspectRatio: 1.5,
          children: [
            _buildInfoCard('IPK', gpa.toString(), Icons.school, Colors.green),
            _buildInfoCard(
              'Kehadiran',
              '$attendancePercentage%',
              Icons.check_circle,
              Colors.orange,
            ),
            _buildInfoCard(
              'Tugas Selesai',
              '$tasksCompleted/$tasksTotal',
              Icons.assignment,
              Colors.purple,
            ),
            _buildInfoCard('Status', 'Aktif', Icons.verified, Colors.blue),
          ],
        ),
      ],
    );
  }

  // ============================================================================
  // HELPER WIDGET 3: Individual Info Card untuk Grid
  // Card: Container untuk single data item (IPK, Kehadiran, Tugas, Status)
  // ============================================================================
  // _buildInfoCard(): Reusable widget untuk membuat single info card
  // Parameter:
  // - title: Label/nama (IPK, Kehadiran, dll)
  // - value: Nilai/data (3.75, 92%, dll)
  // - icon: Icon yang ditampilkan (Icons.school, Icons.check_circle, dll)
  // - color: Warna card (Green, Orange, Purple, Blue)
  //
  // Contoh pemanggilan:
  // _buildInfoCard('IPK', '3.75', Icons.school, Colors.green)
  // _buildInfoCard('Kehadiran', '92%', Icons.check_circle, Colors.orange)
  //
  // Keuntungan function seperti ini:
  // - Reusable: dipanggil 4x untuk 4 info cards
  // - Mudah maintain: ubah design 1x, semua card berubah
  // - Clean code: GridView children jadi lebih singkat dan rapi
  //
  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      // Card: Elevation untuk membedakan individual items
      child: Container(
        // Container: Styling custom dengan background color, border, radius
        // Alasan: Flexible styling, background opacity, border styling
        padding: const EdgeInsets.all(12.0), // Internal padding
        // BoxDecoration: Styling untuk Container
        // Bisa combine: warna, gradient, border, shadow, radius
        decoration: BoxDecoration(
          // Color.withValues(alpha: 0.1): Transparansi warna
          // alpha = opacity level (0.0 = fully transparent, 1.0 = fully opaque)
          // Contoh: Colors.green.withValues(alpha: 0.1) = light green (10% visible)
          // Berguna untuk subtle background yang tidak dominant
          // Warna background dengan opacity (semi-transparent)
          // Alasan: Subtle background color yang tidak terlalu menyolok
          color: color.withValues(alpha: 0.1), // 10% opacity dari color
          // BorderRadius: Rounded corner styling
          // circular(8) = 8px rounded corner di semua corner
          // Berguna untuk softer, modern UI appearance
          borderRadius: BorderRadius.circular(8), // Rounded corners
          // Border: Outline/garis tepi Container
          // Border.all(): Garis di semua sisi
          // Border.all(color, width) = color & thickness
          // Border: Subtle outline untuk membedakan card boundaries
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ), // 30% opacity
        ),
        // Column: Layout vertikal untuk icon, value, title (bottom to top)
        // Alasan: Natural stacking untuk informasi hierarchy
        //
        // Urutan visual hierarchy:
        // 1. Icon: Visual first (mata tertarik ke icon)
        // 2. Value: Angka/data important (focus point)
        // 3. Title: Label kecil (secondary info)
        child: Column(
          // mainAxisAlignment: Align items di sumbu vertikal
          // MainAxisAlignment.center = items di tengah vertical space
          // Berguna untuk card yang ingin centered alignment
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon: Visual indicator untuk tipe data (school, check, assignment, dll)
            // Alasan: Reduce cognitive load, intuitive recognition, visual appeal
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8), // Spacing antar icon dan value
            // Text: Display value (IPK, percentage, count, dll)
            // Alasan: Typography hierarchy - value lebih besar & bold (fokus)
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4), // Spacing antar value dan title
            // Text: Display label/title
            // Alasan: Secondary information, smaller & lighter weight
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // HELPER WIDGET 4: Menu Bar Horizontal (SingleChildScrollView + Row)
  // SingleChildScrollView: Horizontal scrollable container untuk menu items
  // ============================================================================
  // _buildMenuBar(): Horizontal menu yang bisa di-scroll ke kanan
  // Berguna ketika: banyak menu items yang tidak muat dalam 1 screen width
  //
  // Struktur:
  // SingleChildScrollView (horizontal)
  //   └─ Row (children: [Button1, Button2, Button3, Button4, Button5])
  //
  // Kapan pakai apa?
  // ListView: Vertikal list yang banyak items (galeri, chat, list barang)
  // GridView: 2D grid untuk banyak items (foto gallery, produk grid)
  // SingleChildScrollView: 1 widget, tapi bisa scroll (besar/panjang)
  // ScrollView: Custom scroll untuk complex layout
  //
  // Button Types di Flutter:
  // 1. ElevatedButton: Elevated style dengan background color
  //    - Primary action button (paling penting)
  //    - Warna solid background = prominent
  //    - Contoh: "Submit", "Simpan", "Lihat Jadwal"
  //
  // 2. OutlinedButton: Border outline saja, transparent background
  //    - Secondary action button (less important)
  //    - Hanya garis border, tidak solid
  //    - Contoh: "Batal", "Ubah", "Hubungi"
  //
  // 3. TextButton: Text saja, paling simpel
  //    - Tertiary action button (paling kurang penting)
  //    - Hanya text, tanpa background/border
  //    - Contoh: "Baca lebih lanjut", "Info", "Lihat"
  //
  // 4. IconButton: Icon saja, kecil
  //    - Quick action button
  //    - Hanya icon, cocok untuk toolbar/appbar
  //    - Contoh: Profile, Settings, Back
  //
  // Material Design Button Hierarchy:
  // Primary   → ElevatedButton (warna solid, paling prominent)
  // Secondary → OutlinedButton (garis border saja)
  // Tertiary  → TextButton (text saja)
  //
  Widget _buildMenuBar() {
    // menuItems: List of map/dictionary untuk menu data
    // Map: Struktur key-value (seperti object di JavaScript)
    // {'label': 'Jadwal', 'icon': Icons.calendar_today}
    // Berguna untuk menyimpan data grouped (label + icon bersama)
    final menuItems = [
      {'label': 'Jadwal', 'icon': Icons.calendar_today},
      {'label': 'Nilai', 'icon': Icons.grade},
      {'label': 'Tugas', 'icon': Icons.assignment_turned_in},
      {'label': 'Absensi', 'icon': Icons.check},
      {'label': 'Lainnya', 'icon': Icons.more_horiz},
    ];

    return Column(
      // Column: Grouping title + menu buttons secara vertikal
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Menu Cepat',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // SingleChildScrollView: Horizontal scrollable wrapper
        // Alasan: Menu dapat scroll ke kanan jika melebihi screen width
        // Prevent overflow pada small devices, maintain usability
        //
        // Kapan pakai SingleChildScrollView vs ListView?
        // SingleChildScrollView: Untuk 1 child yang besar/panjang
        // ListView: Untuk banyak items yang berulang (efficient rendering)
        //
        // scrollDirection:
        // Axis.vertical = scroll ke bawah (default)
        // Axis.horizontal = scroll ke kanan
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scroll
          // Row: Layout horizontal untuk menu buttons
          // Alasan: Buttons side-by-side, efficient screen space usage
          child: Row(
            children: List.generate(menuItems.length, (index) {
              final item = menuItems[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                // ElevatedButton.icon: Button dengan icon + label
                // Alasan: Material Design styled, visual clear call-to-action
                // icon: visual indicator, label: descriptive text
                //
                // Button Properties:
                // - onPressed: Callback function saat button diklik
                // - icon: Icon di sebelah kiri text
                // - label: Text yang ditampilkan
                // - style: Styling button (warna, padding, shape, dll)
                //
                // StyleFrom properties:
                // - padding: Internal padding (horizontal, vertical)
                // - backgroundColor: Warna background button
                // - foregroundColor: Warna text/icon (bukan background)
                // - shape: Border shape (RoundedRectangleBorder, dll)
                //
                // Material Design Button Colors:
                // - Primary color: Warna utama (contrast, important)
                // - Secondary color: Warna kedua (alternative)
                // - Disable: Abu-abu (tidak aktif)
                // - Text color: Harus readable (contrast ratio > 4.5:1)
                //
                child: ElevatedButton.icon(
                  // onPressed: Callback/function saat button diklik
                  // Callback = function yang dipanggil nanti saat ada event
                  // () { ... } = anonymous function / lambda function
                  // Kalau null/empty: button akan disable (tidak bisa diklik)
                  onPressed: () {
                    // ScaffoldMessenger: Widget untuk menampilkan messages
                    // showSnackBar(): Menampilkan notification di bawah layar
                    // SnackBar: Widget untuk notification message
                    // Contoh: "Profile icon tapped" notification
                    //
                    // Alternatif komunikasi dengan user:
                    // 1. SnackBar: Notification di bawah (dismiss otomatis)
                    // 2. Dialog: Pop-up di tengah (perlu user confirm)
                    // 3. Toast: Floating message (Android)
                    // 4. Drawer: Menu slide dari samping
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item['label']} tapped')),
                    );
                  },
                  // icon: Visual representation di sebelah kiri text
                  // IconData: Type untuk icon (Icons.calendar_today, Icons.grade, dll)
                  // as IconData: Type casting (convert ke IconData type)
                  icon: Icon(item['icon'] as IconData), // Menu icon
                  // label: Teks yang ditampilkan di button
                  // Text dalam button muncul di sebelah kanan icon
                  label: Text(item['label'] as String), // Menu label
                  // style: Styling button (color, size, shape, padding)
                  // ElevatedButton.styleFrom: Builder untuk style ElevatedButton
                  // Return ButtonStyle object
                  style: ElevatedButton.styleFrom(
                    // padding: Internal spacing di dalam button
                    // EdgeInsets.symmetric: Padding sama di sisi kiri-kanan (horizontal)
                    // dan atas-bawah (vertical)
                    // horizontal: 12 = 12px di kiri dan 12px di kanan
                    // vertical: 12 = 12px di atas dan 12px di bawah
                    // Total ukuran button = content + padding
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    // backgroundColor: Warna background button
                    // Colors.blue[100]: Warna biru light (shade 100)
                    // Flutter Colors punya shades: 50, 100, 200, ... 900
                    // 50 = paling light, 900 = paling dark
                    backgroundColor: Colors.blue[100], // Light blue background
                    // foregroundColor: Warna text/icon (bukan background)
                    // Colors.blue[800]: Biru dark untuk readable text
                    foregroundColor: Colors.blue[800], // Dark blue text
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // HELPER WIDGET 5: Tombol Aksi Utama (Primary & Secondary Buttons)
  // ElevatedButton: Primary action, OutlinedButton: Secondary actions
  // ============================================================================
  // _buildActionButtons(): Buttons untuk main actions
  // Kombinasi:
  // 1. 1 primary button (Lihat Jadwal Lengkap) - full width
  // 2. 2 secondary buttons (Hubungi Dosen + Download) - side by side
  //
  // Mengapa design seperti ini?
  // - Primary action harus prominent → full width, solid warna
  // - Secondary actions less important → smaller, outline style
  // - Prevents decision paralysis: user jelas mana action utama
  //
  // Responsive Layout:
  // Untuk small screens (mobile):
  // - Primary: Full width button
  // - Secondary: Buttons side-by-side (50% width each)
  //
  // Untuk large screens (tablet):
  // - Bisa ubah ke 3 columns atau custom layout
  //
  Widget _buildActionButtons() {
    return Column(
      // Column: Grouping action buttons secara vertikal
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aksi Penting',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // SizedBox: Full-width container untuk primary button
        // Alasan: ElevatedButton primary membutuhkan prominent size
        //
        // SizedBox(width: double.infinity):
        // width = double.infinity = menggunakan max width available
        // Contoh: jika Row/Column width 300px, SizedBox juga 300px
        // height: 50 = tinggi button 50 pixel
        //
        // Mengapa height dalam SizedBox?
        // - Button memiliki default height (bisa terlalu kecil)
        // - Dengan SizedBox, kita control exact size button
        // - Lebih mudah di-tap (bigger hitbox untuk touchable area)
        SizedBox(
          width: double.infinity, // Fill available width
          height: 50, // Exact height = 50px
          // ElevatedButton.icon: Primary action button (Lihat Jadwal Lengkap)
          // Alasan: Elevated style = prominent, background color = draw attention
          // icon + label = visual + text info
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Lihat Jadwal Lengkap')),
              );
            },
            icon: const Icon(Icons.event), // Calendar event icon
            label: const Text('Lihat Jadwal Lengkap'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Prominent blue background
              foregroundColor: Colors.white, // White text/icons
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12), // Spacing antar button groups
        // Row: 2 secondary buttons side-by-side
        // Alasan: Space efficient untuk secondary actions
        //
        // Row Layout:
        // ┌─────────────────┐
        // │[Btn1] [Spacing] [Btn2]│
        // └─────────────────┘
        // Expanded(flex=1) [Button 1] - 50% width
        // SizedBox(width=12) - spacing 12px
        // Expanded(flex=1) [Button 2] - 50% width
        //
        // Expanded(flex): Proporsi space allocation
        // flex=1, flex=1 = 50%-50% split
        // flex=1, flex=2 = 33%-67% split
        // flex=2, flex=1 = 67%-33% split
        Row(
          children: [
            // Expanded: Equal width untuk kedua buttons
            // Alasan: Share available space equally
            //
            // Expanded breakdown:
            // - flex: 1 (default) = ambil 1 bagian dari total flex
            // - child: OutlinedButton (secondary action)
            // - Total flex di Row: 1 + 12px (SizedBox) + 1 = 2
            // - Button 1 width: Row.width * (1/2) = 50%
            // - Button 2 width: Row.width * (1/2) = 50%
            Expanded(
              // OutlinedButton.icon: Secondary action (Hubungi Dosen)
              // Alasan: Outlined style = less prominent, border outline = secondary
              // transparent background = alternative action
              //
              // OutlinedButton vs ElevatedButton:
              // ElevatedButton:
              // - Background solid color = prominent
              // - Terlihat raised (elevation)
              // - Untuk PRIMARY action (paling penting)
              //
              // OutlinedButton:
              // - Hanya border outline = less prominent
              // - Flat appearance
              // - Untuk SECONDARY action (less important)
              //
              // Button Choice Logic:
              // 1. Ada beberapa actions? Pilih yang paling penting = ElevatedButton
              // 2. Action sisanya = OutlinedButton atau TextButton
              // 3. Jangan semua ElevatedButton (confusing, tidak jelas mana penting)
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hubungi Dosen')),
                  );
                },
                icon: const Icon(Icons.mail), // Mail/contact icon
                label: const Text('Hubungi Dosen'),
                style: OutlinedButton.styleFrom(
                  // side: Border styling untuk OutlinedButton
                  // BorderSide: Define border color & width
                  // BorderSide(color, width)
                  // width default = 1.0
                  side: const BorderSide(color: Colors.blue), // Blue border
                  // foregroundColor: Text/icon color
                  foregroundColor: Colors.blue, // Blue text/icon
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12), // Horizontal spacing antar buttons
            Expanded(
              // OutlinedButton.icon: Secondary action (Download Transkrip)
              // Alasan: Outlined style = secondary, green color = optional action
              //
              // Color Meaning (UX):
              // - Blue: Primary, neutral (info)
              // - Green: Positive, success, confirm
              // - Red: Danger, delete, warning
              // - Orange: Warning, attention needed
              // - Purple: Category, special
              //
              // Choosing Button Color:
              // - Ubiquitous actions: Blue (safe, neutral)
              // - Positive actions: Green (submit, confirm, save)
              // - Destructive actions: Red (delete, remove)
              // - Warning: Orange (be careful)
              // - Optional: Gray (less important)
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Download Transkrip')),
                  );
                },
                icon: const Icon(Icons.download), // Download icon
                label: const Text('Download'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green), // Green border
                  foregroundColor: Colors.green, // Green text/icon
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
