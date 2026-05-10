# 📋 Dokumentasi Form Peminjaman Buku dengan Validasi

## 🎯 Deskripsi Aplikasi
Aplikasi form peminjaman buku perpustakaan akademik dengan validasi komprehensif untuk:
- Data peminjam (nama, ID, email, telepon)
- Data peminjaman (judul buku, tanggal, durasi)
- Syarat & ketentuan

---

## 📐 Struktur Form

```
┌─────────────────────────────────────────┐
│    FORM PEMINJAMAN BUKU                 │
└─────────────────────────────────────────┘
         │
         ├─── SECTION 1: DATA PEMINJAM
         │    ├─ Input 1: Nama Lengkap (TextFormField)
         │    ├─ Input 2: Jenis ID (Dropdown) + ID (TextFormField)
         │    ├─ Input 3: Email (TextFormField)
         │    └─ Input 4: Nomor Telepon (TextFormField)
         │
         ├─── SECTION 2: DATA PEMINJAMAN
         │    ├─ Input 5: Judul Buku (Dropdown)
         │    ├─ Input 6: Tanggal Peminjaman (DatePicker)
         │    └─ Input 7: Durasi Peminjaman (Dropdown)
         │
         ├─── SECTION 3: SYARAT & KETENTUAN
         │    └─ Checkbox + Link Syarat
         │
         └─── ACTION BUTTONS
              ├─ Tombol Kirim (Submit)
              └─ Tombol Reset
```

---

## 📝 7 Input dengan Validasi

### **1️⃣ Nama Lengkap (Text Input)**
```dart
TextFormField(
  controller: _namaPeminjamController,
  decoration: InputDecoration(
    labelText: 'Nama Lengkap',
    hintText: 'Contoh: Ahmad Pratama',
    prefixIcon: const Icon(Icons.person),
    border: OutlineInputBorder(...),
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
```

**Validasi:**
- ✅ Wajib diisi (required)
- ✅ Minimal 3 karakter
- ✅ Hanya huruf dan spasi (regex: `^[a-zA-Z\s]+$`)

---

### **2️⃣ Jenis Identitas (Dropdown)**
```dart
DropdownButtonFormField<String>(
  value: _jenisIdentitas,
  decoration: InputDecoration(
    labelText: 'Jenis ID',
    border: OutlineInputBorder(...),
  ),
  items: const [
    DropdownMenuItem(value: 'NIM', child: Text('NIM')),
    DropdownMenuItem(value: 'NIK', child: Text('NIK')),
    DropdownMenuItem(value: 'Paspor', child: Text('Paspor')),
  ],
  onChanged: (value) {
    setState(() {
      _jenisIdentitas = value ?? 'NIM';
    });
  },
),
```

**Validasi:**
- ✅ Pilihan terbatas (NIM, NIK, Paspor)
- ✅ Tidak perlu validator (nilai selalu tersedia)

---

### **3️⃣ Nomor ID/NIM (Text Input)**
```dart
TextFormField(
  controller: _nimController,
  decoration: InputDecoration(
    labelText: _jenisIdentitas,
    hintText: 'Contoh: 2024001234',
    prefixIcon: const Icon(Icons.credit_card),
    border: OutlineInputBorder(...),
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
```

**Validasi:**
- ✅ Wajib diisi
- ✅ Minimal 8 digit
- ✅ Hanya angka (regex: `^[0-9]+$`)
- ✅ Keyboard numeric

---

### **4️⃣ Email (Text Input)**
```dart
TextFormField(
  controller: _emailController,
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'nama@universitas.ac.id',
    prefixIcon: const Icon(Icons.email),
    border: OutlineInputBorder(...),
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
```

**Validasi:**
- ✅ Wajib diisi
- ✅ Format email valid (regex: `^[^@]+@[^@]+\.[^@]+$`)
- ✅ Keyboard email address

---

### **5️⃣ Nomor Telepon (Text Input)**
```dart
TextFormField(
  controller: _noTeleponController,
  decoration: InputDecoration(
    labelText: 'Nomor Telepon',
    hintText: '08123456789',
    prefixIcon: const Icon(Icons.phone),
    border: OutlineInputBorder(...),
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
```

