# ========================================================================
# Makefile untuk Kompilasi Buku LaTeX - Bilingual Support
# Menggunakan latexmk untuk automasi kompilasi
# ========================================================================

# File utama untuk setiap bahasa
MAIN_ID = main-id
MAIN_EN = main-en

# PDF Viewer
VIEWER = zathura

# latexmk configuration
LATEXMK = latexmk
LATEXMK_FLAGS = -pdf -bibtex -interaction=nonstopmode -file-line-error

# Chapters list
CHAPTERS = week01-introduction \
           week02-hardware-and-basic-commands \
           week03-basic-io \
           week05-directory-structure \
           week06-process-management \
           week07-bash-shell \
           week09-bash-programming \
           week10-memory-and-syscalls \
           week11-file-and-user-management \
           week12-service-management \
           week13-application-management \
           week14-backup-and-recovery

# ========================================================================
# Target Utama
# ========================================================================

.PHONY: all id en both clean cleanall view view-id view-en watch watch-id watch-en \
        quick quick-id quick-en checkerrors checkref wordcount help check-deps \
        chapters chapters-id chapters-en

# Default target - build Indonesian version (backward compatibility)
all: id

# Build Indonesian version
id: $(MAIN_ID).pdf

# Build English version
en: $(MAIN_EN).pdf

# Build both versions
both: id en

# Kompilasi Indonesian PDF
$(MAIN_ID).pdf: $(MAIN_ID).tex preamble.tex references.bib
	@echo "========================================="
	@echo "Kompilasi versi Indonesia dengan latexmk"
	@echo "========================================="
	$(LATEXMK) $(LATEXMK_FLAGS) $(MAIN_ID).tex
	@echo "========================================="
	@echo "Kompilasi selesai! File: $(MAIN_ID).pdf"
	@echo "========================================="

# Kompilasi English PDF
$(MAIN_EN).pdf: $(MAIN_EN).tex preamble.tex references.bib
	@echo "========================================="
	@echo "Compiling English version with latexmk"
	@echo "========================================="
	$(LATEXMK) $(LATEXMK_FLAGS) $(MAIN_EN).tex
	@echo "========================================="
	@echo "Compilation complete! File: $(MAIN_EN).pdf"
	@echo "========================================="

# Build all chapters individually for both languages
chapters: chapters-id chapters-en

# Build all Indonesian chapters individually
chapters-id:
	@echo "Building all Indonesian chapters..."
	@for chapter in $(CHAPTERS); do \
		echo "Building ID chapter: $$chapter"; \
		./scripts/build-chapter.sh id $$chapter; \
	done
	@echo "All Indonesian chapters built in output/chapters/"

# Build all English chapters individually
chapters-en:
	@echo "Building all English chapters..."
	@for chapter in $(CHAPTERS); do \
		echo "Building EN chapter: $$chapter"; \
		./scripts/build-chapter.sh en $$chapter; \
	done
	@echo "All English chapters built in output/chapters/"

# Build a single chapter: make chapter LANG=en CHAPTER=week01-introduction
chapter:
	@if [ -z "$(LANG)" ] || [ -z "$(CHAPTER)" ]; then \
		echo "Usage: make chapter LANG=<id|en> CHAPTER=<chapter-name>"; \
		exit 1; \
	fi
	./scripts/build-chapter.sh $(LANG) $(CHAPTER)

# Kompilasi cepat (single pass)
quick: quick-id

quick-id:
	@echo "Kompilasi cepat versi Indonesia..."
	$(LATEXMK) -pdf -interaction=nonstopmode $(MAIN_ID).tex

quick-en:
	@echo "Quick compile English version..."
	$(LATEXMK) -pdf -interaction=nonstopmode $(MAIN_EN).tex

# Watch mode - kompilasi otomatis saat file berubah
watch: watch-id

watch-id:
	@echo "========================================="
	@echo "Mode Watch Indonesia - Kompilasi otomatis aktif"
	@echo "Tekan Ctrl+C untuk berhenti"
	@echo "========================================="
	$(LATEXMK) -pdf -bibtex -pvc -interaction=nonstopmode $(MAIN_ID).tex

watch-en:
	@echo "========================================="
	@echo "Watch Mode English - Auto-compilation active"
	@echo "Press Ctrl+C to stop"
	@echo "========================================="
	$(LATEXMK) -pdf -bibtex -pvc -interaction=nonstopmode $(MAIN_EN).tex

