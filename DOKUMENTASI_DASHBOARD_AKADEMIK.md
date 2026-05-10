# Dokumentasi Dashboard Akademik Sederhana - Flutter

## Daftar Isi
1. [Gambaran Umum](#gambaran-umum)
2. [Widget yang Digunakan](#widget-yang-digunakan)
3. [Struktur Layout](#struktur-layout)
4. [Penjelasan Setiap Widget](#penjelasan-setiap-widget)

---

## Gambaran Umum

Dashboard akademik ini dirancang dengan fokus pada **kesederhanaan** dan **user experience**. Setiap widget dipilih dengan pertimbangan matang untuk memberikan fungsionalitas dan visual yang optimal.

### Komponen Utama:
- **AppBar** - Header dengan profil dan navigasi
- **Information Cards** - Grid informasi akademik
- **Menu Bar Horizontal** - Navigasi cepat
- **Action Buttons** - Tombol-tombol aksi
- **Floating Action Button** - Tombol utama (FAB)

---

## Widget yang Digunakan

| Widget | Jumlah | Alasan Penggunaan |
|--------|--------|-------------------|
| Scaffold | 1 | Struktur dasar halaman Flutter |
| AppBar | 1 | Header dengan title dan action buttons |
| ListView | 1 | Container scrollable untuk konten vertikal |
| Card | 7+ | Menampilkan informasi dalam box tertata |
| GridView | 1 | Layout grid untuk data akademik |
| Row | 3+ | Layout horizontal (profile, menu, buttons) |
| Column | 4+ | Layout vertikal (grouping elemen) |
| Container | 4+ | Styling dan dekorasi custom |
| ElevatedButton | 3+ | Tombol aksi dengan styling Material Design |
| OutlinedButton | 2+ | Tombol sekunder dengan border outline |
| IconButton | 2 | Tombol kecil di AppBar |
| Icon | 15+ | Representasi visual untuk menu dan info |
| Text | 20+ | Menampilkan teks dan label |
| Padding | 1 | Spacing di ListView |
| SizedBox | 10+ | Spacing dan ukuran elemen |
| SingleChildScrollView | 1 | Scrollable horizontal menu |
| FloatingActionButton | 1 | Tombol aksi utama mengapung |

---

## Struktur Layout

```
Scaffold
├── AppBar
│   ├── Title: "Dashboard Akademik"
│   └── Actions: [Profile Icon, Settings Icon]
│
├── Body: ListView
│   ├── Profile Card
│   │   └── Student Info (Name, NIM, Semester)
│   │
│   ├── Academic Info Grid (2x2)
│   │   ├── IPK Card
│   │   ├── Attendance Card
│   │   ├── Completed Tasks Card
│   │   └── Status Card
│   │
│   ├── Quick Menu Bar
│   │   └── Horizontal Buttons (Schedule, Grades, Tasks, Attendance)
│   │
│   └── Action Buttons
│       ├── Primary: View Full Schedule
│       ├── Secondary: Contact Lecturer
│       └── Secondary: Download Transcript
│
└── FloatingActionButton
    └── Add New Request Button
```

---

## Penjelasan Setiap Widget

### 1. **Scaffold**
```dart
Scaffold(
  appBar: AppBar(...),
  body: ListView(...),
  floatingActionButton: FloatingActionButton(...)
)
```
**Alasan Penggunaan:**
- Struktur dasar Flutter untuk material design layout
- Menangani AppBar, body, dan FAB secara otomatis
- Menyediakan default padding dan spacing

**Karakteristik:**
- Top-level container untuk halaman
- Mendukung multiple floating action button locations
- Otomatis handle keyboard visibility

---

### 2. **AppBar**
```dart
AppBar(
  backgroundColor: Colors.blueAccent,
  title: Text('Dashboard Akademik'),
  actions: [IconButton(...), IconButton(...)]
)
```
**Alasan Penggunaan:**
- Header standard di aplikasi mobile
- Tempat ideal untuk title dan aksi cepat
- Provides visual hierarchy dan branding

**Fitur Penting:**
- `elevation: 0` - Menghilangkan shadow untuk design flat
- `centerTitle: false` - Title rata kiri (lebih modern)
- `actions` - Icon buttons di sebelah kanan
- Gradient background untuk visual menarik

---

### 3. **ListView**
```dart
ListView(
  padding: const EdgeInsets.all(16.0),
  children: [...]
)
```
**Alasan Penggunaan:**
- Memungkinkan content scrollable vertikal
- Otomatis handle content yang lebih panjang dari screen
- Memory efficient dengan lazy loading

**Karakteristik:**
- Scrollable container untuk multiple children
- Automatic padding management
- Default behavior adalah scrollable

---

### 4. **Card**
```dart
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  child: Container(...)
)
```
**Alasan Penggunaan:**
- Memberikan visual elevation (shadow effect)
- Mengelompokkan informasi terkait
- Standard Material Design component

**Keuntungan:**
- Elevation otomatis membuat depth perception
- Rounded corners untuk modern look
- Responsive terhadap different screen sizes

---

### 5. **GridView**
```dart
GridView.count(
  crossAxisCount: 2,
  childAspectRatio: 1.5,
  children: [...]
)
```
**Alasan Penggunaan:**
- Layout optimal untuk multiple data items
- 2-kolom layout untuk efisiensi space
- Responsive terhadap ukuran screen

**Parameter Penting:**
- `crossAxisCount: 2` - 2 kolom layout
- `shrinkWrap: true` - Tidak scrollable sendiri
- `physics: NeverScrollableScrollPhysics()` - Disable internal scroll
- `childAspectRatio: 1.5` - Kontrol tinggi item

---

### 6. **Row & Column**
```dart
Row(children: [...])  // Layout horizontal
Column(children: [...])  // Layout vertikal
```
**Alasan Penggunaan:**
- Fundamental layout widgets di Flutter
- Row: Menu horizontal, button groups
- Column: Vertical grouping informasi

**Penggunaan:**
- Row untuk profile card (avatar + info)
- Column untuk academic info sections
- Kombinasi keduanya untuk complex layouts

---

### 7. **Container**
```dart
Container(
  padding: const EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    gradient: LinearGradient(...),
    borderRadius: BorderRadius.circular(12)
  ),
  child: ...
)
```
**Alasan Penggunaan:**
- Styling dan dekorasi custom
- Background color/gradient
- Padding dan margin management

**Fitur:**
- Gradient background (blue 300 to 600)
- Border radius untuk rounded corners
- Flexible sizing dengan width/height

---

### 8. **ElevatedButton**
```dart
ElevatedButton.icon(
  onPressed: () {},
  icon: Icon(Icons.event),
  label: Text('View Full Schedule'),
  style: ElevatedButton.styleFrom(...)
)
```
**Alasan Penggunaan:**
- Primary action buttons
- Material Design 3 styling
- Visual prominence dengan background color

**Karakteristik:**
- Elevated style dengan shadow
- Icon + label combination
- Customizable color dan shape

---

### 9. **OutlinedButton**
```dart
OutlinedButton.icon(
  onPressed: () {},
  icon: Icon(Icons.mail),
  label: Text('Contact Lecturer'),
  style: OutlinedButton.styleFrom(
    side: BorderSide(color: Colors.blue)
  )
)
```
**Alasan Penggunaan:**
- Secondary action buttons
- Less prominent daripada ElevatedButton
- Good untuk multiple actions

**Karakteristik:**
- Transparent background dengan colored border
- Cocok untuk alternative actions
- Space-efficient design

---

### 10. **IconButton**
```dart
IconButton(
  icon: const Icon(Icons.person_circle),
  onPressed: () {},
  tooltip: 'User Profile'
)
```
**Alasan Penggunaan:**
- Tombol kecil di AppBar
- Space-efficient untuk aksi sekunder
- Standard untuk navigation actions

**Keuntungan:**
- Compact size cocok untuk header
- Tooltip untuk accessibility
- Ripple effect feedback

---

### 11. **FloatingActionButton (FAB)**
```dart
FloatingActionButton(
  onPressed: () {},
  tooltip: 'Create New Request',
  child: const Icon(Icons.add)
)
```
**Alasan Penggunaan:**
- Primary action utama aplikasi
- Easily accessible floating position
- Standard Material Design pattern

**Karakteristik:**
- Tertarik perhatian user
- FAB di bottom-right corner
- Icon-based quick action

---

### 12. **Icon**
```dart
Icon(Icons.person, size: 40, color: Colors.blue)
```
**Alasan Penggunaan:**
- Visual representation untuk menu items
- Lebih intuitif daripada text saja
- Reduce cognitive load

**Material Icons Digunakan:**
- `Icons.person_circle` - Profile
- `Icons.settings` - Settings
- `Icons.school` - Academic (IPK)
- `Icons.assignment` - Tasks
- `Icons.check_circle` - Completed
- `Icons.verified` - Status
- `Icons.calendar_today` - Schedule
- `Icons.grade` - Grades
- `Icons.event` - Events
- `Icons.mail` - Contact
- `Icons.download` - Download

---

### 13. **Text**
```dart
Text(
  'Dashboard Akademik',
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white
  )
)
```
**Alasan Penggunaan:**
- Display teks content
- Typography hierarchy (title, label, body)
- Styling text dengan TextStyle

**Text Style Hierarchy:**
- **Title:** 22px, bold (AppBar)
- **Section Header:** 16px, bold
- **Value:** 20px, bold (info cards)
- **Label:** 14px, regular
- **Caption:** 12px, light gray

---

### 14. **Padding & SizedBox**
```dart
Padding(padding: EdgeInsets.all(16.0), child: ...)
SizedBox(height: 24) // Vertical spacing
SizedBox(width: 16)  // Horizontal spacing
```
**Alasan Penggunaan:**
- Manage spacing antara elemen
- Consistent whitespace
- Better visual hierarchy

**Perbedaan:**
- `Padding` - Untuk padding di sekitar child widget
- `SizedBox` - Untuk fixed spacing antar widgets

---

### 15. **SingleChildScrollView**
```dart
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(...)
)
```
**Alasan Penggunaan:**
- Menu buttons scrollable horizontal
- Tidak overflow screen pada small devices
- Maintain parent scroll behavior

---

## Best Practices Diterapkan

### 1. **Responsive Design**
```dart
GridView.count(crossAxisCount: 2)  // Auto-adjust untuk different sizes
Expanded(child: ...)                // Flexible width
SizedBox(width: double.infinity)    // Full width buttons
```

### 2. **Color Consistency**
- Primary: `Colors.blueAccent` dan `Colors.blue`
- Secondary: `Colors.orange`, `Colors.green`, `Colors.purple`
- Neutral: `Colors.white`, `Colors.grey`

### 3. **Spacing System**
- 4px - Small spacing (internal)
- 8px - Minor spacing
- 12px - Between components
- 16px - Standard padding
- 24px - Section spacing
- 32px - Major section spacing

### 4. **Typography System**
- Heading 1: 22px Bold (AppBar)
- Heading 2: 18px Bold (Section titles)
- Heading 3: 16px Bold (Card titles)
- Body: 14px Regular
- Caption: 12px Light

### 5. **User Interaction**
- FAB untuk primary action
- ElevatedButton untuk secondary actions
- OutlinedButton untuk alternative actions
- IconButton untuk quick access

---

## Tips Pengembangan Lebih Lanjut

### 1. Tambahkan Real Data
```dart
// Ganti dummy data dengan API calls
Future<StudentData> fetchStudentData() async {
  // API integration
}
```

### 2. Implementasikan Navigation
```dart
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SchedulePage())
  );
}
```

### 3. Tambahkan State Management
```dart
// Gunakan Provider atau BLoC
class AcademicDashboard extends StatelessWidget {
  final dashboardProvider = ref.watch(dashboardNotifierProvider);
}
```

### 4. Customize Theme
```dart
ThemeData(
  primaryColor: Colors.blue,
  useMaterial3: true,
  colorScheme: ColorScheme.light(primary: Colors.blue)
)
```

---

## Kesimpulan

Dashboard akademik ini mendemonstrasikan penggunaan **15+ widget Flutter** secara harmonis untuk menciptakan UI yang:
- ✅ **Simple** - Mudah dipahami dan digunakan
- ✅ **Clean** - Design yang rapi dan terorganisir
- ✅ **Responsive** - Beradaptasi dengan berbagai ukuran screen
- ✅ **Accessible** - Tooltip dan semantic structure
- ✅ **Professional** - Material Design 3 compliant

Setiap widget dipilih dengan purpose spesifik untuk memberikan pengalaman terbaik kepada pengguna.
