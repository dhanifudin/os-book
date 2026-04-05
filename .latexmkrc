# ========================================================================
# latexmk Configuration File
# ========================================================================

# Use pdflatex by default
$pdf_mode = 1;

# Use biber for bibliography
$bibtex_use = 2;

# PDF viewer configuration (used only when -pvc flag is passed explicitly)
$pdf_previewer = 'zathura %O %S';

# Do not auto-open viewer after build; use 'make view-id' / 'make view-en' instead
$preview_mode = 0;

# Extra pdflatex options
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error %O %S';

# Enable shell escape if needed (for minted, etc)
# Uncomment jika menggunakan package yang memerlukan shell escape
# $pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode -file-line-error %O %S';

# Clean extra extensions
$clean_ext = 'aux bbl bcf blg fdb_latexmk fls lof log lot out run.xml synctex.gz toc idx ilg ind lol nav snm vrb';

# Force biber to run
$biber = 'biber %O %S';

# Maximum number of runs
$max_repeat = 5;

# Force mode - continue even if there are errors (important for CI/CD)
# This ensures we get a PDF even with warnings/undefined references on first pass
$force_mode = 1;

# Remove output directory on clean
$out_dir = '';

# Generate PDF using pdflatex
$postscript_mode = 0;
$dvi_mode = 0;

# Warnings
$warnings_as_errors = 0;

# Files to watch for changes (in addition to .tex files)
# Updated for bilingual support
@default_files = ('main-id.tex', 'main-en.tex');

# Extra file extensions to clean
push @generated_exts, 'synctex.gz', 'run.xml', 'bcf', 'nav', 'snm', 'vrb', 'lol';
