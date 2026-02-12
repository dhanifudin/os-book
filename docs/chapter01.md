# Rencana Konten: Bab 1 - Pengenalan Sistem Operasi & Instalasi

> **Scope:** 6 sessions × 50 minutes = 300 minutes (5 hours instruction)
> **Target:** 25-30 pages
> **Approach:** General OS concepts dengan Linux untuk praktik

## Tujuan Pembelajaran

Setelah mempelajari bab ini, pembaca diharapkan mampu:
1. Menjelaskan konsep dasar dan fungsi sistem operasi
2. Memahami arsitektur kernel dan perbedaan desain (monolithic, microkernel, hybrid)
3. Membandingkan sistem operasi populer (Windows, macOS, Linux)
4. Melakukan instalasi Linux dengan berbagai metode
5. Mengkonfigurasi sistem operasi pasca instalasi

---

## Struktur Bab (Compact)

### Session 1-2: Konsep Dasar & Arsitektur OS (4-5 halaman)

#### 1.1 Definisi dan Fungsi Sistem Operasi
- Definisi: Resource manager dan extended machine
- Lima fungsi utama (ringkas):
  - **Process Management** - scheduling, multitasking
  - **Memory Management** - allocation, virtual memory
  - **File Management** - organization, permissions
  - **I/O Management** - device drivers, abstraction
  - **Security** - authentication, access control

#### 1.2 Jenis dan Kategori OS
**Berdasarkan arsitektur:**
- Desktop OS (Windows, macOS, Linux)
- Server OS (Windows Server, Linux)
- Mobile OS (Android, iOS)
- Real-time OS (embedded systems)

**Tabel komparasi singkat:**
| OS | Kernel Type | Primary Use | Market Share |
|----|-------------|-------------|--------------|
| Windows | Hybrid | Desktop/Business | Desktop: 75% |
| macOS | Hybrid (XNU) | Creative/Development | Desktop: 15% |
| Linux | Monolithic | Server/Development | Server: 60% |
| Android | Linux-based | Mobile | Mobile: 70% |

#### 1.3 Arsitektur Kernel (Fokus)

**A. Monolithic Kernel:**
- Semua services di kernel space
- Contoh: Linux, traditional Unix
- Keuntungan: Performance tinggi
- Kerugian: Bug dapat crash sistem

**B. Microkernel:**
- Minimal kernel, services di user space
- Contoh: QNX, MINIX
- Keuntungan: Stability, security
- Kerugian: Performance overhead

**C. Hybrid Kernel:**
- Kombinasi monolithic + microkernel
- Contoh: Windows NT, macOS XNU
- Balance antara performance dan modularity

**Kernel Space vs User Space:**
- Protection rings (Ring 0 vs Ring 3)
- Memory protection
- System calls sebagai interface

**Diagram:**
- OS layers (Hardware → Kernel → System → Apps)
- Kernel architecture comparison (visual)
- System call flow

**Colored Boxes:**
- **notebox**: Tanenbaum-Torvalds debate (brief)
- **examplebox**: System call - opening file di berbagai OS

---

### Session 2: Sejarah Singkat & Ekosistem OS (3-4 halaman)

#### 2.1 Evolusi OS (Timeline Singkat)
- **1960s**: Batch systems, time-sharing
- **1969**: Unix - Bell Labs (Ken Thompson, Dennis Ritchie)
- **1980s**: PC era - MS-DOS, Windows, Mac OS
- **1991**: Linux - Linus Torvalds
- **2000s**: Modern OS - XP, macOS X, mobile revolution
- **2010s**: Cloud dominance, Android/iOS

#### 2.2 Perbandingan Ekosistem (Compact)

**Windows:**
- Ecosystem: Desktop dominance, enterprise integration
- Filesystem: NTFS
- Package: winget, Microsoft Store

**macOS:**
- Ecosystem: Hardware-software integration
- Filesystem: APFS
- Package: App Store, Homebrew

**Linux:**
- Ecosystem: Distributions (Ubuntu, Fedora, Debian)
- Filesystem: ext4, XFS, Btrfs
- Package: apt, dnf, pacman
- Use case: Servers, cloud, development

