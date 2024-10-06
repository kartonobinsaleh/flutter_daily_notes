# Struktur Proyek `lib`

## Deskripsi Proyek

- **Nama Proyek**: `flutter_`
- **Deskripsi**: Aplikasi Flutter untuk daftar tugas sederhana.
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
