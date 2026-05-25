import 'package:flutter/material.dart';

void main() => runApp(const DashboardMahasiswaApp());

class DashboardMahasiswaApp extends StatelessWidget {
  const DashboardMahasiswaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Mahasiswa',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const DashboardMahasiswa(),
    );
  }
}

class DashboardMahasiswa extends StatefulWidget {
  const DashboardMahasiswa({super.key});

  @override
  State<DashboardMahasiswa> createState() => _DashboardMahasiswaState();
}

class _DashboardMahasiswaState extends State<DashboardMahasiswa> {
  // Parent state — digunakan untuk seluruh UI:
  String _namaMahasiswa = 'Mahasiswa Contoh';
  int _jumlahTugas = 0;
  bool _isLoggedIn = false;

  // Semua perubahan state utama dikelola di sini (parent).
  // Alasan: data (nama, jumlah tugas, status login) perlu dibagikan
  // ke beberapa child widget sehingga lebih mudah kalau diletakkan
  // di parent (single source of truth).

  void _ubahNama(String namaBaru) {
    setState(() {
      _namaMahasiswa = namaBaru;
    });
  }

  void _tambahTugas() {
    setState(() {
      _jumlahTugas += 1;
    });
  }

  void _kurangiTugas() {
    setState(() {
      if (_jumlahTugas > 0) _jumlahTugas -= 1;
    });
  }

  void _toggleLogin() {
    setState(() {
      _isLoggedIn = !_isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input untuk mengubah nama mahasiswa (mengupdate parent state)
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nama Mahasiswa',
                border: OutlineInputBorder(),
              ),
              onChanged: _ubahNama,
            ),
            const SizedBox(height: 16),

            // Child widget 1: menampilkan nama (menerima data dari parent)
            StudentInfo(name: _namaMahasiswa),
            const SizedBox(height: 12),

            // Child widget 2: menampilkan dan mengontrol jumlah tugas
            TaskControls(
              count: _jumlahTugas,
              onIncrement: _tambahTugas,
              onDecrement: _kurangiTugas,
            ),
            const SizedBox(height: 12),

            // Child widget 3: menampilkan status login (juga menerima data)
            LoginStatus(loggedIn: _isLoggedIn, onToggle: _toggleLogin),

            const Spacer(),
            // Penjelasan singkat di bawah layar
            const Text(
              'Catatan: State utama (nama, tugas, login) disimpan di parent. Child widgets hanya menerima data dan callback.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- Child Widgets ----------------------

class StudentInfo extends StatelessWidget {
  final String name;

  const StudentInfo({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.person, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nama Mahasiswa',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskControls extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const TaskControls({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.task, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jumlah Tugas',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDecrement,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            IconButton(
              onPressed: onIncrement,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginStatus extends StatelessWidget {
  final bool loggedIn;
  final VoidCallback onToggle;

  const LoginStatus({
    super.key,
    required this.loggedIn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(loggedIn ? Icons.lock_open : Icons.lock, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status Login',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    loggedIn ? 'Logged In' : 'Logged Out',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onToggle,
              child: Text(loggedIn ? 'Logout' : 'Login'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Penjelasan singkat (untuk dikumpulkan bersama screenshot):

- State lokal vs parent:
  - Semua state utama (`_namaMahasiswa`, `_jumlahTugas`, `_isLoggedIn`) berada di stateful parent `_DashboardMahasiswaState`.
  - Alasan: data tersebut perlu dibagikan ke beberapa child widget (StudentInfo, TaskControls, LoginStatus).
  - Child widgets bersifat stateless dan menerima data serta callback dari parent.

- Penggunaan `setState`:
  - Setiap kali data diubah (mis. mengetik nama, menambah tugas, toggle login), method di parent memanggil `setState(() { ... })`.
  - `setState` memberi tahu framework untuk melakukan rebuild pada widget yang bergantung pada state tersebut, sehingga UI ter-update.

- Alur perubahan data:
  1. User melakukan aksi (ketik nama / tekan + / tekan Login).
  2. Child memanggil callback yang diberikan oleh parent (mis. `onIncrement`).
  3. Parent mengubah field state dan memanggil `setState`.
  4. Flutter merender ulang widget yang perlu di-update, child menerima data baru melalui konstruktor dan menampilkan perubahan.

*/
