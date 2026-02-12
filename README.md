# Buku Sistem Operasi Linux

Template LaTeX untuk buku teks "Sistem Operasi Linux: Panduan Komprehensif untuk Mahasiswa"

## 📋 Deskripsi

Template buku ini dirancang untuk mendukung pembelajaran mata kuliah Sistem Operasi dengan fokus pada Linux. Buku ini mencakup 16 minggu pembelajaran yang terstruktur, dari pengenalan sistem operasi hingga manajemen sistem lanjutan.

## 📁 Struktur Direktori

```
os-book/
├── main.tex                    # File utama LaTeX
├── preamble.tex                # Konfigurasi package dan styling
├── references.bib              # Database bibliografi
├── Makefile                    # Automation untuk kompilasi
├── README.md                   # Dokumentasi (file ini)
│
├── frontmatter/                # Halaman depan buku
│   ├── titlepage.tex          # Halaman judul
│   ├── copyright.tex          # Halaman hak cipta
│   └── preface.tex            # Kata pengantar
│
├── chapters/                   # Bab-bab utama
│   ├── week01-introduction.tex
│   ├── week02-hardware-and-basic-commands.tex
│   ├── week03-basic-io.tex
│   ├── week05-directory-structure.tex
│   ├── week06-process-management.tex
│   ├── week07-bash-shell.tex
│   ├── week09-bash-programming.tex
│   ├── week10-memory-and-syscalls.tex
│   ├── week11-file-and-user-management.tex
│   ├── week12-service-management.tex
│   ├── week13-application-management.tex
│   └── week14-backup-and-recovery.tex
│
├── appendices/                 # Lampiran
│   ├── command-reference.tex  # Referensi perintah
│   ├── exercise-solutions.tex # Solusi latihan
│   └── glossary.tex           # Daftar istilah
│
└── images/                     # Direktori untuk gambar
```

## 🔧 Persyaratan Sistem

### Software yang Diperlukan

1. **TeX Distribution** (pilih salah satu):
   - **Linux**: TeX Live
     ```bash
     sudo apt install texlive-full    # Ubuntu/Debian
     sudo dnf install texlive-scheme-full  # Fedora
     ```
   - **macOS**: MacTeX
   - **Windows**: MiKTeX atau TeX Live

2. **Biber** (untuk bibliography):
   ```bash
   sudo apt install biber
   ```

3. **latexmk** (untuk automasi kompilasi):
   ```bash
   sudo apt install latexmk
   ```

4. **Make** (opsional, untuk menggunakan Makefile):
   ```bash
   sudo apt install build-essential
   ```

5. **Zathura** (PDF viewer, opsional):
   ```bash
   sudo apt install zathura
   ```

### Package LaTeX yang Digunakan

Template ini menggunakan berbagai package LaTeX:
- **KOMA-Script** (scrbook) - Document class
- **babel** - Dukungan bahasa Indonesia
- **graphicx, tikz** - Grafis dan diagram
- **listings** - Syntax highlighting untuk kode
- **biblatex** - Manajemen bibliografi
- **hyperref** - Hyperlink dan cross-reference
- **tcolorbox** - Colored boxes untuk catatan, tips, dll.

## 🚀 Cara Menggunakan

### Kompilasi Menggunakan Makefile (Recommended)

```bash
# Kompilasi lengkap
make

# Kompilasi cepat (single pass)
make quick

# Mode watch - kompilasi otomatis saat ada perubahan
make watch

# Lihat PDF hasil kompilasi dengan zathura
make view

# Bersihkan file temporary
make clean

# Bersihkan semua termasuk PDF
make cleanall

# Check dependensi
make check-deps

# Lihat semua opsi
make help
```

### Kompilasi Manual

Jika tidak menggunakan Makefile, gunakan latexmk:

```bash
# Kompilasi lengkap dengan latexmk (recommended)
latexmk -pdf -bibtex main.tex

# Mode watch dengan latexmk
latexmk -pdf -bibtex -pvc main.tex

# Clean temporary files
latexmk -c main.tex
```

**Atau** manual dengan pdflatex (tidak direkomendasikan):

```bash
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

**Catatan**: latexmk secara otomatis mendeteksi perubahan dan menjalankan kompilasi sesuai kebutuhan. Mode watch (`-pvc`) sangat berguna saat menulis.

## ✏️ Mulai Menulis

### 1. Edit Informasi Buku

Edit file-file berikut untuk menyesuaikan dengan informasi Anda:

**main.tex** (baris 20-24):
```latex
\title{Sistem Operasi Linux}
\subtitle{Panduan Komprehensif untuk Mahasiswa}
\author{[Nama Penulis]}
\date{\today}
\publishers{[Nama Penerbit]}
```

**frontmatter/titlepage.tex**:
- Ganti `[Nama Penulis Lengkap]`
- Tambahkan logo institusi jika ada

**frontmatter/copyright.tex**:
- Isi informasi penerbit
- Tambahkan ISBN

**frontmatter/preface.tex**:
- Sesuaikan kata pengantar

### 2. Menulis Konten Bab

Setiap bab memiliki file terpisah di direktori `chapters/`. Contoh untuk Bab 1 sudah lengkap di `week01-introduction.tex`.

#### Struktur Dasar Bab

```latex
\chapter{Judul Bab}
\label{ch:label-bab}

