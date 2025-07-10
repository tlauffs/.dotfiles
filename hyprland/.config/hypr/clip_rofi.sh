#!/usr/bin/env bash

cliphist list | \
    grep -vE 'password|login|token|secret|key|api_key|auth|credential|private|ssh|gpg|otp|2fa|pin|ssn|bank|account|card|cvv|address|phone|email|username|user|pass|pwd' | \
    awk '{if (length($0) > 20) print substr($0, 1, 30) "..."; else print $0}' | \
    rofi -dmenu -p "Clipboard history" | \
    awk '{print $1}' | \
    xargs -I{} cliphist decode {} | \
    wl-copy
