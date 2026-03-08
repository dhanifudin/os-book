# Kuis 1 - Sistem Operasi

## Petunjuk Pengerjaan

1. Kuis ini terdiri dari dua bagian: **Bagian A** (5 soal) dan **Bagian B** (5 soal).
2. Pilih **2 soal dari Bagian A** dan **2 soal dari Bagian B** untuk dikerjakan (total 4 soal).
3. Setiap soal dikerjakan langsung di VM Ubuntu Anda.
4. Rekam seluruh proses pengerjaan dalam bentuk **video dokumentasi** yang memuat:
   - Layar terminal VM saat menjalankan setiap perintah
   - Penjelasan lisan untuk setiap langkah dan jawaban yang diberikan
   - Pembacaan output dan interpretasinya
5. Unggah video ke **YouTube** (boleh unlisted) dan sertakan link video pada lembar jawaban Anda.
6. Pastikan video jelas, audio dapat didengar, dan mencakup seluruh sub-pertanyaan dari soal yang dipilih.

---

## Bagian A: Manajemen Perangkat Keras & Perintah Dasar

### Soal 1

Anda sedang melakukan praktikum menggunakan Ubuntu Server di VirtualBox. Tugas Anda adalah mengidentifikasi perangkat jaringan virtual yang tersedia di VM dan memverifikasi modul kernel yang menanganinya.

Jalankan perintah berikut di terminal VM Anda:

```bash
lspci -nnk
```

Contoh output yang mungkin Anda lihat (output aktual bisa berbeda):

```
00:03.0 Ethernet controller [0200]: Intel Corporation 82540EM Gigabit Ethernet Controller [8086:100e] (rev 02)
        Subsystem: Intel Corporation PRO/1000 MT Desktop Adapter [8086:001e]
        Kernel driver in use: e1000
        Kernel modules: e1000
```

a) Berdasarkan output perintah `lspci -nnk` yang Anda jalankan di VM:

- Tuliskan nama perangkat Ethernet yang terdeteksi beserta Vendor ID dan Device ID-nya (format `[xxxx:xxxx]`).
- Tuliskan nama modul kernel yang sedang digunakan (`Kernel driver in use`).

b) Tuliskan perintah yang memfilter output `lspci -nnk` untuk menampilkan hanya baris yang mengandung kata `Ethernet` beserta 3 baris setelahnya. Jalankan perintah tersebut dan salin hasilnya.

c) Gunakan nama modul yang Anda temukan pada poin (a) untuk menjalankan `modinfo`. Dari outputnya, tuliskan nilai field `description`, `version`, dan satu `parm` (parameter) yang tersedia.

---

### Soal 2

Seorang teknisi sedang melakukan audit hardware pada server Ubuntu 22.04 yang baru diterima dari vendor. Ia perlu mendokumentasikan spesifikasi CPU, kondisi memori, serta konfigurasi storage sebelum server diproduksi.

a) Tuliskan tiga perintah yang digunakan secara berurutan untuk melihat: (1) arsitektur dan jumlah core CPU, (2) total RAM beserta penggunaan swap, dan (3) daftar disk beserta partisi dan tipe filesystemnya. Jalankan ketiga perintah tersebut di VM Anda dan catat hasilnya.

b) Sebelum memeriksa UUID, teknisi perlu mengetahui terlebih dahulu device mana yang digunakan sebagai root filesystem di VM-nya.

- Jalankan perintah untuk menemukan device yang me-mount root filesystem (`/`) di VM Anda. _(Hint: gunakan `findmnt /`)_
- Catat nama device yang Anda temukan (misalnya `/dev/sda1` atau `/dev/sda2`, bisa berbeda di tiap VM).
- Gunakan nama device tersebut untuk menampilkan UUID dan tipe filesystemnya. Tuliskan perintah yang Anda gunakan beserta outputnya.

c) Jelaskan mengapa UUID lebih dianjurkan daripada nama device (seperti `/dev/sda2`) untuk konfigurasi mounting di `/etc/fstab`.

---

### Soal 3

Anda ingin membuat antarmuka jaringan virtual untuk keperluan pengujian konfigurasi jaringan di VM tanpa membutuhkan perangkat fisik tambahan. Linux menyediakan modul `dummy` yang memungkinkan pembuatan network interface virtual tersebut.

