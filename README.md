# Buku Sistem Operasi Linux (Bilingual Edition)

Template LaTeX untuk buku teks "Sistem Operasi Linux: Panduan Komprehensif untuk Mahasiswa"

**🌏 Available in two languages:** Indonesian (Bahasa Indonesia) and English

## 📋 Deskripsi

Template buku ini dirancang untuk mendukung pembelajaran mata kuliah Sistem Operasi dengan fokus pada Linux. Buku ini mencakup 16 minggu pembelajaran yang terstruktur, dari pengenalan sistem operasi hingga manajemen sistem lanjutan.

**Bilingual Support:**
- `main-id.tex` - Indonesian version
- `main-en.tex` - English version
- Shared preamble and bibliography
- Separate content directories: `chapters/id/` and `chapters/en/`

## 📁 Struktur Direktori

```
os-book/
├── main-id.tex                 # Indonesian version entry point
├── main-en.tex                 # English version entry point
├── preamble.tex                # Shared configuration
├── references.bib              # Shared bibliography
├── Makefile                    # Build automation (bilingual)
├── CLAUDE.md                   # Documentation for Claude Code
├── README.md                   # This file
│
├── .github/
│   └── workflows/              # GitHub Actions CI/CD
│       ├── build-pdf.yml       # Automatic PDF builds
│       ├── release.yml         # Release automation
│       └── README.md           # Workflow documentation
│
├── frontmatter/                # Front matter
│   ├── id/                     # Indonesian
│   │   ├── titlepage.tex
│   │   ├── copyright.tex
│   │   └── preface.tex
│   └── en/                     # English
│       ├── titlepage.tex
│       ├── copyright.tex
│       └── preface.tex
│
├── chapters/                   # Main chapters
│   ├── id/                     # Indonesian chapters
│   │   ├── week01-introduction.tex
│   │   ├── week02-hardware-and-basic-commands.tex
│   │   └── ... (weeks 3-14)
│   └── en/                     # English chapters
│       ├── week01-introduction.tex
│       ├── week02-hardware-and-basic-commands.tex
│       └── ... (weeks 3-14)
│
├── appendices/                 # Appendices
│   ├── id/                     # Indonesian
│   │   ├── command-reference.tex
│   │   ├── exercise-solutions.tex
│   │   └── glossary.tex
│   └── en/                     # English
│       ├── command-reference.tex
│       ├── exercise-solutions.tex
│       └── glossary.tex
│
└── images/                     # Shared images directory
```

## 🤖 Automated Builds (GitHub Actions)

This repository includes automated PDF builds via GitHub Actions:

- **Automatic builds** on every push to `main` or `feature/*` branches
- **PDF artifacts** available for download (90 days retention)
- **Automatic releases** when you push version tags (e.g., `v1.0.0`)

See [`.github/workflows/README.md`](.github/workflows/README.md) for details.

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

**Build Indonesian version:**
```bash
make id              # or just `make` (default)
make quick-id        # Quick build (single pass)
make watch-id        # Auto-compile on changes
make view-id         # Build and view with zathura
```

**Build English version:**
```bash
make en              # Full build
make quick-en        # Quick build (single pass)
make watch-en        # Auto-compile on changes
make view-en         # Build and view with zathura
```

**Build both versions:**
```bash
make both            # Build Indonesian and English
```

**Other commands:**
```bash
make clean           # Clean temporary files
make cleanall        # Clean all including PDFs
make check-deps      # Check dependencies
make help            # Show all options
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

## 📦 Downloading Pre-built PDFs

If you don't want to build locally, you can download pre-built PDFs:

### From Releases (Stable Versions)
1. Go to the [Releases page](../../releases)
2. Download the latest release PDFs

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
