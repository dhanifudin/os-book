# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a bilingual LaTeX textbook project for teaching Operating Systems with a focus on Linux. The book is structured as a 16-week course (outline.md) and supports both Indonesian and English versions from a single codebase.

## Bilingual Architecture

**Critical**: This repository uses a dual-language structure with separate main files:
- `main-id.tex` - Indonesian version entry point
- `main-en.tex` - English version entry point
- Both share the same `preamble.tex` which uses language flags (`\ifIndonesian` and `\ifEnglish`) to control language-specific elements

**Language-specific content structure**:
```
chapters/
  ├── id/          # Indonesian chapters
  │   ├── week01-introduction.tex
  │   ├── week02-hardware-and-basic-commands.tex
  │   └── ...
  └── en/          # English chapters (parallel structure)
      ├── week01-introduction.tex
      ├── week02-hardware-and-basic-commands.tex
      └── ...

frontmatter/
  ├── id/          # Indonesian front matter
  │   ├── titlepage.tex
  │   ├── copyright.tex
  │   └── preface.tex
  └── en/          # English front matter
      └── ...

appendices/
  ├── id/          # Indonesian appendices
  │   ├── command-reference.tex
  │   ├── exercise-solutions.tex
  │   └── glossary.tex
  └── en/          # English appendices (currently empty)
      └── ...
```

**When creating/editing content**:
1. Language flags MUST be set in main-*.tex BEFORE loading preamble
2. Each language has parallel directory structure (id/ and en/)
3. Main files use `\input{chapters/[lang]/filename}` to load language-specific content
4. The preamble uses conditional blocks (`\ifIndonesian ... \else ... \fi`) for language-specific configuration

## Build System

### Primary Commands

**Build Indonesian version** (default):
```bash
make              # or `make id`
make quick-id     # Single-pass compilation (faster, no bibliography updates)
make watch-id     # Continuous compilation on file changes
```

**Build English version**:
```bash
make en
make quick-en     # Single-pass compilation
make watch-en     # Continuous compilation
```

**Build both versions**:
```bash
make both
```

**Other useful commands**:
```bash
make clean        # Remove temporary files only
make cleanall     # Remove all output including PDFs
make view-id      # Compile and open Indonesian PDF in zathura
make view-en      # Compile and open English PDF in zathura
make checkerrors  # Check log files for errors/warnings
make checkref     # Find undefined references
make wordcount    # Count words in both versions (requires texcount)
make check-deps   # Verify all required dependencies are installed
make help         # Show all available targets
```

### Manual Compilation

If needed, you can compile manually with latexmk:
```bash
# Full compilation
latexmk -pdf -bibtex main-id.tex
latexmk -pdf -bibtex main-en.tex

# Watch mode
latexmk -pdf -bibtex -pvc main-id.tex

# Clean
latexmk -c main-id.tex
latexmk -C main-id.tex  # Also removes PDF
```

## LaTeX Structure

### Document Class & Configuration

- Uses **KOMA-Script** `scrbook` class for better typography and flexibility
- A4 paper, 12pt font, two-sided printing layout
- Configuration in `preamble.tex` (shared by both languages)
- Language-specific captions/terms controlled by flags

### Custom Commands & Environments

**Linux-specific commands** (defined in preamble.tex):
```latex
\cmd{command}                  % Format shell commands
\file{/path/to/file}          % Format file paths
\dir{/path/to/directory}      % Format directory paths
\var{VARIABLE_NAME}           % Format environment variables
\keystroke{Ctrl+C}            % Format keyboard shortcuts
```

**Colored boxes** for special content:
```latex
\begin{notebox}
  Important notes and reminders
\end{notebox}

\begin{tipbox}
  Helpful tips and best practices
\end{tipbox}

\begin{warningbox}
  Warnings about dangerous operations
\end{warningbox}

\begin{examplebox}[Optional Title]
  Examples and demonstrations
\end{examplebox}

\begin{exercisebox}[Exercise Number]
  Practice exercises
\end{exercisebox}
```

**Code listings** - Multiple options available:

