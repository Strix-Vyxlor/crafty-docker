#!/bin/sh

cd /crafty
source .venv/bin/activate
cd crafty-4

exec python3 main.py
