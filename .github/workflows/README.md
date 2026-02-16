# GitHub Actions Workflows

This directory contains GitHub Actions workflows for automatically building the LaTeX PDFs.

## Workflows

### 1. Build PDFs (`build-pdf.yml`)

**Triggers:**
- Push to `main` branch
- Push to any `feature/*` branch
- Pull requests to `main`
- Manual trigger via GitHub UI (workflow_dispatch)

**What it does:**
- Installs all necessary LaTeX dependencies
- Builds Indonesian PDF (`main-id.pdf`)
- Builds English PDF (`main-en.pdf`)
- Uploads both PDFs as artifacts (available for 90 days)

**Artifacts:**
- `os-book-indonesian` - Indonesian PDF only
- `os-book-english` - English PDF only
- `os-book-both-versions` - Both PDFs together

**How to download artifacts:**
1. Go to the Actions tab in GitHub
2. Click on the workflow run
3. Scroll down to "Artifacts" section
4. Download the desired artifact

### 2. Create Release (`release.yml`)

**Triggers:**
- Push of version tags (e.g., `v1.0.0`, `v2.1.3`)

**What it does:**
- Builds both Indonesian and English PDFs
- Renames PDFs with version number
- Creates a GitHub Release with both PDFs attached
- Includes release notes with build information

**How to create a release:**

```bash
# 1. Commit your changes
git add .
git commit -m "Release version 1.0.0"

# 2. Create and push a tag
git tag v1.0.0
git push origin v1.0.0

# 3. GitHub Actions will automatically:
#    - Build both PDFs
#    - Create a release at https://github.com/YOUR_USERNAME/os-book/releases
#    - Attach PDFs to the release
```

**Release naming convention:**
- Tags should follow semantic versioning: `vMAJOR.MINOR.PATCH`
- Example: `v1.0.0`, `v1.1.0`, `v2.0.0`

## LaTeX Dependencies Installed

The workflows install these packages:
- `texlive-latex-base` - Basic LaTeX
- `texlive-latex-extra` - Extra LaTeX packages
- `texlive-fonts-recommended` - Recommended fonts
- `texlive-fonts-extra` - Extra fonts
- `texlive-lang-other` - Language support (Indonesian, etc.)
- `texlive-bibtex-extra` - Bibliography support
- `biber` - Bibliography processor
- `latexmk` - Build automation
- `texlive-xetex` - XeTeX support
- `texlive-science` - Scientific packages

## Troubleshooting

### Build fails with missing package error

If a LaTeX package is missing, add it to the `apt-get install` command in the workflow file.

### PDFs not generated

Check the workflow logs in the GitHub Actions tab for specific LaTeX compilation errors.

### Artifacts not appearing

Artifacts only appear if the build succeeds. Check the workflow logs for errors.

## Local Testing

To test the build locally before pushing:

```bash
# Test Indonesian build
make clean
make id

# Test English build
make clean
make en

# Test both
make cleanall
make both
```
