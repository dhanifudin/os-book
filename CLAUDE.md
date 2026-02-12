# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a LaTeX book project for "Sistem Operasi: Panduan Komprehensif untuk Pemula" - a comprehensive Indonesian-language textbook for an Operating Systems course, focused on Linux for practical. The book covers 16 weeks of structured learning, from OS fundamentals to advanced system administration.

## Build System

The project uses **latexmk** for intelligent compilation automation, managed through a Makefile.

### Essential Commands

```bash
# Full compilation with bibliography
make

# Quick single-pass compilation (during development)
make quick

# Watch mode - auto-recompile on file changes (recommended during writing)
make watch

# View PDF (opens with zathura - note: Makefile has been customized from default evince)
make view

# Clean temporary files
make clean

# Clean everything including PDF
make cleanall

# Check all dependencies are installed
make check-deps
```

### Direct latexmk Usage

```bash
# Full compilation
latexmk -pdf -bibtex main.tex

# Watch mode with continuous preview
latexmk -pdf -bibtex -pvc main.tex

# Clean
latexmk -c main.tex
```

Configuration is in `.latexmkrc` which sets pdflatex options, biber for bibliography, and PDF viewer preferences.

## Architecture

### Entry Point and Structure

- **main.tex**: Entry point that includes preamble and structures the book into 4 parts:
  - Part I: Fundamental Sistem Operasi (Weeks 1-3)
  - Part II: Manajemen File dan Proses (Weeks 5-6)
  - Part III: Bash Shell dan Scripting (Weeks 7, 9)
  - Part IV: Manajemen Sistem Lanjutan (Weeks 10-14)

- **preamble.tex**: Centralized package configuration and custom commands. This defines all styling, packages, and custom environments.

### Content Organization

Chapters are in `chapters/` directory with naming pattern `weekXX-topic.tex`. Weeks 4, 8, 15, 16 are quiz/exam weeks and have no chapters. The course outline in `outline.md` provides detailed content expectations for each week.

- `frontmatter/`: Title page, copyright, preface
- `appendices/`: Command reference, exercise solutions, glossary
- `images/`: Graphics and diagrams
- `references.bib`: BibLaTeX bibliography database

## Custom LaTeX Elements

### Colored Boxes (defined in preamble.tex)

These tcolorbox environments provide visual emphasis:

- `\begin{notebox}` - Blue boxes for important notes
- `\begin{tipbox}` - Green boxes for tips
- `\begin{warningbox}` - Red boxes for warnings
- `\begin{examplebox}[title]` - Yellow/orange boxes for examples with optional title
- `\begin{exercisebox}[number]` - Purple boxes for exercises with number

### Custom Commands for Linux Content

- `\cmd{command}` - Colored command text (uses commandcolor)
- `\file{/path/to/file}` - File path formatting
- `\dir{/path/to/dir}` - Directory path (adds trailing slash)
- `\var{VARNAME}` - Environment variable (adds $ prefix)
- `\keystroke{key}` - Keyboard key representation

### Code Listings

Bash syntax highlighting is pre-configured with the `bashstyle` listing style. Use:

```latex
\begin{lstlisting}[language=bash, caption={Description}]
# code here
\end{lstlisting}
```

### Cross-references

Use `\cref{}` from cleveref package for smart references that automatically add "Figure", "Table", "Chapter" prefixes in Indonesian.

## Content Writing Guidelines

### Chapter Template

`chapters/week01-introduction.tex` is a complete reference implementation showing:
- Proper chapter structure with abstract
- Section/subsection hierarchy
- TikZ diagrams
- Professional tables with booktabs
- Code listings with syntax highlighting
- All colored box types
- Exercise sections
- Bibliography citations

Use this as the template when writing remaining chapters.

### Labels Convention

- Chapters: `\label{ch:short-name}`
- Sections: `\label{sec:descriptive-name}`
- Figures: `\label{fig:description}`
- Tables: `\label{tab:description}`

### Bibliography

Add references to `references.bib` in BibLaTeX format. The template includes key OS/Linux textbooks and resources. Use `\cite{key}` in text.

## Dependencies

Required packages:
- TeX Live (full installation recommended)
- biber (for bibliography)
- latexmk (for build automation)
- PDF viewer (currently configured for zathura, originally evince)

Check with: `make check-deps`

## Document Class and Language

- Uses KOMA-Script `scrbook` class for A4 paper, two-sided printing
- Primary language: Indonesian (babel package)
- Configured for professional book publishing with proper margins for binding

## Common Issues

### Bibliography not appearing
Run full compilation with `make` (not `make quick`). latexmk handles the pdflatex → biber → pdflatex cycle automatically.

### Undefined references
Multiple compilation passes are needed for cross-references. latexmk automatically runs sufficient passes (max 5). For manual compilation, run pdflatex at least 3 times.

### PDF viewer not found
The Makefile has been customized to use zathura instead of the default evince. To change viewer, edit the `VIEWER` variable in Makefile or the `$pdf_previewer` in `.latexmkrc`.

## File Modification Notes

When editing chapters, the main.tex structure inputs them via `\input{chapters/filename}`. New chapters must be added to main.tex to be included in compilation.

Book metadata (title, author, publisher) is defined at the top of main.tex and in frontmatter files - these should be updated before final publication.
