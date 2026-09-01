# Automation Script for Clean System Cache and Log for macOS

A safe, user-level automation utility designed exclusively for **macOS** to clean user caches and manage old log files without requiring root (`sudo`) privileges.

---

## Overview

This repository provides lightweight Zsh and Python utilities to keep your Mac's user cache and log directories clutter-free. It targets non-system files inside your home directory, ensuring optimal performance without risking your operating system's stability.

---

## Folder Structure

- `mac-cleanup/`
  - `mac_cleanup.zsh`: The core Zsh script that handles safe cache deletion and log pruning.
  - `Run_Mac_Cleanup.command`: A convenient macOS launcher wrapper that allows you to run the cleaner script with a simple **double-click** in Finder.
  - `mac_cleanup.py`: Python script counterpart for executing the cleanup via Python.

---

## Settings 

You can configure how many days of logs and cache you want to retain. Find the `LOG_MAX_DAYS` variable inside the Python or shell script and change it to your preferred number of days. By default, it is set to **15 days**.

---

## How to Run The Script

### Option A: Run via Double-Click (`.command` file)

If you prefer a graphical approach without using the command line:

1. Locate the `Run_Mac_Cleanup.command` file in Finder. 
2. **Double-click** it. 
   *(Note: The first time you run it, macOS Gatekeeper might block it because it's an unrecognized script. To fix this, right-click the file, select **Open**, and click **Open** in the warning dialog).*
3. A Terminal window will automatically launch, execute the cleanup, and display a summary report.

---

### Option B: Run via CLI (Terminal)

If you prefer using the Command Line Interface, you can execute either the shell or Python script directly.

#### 1. Run the Zsh Script
1. Open **Terminal**.
2. Navigate to the folder containing the script:
   ```bash
   cd /path/to/mac-cleanup

   ```

3. Grant execution permissions (only needed the first time):
   ```bash
   chmod +x mac_cleanup.zsh

   ```


4. Run the script:
   ```bash
   ./mac_cleanup.zsh

   ```


#### 2. Run the Python Script

1. Open **Terminal**.
2. Navigate to the folder containing the script:
   ```bash
   cd /path/to/mac-cleanup

   ```   


3. Run the script:
   ```bash
   python3 mac_cleanup.py

   ```