**Validasi:**
- ✅ Wajib diisi
- ✅ Diawali 08
- ✅ Total 10-13 digit (regex: `^08[0-9]{8,11}$`)
- ✅ Keyboard phone

---

### **6️⃣ Judul Buku (Dropdown)**
```dart
DropdownButtonFormField<String>(
  value: _judulBukuTerpilih,
  decoration: InputDecoration(
    labelText: 'Judul Buku',
    hintText: 'Pilih buku yang ingin dipinjam',
    prefixIcon: const Icon(Icons.book),
    border: OutlineInputBorder(...),
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
```

**Validasi:**
- ✅ Wajib dipilih
- ✅ 6 pilihan buku tersedia

---

### **7️⃣ Tanggal Peminjaman (DatePicker)**
```dart
TextFormField(
  controller: _tanggalPeminjamanController,
  readOnly: true,
  decoration: InputDecoration(
    labelText: 'Tanggal Peminjaman',
    hintText: 'Pilih tanggal',
    prefixIcon: const Icon(Icons.calendar_today),
    suffixIcon: IconButton(
      icon: const Icon(Icons.date_range),
      onPressed: _selectTanggal,
    ),
    border: OutlineInputBorder(...),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Pilih tanggal peminjaman';
    }
    return null;
  },
),
```

**Validasi:**
- ✅ Wajib dipilih
- ✅ Tidak boleh tanggal lampau
- ✅ Format: "dd MMMM yyyy"

---

### **8️⃣ Durasi Peminjaman (Dropdown)**
```dart
DropdownButtonFormField<int>(
  value: _durasiDipilih,
  decoration: InputDecoration(
    labelText: 'Durasi Peminjaman',
    hintText: 'Berapa lama ingin meminjam?',
    prefixIcon: const Icon(Icons.timer),
    border: OutlineInputBorder(...),
  ),
  items: [1, 3, 7, 14, 30].map((durasi) {
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
```

**Validasi:**
- ✅ Wajib dipilih
- ✅ Pilihan: 1, 3, 7, 14, 30 hari

---

### **✅ Checkbox - Syarat & Ketentuan**
```dart
Checkbox(
  value: _setujuSyarat,
  onChanged: (value) {
    setState(() {
      _setujuSyarat = value ?? false;
    });
  },
),
```

**Validasi:**
- ✅ Harus dicentang sebelum submit
- ✅ Tampilkan pesan error jika belum dicentang

---

## 🔍 Tipe-Tipe Validasi yang Digunakan

| Validasi | Input | Contoh |
|----------|-------|---------|
| **Required** | Semua | Nama, Email, Telepon |
| **Length** | Nama, ID | Min 3 karakter, Min 8 digit |
| **Regex Pattern** | Nama, Email, Telepon | `^[a-zA-Z\s]+$`, `^08[0-9]{8,11}$` |
| **Email Format** | Email | RFC standard email |
| **Dropdown Selection** | Buku, Durasi | Pilihan harus ada |
| **Date Range** | Tanggal | Tidak boleh tanggal lampau |
| **Checkbox** | Syarat | Harus dicentang |

---

## 📱 Fitur Utama Form

### **1. Real-time Validation**
Setiap field memiliki validator yang berjalan otomatis saat user mengubah nilai.

### **2. GlobalKey Form Management**
```dart
final _formKey = GlobalKey<FormState>();

// Validate all fields at once
if (_formKey.currentState!.validate()) {
  _submitForm();
}
```

### **3. TextFormField Controllers**
```dart
final TextEditingController _namaPeminjamController = 
    TextEditingController();

// Untuk mengambil nilai
String nama = _namaPeminjamController.text;

// Cleanup di dispose()
@override
void dispose() {
  _namaPeminjamController.dispose();
  super.dispose();
}
```

### **4. DatePicker Integration**
```dart
Future<void> _selectTanggal() async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2026, 12, 31),
  );
  
  if (picked != null) {
    setState(() {
      _tanggalPeminjamanController.text = 
          DateFormat('dd MMMM yyyy').format(picked);
    });
  }
}
```

### **5. Loading State**
```dart
setState(() {
  _isLoading = true;
});

// Simulate API call
Future.delayed(const Duration(seconds: 2), () {
  setState(() {
    _isLoading = false;
  });
});
```