# Bersihkan file temporary
clean:
	@echo "Membersihkan file temporary..."
	$(LATEXMK) -c $(MAIN_ID).tex $(MAIN_EN).tex
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg *.bcf *.run.xml
	rm -f *.idx *.ilg *.ind *.lol *.nav *.snm *.vrb
	rm -f chapters/id/*.aux chapters/en/*.aux
	rm -f frontmatter/id/*.aux frontmatter/en/*.aux
	rm -f appendices/id/*.aux appendices/en/*.aux
	@echo "File temporary telah dibersihkan."

# Bersihkan semua file termasuk PDF
cleanall:
	@echo "Menghapus semua file output..."
	$(LATEXMK) -C $(MAIN_ID).tex $(MAIN_EN).tex
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg *.bcf *.run.xml
	rm -f *.idx *.ilg *.ind *.lol *.nav *.snm *.vrb
	rm -f chapters/id/*.aux chapters/en/*.aux
	rm -f frontmatter/id/*.aux frontmatter/en/*.aux
	rm -f appendices/id/*.aux appendices/en/*.aux
	rm -rf output/
	@echo "Semua file output telah dihapus."

# Buka PDF dengan viewer
view: view-id

view-id: $(MAIN_ID).pdf
	@echo "Membuka PDF Indonesia dengan $(VIEWER)..."
	@if command -v $(VIEWER) > /dev/null; then \
		$(VIEWER) $(MAIN_ID).pdf & \
	else \
		echo "Error: $(VIEWER) tidak ditemukan!"; \
		echo "Install dengan: sudo apt install zathura"; \
		exit 1; \
	fi

view-en: $(MAIN_EN).pdf
	@echo "Opening English PDF with $(VIEWER)..."
	@if command -v $(VIEWER) > /dev/null; then \
		$(VIEWER) $(MAIN_EN).pdf & \
	else \
		echo "Error: $(VIEWER) not found!"; \
		echo "Install with: sudo apt install zathura"; \
		exit 1; \
	fi

# Cek error di log files
checkerrors:
	@echo "Memeriksa error di log files..."
	@for logfile in $(MAIN_ID).log $(MAIN_EN).log; do \
		if [ -f $$logfile ]; then \
			echo "=== $$logfile ==="; \
			grep -i "error\|warning" $$logfile || echo "Tidak ada error atau warning."; \
		fi; \
	done

# Validasi referensi
checkref:
	@echo "Memeriksa referensi yang tidak terdefinisi..."
	@for logfile in $(MAIN_ID).log $(MAIN_EN).log; do \
		if [ -f $$logfile ]; then \
			echo "=== $$logfile ==="; \
			grep "undefined" $$logfile || echo "Semua referensi terdefinisi."; \
		fi; \
	done

# Word count
wordcount:
	@echo "Menghitung jumlah kata..."
	@if command -v texcount > /dev/null; then \
		echo "=== Indonesian Version ==="; \
		texcount -inc -total $(MAIN_ID).tex; \
		echo ""; \
		echo "=== English Version ==="; \
		texcount -inc -total $(MAIN_EN).tex; \
	else \
		echo "texcount tidak ditemukan. Install: sudo apt install texlive-extra-utils"; \
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
	@command -v $(VIEWER) >/dev/null 2>&1 || { echo "⚠ $(VIEWER) tidak ditemukan (opsional)"; }
	@command -v $(VIEWER) >/dev/null 2>&1 && echo "✓ $(VIEWER) ditemukan"
	@echo "========================================="
	@echo "Semua dependensi wajib tersedia!"
	@echo "========================================="

# Help
help:
	@echo "========================================="
	@echo "Makefile untuk Kompilasi Buku LaTeX (Bilingual)"
	@echo "========================================="
	@echo ""
	@echo "Target yang tersedia:"
	@echo "  make (atau make all)  - Kompilasi versi Indonesia (default)"
	@echo "  make id               - Kompilasi versi Indonesia"
	@echo "  make en               - Kompilasi versi English"
	@echo "  make both             - Kompilasi kedua versi"
	@echo "  make quick-id         - Kompilasi cepat Indonesia"
	@echo "  make quick-en         - Kompilasi cepat English"
	@echo "  make watch-id         - Watch mode Indonesia"
	@echo "  make watch-en         - Watch mode English"
	@echo "  make clean            - Hapus file temporary"
	@echo "  make cleanall         - Hapus semua file termasuk PDF"
	@echo "  make view-id          - Buka PDF Indonesia"
	@echo "  make view-en          - Buka PDF English"
	@echo "  make checkerrors      - Cek error di log files"
	@echo "  make checkref         - Cek referensi undefined"
	@echo "  make wordcount        - Hitung jumlah kata kedua versi"
	@echo "  make check-deps       - Periksa dependensi"
	@echo "  make chapters         - Build semua chapter (ID & EN) secara terpisah"
	@echo "  make chapters-id      - Build semua chapter Indonesia secara terpisah"
	@echo "  make chapters-en      - Build semua chapter English secara terpisah"
	@echo "  make chapter LANG=<id|en> CHAPTER=<name> - Build satu chapter"
	@echo "  make help             - Tampilkan bantuan ini"
	@echo ""
	@echo "Contoh penggunaan:"
	@echo "  make both             # Kompilasi Indonesia & English"
	@echo "  make view-en          # Kompilasi dan buka PDF English"
	@echo "  make watch-id         # Watch mode untuk development Indonesia"
	@echo ""
	@echo "Output files:"
	@echo "  $(MAIN_ID).pdf        - Versi Indonesia"
	@echo "  $(MAIN_EN).pdf        - Versi English"
	@echo ""