**Mengapa Linux untuk Praktik?**
- Open source dan gratis
- Educational-friendly (transparent)
- Industry standard (servers, cloud)
- Highly customizable

**Diagram:**
- OS evolution timeline (simplified)
- Linux distribution families (Debian, Red Hat, Independent)

---

### Session 3-4: Instalasi Sistem Operasi (8-10 halaman)

#### 3.1 Konsep Instalasi (Universal - Brief)

**Tahapan instalasi:**
1. Preparation (media, backup)
2. Boot (BIOS/UEFI)
3. Partitioning
4. Installation
5. Configuration

**BIOS vs UEFI:**
- BIOS: Legacy (pre-2010)
- UEFI: Modern, Secure Boot, GPT support

**Metode deployment:**
- **Virtual Machine** (recommended untuk learning) - VirtualBox, VMware
- **Dual-boot** - Multiple OS pada satu machine
- **Bare metal** - Single OS, full performance

#### 3.2 Praktik: Instalasi Ubuntu Server 22.04 LTS

**Prerequisites:**
- VirtualBox installed
- Ubuntu Server ISO downloaded
- VM specs: 2GB RAM, 25GB disk

**Step-by-Step (Focused):**

1. **Create VM:**
   - New VM, Type: Linux, Version: Ubuntu 64-bit
   - Memory: 2048 MB
   - Create virtual hard disk: 25 GB, VDI, dynamically allocated

2. **Boot Installer:**
   - Attach ISO, start VM
   - Language, keyboard layout selection

3. **Network Configuration:**
   - DHCP (automatic) atau Static IP

4. **Partitioning:**
   - **Option 1**: Automatic (guided - entire disk)
   - **Option 2**: Manual (custom layout) - dijelaskan di section 4

5. **User Setup:**
   - Username, password, hostname

6. **Software Selection:**
   - OpenSSH server (recommended)
   - Optional: Docker, basic utilities

7. **Installation:**
   - Wait for completion (~15-20 minutes)
   - Reboot

8. **First Login:**
   - Console login
   - Basic verification

**Diagram:**
- VM setup flowchart
- Installation process (annotated screenshots-style)

**Colored Boxes:**
- **tipbox**: Menggunakan VM untuk safe experimentation
- **warningbox**: Backup data sebelum dual-boot
- **examplebox**: Creating bootable USB (brief mention)

**Code Listings (Linux practical):**
```bash
# Verify installation
uname -r          # Kernel version
cat /etc/os-release   # OS information
ip a              # Network interfaces
```

---

### Session 4-5: Partisi dan Filesystem (5-6 halaman)

#### 4.1 Konsep Partisi

**Mengapa partisi?**
- Organization, security, multi-OS
- Backup/recovery easier

**Partition Tables:**
- **MBR** (Legacy): Max 4 primary, 2TB limit
- **GPT** (Modern): 128 partitions, >2TB disks, UEFI required

#### 4.2 Skema Partisi Linux

**Minimum:**
```
/           20 GB    ext4
swap        2 GB     swap
```

**Recommended:**
```
/boot       1 GB     ext4
/           20 GB    ext4
/home       varies   ext4
swap        2-4 GB   swap
```

**Penjelasan mount points:**
- `/` - Root, system files
- `/boot` - Kernel, bootloader
- `/home` - User data (pisah untuk easy reinstall)
- `swap` - Virtual memory

#### 4.3 Filesystem Types (Focused)

**Cross-platform comparison:**
| Filesystem | Platform | Max File | Journaling | Use Case |
|------------|----------|----------|------------|----------|
| **NTFS** | Windows | 16 TB | Yes | Windows system |
| **APFS** | macOS | 8 EB | CoW | Modern macOS |
| **ext4** | Linux | 16 TB | Yes | Linux default |
| **exFAT** | Universal | 16 EB | No | USB drives |

**Linux filesystems (brief):**
- **ext4**: Default, stable, general purpose
- **XFS**: Large files, high performance (RHEL default)
- **Btrfs**: Modern, snapshots, compression

#### 4.4 Swap Space

**Apa itu swap?**
- Virtual memory extension di disk
- Digunakan saat RAM penuh

