# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a bilingual LaTeX book project for "Operating Systems: A Comprehensive Guide for Students" - an academic textbook for a 16-week Operating Systems course focused on Linux. The book supports both Indonesian and English with separate PDF outputs.

## Build System

The project uses **latexmk** for intelligent compilation automation, managed through a Makefile.

### Essential Commands

```bash
# Build Indonesian version (default)
make
make id

# Build English version
make en

# Build both versions
make both

# Quick single-pass compilation (development)
make quick-id
make quick-en

# Watch mode - auto-recompile on file changes (recommended during writing)
make watch-id
make watch-en

# View compiled PDF
make view-id
make view-en

# Clean temporary files
make clean

# Clean everything including PDFs
make cleanall

# Validate dependencies
make check-deps
```

### Direct latexmk Usage

```bash
# Full compilation
latexmk -pdf -bibtex main-id.tex
latexmk -pdf -bibtex main-en.tex

# Watch mode with continuous preview
latexmk -pdf -bibtex -pvc main-id.tex

# Clean
latexmk -c main-id.tex main-en.tex
```

Configuration is in `.latexmkrc` which sets pdflatex options, biber for bibliography, and PDF viewer preferences.

## Architecture

### Bilingual Structure

The project maintains complete separation between Indonesian and English content while sharing configuration and resources:

```
os-book/
├── main-id.tex              # Indonesian entry point
├── main-en.tex              # English entry point
├── preamble.tex             # Shared configuration (language-aware)
├── chapters/
│   ├── id/                  # Indonesian chapters (12 files)
│   └── en/                  # English chapters (12 files)
├── frontmatter/
│   ├── id/                  # Indonesian front matter
│   └── en/                  # English front matter
├── appendices/
│   ├── id/                  # Indonesian appendices
│   └── en/                  # English appendices
├── images/                  # Shared images
├── references.bib           # Shared bibliography
├── Makefile                 # Bilingual build targets
└── .latexmkrc              # LaTeX compilation config
```

### Language Switching Mechanism

**preamble.tex** uses conditional flags for language-specific elements:

```latex
% Set in main-id.tex or main-en.tex BEFORE loading preamble
\newif\ifIndonesian
\newif\ifEnglish
\Indonesiantrue  % or \Englishtrue

% All language-specific elements adapt:
\ifIndonesian
    \def\noteboxTitle{Catatan}
\else
    \def\noteboxTitle{Note}
\fi
```

Language-specific elements that automatically switch:
- Colored box titles (notebox, warningbox, tipbox, examplebox, exercisebox)
- Caption names (Gambar/Figure, Tabel/Table, Kode/Listing)
- Cleveref auto-prefixes (bab/chapter, bagian/section, etc.)
- Theorem environment names (Definisi/Definition, Teorema/Theorem)
- Babel captions and localization

### Entry Points

**main-id.tex** and **main-en.tex** are structurally identical except for:
1. Language flags set before preamble inclusion
2. `\selectlanguage{indonesian}` or `\selectlanguage{english}`
3. Book metadata (title, subtitle, author, publisher)
4. Part titles
5. File paths (`\input{chapters/id/...}` vs `\input{chapters/en/...}`)

### Content Organization

Chapters follow naming pattern `weekXX-topic.tex`. Weeks 4, 8, 15, 16 are quiz/exam weeks with no chapters.

**Book structure (4 parts, 12 chapters):**
- Part I: Operating Systems Fundamentals (Weeks 1-3)
- Part II: File and Process Management (Weeks 5-6)
- Part III: Bash Shell and Scripting (Weeks 7, 9)
- Part IV: Advanced System Management (Weeks 10-14)

See `outline.md` for detailed content expectations per week.

## Custom LaTeX Elements

### Colored Boxes

Defined in preamble.tex with language-aware titles:

```latex
\begin{notebox}
Important note content
\end{notebox}

\begin{tipbox}
Helpful tip
\end{tipbox}

\begin{warningbox}
Warning about dangerous operation
\end{warningbox}

\begin{examplebox}[Optional Title]
Example with code or illustration
\end{examplebox}

\begin{exercisebox}[1.1]
Exercise content
\end{exercisebox}
```

### Custom Commands for Linux Content

```latex
\cmd{ls -la}              % Colored command text
\file{/etc/passwd}        % File path
\dir{/home/user}          % Directory path (adds trailing /)
\var{PATH}                % Environment variable (adds $ prefix)
\keystroke{Ctrl+C}        % Keyboard key
```

### Code Listings

Bash syntax highlighting pre-configured with `bashstyle`:

```latex
\begin{lstlisting}[language=bash, caption={Description}]
sudo apt update
sudo apt upgrade
\end{lstlisting}
```

### Cross-references