a) Jalankan perintah untuk memeriksa apakah modul `dummy` sudah aktif di kernel saat ini. Tuliskan perintah yang digunakan dan salin outputnya. Apakah modul tersebut sudah aktif di VM Anda?

b) Jalankan `modinfo dummy` di VM Anda. Dari outputnya, tuliskan nilai field berikut:

- `filename` (lokasi file `.ko` modul)
- `description`
- `vermagic` (versi kernel yang kompatibel)

c) Lakukan langkah-langkah berikut secara berurutan dan tuliskan output dari setiap perintah:

1. Muat modul `dummy` menggunakan `modprobe`
2. Verifikasi modul berhasil dimuat menggunakan `lsmod`
3. Buat network interface virtual dengan perintah berikut:

    ```bash
    sudo ip link add dummy0 type dummy
    ```

4. Tampilkan interface `dummy0` menggunakan `ip link show dummy0` sebagai bukti berhasil

---

### Soal 4

Seorang administrator menerima laporan bahwa aplikasi web di server mengalami error. Ia perlu mengunduh file log yang telah disiapkan, kemudian menganalisisnya menggunakan perintah manipulasi teks.

Unduh file log menggunakan perintah berikut di VM Anda:

```bash
wget -O app.log https://s.id/IvfhB
```

Setelah file berhasil diunduh, gunakan file `app.log` tersebut untuk menjawab pertanyaan berikut.

a) Jalankan perintah `grep` untuk menampilkan hanya baris-baris yang mengandung `ERROR`, beserta nomor barisnya. Tuliskan perintah yang digunakan dan salin outputnya.

b) Jalankan perintah untuk menampilkan baris yang mengandung `WARN` atau `ERROR` sekaligus menggunakan satu perintah `grep`. Tuliskan perintah yang digunakan dan salin outputnya.

c) Tim developer meminta log dirapikan dengan mengganti label `WARN` menjadi `WARNING` dan `ERROR` menjadi `CRITICAL` pada file tersebut. Tuliskan perintah `sed` untuk melakukan kedua penggantian tersebut sekaligus, dengan terlebih dahulu membuat backup file asli. Tampilkan isi file sebelum dan sesudah perubahan.

---

### Soal 5

Saat mengerjakan tugas praktikum, Anda tidak sengaja menjalankan dua proses `sleep` di background sekaligus dan lupa berapa lama masing-masing berjalan. Untuk melatih manajemen proses, Anda perlu menemukan dan menghentikan keduanya dengan cara yang benar.

Jalankan perintah berikut terlebih dahulu di VM Anda untuk menyiapkan skenario:

```bash
sleep 800 &
sleep 900 &
```

a) Jalankan perintah `ps` untuk menemukan PID dari kedua proses `sleep` tersebut tanpa menampilkan proses `grep` dalam hasilnya. Tuliskan perintah yang digunakan dan catat kedua PID yang Anda temukan.

b) Hentikan proses `sleep 800` menggunakan SIGTERM. Verifikasi bahwa proses tersebut sudah berhenti dengan menjalankan kembali perintah pencarian dari poin (a). Tuliskan semua perintah yang Anda gunakan beserta outputnya.

c) Jelaskan perbedaan antara SIGTERM dan SIGKILL. Dalam kondisi apa Anda sebaiknya beralih dari SIGTERM ke SIGKILL, dan apa risiko menggunakan SIGKILL secara langsung tanpa mencoba SIGTERM terlebih dahulu?

---

## Bagian B: Dasar Input/Output (I/O)

### Soal 1

Seorang mahasiswa baru belajar tentang file descriptor di Linux. Ia menjalankan perintah berikut di terminal:

```bash
ls -l /proc/$$/fd
```

Dan mendapat output:

```
lrwx------ 1 student student 64 Mar  4 09:00 0 -> /dev/pts/1
lrwx------ 1 student student 64 Mar  4 09:00 1 -> /dev/pts/1
lrwx------ 1 student student 64 Mar  4 09:00 2 -> /dev/pts/1
lr-x------ 1 student student 64 Mar  4 09:00 3 -> /proc/1234/fd
```

a) Jelaskan apa yang direpresentasikan oleh file descriptor 0, 1, dan 2 pada output di atas, serta mengapa ketiganya mengarah ke `/dev/pts/1`.

b) Mahasiswa tersebut kemudian menjalankan `cat < /etc/hostname`. Jelaskan bagaimana aliran data terjadi, dari mana shell membaca input, dan ke mana outputnya dikirim.