**Option 1: Standard lstlisting (DEFAULT - RECOMMENDED)**
```latex
\begin{lstlisting}[language=bash, caption={Description}]
sudo apt update
sudo apt install package
\end{lstlisting}
```
- **No line numbers** (cleaner appearance)
- **Automatically prevents page breaks** using `samepage` environment
- **Better readability** with Inconsolata font (scaled 1.05x)
- Ensures minimum 10 lines space before listing starts
- If not enough space, entire listing moves to next page
- Use this for ALL standard code examples (short to medium length)

**Option 2: longlisting environment (for very long code)**
```latex
\begin{longlisting}[language=bash, caption={Description}]
#!/bin/bash
# Very long script (50+ lines)
# ... many lines ...
# CAN break across pages if needed
\end{longlisting}
```
- Allows page breaks for code longer than one page
- Use ONLY when code is legitimately too long to fit on single page
- Same syntax highlighting as standard lstlisting
- Use sparingly (most code examples should fit on one page)

**Option 3: codebox environment (alternative with colored box)**
```latex
\begin{codebox}[additional options]{Caption Title}
sudo apt update
sudo apt install package
\end{codebox}
```
- Uses tcolorbox with colored frame
- Also unbreakable (same as standard lstlisting)
- Nice visual separation with colored borders
- Optional: use when you want visual emphasis

**Option 4: longcodebox environment (long code with colored box)**
```latex
\begin{longcodebox}[additional options]{Caption Title}
#!/bin/bash
# Very long script in colored box
\end{longcodebox}
```
- Long code version of codebox
- Allows page breaks
- Use rarely

**Recommendation**:
- **95% of cases**: Use standard `lstlisting` (unbreakable, no line numbers)
- **Long scripts only**: Use `longlisting` when code is 50+ lines
- **Visual emphasis**: Use `codebox` for important code snippets you want to highlight

### Chapter Structure

Each chapter follows this pattern (see chapters/id/week01-introduction.tex for complete example):
```latex
\chapter{Chapter Title}
\label{ch:chapter-id}

\begin{abstract}
Chapter summary...
\end{abstract}

\section{Section Title}
\label{sec:section-id}

Content...

\subsection{Subsection Title}
More content...
```

### Mandatory: Learning Objectives Block

**Every chapter MUST include a learning objectives block** immediately after the opening paragraph(s) and before the first `\section`. Use the heading `\textbf{Yang Akan Kamu Pelajari}` (NOT "Tujuan Praktikum" — that reads as academic/module language; this book targets commercial readers).

```latex
\textbf{Yang Akan Kamu Pelajari}

Setelah menyelesaikan bab ini, kamu akan mampu:

\begin{enumerate}
    \item objective one;
    \item objective two;
    \item objective three.
\end{enumerate}
```

- Use informal second person (`kamu`, not `mahasiswa` or `pembaca`)
- List 4–6 concrete, verb-led outcomes (mampu, memahami, membuat, menganalisis…)
- For English chapters, use `\textbf{What You'll Learn}` with `By the end of this chapter, you will be able to:`

### Standard Lab Chapter Structure (≤ 20 pages)

Lab chapters (all except theory-heavy chapters like week01) follow this pattern:

```
Chapter opening paragraph(s)               (~0.3 p)
Yang Akan Kamu Pelajari block              (~0.3 p)
[Optional: working directory notebox]      (~0.2 p)

Repeat 3–5 times:
  \section{Topic}
  Concept paragraph(s) + analogy           (~0.5–1 p)
    → Introduce commands inline, no separate list
  \subsection*{Praktikum N.N / Lab N.N}
    Objective line + numbered steps
    → Embed 1–2 "Amati:" / "Observe:" bullets  (~1–1.5 p)
    inside the steps instead of a formal Analisis block
  \begin{challengebox}
    Harder variation OR mini open-ended task  (~0.5 p)
    May combine techniques from a prior chapter
  \end{challengebox}

\section{Tugas / Assignment}               (~2–3 p)
\section{Referensi / References}           (~0.3 p)
```

