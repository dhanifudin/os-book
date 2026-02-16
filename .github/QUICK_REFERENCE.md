# GitHub Actions Quick Reference

## 🚀 For Contributors

### Push your changes
```bash
git add .
git commit -m "Your commit message"
git push
```
→ **Result**: PDFs automatically built and available as artifacts

### Download PDFs
1. Go to **Actions** tab
2. Click on latest workflow run
3. Scroll to **Artifacts**
4. Download `os-book-both-versions`

---

## 📦 For Maintainers

### Create a Release

```bash
# 1. Prepare release
git add .
git commit -m "Release v1.0.0"
git push

# 2. Tag and push
git tag v1.0.0
git push origin v1.0.0
```
→ **Result**: Release created at `/releases` with PDFs attached

### Tag Naming Convention
- `v1.0.0` - Major release
- `v1.1.0` - Minor update
- `v1.1.1` - Patch/bugfix

---

## 📋 Build Commands (Local)

```bash
# Indonesian only
make id

# English only
make en

# Both versions
make both

# Clean and rebuild
make cleanall && make both
```

---

## 🔍 Troubleshooting

### Build fails in Actions?
- Check **Actions** tab → Click failed run → View logs
- Test locally: `make both`
- Ensure all files exist in repository

### No artifacts appearing?
- Artifacts only appear if build succeeds
- Check workflow logs for errors

### Release not creating?
- Ensure tag format is `vX.Y.Z`
- Check **Settings** → **Actions** → **General** → Workflow permissions
- Should be "Read and write permissions"

---

## 📊 Artifact Retention

| Type | Retention |
|------|-----------|
| Build artifacts | 90 days |
| Release PDFs | Permanent |

---

## 🔗 Quick Links

- **Actions**: `https://github.com/YOUR_USERNAME/os-book/actions`
- **Releases**: `https://github.com/YOUR_USERNAME/os-book/releases`
- **Workflow files**: `.github/workflows/`

---

## 📚 Documentation

- Full workflow docs: `.github/workflows/README.md`
- Setup summary: `GITHUB_ACTIONS_SETUP.md`
- Main README: `README.md`
