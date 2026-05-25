import 'package:flutter/material.dart';

/*
================================================================================
                    FORM SPESIFIKASI HARDWARE
================================================================================

DESKRIPSI APLIKASI:
====================
Aplikasi form untuk mencatat spesifikasi hardware komputer dengan validasi lengkap.
Cocok dipelajari setelah memahami dasar Flutter di tugas2april.dart

FITUR UTAMA:
============
✓ 8 Input Field Berbeda (Minimal 5 sesuai requirement)
✓ Validasi Lengkap untuk Setiap Field
✓ UI Modern dengan Material Design 3
✓ Snackbar untuk Feedback
✓ Tombol Submit dan Reset
✓ Informasi Catatan untuk User

================================================================================
KONSEP PENTING FORM FLUTTER:
================================================================================

1. FORM VALIDATION (Validasi Form)
   ================================
   Validasi = proses pengecekan data sebelum disimpan
   Tujuan: Pastikan data valid dan sesuai requirement
   
   Contoh validasi:
   - Wajib diisi (empty check)
   - Minimum/maksimum karakter (length check)
   - Format tertentu (regex check)
   - Range nilai (number range check)
   
   Form Widget Flutter:
   - Form: Container untuk multiple TextFormField/DropdownButtonFormField
   - GlobalKey<FormState>: Handle form validation dan reset
   - TextFormField: Input field dengan built-in validator
   - DropdownButtonFormField: Dropdown dengan built-in validator
   - validator: Function yang return error message atau null

   Workflow Validasi:
   1. User masukkan data di input field
   2. User klik tombol "Simpan Data"
   3. Form cek semua field dengan validator function
   4. Jika semua valid (semua validator return null):
      → Data disimpan, tampilkan success snackbar
   5. Jika ada field invalid:
      → Tampilkan error message di field tsb, snackbar error

2. STATE MANAGEMENT (Manajemen Data)
   ==================================
   State = kondisi/data yang bisa berubah
   StatefulWidget = widget yang bisa berubah statenya
   
   Di aplikasi ini menggunakan:
   - TextEditingController: Manage text input (processor, GPU, harga, dll)
   - setState(): Update state dan re-build widget
   - Dropdown value variables: Store selected dropdown values
   
   Kapan data berubah?
   - User mengetik di text field → TextEditingController.text berubah
   - User pilih dropdown → _selectedRam, _selectedBrand berubah
   - User reset form → TextEditingController.clear(), setState()
   - User submit form → Simpan data, reset, rebuild UI

3. CONTROLLERS (TextEditingController)
   ===================================
   TextEditingController = object untuk manage text input field
   
   Kegunaan:
   - Akses text value: _processorController.text
   - Ubah text value: _processorController.text = "new value"
   - Clear text: _processorController.clear()
   - Listen perubahan: _processorController.addListener(...)
   
   Penting: Selalu dispose() controller di onDispose() untuk memory leak prevention
   
   Contoh:
   TextEditingController _processorController = TextEditingController();
   → TextField(controller: _processorController)
   → Bisa akses value: _processorController.text

4. REGEX (Regular Expression) - Validasi Format
   =============================================
   Regex = pattern untuk validasi format text
   
   Contoh regex di aplikasi ini:
   - r'^[a-zA-Z0-9\s\-\.]+$' → Hanya huruf, angka, space, dash, titik
   - r'^[0-9]+$' → Hanya angka (integer)
   
   Cara guna: RegExp(pattern).hasMatch(text)
   Contoh:
   RegExp(r'^[0-9]+$').hasMatch("12345") → true (hanya angka)
   RegExp(r'^[0-9]+$').hasMatch("123abc") → false (ada huruf)

5. DIALOG (Alert Dialog)
   =====================
   Dialog = popup window yang tampil di atas halaman
   
   Kegunaan:
   - Tampilkan hasil simpan data
   - Konfirmasi aksi
   - Error message detail
   
   Struktur AlertDialog:
   - title: Judul dialog
   - content: Isi/message dialog
   - actions: Buttons (OK, Cancel, dll)
   
   Cara guna: showDialog(context: context, builder: (context) { ... })

================================================================================
DAFTAR WIDGET YANG DIGUNAKAN:
================================================================================

SETUP APLIKASI:
1. MaterialApp - Setup aplikasi dengan theme & home page
2. MyApp - Root widget (StatelessWidget)

HALAMAN UTAMA:
3. Scaffold - Struktur dasar halaman (AppBar, body, dll)
4. AppBar - Header/judul di atas halaman
5. SingleChildScrollView - Scrollable container untuk form yang panjang

FORM WIDGETS:
6. Form - Container untuk multiple input fields dengan validation
7. TextFormField - Text input dengan built-in validator
8. DropdownButtonFormField - Dropdown dengan built-in validator
9. GlobalKey<FormState> - Key untuk akses form state (validate, reset)

LAYOUT:
10. Column - Atur widget secara vertikal (atas-bawah)
11. Row - Atur widget secara horizontal (kiri-kanan)
12. Card - Box dengan elevation/shadow untuk visual grouping
13. Container - Custom styling box (padding, decoration, color, dll)
14. SizedBox - Fixed spacing antar widget

TEXT & LABELS:
15. Text - Widget untuk menulis teks

BUTTONS:
16. ElevatedButton - Button dengan background color (primary action)
17. OutlinedButton - Button dengan border saja (secondary action)
18. ElevatedButton.icon - Button dengan icon + label
19. OutlinedButton.icon - Button outline dengan icon + label

DIALOG:
20. AlertDialog - Popup dialog untuk tampilkan data/konfirmasi
21. showDialog() - Function untuk tampilkan dialog

FEEDBACK:
22. SnackBar - Notification bar di bawah halaman
23. ScaffoldMessenger - Widget untuk tampilkan SnackBar

ICONS:
24. Icon - Widget untuk menampilkan icon/simbol
25. Icons - Pre-made icons dari Material Design

SPACING:
26. SizedBox - Fixed size box untuk spacing

STYLING:
27. InputDecoration - Styling untuk TextFormField/DropdownButtonFormField
28. BoxDecoration - Styling untuk Container (color, border, radius, dll)
29. OutlineInputBorder - Border style untuk InputDecoration

================================================================================
FLOW APLIKASI:
================================================================================

main() 
  → MyApp (setup app)
    → MaterialApp (setup routing & theme)
      → HardwareSpecificationForm (StatefulWidget halaman form)
        → _HardwareSpecificationFormState (manage state & data)
          → build() (render UI)
            → Scaffold
              → AppBar
              → SingleChildScrollView
                → Form
                  → [TextFormField, DropdownButtonFormField, dll]
                  → Buttons (Simpan, Reset)

WORKFLOW USER:
==============
1. User buka aplikasi
2. Aplikasi tampilkan form dengan 8 input fields
3. User isi semua fields:
   - Pilih brand processor di dropdown
   - Ketik model processor
   - Pilih RAM di dropdown
   - Pilih tipe storage di dropdown
   - Ketik kapasitas storage
   - Ketik model GPU
   - Ketik harga
   - Ketik garansi
4. User klik tombol "Simpan Data"
5. Form validasi semua fields:
   - Jika ada field invalid → tampilkan error message
   - Jika semua valid → tampilkan data di dialog
6. Data ditampilkan di dialog popup
7. User klik "Tutup" untuk tutup dialog
8. Form di-reset (kosongkan semua fields)
9. User bisa isi form lagi atau klik "Reset" manual

================================================================================
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MaterialApp: Setup aplikasi Flutter
    // - title: Nama app di task switcher
    // - theme: Styling global (warna, font, material design)
    // - home: Halaman pertama saat app dibuka
    // - useMaterial3: Gunakan design system Material Design 3 (modern)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Spesifikasi Hardware',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HardwareSpecificationForm(),
    );
  }
}

// ============================================================================
// MAIN FORM WIDGET
// ============================================================================
// HardwareSpecificationForm: StatefulWidget karena form bisa berubah
// StatefulWidget: Widget yang punya state/data yang bisa berubah
// Berbeda dengan StatelessWidget: Widget yang statis, tidak berubah
//
// Kapan pakai StatefulWidget?
// - Form dengan multiple input fields
// - Data berubah berdasarkan user action
// - Perlu update UI sesuai state berubah
// - Contoh: Form, Counter, Todo List, Chat
//
// Kapan pakai StatelessWidget?
// - Halaman static (profile, about, splash screen)
// - Tidak ada data yang berubah
// - Hanya menampilkan data (read-only)
//
class HardwareSpecificationForm extends StatefulWidget {
  const HardwareSpecificationForm({Key? key}) : super(key: key);

  @override
  // createState(): Return State object yang manage data form
  // State object menyimpan semua controller, validator, data
  State<HardwareSpecificationForm> createState() =>
      _HardwareSpecificationFormState();
}

// ============================================================================
// STATE CLASS - Manajemen Data & Logic Form
// ============================================================================
// _HardwareSpecificationFormState: Manage state (data) form
// _ = private class (hanya bisa diakses di file ini)
//
// Tanggung jawab:
// 1. Declare controllers untuk setiap text input
// 2. Declare variables untuk dropdown values
// 3. Implement validator functions
// 4. Implement submit & reset logic
// 5. Build UI di build() method
//
class _HardwareSpecificationFormState extends State<HardwareSpecificationForm> {
  // ========== FORM KEY ==========
  // GlobalKey<FormState>: Key untuk akses Form state
  // Kegunaan:
  // - Validasi form: _formKey.currentState!.validate()
  // - Reset form: _formKey.currentState!.reset()
  // - Access form state: _formKey.currentState
  //
  // Penting: Harus di-attach ke Form widget
  // Form(key: _formKey, child: ...)
  final _formKey = GlobalKey<FormState>();

  // ========== TEXT CONTROLLERS ==========
  // TextEditingController: Manage text input fields
  // Kegunaan:
  // - Akses text value: controller.text
  // - Ubah text: controller.text = "new value"
  // - Clear text: controller.clear()
  // - Listen perubahan: controller.addListener(() { ... })
  //
  // Penting: Dispose di dispose() method untuk prevent memory leak
  //
  // Mengapa perlu controller?
  // - Akses value dari text field kapan saja (tidak harus di build)
  // - Imperative control (programmer control, bukan Flutter)
  // - Useful untuk form submission, reset, pre-fill data
  //
  // Contoh:
  // TextFormField(controller: _processorController)
  // → Bisa akses: _processorController.text
  // → Bisa ubah: _processorController.text = "Intel Core i9"
  // → Bisa clear: _processorController.clear()
  //
  final TextEditingController _processorController = TextEditingController();
  final TextEditingController _storageCapacityController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _gpuController = TextEditingController();
  final TextEditingController _warrantyController = TextEditingController();

  // ========== DROPDOWN VALUES ==========
  // String? = nullable string (bisa null atau string value)
  // ? = nullable operator (bisa null)
  //
  // Dropdown membutuhkan variable untuk store selected value
  // Setiap kali user pilih item, variable ini di-update
  //
  // Contoh:
  // DropdownButtonFormField(
  //   value: _selectedRam,  ← current value
  //   onChanged: (value) {
  //     setState(() {
  //       _selectedRam = value;  ← update when user select
  //     });
  //   }
  // )
  //
  String? _selectedRam = '8 GB';
  String? _selectedStorageType = 'SSD';
  String? _selectedBrand = 'Intel';

  // ========== DROPDOWN OPTIONS ==========
  // List<String> = List berisi string values
  // Gunakan untuk populate dropdown items
  //
  // Contoh:
  // List<String> _ramOptions = ['4 GB', '8 GB', '16 GB'];
  // DropdownButtonFormField(
  //   items: _ramOptions.map((value) {
  //     return DropdownMenuItem(value: value, child: Text(value));
  //   }).toList()
  // )
  //
  final List<String> _ramOptions = ['4 GB', '8 GB', '16 GB', '32 GB', '64 GB'];
  final List<String> _storageTypeOptions = ['SSD', 'HDD', 'NVMe'];
  final List<String> _brandOptions = [
    'Intel',
    'AMD',
    'Apple',
    'Qualcomm',
    'Other',
  ];

  @override
  // dispose(): Cleanup resources saat widget destroyed
  // PENTING: Selalu dispose TextEditingController untuk prevent memory leak
  //
  // Memory leak = memory yang tidak bisa dibebaskan
  // Akibat: App jadi lambat, crash, battery drain
  //
  // Workflow:
  // 1. Widget dibuat → controller dibuat
  // 2. Widget dihapus → dispose() dipanggil → controller di-dispose
  // 3. Memory dibebaskan ✓
  //
  // Jika tidak dispose:
  // 1. Widget dibuat → controller dibuat
  // 2. Widget dihapus → controller TIDAK di-dispose
  // 3. Memory TIDAK dibebaskan → memory leak ✗
  //
  void dispose() {
    _processorController.dispose();
    _storageCapacityController.dispose();
    _priceController.dispose();
    _gpuController.dispose();
    _warrantyController.dispose();
    super.dispose();
  }

  // ========== VALIDATOR FUNCTIONS ==========
  // Validator = function yang cek validity input
  // Return type: String? (return error message atau null)
  //   - null = valid (tidak ada error)
  //   - String = invalid (return error message)
  //
  // Validator dipanggil saat:
  // 1. User submit form
  // 2. Form.validate() dipanggil
  //
  // Contoh:
  // String? _validateProcessor(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Processor tidak boleh kosong';  // Invalid
  //   }
  //   return null;  // Valid
  // }
  //
  // Jenis Validasi:
  // 1. Empty Check: field tidak boleh kosong
  // 2. Length Check: karakter minimal/maksimal
  // 3. Format Check: validasi format pakai regex
  // 4. Range Check: nilai berada di range tertentu
  //
  // VALIDASI 1: MODEL PROCESSOR
  // ==========================
  // Requirements:
  // - Tidak boleh kosong
  // - Minimal 3 karakter
  // - Hanya huruf, angka, dash, titik
  //
  // Contoh valid: "Core i7-13700K", "Ryzen 9-5900X"
  // Contoh invalid: "i7" (terlalu pendek), "Core i7@#$" (karakter invalid)
  //
  String? _validateProcessor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Processor tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Nama processor minimal 3 karakter';
    }
    // RegExp: Regular Expression untuk validasi format
    // r'^[a-zA-Z0-9\s\-\.]+$'
    // ^ = start of string
    // [a-zA-Z0-9\s\-\.]+ = 1+ karakter: huruf besar, huruf kecil, angka, space, dash, titik
    // $ = end of string
    //
    // Jika tidak match → return error
    if (!RegExp(r'^[a-zA-Z0-9\s\-\.]+$').hasMatch(value)) {
      return 'Processor hanya boleh mengandung huruf, angka, dash, dan titik';
    }
    return null; // Valid
  }

  // VALIDASI 2: KAPASITAS STORAGE
  // =============================
  // Requirements:
  // - Tidak boleh kosong
  // - Hanya angka
  // - Antara 128 - 10000 GB
  //
  // Contoh valid: "256", "512", "1024", "2048"
  // Contoh invalid: "64" (terlalu kecil), "20000" (terlalu besar), "512gb" (ada text)
  //
  String? _validateStorageCapacity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kapasitas storage tidak boleh kosong';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Kapasitas harus berupa angka (GB)';
    }
    // Parse string ke integer
    // int.parse("512") → 512
    int capacity = int.parse(value);
    if (capacity < 128 || capacity > 10000) {
      return 'Kapasitas harus antara 128 GB - 10000 GB';
    }
    return null; // Valid
  }

  // VALIDASI 3: HARGA
  // =================
  // Requirements:
  // - Tidak boleh kosong
  // - Hanya angka
  // - Antara Rp 500.000 - Rp 500.000.000
  //
  // Contoh valid: "5000000" (5 juta), "15000000" (15 juta)
  // Contoh invalid: "100000" (terlalu murah), "1000000000" (terlalu mahal)
  //
  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harga tidak boleh kosong';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Harga harus berupa angka';
    }
    int price = int.parse(value);
    if (price < 500000 || price > 500000000) {
      return 'Harga harus antara Rp 500.000 - Rp 500.000.000';
    }
    return null; // Valid
  }

  // VALIDASI 4: MODEL GPU
  // =====================
  // Requirements:
  // - Tidak boleh kosong
  // - Minimal 2 karakter
  // - Hanya huruf, angka, dash
  //
  // Contoh valid: "RTX 4070 Ti", "RTX 4090", "A100"
  // Contoh invalid: "4" (terlalu pendek), "RTX@#$" (karakter invalid)
  //
  String? _validateGpu(String? value) {
    if (value == null || value.isEmpty) {
      return 'GPU model tidak boleh kosong';
    }
    if (value.length < 2) {
      return 'Nama GPU minimal 2 karakter';
    }
    if (!RegExp(r'^[a-zA-Z0-9\s\-]+$').hasMatch(value)) {
      return 'GPU hanya boleh mengandung huruf, angka, dan dash';
    }
    return null; // Valid
  }

  // VALIDASI 5: GARANSI
  // ===================
  // Requirements:
  // - Tidak boleh kosong
  // - Hanya angka
  // - Antara 1 - 120 bulan
  //
  // Contoh valid: "12" (1 tahun), "24" (2 tahun), "36" (3 tahun)
  // Contoh invalid: "0" (tidak ada garansi), "200" (terlalu lama)
  //
  String? _validateWarranty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Garansi tidak boleh kosong';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Garansi harus berupa angka (bulan)';
    }
    int warranty = int.parse(value);
    if (warranty < 1 || warranty > 120) {
      return 'Garansi harus antara 1 - 120 bulan';
    }
    return null; // Valid
  }

  // ========== SUBMIT FORM FUNCTION ==========
  // Dipanggil saat user klik tombol "Simpan Data"
  // Workflow:
  // 1. Validasi semua fields pakai Form.validate()
  // 2. Jika valid:
  //    a. Simpan data ke variables
  //    b. Tampilkan data di dialog
  //    c. Print ke console
  //    d. Reset form
  //    e. Tampilkan success snackbar
  // 3. Jika invalid:
  //    a. Tampilkan error snackbar
  //
  void _submitForm() {
    // _formKey.currentState!.validate()
    // Form.validate() = validasi semua fields
    // Return true jika semua valid, false jika ada invalid
    //
    // ! = null assertion operator (assert value tidak null)
    // Digunakan ketika kita yakin value pasti tidak null
    //
    if (_formKey.currentState!.validate()) {
      // ===== JIKA FORM VALID =====

      // Simpan data ke variables sebelum reset
      // Karena reset akan mengosongkan semua fields
      final String brand = _selectedBrand ?? 'Intel';
      final String processor = _processorController.text;
      final String ram = _selectedRam ?? '8 GB';
      final String storageType = _selectedStorageType ?? 'SSD';
      final String storageCapacity = _storageCapacityController.text;
      final String gpu = _gpuController.text;
      final String price = _priceController.text;
      final String warranty = _warrantyController.text;

      // Tampilkan data yang berhasil disimpan di dialog
      _showDataDialog(
        brand: brand,
        processor: processor,
        ram: ram,
        storageType: storageType,
        storageCapacity: storageCapacity,
        gpu: gpu,
        price: price,
        warranty: warranty,
      );

      // Print ke console (Logcat) untuk debug
      print('=== DATA SPESIFIKASI HARDWARE BERHASIL DISIMPAN ===');
      print('Brand Processor     : $brand');
      print('Model Processor     : $processor');
      print('Kapasitas RAM       : $ram');
      print('Tipe Penyimpanan    : $storageType');
      print('Kapasitas Storage   : $storageCapacity GB');
      print('Model GPU/VGA       : $gpu');
      print('Harga               : Rp $price');
      print('Garansi             : $warranty bulan');
      print('================================================');

      // Reset form
      _formKey.currentState!.reset();
      _resetForm();

      // Tampilkan success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('✓ Spesifikasi Hardware berhasil disimpan!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // ===== JIKA FORM INVALID =====
      // Tampilkan error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✗ Mohon lengkapi semua field dengan benar'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // ========== SHOW DATA DIALOG FUNCTION ==========
  // Tampilkan data yang berhasil disimpan di popup dialog
  // Dialog = popup window di atas halaman
  //
  // Struktur AlertDialog:
  // - title: Judul dialog
  // - content: Isi/message (SingleChildScrollView + Column + data rows)
  // - actions: Buttons (Tutup button)
  //
  void _showDataDialog({
    required String brand,
    required String processor,
    required String ram,
    required String storageType,
    required String storageCapacity,
    required String gpu,
    required String price,
    required String warranty,
  }) {
    // showDialog(): Function untuk tampilkan AlertDialog
    // context: BuildContext (akses ke widget tree)
    // builder: Function yang return AlertDialog widget
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // AlertDialog: Dialog widget dengan title, content, actions
        return AlertDialog(
          title: const Text('✓ Data Berhasil Disimpan'),
          // SingleChildScrollView: Jika content panjang, bisa di-scroll
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Setiap baris: Label + Value
                _buildDataRow('Brand Processor', brand),
                _buildDataRow('Model Processor', processor),
                _buildDataRow('Kapasitas RAM', ram),
                _buildDataRow('Tipe Penyimpanan', storageType),
                _buildDataRow('Kapasitas Storage', '$storageCapacity GB'),
                _buildDataRow('Model GPU/VGA', gpu),
                _buildDataRow('Harga', 'Rp $price'),
                _buildDataRow('Garansi', '$warranty bulan'),
              ],
            ),
          ),
          // actions: Buttons di bawah dialog
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // ========== BUILD DATA ROW WIDGET ==========
  // Helper widget untuk tampilkan satu baris data
  // Parameter:
  // - label: Label/nama field (Brand Processor, RAM, dll)
  // - value: Nilai/data (Intel, 8 GB, dll)
  //
  // Return: Row dengan label di kiri, value di kanan
  //
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label (kiri)
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 10),
          // Value (kanan)
          // Expanded: Agar value tidak overflow dan bisa ke baris baru
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========== RESET FORM FUNCTION ==========
  // Clear semua input fields ke nilai default
  // Dipanggil saat:
  // 1. User klik tombol "Reset"
  // 2. User submit form (setelah simpan data)
  //
  void _resetForm() {
    // Clear text fields
    _processorController.clear();
    _storageCapacityController.clear();
    _priceController.clear();
    _gpuController.clear();
    _warrantyController.clear();
    // Reset dropdown values
    setState(() {
      _selectedRam = '8 GB';
      _selectedStorageType = 'SSD';
      _selectedBrand = 'Intel';
    });
  }

  @override
  // build(): Render UI halaman
  // Method ini dipanggil setiap kali state berubah (setState())
  // Return: Scaffold widget dengan AppBar, body, form, buttons
  Widget build(BuildContext context) {
    // Scaffold: Struktur dasar halaman
    // - appBar: Header di atas
    // - body: Konten utama
    //
    // Scaffold layout:
    // ┌─────────────────┐
    // │    AppBar       │ ← title, background color
    // ├─────────────────┤
    // │                 │
    // │  Body (Form)    │ ← SingleChildScrollView + Form
    // │                 │
    // └─────────────────┘
    //
    return Scaffold(
      // AppBar: Header dengan title dan styling
      appBar: AppBar(
        title: const Text('Form Spesifikasi Hardware'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      // body: Konten utama (form)
      // SingleChildScrollView: Agar form bisa di-scroll jika panjang
      // SingleChildScrollView vs ListView:
      // - SingleChildScrollView: 1 child, scrollable
      // - ListView: Multiple children, scrollable, efficient
      //
      // Di sini pakai SingleChildScrollView karena Form adalah 1 child
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue.shade50,
          padding: const EdgeInsets.all(20.0),
          // Form: Container untuk multiple input fields
          // key: _formKey - untuk akses Form state (validate, reset)
          child: Form(
            key: _formKey,
            // Column: Layout vertikal untuk form fields
            // child: Column yang berisi:
            // 1. Header card
            // 2. Input fields (brand, processor, RAM, storage, GPU, harga, garansi)
            // 3. Buttons (Simpan, Reset)
            // 4. Info box
            //
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== HEADER =====
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Formulir Spesifikasi Hardware',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Isi data spesifikasi hardware computer Anda dengan lengkap dan benar',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ===== INPUT FIELD 1: BRAND PROCESSOR (DROPDOWN) =====
                // Dropdown = list selector
                // User bisa pilih 1 dari beberapa options
                //
                // DropdownButtonFormField: Dropdown dengan built-in validator
                // Keuntungan vs DropdownButton:
                // - Built-in validator
                // - InputDecoration (styling)
                // - Terintegrasi dengan Form validation
                //
                Text(
                  'Brand Processor*',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  // value: Current selected value
                  // Saat dropdown dibuka, item ini yang di-highlight
                  value: _selectedBrand,
                  // decoration: Styling untuk dropdown
                  // InputDecoration = styling untuk text input (berlaku juga dropdown)
                  // Properties:
                  // - hintText: Placeholder text jika tidak ada value
                  // - border: Border styling
                  // - filled: Isi background
                  // - fillColor: Background color
                  // - prefixIcon: Icon di sebelah kiri
                  decoration: InputDecoration(
                    hintText: 'Pilih brand processor',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.computer),
                  ),
                  // items: List of dropdown items
                  // Buat dari _brandOptions list
                  items: _brandOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  // onChanged: Dipanggil saat user pilih item
                  onChanged: (String? newValue) {
                    // setState(): Update state & trigger rebuild
                    // Ketika state berubah, UI di-rebuild dengan value baru
                    setState(() {
                      _selectedBrand = newValue;
                    });
                  },
                  // validator: Validasi dropdown value
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Brand harus dipilih';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // ===== INPUT FIELD 2: MODEL PROCESSOR (TEXT) =====
                // TextFormField = text input dengan validator
                // Properties:
                // - controller: TextEditingController untuk manage value
                // - decoration: Styling
                // - keyboardType: Tipe keyboard yang tampil
                // - validator: Function untuk validate input
                //
                Text(
                  'Model Processor*',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _processorController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Core i7-13700K',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.memory),
                    // helperText: Info text di bawah field
                    // Tujuan: Guide user tentang format/requirement
                    helperText: 'Masukkan model processor (minimal 3 karakter)',
                  ),
                  keyboardType: TextInputType.text,
                  validator: _validateProcessor,
                ),
                const SizedBox(height: 20),

                // ===== INPUT FIELD 3: KAPASITAS RAM (DROPDOWN) =====
                Text(
                  'Kapasitas RAM*',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedRam,
                  decoration: InputDecoration(
                    hintText: 'Pilih kapasitas RAM',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.storage),
                  ),
                  items: _ramOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRam = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'RAM harus dipilih';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // ===== INPUT FIELD 4: TIPE PENYIMPANAN (DROPDOWN) =====
                Text(
                  'Tipe Penyimpanan*',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedStorageType,
                  decoration: InputDecoration(
                    hintText: 'Pilih tipe penyimpanan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.save),
                  ),
                  items: _storageTypeOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStorageType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tipe penyimpanan harus dipilih';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // ===== INPUT FIELD 5: KAPASITAS STORAGE (TEXT) =====
                // keyboardType: TextInputType.number
                // Tujuan: Tampilkan numeric keyboard (hanya angka)
                // Di Android: Numeric keypad
                // Di iOS: Numeric keyboard dengan +/- operators
                //
                Text(
                  'Kapasitas Penyimpanan (GB)*',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _storageCapacityController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 512 (GB)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.sd_card),
                    // suffixText: Text di belakang input (right side)
                    // Tujuan: Show unit (GB, MB, Rp, dll)
                    suffixText: 'GB',
                    helperText: 'Masukkan angka antara 128 - 10000 GB',
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateStorageCapacity,
                ),
                const SizedBox(height: 20),

                // ===== INPUT FIELD 6: MODEL GPU (TEXT) =====
                Text(
                  'Model GPU / VGA*',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _gpuController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: RTX 4070 Ti',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.videogame_asset),
                    helperText: 'Masukkan model GPU/VGA Anda',
                  ),
                  keyboardType: TextInputType.text,
                  validator: _validateGpu,
                ),
                const SizedBox(height: 20),

                // ===== INPUT FIELD 7: HARGA (TEXT) =====
                // prefixText: Text prefix di input
                // Contoh: "Rp 15000000" → "Rp" adalah prefix
                //
                Text(
                  'Harga (Rp)*',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 15000000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.attach_money),
                    prefixText: 'Rp ',
                    helperText:
                        'Masukkan harga antara Rp 500.000 - Rp 500.000.000',
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validatePrice,
                ),
                const SizedBox(height: 20),

                // ===== INPUT FIELD 8: GARANSI (TEXT) =====
                Text(
                  'Garansi (Bulan)*',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _warrantyController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 24',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.verified_user),
                    suffixText: 'bulan',
                    helperText: 'Masukkan angka antara 1 - 120 bulan',
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateWarranty,
                ),
                const SizedBox(height: 30),

                // ===== BUTTONS ROW =====
                // Row dengan 2 buttons: Simpan & Reset
                // Expanded: Buat buttons same width (50% - 50%)
                //
                Row(
                  children: [
                    // Button 1: Simpan Data (ElevatedButton)
                    // ElevatedButton = primary action button
                    // Karakteristik:
                    // - Background color (solid)
                    // - Raised/elevated appearance
                    // - Prominent, menarik attention
                    // - Used untuk main action
                    //
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _submitForm, // Call _submitForm saat diklik
                        icon: const Icon(Icons.save),
                        label: const Text('Simpan Data'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Button 2: Reset (OutlinedButton)
                    // OutlinedButton = secondary action button
                    // Karakteristik:
                    // - Border outline saja (transparent background)
                    // - Subtle appearance
                    // - Less prominent
                    // - Used untuk secondary actions
                    //
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _resetForm, // Call _resetForm saat diklik
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ===== INFO BOX =====
                // Card dengan catatan/informasi penting
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Catatan:',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '• Semua field bertanda (*) harus diisi\n'
                          '• RAM: Pilih dari 4 GB hingga 64 GB\n'
                          '• Storage: Minimal 128 GB, maksimal 10000 GB\n'
                          '• Harga: Minimal Rp 500.000, maksimal Rp 500.000.000\n'
                          '• Garansi: Minimal 1 bulan, maksimal 120 bulan',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