c) Apa yang dimaksud dengan variabel `$$` dalam perintah di atas? Mengapa nilai `$$` berbeda setiap kali sesi terminal baru dibuka?

---

### Soal 2

Saat mencoba memahami redirection, Anda menjalankan perintah `find` untuk mencari semua file `.conf` di sistem. Namun, outputnya bercampur antara hasil pencarian yang valid dan banyak pesan error "Permission denied" karena ada folder sistem yang tidak bisa diakses.

Jalankan perintah berikut di VM Anda dan amati outputnya:

```bash
find / -name "*.conf"
```

a) Dari output perintah di atas, ada dua jenis output yang muncul. Jelaskan perbedaan keduanya dan melalui file descriptor mana masing-masing dikirim.

b) Tuliskan ulang perintah tersebut agar:

- Hasil pencarian yang valid tersimpan ke file `hasil-pencarian.txt`
- Pesan error "Permission denied" tersimpan ke file `error.txt`

Jalankan perintah tersebut, lalu tampilkan 5 baris pertama dari masing-masing file untuk membuktikan pemisahan berhasil.

c) Tuliskan perintah untuk menjalankan pencarian yang sama, tetapi kali ini pesan error dibuang sepenuhnya agar terminal hanya menampilkan hasil pencarian yang valid. Kapan pendekatan ini lebih tepat digunakan dibandingkan menyimpan error ke file?

---

### Soal 3

Untuk keperluan laporan praktikum, Anda perlu mendokumentasikan kondisi sistem VM saat ini. Anda ingin melihat outputnya langsung di terminal sekaligus menyimpannya ke sebuah file laporan tanpa harus menjalankan perintah dua kali.

a) Jalankan perintah `df -h` menggunakan `tee` agar outputnya tampil di terminal sekaligus tersimpan ke file `laporan.txt`. Kemudian jalankan perintah `free -h` dengan `tee` dalam mode **append** agar hasilnya ditambahkan ke file yang sama. Tuliskan kedua perintah yang digunakan dan tampilkan isi `laporan.txt` setelah keduanya dijalankan.

b) Anda ingin menyimpan output `uptime` ke dua file sekaligus: `laporan.txt` (mode append) dan `backup-laporan.txt` (mode append). Jalankan perintah menggunakan `tee` untuk mencapai keduanya dalam satu perintah, kemudian tampilkan isi kedua file sebagai bukti.

c) Jelaskan perbedaan antara `tee` dan operator `>`. Kapan Anda memilih menggunakan `tee` dibandingkan cukup menggunakan `>`?

---

### Soal 4

Anda diminta menganalisis daftar user yang ada di VM dan menyimpan hasilnya secara bertahap. Gunakan file `/etc/passwd` sebagai sumber data.

a) Jalankan pipeline berikut di VM Anda dan jelaskan fungsi setiap perintah dalam pipeline tersebut secara berurutan:

```bash
cat /etc/passwd | cut -d: -f1 | sort | uniq
```

b) Modifikasi pipeline di atas menggunakan `tee` agar hasil setelah tahap `sort` tersimpan ke file `sorted-users.txt`, sementara data tetap mengalir ke perintah `uniq`. Jalankan pipeline tersebut dan tampilkan isi `sorted-users.txt` untuk membuktikan hasilnya.

c) Jelaskan perbedaan hasil antara menggunakan `sort | uniq` dan hanya menggunakan `sort` saja. Dalam konteks file `/etc/passwd`, apakah perbedaan tersebut terlihat? Mengapa?

---

### Soal 5

Anda ingin mengecek proses apa saja yang sedang berjalan di VM, kemudian menyimpan hasilnya ke file untuk diperiksa kembali nanti.

a) Jalankan pipeline berikut di VM Anda, lalu jelaskan fungsi setiap tahapnya:

```bash
ps aux | grep -v grep | head -10
```

b) Modifikasi pipeline di atas agar hasilnya tersimpan ke file `proses.txt` sekaligus tetap tampil di terminal. Jalankan perintah tersebut dan tampilkan isi `proses.txt` sebagai bukti.

c) Jelaskan perbedaan antara dua perintah berikut dan kapan masing-masing digunakan:

```bash
ps aux | grep sshd > hasil.txt
ps aux | grep sshd >> hasil.txt
```

Jalankan keduanya secara berurutan dua kali, lalu bandingkan isi `hasil.txt` setelah masing-masing percobaan.

---