**Sizing guideline:**
- RAM ≤ 2GB: 2x RAM
- RAM 2-8GB: Same as RAM
- RAM > 8GB: 4-8 GB fixed

#### 4.5 Praktik: Manual Partitioning

**During Ubuntu installation - Manual partition:**
```
Device          Size      Type      Mount Point
/dev/sda1       1 GB      ext4      /boot
/dev/sda2       20 GB     ext4      /
/dev/sda3       50 GB     ext4      /home
/dev/sda4       4 GB      swap      [swap]
```

**Post-installation filesystem operations:**
```bash
# Check disk usage
df -h

# Check partition table
lsblk
sudo fdisk -l

# Filesystem type
lsblk -f

# Mount manually
sudo mount /dev/sdb1 /mnt

# Check fstab (auto-mount)
cat /etc/fstab
```

**Diagram:**
- MBR vs GPT layout (visual)
- Partition scheme visualization

**Colored Boxes:**
- **warningbox**: Formatting erases data!
- **tipbox**: Why separate /home - easy OS upgrade
- **notebox**: UUID vs device names (stability)

---

### Session 5-6: Konfigurasi Post-Installation (4-5 halaman)

#### 5.1 System Updates

**Mengapa penting:**
- Security patches, bug fixes

**Linux (Ubuntu/Debian):**
```bash
sudo apt update        # Update package list
sudo apt upgrade       # Upgrade packages
sudo apt autoremove    # Remove unused packages
```

**Brief mentions:**
- Windows: Windows Update
- macOS: System Preferences → Software Update

#### 5.2 Software Installation Essentials

**Development tools:**
```bash
sudo apt install -y \
    build-essential \
    git \
    curl \
    wget \
    vim \
    htop
```

#### 5.3 Network Configuration

**Check network:**
```bash
ip addr show          # IP addresses
ip route show         # Routing table
ping -c 4 google.com  # Connectivity test
```

**Static IP (Ubuntu - Netplan):**
```yaml
# /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    eth0:
      addresses: [192.168.1.100/24]
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
```

Apply: `sudo netplan apply`

#### 5.4 SSH Configuration

**Enable SSH:**
```bash
sudo apt install openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
```

**Security basics:**
- Disable root login
- Use SSH keys (mention, not detailed)
- Change default port (optional)

#### 5.5 Firewall Setup

```bash
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 80/tcp     # HTTP
sudo ufw allow 443/tcp    # HTTPS
sudo ufw status
```

#### 5.6 System Information

```bash
# OS info
cat /etc/os-release
uname -a

# Hardware
lscpu               # CPU
free -h             # Memory
df -h               # Disk
```

**Colored Boxes:**
- **warningbox**: Test SSH before logging out!
- **tipbox**: Create system snapshot/backup after setup
- **examplebox**: Complete post-install script (simple)

---

### Session 6: Rangkuman, Latihan, Referensi (3-4 halaman)

#### 6.1 Rangkuman

**Konsep Dasar:**
- OS sebagai resource manager
- 5 fungsi utama: Process, Memory, File, I/O, Security
- Kernel architectures: Monolithic, Microkernel, Hybrid

**Platform Overview:**
- Windows: Desktop dominance, enterprise
- macOS: Premium integration
- Linux: Server, cloud, development - open source

**Practical Skills:**
- Installation process (VM, partitioning)
- Filesystem concepts (ext4, swap, mount points)
- Post-installation: updates, network, security

**Key Takeaway:**
Konsep OS bersifat universal. Linux excellent untuk learning karena open, free, dan transparent.

---

#### 6.2 Latihan (Focused - 10 exercises)

**Konseptual (3):**
1. Jelaskan 5 fungsi OS dengan contoh dari 2 OS berbeda
2. Bandingkan monolithic vs microkernel - advantages/disadvantages
3. Kapan gunakan Windows vs Linux vs macOS? Analisis use cases

**Praktikal (5):**
4. Install Ubuntu Server di VirtualBox dengan:
   - Manual partitioning (/, /home, swap)
   - Static IP configuration
   - SSH enabled
   - Dokumentasi lengkap
