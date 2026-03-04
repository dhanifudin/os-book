# Quiz 1 - Operating Systems

## Instructions

1. This quiz consists of two sections: **Section A** (5 problems) and **Section B** (5 problems).
2. Choose **2 problems from Section A** and **2 problems from Section B** to answer (4 problems total).
3. Each problem must be completed directly on your Ubuntu Server VM.
4. Record the entire process as a **video documentation** that includes:
   - Your VM terminal screen while running each command
   - Verbal explanation for every step and answer given
   - Reading the output and interpreting the results
5. Upload the video to **YouTube** (unlisted is allowed) and include the video link in your answer sheet.
6. Ensure the video is clear, audio is audible, and covers all sub-questions of the chosen problems.

---

## Section A: Hardware Management & Basic Commands

### Problem 1

You are doing a lab session using Ubuntu Server in VirtualBox. Your task is to identify the virtual network device available in the VM and verify the kernel module that handles it.

Run the following command in your VM terminal:

```bash
lspci -nnk
```

Example output you might see (actual output may differ):

```
00:03.0 Ethernet controller [0200]: Intel Corporation 82540EM Gigabit Ethernet Controller [8086:100e] (rev 02)
        Subsystem: Intel Corporation PRO/1000 MT Desktop Adapter [8086:001e]
        Kernel driver in use: e1000
        Kernel modules: e1000
```

a) Based on the output of `lspci -nnk` that you ran on your VM:

- Write down the name of the detected Ethernet device along with its Vendor ID and Device ID (format `[xxxx:xxxx]`).
- Write down the name of the kernel module currently in use (`Kernel driver in use`).

b) Write the command that filters the output of `lspci -nnk` to show only lines containing the word `Ethernet` along with the 3 lines following it. Run the command and copy its output.

c) Use the module name you found in (a) to run `modinfo`. From the output, write down the values of the `description`, `version`, and one available `parm` (parameter) field.

---

### Problem 2

A technician is performing a hardware audit on a newly received Ubuntu Server VM. They need to document the CPU specifications, memory status, and storage configuration before the server goes into production.

a) Write the three commands used in sequence to view: (1) CPU architecture and number of cores, (2) total RAM and swap usage, and (3) list of disks along with their partitions and filesystem types. Run all three commands on your VM and record the results.

b) Before checking the UUID, the technician first needs to find out which device is used as the root filesystem on their VM.

- Run the command to find the device mounting the root filesystem (`/`) on your VM. *(Hint: use `findmnt /`)*
- Record the device name you find (e.g. `/dev/sda1` or `/dev/sda2`, may differ per VM).
- Use that device name to display its UUID and filesystem type. Write the command you used along with its output.

c) Explain why UUID is preferred over a device name (such as `/dev/sda2`) for mount configuration in `/etc/fstab`.

---

### Problem 3

You want to create a virtual network interface for testing network configuration on your VM without needing additional physical hardware. Linux provides the `dummy` module which enables the creation of such a virtual network interface.

a) Run the command to check whether the `dummy` module is currently active in the kernel. Write the command used and copy its output. Is the module already active on your VM?

b) Run `modinfo dummy` on your VM. From the output, write down the values of the following fields:

- `filename` (location of the module's `.ko` file)
- `description`
- `vermagic` (compatible kernel version)

c) Perform the following steps in order and write the output of each command:

1. Load the `dummy` module using `modprobe`
2. Verify the module was loaded successfully using `lsmod`
3. Create a virtual network interface using the following command:

    ```bash
    sudo ip link add dummy0 type dummy
    ```

4. Display the `dummy0` interface using `ip link show dummy0` as proof of success

---

### Problem 4

An administrator receives a report that a web application on the server is experiencing errors. They need to download a prepared log file and analyze it using text manipulation commands.

Download the log file using the following command on your VM:

```bash
wget -O app.log https://s.id/IvfhB
```

Once the file is downloaded, use `app.log` to answer the following questions.

a) Run the `grep` command to display only the lines containing `ERROR`, along with their line numbers. Write the command used and copy its output.

b) Run the command to display lines containing `WARN` or `ERROR` at the same time using a single `grep` command. Write the command used and copy its output.

c) The developer team requests the log to be cleaned up by replacing the label `WARN` with `WARNING` and `ERROR` with `CRITICAL` in the file. Write the `sed` command to perform both replacements at once, after first creating a backup of the original file. Display the file contents before and after the changes.

