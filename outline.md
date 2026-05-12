
# Outline Buku Sistem Operasi

## Bab 1: Pengenalan Sistem Operasi dan Instalasi Linux
- **Materi**:
  - Konsep dasar dan fungsi sistem operasi
  - Sejarah dan evolusi sistem operasi Linux
  - Arsitektur kernel Linux
  - Variasi dan karakteristik distribusi Linux
  - Proses instalasi Linux
  - Partisi disk dan sistem file di Linux (konteks instalasi: tipe partisi, mount point, swap)
  - Konfigurasi awal pasca instalasi

## Bab 2: Manajemen Perangkat Keras dan Perintah Dasar
- **Materi**:
  - Deteksi perangkat keras dan konfigurasi di Linux
  - Modul kernel dan driver perangkat
  - Perintah dasar terminal Linux (`ls`, `cd`, `pwd`, dll.)
  - Operasi dasar file dan direktori (`cp`, `mv`, `rm`, `mkdir`, `touch`)
  - Manipulasi teks dengan `sed`, `awk`, dan `grep`
  - Bantuan dan dokumentasi perintah (`man`, `--help`, `info`)

## Bab 3: Dasar Input dan Output (I/O)
- **Materi**:
  - File descriptor di Linux
  - Pengalihan I/O standar (stdin, stdout, stderr)
  - Pipa dan penggunaan operator `|`
  - Pengalihan output ke file (`>`, `>>`)
  - Penggunaan `tee` untuk output ganda

## Bab 4: Struktur Direktori dan Operasi File
- **Materi**:
  - Standar Hierarki Sistem File (FHS) di Linux (sistem yang berjalan — bukan partisi instalasi, lihat Bab 1)
  - Sistem file Linux dan peran `/dev`
  - Jenis file di Linux (reguler, direktori, symlink, perangkat)
  - Eksplorasi struktur direktori Linux melalui command line
  - Hard links dan symbolic links
  - Pencarian file dengan `find` dan `locate`
  - Kompresi dan pengarsipan file (`tar`, `gzip`, `zip`)

## Bab 5: Manajemen Proses
- **Materi**:
  - Konsep proses dan thread di Linux
  - Siklus hidup proses
  - Penjadwalan proses dan prioritas
  - Sinyal proses dan penanganannya
  - Manajemen job (foreground dan background)
  - Pemantauan proses dengan `ps`, `top`, `htop`, dan `atop` (perspektif proses)
  - Penggunaan `nice` dan `renice` untuk prioritas proses

## Bab 6: Bash Shell
- **Materi**:
  - Pengenalan Bash sebagai shell default di Linux
  - Konfigurasi Bash (`.bashrc`, `.bash_profile`)
  - Variabel lingkungan dan PATH
  - Membuat alias shell (fungsi shell dibahas di Bab 7)
  - Penyelesaian dan history Bash
  - Wildcards dan ekspansi nama file
  - Quoting dan escaping di Bash

## Bab 7: Pemrograman Bash
- **Materi**:
  - Dasar-dasar scripting Bash
  - Variabel lokal skrip dan parameter posisional (bukan variabel lingkungan — lihat Bab 6)
  - Struktur kontrol (if, for, while, case)
  - Fungsi dalam shell script
  - Pengolahan argumen command line
  - Debugging shell script
  - Praktik terbaik dalam shell scripting

## Bab 8: Manajemen Memori dan System Call
- **Materi**:
  - Arsitektur memori di Linux
  - Manajemen memori virtual
  - Konfigurasi swap space
  - Pemantauan penggunaan memori (`free`, `vmstat`, `/proc/meminfo`) — `top` dibahas di Bab 5
  - Pengenalan system call di Linux
  - Jenis-jenis system call umum
  - Interaksi antara user space dan kernel space

## Bab 9: Manajemen File, User, dan Group
- **Materi**:
  - Sistem kontrol akses di Linux (permissions)
  - Perintah izin dan kepemilikan file (`chmod`, `chown`, `chgrp`)
  - Access Control Lists (ACLs)
  - Manajemen user dan group (`useradd`, `usermod`, `groupadd`, dll.)
  - Konfigurasi `sudo` dan penggunaan `su`
  - Disk quota untuk user dan group

## Bab 10: Manajemen Layanan (Services)
- **Materi**:
  - Pengenalan sistem init di Linux (SysV init, Upstart, systemd)
  - Mengelola layanan dengan `systemctl`
  - Membuat dan menyesuaikan file unit sistem
  - Manajemen dependensi layanan
  - Pemantauan status layanan dan logging
  - Mengonfigurasi layanan jaringan (SSH, Apache, MySQL)
  - Automatisasi start-up dan shutdown layanan
  - Troubleshooting layanan Linux

## Bab 11: Manajemen Aplikasi
- **Materi**:
  - Sistem manajemen paket di Linux (apt, yum, dnf)
  - Instalasi, update, dan penghapusan software
  - Manajemen repositori software
  - Kompilasi software dari source code
  - Penggunaan container (Docker, Podman) untuk isolasi aplikasi
  - Manajemen dependensi aplikasi
  - Pemantauan performa aplikasi

## Bab 12: Backup dan Pemulihan Sistem
- **Materi**:
  - Strategi backup di lingkungan Linux
  - Penggunaan tools backup (`rsync`, `dd`, dan penggunaan lanjutan `tar` — sintaks dasar `tar` dibahas di Bab 4)
  - Implementasi backup terjadwal
  - Pemulihan sistem dari backup
  - Perencanaan pemulihan bencana untuk sistem Linux