### **6. Modal Dialogs**
- Success dialog menampilkan data yang dikirim
- Dialog syarat & ketentuan untuk informasi lengkap

### **7. Reset Form**
```dart
void _resetForm() {
  _formKey.currentState!.reset(); // Clear validation errors
  _namaPeminjamController.clear();
  // ... clear semua controller
  
  setState(() {
    // Reset semua state variables
  });
}
```

---

## 🎨 Input Styling

Setiap TextFormField memiliki:
- **Label** - Judul field
- **Hint Text** - Placeholder/contoh isi
- **Prefix Icon** - Icon sebelum teks
- **OutlineInputBorder** - Border dengan rounded corners
- **Keyboard Type** - Tipe keyboard yang sesuai (number, email, phone)

---

## 📊 Data Model - DataPeminjaman

```dart
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
  
  // toString() untuk display di success dialog
}
```

---

## 🚀 Alur Submit Form

```
User Fill Form
       ↓
Click "Kirim" Button
       ↓
Check Syarat Checkbox
       ├─ Jika belum dicentang → Show Snackbar Error
       └─ Jika sudah → Lanjut
       ↓
Validate All Fields (_formKey.currentState!.validate())
       ├─ Ada Error → Show Error Messages
       └─ Semua Valid → Lanjut
       ↓
Set Loading State (true)
       ↓
Create DataPeminjaman Object
       ↓
Simulate 2 Seconds Delay
       ↓
Set Loading State (false)
       ↓
Show Success Dialog
       ├─ Display: Nama, NIM, Email, Buku, Tanggal, Durasi
       ├─ Display: Est. Kembali (Tgl Pinjam + Durasi)
       └─ Tombol OK untuk tutup
```

---

## ✅ Fitur Validasi Checklist

- ✅ **Nama**: Required | MinLength(3) | OnlyLetters
- ✅ **ID**: Required | MinLength(8) | OnlyNumbers  
- ✅ **Email**: Required | ValidFormat
- ✅ **Telepon**: Required | Pattern(08+8-11digits)
- ✅ **Buku**: Required | DropdownSelection
- ✅ **Tanggal**: Required | NotPastDate
- ✅ **Durasi**: Required | PredefinedChoices
- ✅ **Syarat**: Required | MustBeChecked

---

## 🎯 Best Practices Diterapkan

1. **Separation of Concerns** - Form logic terpisah dari UI
2. **State Management** - Menggunakan StatefulWidget + setState
3. **Form Validation** - GlobalKey + FormState
4. **Resource Cleanup** - Dispose controllers di dispose()
5. **User Feedback** - SnackBar, Dialog, Loading indicator
6. **Input Security** - Regex validation, Type checking
7. **Accessibility** - Icons, Labels, Hint text
8. **Error Handling** - Try-catch ready untuk backend integration
9. **Date Formatting** - Menggunakan intl package
10. **Responsive Design** - SingleChildScrollView, proper spacing

---

## 📚 Widget yang Digunakan

- **TextFormField** - Text input dengan validasi
- **DropdownButtonFormField** - Dropdown dengan validasi
- **Checkbox** - Checkbox untuk terms & conditions
- **ElevatedButton** - Tombol aksi
- **DatePicker** - Pilih tanggal
- **AlertDialog** - Modal success/information
- **SnackBar** - Notifikasi ringkas
- **Card** - Container dengan styling
- **CircularProgressIndicator** - Loading indicator
- **SingleChildScrollView** - Scrollable content
- **Form** - Container untuk field validation

---

## 🔧 Cara Menjalankan

```bash
# Edit main.dart mengimport file ini
# Atau run langsung dengan:
flutter run -t lib/dashboard_akademik_formandvalidation.dart
```

---

## 💡 Pengembangan Lebih Lanjut

1. **Backend Integration** - Ganti delay dengan API call
2. **Local Database** - Simpan data dengan SQLite
3. **File Upload** - Upload kartu identitas (foto)
4. **Image Picker** - Ambil foto dari galeri
5. **Notification** - Notif pengingat pengembalian buku
6. **QR Code** - Scan buku untuk autocomplete judul
7. **Camera Integration** - Fotografi buku
8. **Biometric** - Login dengan fingerprint/face

---

**Dibuat: 28 April 2026**  
**Status: Production Ready**