Use `\cref{}` from cleveref for smart references that automatically add language-appropriate prefixes:

```latex
\cref{fig:kernel-architecture}  % "Gambar 1" or "Figure 1"
\cref{ch:introduction}           % "Bab 1" or "Chapter 1"
```

## Content Guidelines

### Label Naming Convention

**CRITICAL:** Use identical `\label{}` names in both id/ and en/ versions for cross-references to work:

```latex
% Both chapters/id/week01-introduction.tex and chapters/en/week01-introduction.tex
\chapter{...}
\label{ch:introduction}  % Same label in both languages

\section{...}
\label{sec:os-basics}    % Same label in both languages
```

**Convention:** Use English-based labels regardless of content language:
- Chapters: `\label{ch:short-name}`
- Sections: `\label{sec:descriptive-name}`
- Figures: `\label{fig:description}`
- Tables: `\label{tab:description}`

### Translation Requirements

When creating English versions from Indonesian content:

**Preserve exactly:**
- ALL LaTeX command structure
- Label names (`\label{}`, `\ref{}`, `\cref{}`)
- Code examples (commands are universal: `ls`, `cd`, `chmod`)
- File paths (`/etc/passwd`, `/home/user/`)
- Technical command syntax

**Translate:**
- Chapter/section titles
- Body text and explanations
- Abstract content
- Exercise questions
- Code comments within listings
- Table content and captions

**Keep as technical terms:**
- Standard English technical terms (kernel, driver, CPU, RAM)
- Linux-specific terms (filesystem, systemd, bash)
- Acronyms (OS, I/O, GUI, CLI)

### Chapter Template

`chapters/id/week01-introduction.tex` is the complete reference implementation showing:
- Proper chapter structure with abstract
- Section/subsection hierarchy
- TikZ diagrams with parametrized text
- Professional tables with booktabs
- Code listings with syntax highlighting
- All colored box types
- Exercise sections
- Bibliography citations

Use this as the template for remaining chapters.

## Dependencies

Required packages:
- TeX Live (full installation recommended)
- biber (for bibliography)
- latexmk (for build automation)
- PDF viewer (currently zathura, configurable in Makefile)

Check with: `make check-deps`

## Document Class and Language

- Uses KOMA-Script `scrbook` class for A4 paper, two-sided printing
- Babel package loaded with `[indonesian,english]`
- Active language selected via `\selectlanguage{}` in main files
- Bibliography uses biblatex with IEEE style, biber backend

## Common Issues

### Bibliography not appearing
Run full compilation with `make id` or `make en` (not `make quick-*`). latexmk handles the pdflatex → biber → pdflatex cycle automatically.

### Undefined references
Multiple compilation passes needed. latexmk automatically runs sufficient passes (max 5). Use `make cleanall && make both` if references remain undefined.

### PDF viewer not found
Makefile uses zathura. Change the `VIEWER` variable in Makefile or `$pdf_previewer` in `.latexmkrc` to use a different viewer (e.g., evince, okular).

### Language-specific issues
If colored boxes show wrong language, verify:
1. Language flags set in main-*.tex before `\input{preamble}`
2. Correct `\selectlanguage{}` after preamble
3. Clean build: `make cleanall && make id` (or `make en`)

## File Modification Notes

When adding new chapters:
1. Create content in BOTH `chapters/id/` and `chapters/en/`
2. Use IDENTICAL `\label{}` names in both versions
3. Add `\input{chapters/id/filename}` to main-id.tex
4. Add `\input{chapters/en/filename}` to main-en.tex with translated title
5. Ensure Part titles match in structure (though translated in text)
6. Run `make both` to verify both compile

When modifying preamble.tex:
- All language-dependent elements use `\ifIndonesian ... \else ... \fi` conditionals
- Test both languages after changes: `make both`
- Shared elements (packages, geometry, colors) are language-neutral

Book metadata (title, author, publisher) defined at top of main-id.tex and main-en.tex separately.

## Bibliography

Shared `references.bib` file contains all sources. BibLaTeX/biber handles language-specific formatting automatically. Use `\cite{key}` in text.

To add references:
```bibtex
@book{key,
  title={Book Title},
  author={Author Name},
  year={2024},
  publisher={Publisher Name},
  isbn={978-xxx}
}
```

## Git Workflow

Currently on branch `feature/bilingual-support`. The bilingual infrastructure is complete:
- ✅ Directory structure reorganized
- ✅ Preamble parametrized for bilingual support
- ✅ Main entry points created (main-id.tex, main-en.tex)
- ✅ Makefile updated with bilingual targets
- ✅ Indonesian content in id/ directories
- ✅ English frontmatter created
- 🔄 English chapter translations in progress

When content translation is complete, merge to main branch.
