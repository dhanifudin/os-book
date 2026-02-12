# ========================================================================
# Makefile untuk Kompilasi Buku LaTeX
# Menggunakan latexmk untuk automasi kompilasi
# ========================================================================

# Nama file utama (tanpa ekstensi .tex)
MAIN = main

# PDF Viewer
VIEWER = zathura

# latexmk configuration
LATEXMK = latexmk
LATEXMK_FLAGS = -pdf -bibtex -interaction=nonstopmode -file-line-error

# ========================================================================
# Target Utama
# ========================================================================

.PHONY: all clean cleanall view watch checkerrors checkref wordcount help

# Default target
all: $(MAIN).pdf

# Kompilasi penuh menggunakan latexmk
$(MAIN).pdf: $(MAIN).tex preamble.tex references.bib
	@echo "========================================="
	@echo "Kompilasi LaTeX dengan latexmk"
	@echo "========================================="
	$(LATEXMK) $(LATEXMK_FLAGS) $(MAIN).tex
	@echo "========================================="
	@echo "Kompilasi selesai! File: $(MAIN).pdf"
	@echo "========================================="

# Kompilasi cepat (single pass, no bibtex)
quick:
	@echo "Kompilasi cepat (single pass)..."
	$(LATEXMK) -pdf -interaction=nonstopmode $(MAIN).tex

# Watch mode - kompilasi otomatis saat file berubah
watch:
	@echo "========================================="
	@echo "Mode Watch - Kompilasi otomatis aktif"
	@echo "Tekan Ctrl+C untuk berhenti"
	@echo "========================================="
	$(LATEXMK) -pdf -bibtex -pvc -interaction=nonstopmode $(MAIN).tex

# Bersihkan file temporary
clean:
	@echo "Membersihkan file temporary..."
	$(LATEXMK) -c $(MAIN).tex
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg *.bcf *.run.xml
	rm -f *.idx *.ilg *.ind *.lol *.nav *.snm *.vrb
	rm -f chapters/*.aux
	rm -f frontmatter/*.aux
	rm -f appendices/*.aux
	@echo "File temporary telah dibersihkan."

# Bersihkan semua file termasuk PDF
cleanall:
	@echo "Menghapus semua file output..."
	$(LATEXMK) -C $(MAIN).tex
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg *.bcf *.run.xml
	rm -f *.idx *.ilg *.ind *.lol *.nav *.snm *.vrb
	rm -f chapters/*.aux
	rm -f frontmatter/*.aux
	rm -f appendices/*.aux
	@echo "Semua file output telah dihapus."

# Buka PDF dengan zathura
view: $(MAIN).pdf
	@echo "Membuka PDF dengan zathura..."
	@if command -v $(VIEWER) > /dev/null; then \
		$(VIEWER) $(MAIN).pdf & \
	else \
		echo "Error: $(VIEWER) tidak ditemukan!"; \
		echo "Install dengan: sudo apt install zathura"; \
		exit 1; \
	fi

# Cek error di log file
checkerrors:
	@echo "Memeriksa error di log file..."
	@if [ -f $(MAIN).log ]; then \
		grep -i "error\|warning" $(MAIN).log || echo "Tidak ada error atau warning yang ditemukan."; \
	else \
		echo "File log tidak ditemukan. Jalankan 'make' terlebih dahulu."; \
	fi

# Validasi referensi
checkref:
	@echo "Memeriksa referensi yang tidak terdefinisi..."
	@if [ -f $(MAIN).log ]; then \
		grep "undefined" $(MAIN).log || echo "Semua referensi sudah terdefinisi."; \
	else \
		echo "File log tidak ditemukan. Jalankan 'make' terlebih dahulu."; \
	fi

# Word count (perkiraan)
wordcount:
	@echo "Menghitung jumlah kata..."
	@if command -v texcount > /dev/null; then \
		texcount -inc -total $(MAIN).tex; \
	else \
		echo "texcount tidak ditemukan. Install dengan: sudo apt install texlive-extra-utils"; \
	fi

# Check dependencies
check-deps:
	@echo "========================================="
	@echo "Memeriksa dependensi..."
	@echo "========================================="
	@command -v pdflatex >/dev/null 2>&1 || { echo "✗ pdflatex tidak ditemukan"; exit 1; }
	@echo "✓ pdflatex ditemukan"
	@command -v biber >/dev/null 2>&1 || { echo "✗ biber tidak ditemukan"; exit 1; }
	@echo "✓ biber ditemukan"
	@command -v latexmk >/dev/null 2>&1 || { echo "✗ latexmk tidak ditemukan"; exit 1; }
	@echo "✓ latexmk ditemukan"
	@command -v zathura >/dev/null 2>&1 || { echo "⚠ zathura tidak ditemukan (opsional)"; }
	@command -v zathura >/dev/null 2>&1 && echo "✓ zathura ditemukan"
	@echo "========================================="
	@echo "Semua dependensi wajib tersedia!"
	@echo "========================================="

# Help
help:
	@echo "========================================="
	@echo "Makefile untuk Kompilasi Buku LaTeX"
	@echo "Menggunakan latexmk untuk automasi"
	@echo "========================================="
	@echo ""
	@echo "Target yang tersedia:"
	@echo "  make              - Kompilasi lengkap dengan bibliography"
	@echo "  make quick        - Kompilasi cepat (single pass)"
	@echo "  make watch        - Mode watch (kompilasi otomatis saat ada perubahan)"
	@echo "  make clean        - Hapus file temporary"
	@echo "  make cleanall     - Hapus semua file termasuk PDF"
	@echo "  make view         - Buka PDF dengan zathura"
	@echo "  make checkerrors  - Cek error di log file"
	@echo "  make checkref     - Cek referensi yang undefined"
	@echo "  make wordcount    - Hitung jumlah kata (memerlukan texcount)"
	@echo "  make check-deps   - Periksa dependensi yang diperlukan"
	@echo "  make help         - Tampilkan bantuan ini"
	@echo ""
	@echo "Contoh penggunaan:"
	@echo "  make              # Kompilasi penuh"
	@echo "  make view         # Kompilasi dan buka PDF dengan zathura"
	@echo "  make watch        # Mode watch untuk development"
	@echo "  make clean all    # Bersihkan dan kompilasi ulang"
	@echo ""
	@echo "Catatan:"
	@echo "  - latexmk otomatis menjalankan pdflatex dan biber sesuai kebutuhan"
	@echo "  - Mode watch sangat berguna saat menulis, kompilasi otomatis"
	@echo "  - PDF viewer yang digunakan: $(VIEWER)"
	@echo ""