**Rules:**
- **Drop** `\textbf{Perintah yang Digunakan}` as a standalone list — weave command names and flags into the concept prose instead.
- **Drop** formal `\textbf{Analisis:}` numbered blocks — replace with 1–2 inline `\textit{Amati:}` (ID) / `\textit{Observe:}` (EN) bullets embedded in the relevant step.
- **Absorb** `Studi Kasus` scenarios into a `challengebox` where they fit naturally; keep as a subsection only if the scenario genuinely needs more than half a page.
- Each `challengebox` should build on ≥ 1 prior chapter skill when natural (not forced). Week10 challenges reference Bash from Chapter 9.
- Theory-only chapters (week01 pattern) are exempt from challengebox requirement.

### Mandatory: Rangkuman Section

**Every chapter MUST include a `\section{Rangkuman}` block** placed after all content sections and before `\section{Tugas Praktikum}`.

```latex
\section{Rangkuman}

Dalam bab ini, kamu telah mempelajari:

\begin{itemize}
    \item \textbf{Topik 1}: ringkasan poin kunci dalam satu kalimat.
    \item \textbf{Topik 2}: ringkasan poin kunci dalam satu kalimat.
    \item \textbf{Topik 3}: ringkasan poin kunci dalam satu kalimat.
\end{itemize}
```

- Use `\textbf{topic label}:` pattern — bold topic, then one-sentence recap
- Mirror the learning objectives from "Yang Akan Kamu Pelajari" — each objective should map to at least one bullet
- Keep it tight: 5–8 bullets, no new information introduced, consolidation only
- For English chapters, use `\section{Summary}` with `In this chapter, you learned:`

**Available box environments** (defined in `preamble.tex`):
```latex
\begin{notebox}     % blue  — notes and reminders
\begin{tipbox}      % green — tips and best practices
\begin{warningbox}  % red   — dangerous operations
\begin{examplebox}[Title]   % orange — examples
\begin{exercisebox}[N]      % purple — end-of-chapter exercises
\begin{challengebox}        % teal   — per-section challenge
```

### Cross-References & Citations

```latex
\cref{fig:label}              % Smart cross-reference (auto-detects type)
\cite{citation-key}           % Bibliography citation
\url{https://example.com}     % URL formatting
```

## Writing Style Guidelines

These rules apply to all prose in every chapter. They ensure the text reads naturally, is accessible to beginners, and maintains consistent quality.

### Punctuation: No Em-Dash

**Never use `---` (em-dash) anywhere in chapter prose.** Em-dashes produce an abrupt, informal break that is difficult for beginner readers to parse. Use these alternatives instead:

- **Colon** when the second clause explains the first: `RAM menyimpan data yang sedang aktif digunakan: semakin besar kapasitasnya, semakin banyak program yang dapat berjalan sekaligus.`
- **Comma** for a soft pause between related ideas.
- **Separate sentence** when the inserted thought is long enough to stand on its own.
- **Parentheses** for a short clarification: `perintah \cmd{free} (dijalankan tanpa argumen) menampilkan ringkasan penggunaan memori.`

This rule applies to both Indonesian and English chapters.

### Audience: Formal Language for Beginners

Write for a reader who has no prior experience with operating systems or the Linux command line. Every technical term must be introduced with a brief, plain-language definition before it is used in a technical context. After the first introduction, the term may be used freely.

**Tone**: Formal and instructional. Avoid colloquial filler words (`sebenarnya`, `tentunya`, `basically`, `of course`). Avoid rhetorical questions used as filler. Use direct, declarative sentences.

**Structure per concept**:
1. State what the concept is in one plain sentence.
2. Give a concrete analogy drawn from everyday experience.
3. Show the command or mechanism.
4. State the expected result or what the reader should observe.

Do not assume the reader knows related concepts unless those concepts were covered in a previous chapter. When referencing a prior chapter, name it explicitly: `seperti yang telah dipelajari pada Bab~9`.

### Natural Prose: Avoid AI-Detectable Patterns

Write prose that reflects how a knowledgeable instructor explains material in a structured textbook, not how a language model generates text. Specific rules:

