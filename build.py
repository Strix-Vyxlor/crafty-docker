#!/usr/bin/python3

import sys
import os
import subprocess

argc = len(sys.argv)

if argc != 2:
    print("not enough arguments --> python build.py $ARCH")
    exit()

arch = None

if sys.argv[1] not in ["arm64", "amd64"]:
    print("supported arch: arm64/v8, amd64")
    exit()

arch = sys.argv[1]

subprocess.run(["docker", "buildx", "build",
            "--tag", f"minecraft-docker:latest-{arch}",
            "--platform", f"linux/{arch}",
            "--builder", "crafty",
            "--load", "."])
