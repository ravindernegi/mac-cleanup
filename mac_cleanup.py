#!/usr/bin/env python3

from pathlib import Path
import time


HOME = Path.home()
CACHE_DIR = HOME / "Library" / "Caches"
LOG_DIR = HOME / "Library" / "Logs"

LOG_MAX_AGE_DAYS = 15 # Set the number of days to keep logs. The script will remove logs older than 15 days.


def clean_user_cache():
    removed = 0
    skipped = 0

    if not CACHE_DIR.is_dir():
        return removed, skipped

    try:
        for item in CACHE_DIR.iterdir():

            try:
                # Do not follow directories.
                # Do not recursively delete anything.
                if item.is_file() or item.is_symlink():
                    item.unlink()
                    removed += 1

            except (PermissionError, FileNotFoundError, OSError):
                skipped += 1

    except (PermissionError, OSError):
        skipped += 1

    return removed, skipped


def clean_old_logs():
    removed = 0
    skipped = 0

    if not LOG_DIR.is_dir():
        return removed, skipped

    cutoff = time.time() - (LOG_MAX_AGE_DAYS * 86400)

    try:
        for item in LOG_DIR.iterdir():

            try:
                if item.is_symlink():
                    continue

                if not item.is_file():
                    continue

                if item.stat().st_mtime < cutoff:
                    item.unlink()
                    removed += 1

            except (PermissionError, FileNotFoundError, OSError):
                skipped += 1

    except (PermissionError, OSError):
        skipped += 1

    return removed, skipped


def main():
    print("macOS Safe Cleanup")
    print("==================")

    cache_removed, cache_skipped = clean_user_cache()
    log_removed, log_skipped = clean_old_logs()

    print(f"Cache files removed : {cache_removed}")
    print(f"Old logs removed    : {log_removed}")
    print(f"Files skipped       : {cache_skipped + log_skipped}")

    print("\nDone.")
    print("Trash was NOT emptied.")
    print("You can empty Trash manually.")


if __name__ == "__main__":
    main()