---

### Problem 5

While working on a lab assignment, you accidentally launched two `sleep` processes in the background at the same time and forgot how long each was set to run. To practice process management, you need to find and stop both of them properly.

First, run the following commands on your VM to set up the scenario:

```bash
sleep 800 &
sleep 900 &
```

a) Run the `ps` command to find the PIDs of both `sleep` processes without showing the `grep` process itself in the results. Write the command used and record both PIDs you found.

b) Stop the `sleep 800` process using SIGTERM. Verify that the process has stopped by running the search command from (a) again. Write all commands used along with their outputs.

c) Explain the difference between SIGTERM and SIGKILL. Under what circumstances should you switch from SIGTERM to SIGKILL, and what is the risk of using SIGKILL directly without trying SIGTERM first?

---

## Section B: Basic Input/Output (I/O)

### Problem 1

A student is learning about file descriptors in Linux. They run the following command in the terminal:

```bash
ls -l /proc/$$/fd
```

And get the following output:

```
lrwx------ 1 student student 64 Mar  4 09:00 0 -> /dev/pts/1
lrwx------ 1 student student 64 Mar  4 09:00 1 -> /dev/pts/1
lrwx------ 1 student student 64 Mar  4 09:00 2 -> /dev/pts/1
lr-x------ 1 student student 64 Mar  4 09:00 3 -> /proc/1234/fd
```

a) Explain what file descriptors 0, 1, and 2 represent in the output above, and why all three point to `/dev/pts/1`.

b) The student then runs `cat < /etc/hostname`. Explain how the data flows, where the shell reads the input from, and where the output is sent.

c) What does the `$$` variable mean in the command above? Why does the value of `$$` differ every time a new terminal session is opened?

---

### Problem 2

While trying to understand redirection, you run the `find` command to search for all `.conf` files on the system. However, the output mixes valid search results with many "Permission denied" error messages because some system folders are not accessible.

Run the following command on your VM and observe the output:

```bash
find / -name "*.conf"
```

a) From the output above, two types of output appear. Explain the difference between them and through which file descriptor each is sent.

b) Rewrite the command so that:

- Valid search results are saved to the file `search-results.txt`
- "Permission denied" error messages are saved to the file `error.txt`

Run the command, then display the first 5 lines of each file to prove the separation was successful.

c) Write the command to run the same search, but this time discard error messages entirely so the terminal only shows valid search results. When is this approach more appropriate than saving errors to a file?

---

### Problem 3

For your lab report, you need to document the current state of your VM. You want to see the output directly in the terminal while also saving it to a report file without running the commands twice.

a) Run the `df -h` command using `tee` so that its output is displayed in the terminal and saved to `report.txt` at the same time. Then run `free -h` with `tee` in **append** mode so the result is added to the same file. Write both commands used and display the contents of `report.txt` after both have been run.

b) You want to save the output of `uptime` to two files at once: `report.txt` (append mode) and `backup-report.txt` (append mode). Run the command using `tee` to achieve both in a single command, then display the contents of both files as proof.

c) Explain the difference between `tee` and the `>` operator. When would you choose to use `tee` instead of just using `>`?

---

### Problem 4

You are asked to analyze the list of users on your VM and save the results step by step. Use the file `/etc/passwd` as the data source.

a) Run the following pipeline on your VM and explain the function of each command in the pipeline in order:

```bash
cat /etc/passwd | cut -d: -f1 | sort | uniq
```

b) Modify the pipeline above using `tee` so that the result after the `sort` stage is saved to a file `sorted-users.txt`, while the data continues to flow to the `uniq` command. Run the pipeline and display the contents of `sorted-users.txt` as proof.

c) Explain the difference in output between using `sort | uniq` versus using `sort` alone. In the context of `/etc/passwd`, is the difference noticeable? Why?

---

### Problem 5

You want to check which processes are currently running on your VM, then save the results to a file for later review.

a) Run the following pipeline on your VM, then explain the function of each stage:

```bash
ps aux | grep -v grep | head -10
```

b) Modify the pipeline above so that the output is saved to a file `processes.txt` while still being displayed in the terminal. Run the command and display the contents of `processes.txt` as proof.

c) Explain the difference between the following two commands and when each is used:

```bash
ps aux | grep sshd > result.txt
ps aux | grep sshd >> result.txt
```

Run both sequentially twice, then compare the contents of `result.txt` after each attempt.

---