\begin{abstract}
Ringkasan bab...
\end{abstract}

\section{Judul Section}
\label{sec:label-section}

Konten...

\subsection{Judul Subsection}

Konten...
```

### 3. Fitur-Fitur Khusus

#### Code Listing

```latex
\begin{lstlisting}[language=bash, caption={Deskripsi kode}]
sudo apt update
sudo apt upgrade
\end{lstlisting}
```

#### Colored Boxes

```latex
% Catatan
\begin{notebox}
Ini adalah catatan penting...
\end{notebox}

% Tips
\begin{tipbox}
Tips: Gunakan tab completion...
\end{tipbox}

% Peringatan
\begin{warningbox}
Peringatan: Perintah ini dapat menghapus data!
\end{warningbox}

% Contoh
\begin{examplebox}[Judul Contoh]
Contoh penggunaan...
\end{examplebox}

% Latihan
\begin{exercisebox}[1.1]
Soal latihan...
\end{exercisebox}
```

#### Command Khusus Linux

```latex
\cmd{ls -la}              % Perintah dengan warna
\file{/etc/passwd}        % Nama file
\dir{/home/user}          % Direktori
\var{PATH}                % Variable
\keystroke{Ctrl+C}        % Keystroke
```

#### Gambar

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.8\textwidth]{nama-gambar.png}
    \caption{Caption gambar}
    \label{fig:label-gambar}
\end{figure}
```

Simpan gambar di direktori `images/`.

#### Tabel

```latex
\begin{table}[htbp]
    \centering
    \caption{Caption tabel}
    \label{tab:label-tabel}
    \begin{tabular}{@{}lll@{}}
        \toprule
        \textbf{Kolom 1} & \textbf{Kolom 2} & \textbf{Kolom 3} \\
        \midrule
        Data 1 & Data 2 & Data 3 \\
        Data 4 & Data 5 & Data 6 \\
        \bottomrule
    \end{tabular}
\end{table}
```

#### Referensi

```latex
% Referensi gambar, tabel, bab, dll
Lihat \cref{fig:kernel-architecture}
Seperti dijelaskan di \cref{ch:introduction}

% URL
\url{https://www.kernel.org}

% Sitasi
Menurut \cite{tanenbaum2014modern}...
```

### 4. Menambah Referensi

Edit file `references.bib`:

```bibtex
@book{key,
  title={Judul Buku},
  author={Nama Penulis},
  year={2024},
  publisher={Penerbit},
  isbn={978-xxx}
}
```

Gunakan di teks dengan `\cite{key}`.

## 📝 Workflow Penulisan

1. **Mulai dari Chapter 1** yang sudah ada templatenya
2. **Isi konten** sesuai outline di `outline.md`
3. **Kompilasi berkala** dengan `make quick` untuk cek hasil
4. **Tambahkan gambar** di direktori `images/`
5. **Update referensi** di `references.bib`
6. **Kompilasi final** dengan `make` sebelum review

## 🎨 Kustomisasi

### Mengubah Warna

Edit `preamble.tex` bagian Color definitions:

```latex
\definecolor{linkcolor}{rgb}{0.0,0.2,0.6}
\definecolor{commandcolor}{rgb}{0.1,0.3,0.5}
```

### Mengubah Font

Edit `preamble.tex`:

```latex
\usepackage{lmodern}  % Ganti dengan font lain
```

### Mengubah Margin

Edit `preamble.tex` bagian geometry:

```latex
\geometry{
    top=2.5cm,
    bottom=2.5cm,
    left=3cm,
    right=2.5cm,
}
```

## 🐛 Troubleshooting

### Error: Package not found

```bash
# Install package yang kurang
sudo apt install texlive-latex-extra texlive-fonts-extra
```

### Error: Bibliography not compiled

```bash
# Pastikan biber terinstall
sudo apt install biber

# Kompilasi ulang dengan urutan benar
make clean
make
```

### Error: Undefined reference

Kompilasi harus dilakukan beberapa kali:
```bash
make cleanall
make
```

### PDF tidak terupdate

```bash
make clean
make
```

## 📖 Contoh Chapter Lengkap

Lihat `chapters/week01-introduction.tex` untuk contoh lengkap yang mencakup:
- Struktur bab yang baik
- Penggunaan section dan subsection
- Code listings
- Colored boxes
- Gambar dengan TikZ
- Tabel
- Latihan
- Referensi

## 🤝 Kontribusi

Untuk perbaikan atau saran, silakan:
1. Fork repository
2. Buat branch baru
3. Submit pull request

## 📄 Lisensi

[Sesuaikan dengan lisensi yang diinginkan]

## 📞 Kontak

[Isi informasi kontak penulis]

---

**Selamat menulis! 🎉**

Untuk pertanyaan atau bantuan, silakan hubungi [kontak].
