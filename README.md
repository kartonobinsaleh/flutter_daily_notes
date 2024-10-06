# Struktur Proyek dan Dokumentasi Penggunaan Aplikasi

## Deskripsi Proyek

- **Nama Proyek**: `flutter_daily_notes`
- **Deskripsi**: Aplikasi Catatan untuk pencatatan sederhana dengan timer.
- **Versi**: `1.0.0+1`
- **SDK Dart**: `^3.5.3`

## Teknologi yang Digunakan

- **Flutter**: Kerangka kerja untuk membangun antarmuka pengguna.
- **Equatable**: Untuk membandingkan objek.
- **Flutter Bloc**: Untuk manajemen state menggunakan pola BLoC.
- **Hydrated Bloc**: Untuk manajemen state yang persisten.
- **Bloc**: Kerangka kerja untuk memisahkan logika bisnis dari antarmuka pengguna.
- **Meta**: Menyediakan fitur metadata untuk Dart.
- **Path Provider**: Menyediakan akses ke lokasi penyimpanan.
- **Crypto**: Untuk hashing dan enkripsi.
- **Intl**: Untuk internasionalisasi dan format tanggal/waktu.
- **Cupertino Icons**: Ikon untuk gaya iOS.
- **Alarm**: Untuk mengatur alarm.

## Struktur Proyek

## 1. lib/

- **main.dart**: File utama untuk menginisialisasi aplikasi Flutter dan mendefinisikan root widget.

## 2. models/

- **user.dart**: Model data untuk pengguna dengan atribut seperti `id`, `name`, dan `email`.
- **note.dart**: Model data untuk catatan dengan atribut seperti `id`, `title`, dan `content`.

## 3. extensions/

- **router.dart**: Menyediakan fungsionalitas tambahan untuk navigasi dalam aplikasi.
- **list.dart**: Menyediakan extension untuk manipulasi objek `List`.

## 4. screens/

- **detail_note_page.dart**: Halaman untuk menampilkan detail catatan tertentu.
- **sign_up_page.dart**: Halaman untuk pendaftaran pengguna baru.
- **login_page.dart**: Halaman untuk proses login pengguna.
- **home_page.dart**: Halaman utama yang menampilkan daftar catatan.
- **add_note_page.dart**: Halaman untuk menambah catatan baru.

## 5. helper/

- **password.dart**: Helper untuk logika terkait password, termasuk validasi dan hashing.

## 6. widgets/

- **note_item.dart**: Widget untuk menampilkan catatan dalam daftar.
- **bottom_navbar_add.dart**: Widget untuk navigasi bawah dengan tombol tambah catatan.
- **custom_textfield.dart**: Widget custom untuk `TextField` dengan desain khusus.
- **custom_ilustration.dart**: Widget untuk menampilkan ilustrasi.
- **custom_account_text.dart**: Widget untuk teks terkait akun pengguna.
- **custom_button.dart**: Widget untuk tombol dengan desain kustom.
- **image_item.dart**: Widget untuk menampilkan gambar.

## 7. bloc/

### note/

- **note_bloc.dart**: Mengatur event dan state terkait catatan.
- **note_state.dart**: Mendefinisikan berbagai state catatan.
- **note_event.dart**: Mendefinisikan event yang memanipulasi data catatan.

### auth/

- **auth_bloc.dart**: Mengatur event dan state untuk login, logout, dan pendaftaran.
- **auth_event.dart**: Mendefinisikan event otentikasi.
- **auth_state.dart**: Mendefinisikan state terkait otentikasi pengguna.

Struktur proyek ini memisahkan dengan jelas antara model data, logika bisnis, dan tampilan, mengikuti praktik pengembangan yang baik.

## Dokumentasi Penggunaan Aplikasi

### 2.1. Halaman Login
Saat pertama kali membuka aplikasi, Anda akan diarahkan ke **Halaman Login**.  
Pengguna yang sudah terdaftar dapat login menggunakan **email** dan **password** mereka.  
Pengguna baru dapat mendaftar dengan menekan tombol **"Sign Up"** dan melengkapi form pendaftaran.

### 2.2. Halaman Home
Setelah login berhasil, Anda akan diarahkan ke **Halaman Utama (Home)**.  
Di sini, Anda bisa melihat daftar catatan yang sudah dibuat.  
Setiap catatan ditampilkan dalam bentuk **Note Item** yang berisi **judul** dan **konten singkat** catatan.

### 2.3. Menambahkan Catatan Baru
Untuk menambah catatan baru, tekan tombol **Add** di bagian bawah navigasi.  
Anda akan diarahkan ke **Halaman Tambah Catatan (Add Note)**.  
Isi **judul** dan **konten** catatan Anda, lalu tekan tombol **Save** untuk menyimpan catatan.

### 2.4. Melihat dan Mengedit Catatan
Untuk melihat detail catatan, tap pada catatan yang ada di daftar pada **Halaman Home**.  
Anda akan diarahkan ke **Halaman Detail Catatan (Detail Note Page)**.  
Di halaman ini, Anda bisa melihat **isi lengkap** catatan, serta opsi untuk **mengedit** atau **menghapus** catatan.  
Untuk mengedit, tekan tombol **Edit**, lakukan perubahan pada catatan, lalu tekan **Save**.

### 2.5. Pengaturan Alarm/Tugas
Pada setiap catatan, Anda dapat menambahkan **pengingat** atau **alarm**.  
Pilih catatan, tekan tombol **Set Alarm**, lalu atur waktu pengingat untuk catatan tersebut.  
Pengingat ini akan memberi **notifikasi** saat waktunya tiba.

### 2.6. Logout
Untuk keluar dari aplikasi, tekan tombol **Profil** di bagian kanan atas layar, lalu pilih **Logout**.
"""