- **Vary sentence length.** Mix short sentences (4 to 8 words) with longer ones (15 to 25 words). Do not write paragraph after paragraph of sentences with the same length.
- **Vary paragraph length.** Some paragraphs are two sentences; some are five. Avoid uniform blocks.
- **Use specific, concrete numbers and names.** Instead of "a large amount of memory," write "512 MB dari total 4 GB RAM." Instead of "some processes," write "proses \texttt{firefox} dan \texttt{code}."
- **Avoid formulaic transition phrases.** Do not open every paragraph with `Selain itu,`, `Lebih lanjut,`, `Pertama,`, `Kemudian,`, or their English equivalents used mechanically. Use transitions only when they genuinely reflect the logical relationship between paragraphs.
- **Avoid redundant summaries.** Do not end a concept paragraph by restating what was just said. Move directly to the next idea or to the practice steps.
- **Prefer active voice.** Write `Linux memetakan alamat virtual ke alamat fisik` rather than `alamat virtual dipetakan oleh Linux ke alamat fisik.`
- **Ground analogies in the local context.** Use everyday analogies that are culturally familiar to Indonesian readers: a physical desk, a file cabinet, a toll gate, a library card catalog.

## Content Organization

### Book Structure (4 Parts)

1. **Part I: Fundamental Sistem Operasi** - Weeks 1-3
   - Introduction, hardware management, basic I/O

2. **Part II: Manajemen File dan Proses** - Weeks 5-6
   - Directory structure, process management

3. **Part III: Bash Shell dan Scripting** - Weeks 7-9
   - Bash shell, bash programming

4. **Part IV: Manajemen Sistem Lanjutan** - Weeks 10-14
   - Memory, files/users, services, applications, backup/recovery

Note: Weeks 4, 8, 15, 16 are for quizzes/exams (see outline.md)

### Current Development Status

**Indonesian version** (id/):
- Week 1-2: Substantially complete with detailed content
- Week 3-14: Basic chapter structure created (minimal content)
- Frontmatter: Complete (titlepage, copyright, preface)
- Appendices: Structure present (command-reference, exercise-solutions, glossary)

**English version** (en/):
- Frontmatter files exist but chapters/en/ directory is empty
- Appendices/en/ directory is empty
- Translation work is needed

## Dependencies

Required software:
- `pdflatex` - LaTeX compiler
- `biber` - Bibliography processor (NOT bibtex)
- `latexmk` - Build automation
- `zathura` (optional) - PDF viewer

Optional:
- `texcount` - Word counting utility

Install on Ubuntu/Debian:
```bash
sudo apt install texlive-full biber latexmk zathura
```

Verify installation:
```bash
make check-deps
```

## Common Workflows

### Adding a New Chapter

1. Create file in appropriate language directory:
   - `chapters/id/weekXX-topic-name.tex`
   - `chapters/en/weekXX-topic-name.tex`

2. Add `\input` statement to corresponding main file:
   - `main-id.tex`: `\input{chapters/id/weekXX-topic-name}`
   - `main-en.tex`: `\input{chapters/en/weekXX-topic-name}`

3. Follow chapter structure template from week01-introduction.tex

### Adding Images

1. Place image files in `images/` directory
2. Reference in LaTeX:
```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.8\textwidth]{image-filename.png}
    \caption{Caption text}
    \label{fig:image-label}
\end{figure}
```

### Adding Bibliography Entries

Edit `references.bib` (shared by both languages):
```bibtex
@book{key,
  title={Book Title},
  author={Author Name},
  year={2024},
  publisher={Publisher},
  isbn={978-xxx}
}
```

## File Patterns to Watch

**Always rebuild** after changes to:
- `preamble.tex` - Affects all documents
- `references.bib` - Bibliography entries
- `main-id.tex` or `main-en.tex` - Document structure
- Any chapter file - Content changes

**Temporary/build files** (safe to clean):
- `*.aux`, `*.log`, `*.out`, `*.toc`, `*.lof`, `*.lot`
- `*.bbl`, `*.blg`, `*.bcf`, `*.run.xml`
- `*.fdb_latexmk`, `*.fls`
- `*-SAVE-ERROR` files

## Troubleshooting

**Undefined references/citations**: Run full build (`make id` or `make en`), not quick build

**Bibliography not updating**: Ensure biber is installed and run `make cleanall && make`

**Compilation errors**: Check `make checkerrors` output or view `.log` files

**Language-specific issues**: Verify language flags are set correctly in main-*.tex before `\input{preamble}`