5. Compare filesystem:
   - Create ext4 dan XFS partitions
   - Test performance (basic dd test)
   - Document differences
6. Post-installation setup:
   - Update system
   - Install development tools
   - Configure firewall
   - Create additional user
7. Network diagnostics:
   - Check IP, routing, DNS
   - Test connectivity
   - Configure static IP
8. System information gathering:
   - CPU, memory, disk info
   - Running services
   - Installed packages

**Research (2):**
9. Research dan bandingkan 3 Linux distributions:
   - Ubuntu vs Fedora vs Arch
   - Installation process, package management, target audience
10. Investigate cloud Linux images:
    - AWS AMI, Azure, Google Compute
    - Perbedaan dengan desktop distros

---

#### 6.3 Referensi (Compact)

**Books:**
- "Operating System Concepts" - Silberschatz et al. (theory)
- "Modern Operating Systems" - Tanenbaum (comprehensive)
- "How Linux Works" - Brian Ward (practical Linux)

**Online Resources:**
- Linux Foundation: https://www.linuxfoundation.org
- Ubuntu Documentation: https://ubuntu.com/server/docs
- Arch Wiki: https://wiki.archlinux.org (excellent general reference)

**Interactive Learning:**
- Linux Journey: https://linuxjourney.com
- OverTheWire Bandit: https://overthewire.org/wargames/bandit/

**Official Docs:**
- Windows: https://docs.microsoft.com
- macOS: https://developer.apple.com/documentation
- Linux Kernel: https://www.kernel.org

---

## Estimasi Halaman (Revised)

- **Session 1-2**: Konsep & Arsitektur - 4-5 halaman
- **Session 2**: Sejarah & Ekosistem - 3-4 halaman
- **Session 3-4**: Instalasi - 8-10 halaman
- **Session 4-5**: Partisi & Filesystem - 5-6 halaman
- **Session 5-6**: Post-Installation - 4-5 halaman
- **Session 6**: Rangkuman, Latihan, Referensi - 3-4 halaman

**Total: 27-34 halaman** ✓ Fits 6 sessions

---

## Visual Assets (Streamlined)

**Diagrams (5 essential):**
1. OS layers architecture
2. Kernel comparison (monolithic/micro/hybrid)
3. System call flow
4. Installation flowchart
5. Partition layouts (MBR vs GPT)

**Tables (4 essential):**
1. OS comparison (Windows/macOS/Linux)
2. Filesystem comparison
3. Partition sizing guidelines
4. Linux distributions overview

**Code Listings:**
- System info commands
- Installation verification
- Filesystem operations
- Network configuration
- Post-install essentials

---

## Session Breakdown

| Session | Topic | Pages | Activities |
|---------|-------|-------|------------|
| 1 | OS Concepts & Functions | 2-3 | Lecture, discussion |
| 2 | Kernel Architecture & OS Comparison | 4-5 | Lecture, comparison exercise |
| 3 | Installation Prep & Process | 4-5 | Demo, hands-on VM setup |
| 4 | Partitioning & Filesystem | 5-6 | Hands-on partitioning |
| 5 | Post-Installation Config | 4-5 | Hands-on configuration |
| 6 | Review, Q&A, Lab | 3-4 | Exercises, troubleshooting |

**Total: ~27-34 pages** for 300 minutes instruction ✓

---

## Implementation Notes

**Prioritas Konten:**
1. **Must-have**: Core OS concepts, kernel architecture, Linux installation, basic config
2. **Should-have**: OS comparison, partitioning details, network setup
3. **Nice-to-have**: History details, advanced filesystem features

**Practical Focus:**
- 40% theory (concepts, architecture)
- 60% practical (installation, configuration)
- All hands-on work uses Linux (VirtualBox + Ubuntu Server)

**Tone:**
- Professional but accessible
- Assume basic computer literacy only
- Explain technical terms on first use
- Real-world examples

**Exercises:**
- Reduced from 27 to 10 focused exercises
- Mix of theory and practice
- All practical exercises doable with free software

---

**Status: DRAFT - Ready for Review**

Sudah dikompres dari 60-75 halaman menjadi 27-34 halaman untuk 6 sessions (300 menit).
