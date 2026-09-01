#!/bin/zsh

# ============================================================
# macOS Safe User Cache & Log Cleaner
#
# Cleans:
#   ~/Library/Caches
#   ~/Library/Logs (files older than 3 days)
#
# Does NOT touch:
#   /System
#   /private
#   /var
#   /tmp
#   /Library/Caches
#   /Library/Logs
#   ~/Library/Application Support
#   Trash
#
# No sudo required.
# ============================================================

setopt NO_NOMATCH

LOG_MAX_DAYS=15 # Set the number of days to keep logs. The script will remove logs older than 15 days.

USER_CACHE="$HOME/Library/Caches"
USER_LOGS="$HOME/Library/Logs"

removed_cache=0
removed_logs=0
skipped=0


# ------------------------------------------------------------
# Safety check
# ------------------------------------------------------------

if [[ "$HOME" != /* || "$HOME" == "/" ]]; then
    print "ERROR: Unsafe HOME path: $HOME"
    exit 1
fi

if [[ ! -d "$HOME" ]]; then
    print "ERROR: Home directory does not exist."
    exit 1
fi


# ------------------------------------------------------------
# Clean user cache
#
# Only direct files/symlinks are removed.
# Cache directories themselves are left untouched.
# ------------------------------------------------------------

print ""
print "Cleaning user cache..."
print "Location: $USER_CACHE"

if [[ -d "$USER_CACHE" ]]; then

    for item in "$USER_CACHE"/*(N); do

        # Do not recursively remove directories.
        if [[ -f "$item" || -L "$item" ]]; then

            if rm -f -- "$item" 2>/dev/null; then
                (( removed_cache++ ))
            else
                (( skipped++ ))
            fi

        fi

    done

else
    print "Cache directory does not exist."
fi


# ------------------------------------------------------------
# Clean old user logs
#
# Only regular files directly inside ~/Library/Logs.
# Files newer than LOG_MAX_DAYS are preserved.
# ------------------------------------------------------------

print ""
print "Cleaning old user logs..."
print "Older than: $LOG_MAX_DAYS days"
print "Location: $USER_LOGS"

if [[ -d "$USER_LOGS" ]]; then

    while IFS= read -r -d '' item; do

        if rm -f -- "$item" 2>/dev/null; then
            (( removed_logs++ ))
        else
            (( skipped++ ))
        fi

    done < <(
        find "$USER_LOGS" \
            -type f \
            -mtime +"$LOG_MAX_DAYS" \
            -print0 \
            2>/dev/null
    )

else
    print "Log directory does not exist."
fi


# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------

print ""
print "=========================================="
print " macOS cleanup complete"
print "=========================================="
print ""
print "Cache files removed : $removed_cache"
print "Old logs removed    : $removed_logs"
print "Skipped             : $skipped"
print ""
print "Trash was NOT emptied."
print "You can review and empty Trash manually."
print ""