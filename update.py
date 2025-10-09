#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p "python3.withPackages (ps: with ps; [ ])" -p skopeo -p nix-prefetch-github

import json
import os
import subprocess
import sys

if __name__ == "__main__":
    with open("version.json") as f:
        versions = json.load(f)
        for name, info in versions.items():
            if info.get("type") == "container":
                print(f"Checking {name}")
                import subprocess
                completed = subprocess.run(
                    f"skopeo inspect docker://{info['url']}:latest",
                    shell=True,
                    stdout=subprocess.PIPE,
                    text=True
                )
                data = json.loads(completed.stdout)
                tag = data.get("Labels").get("org.opencontainers.image.version")
                versions[name]["latest"] = tag
                print(f"  Latest version: {tag}\n")
            if info.get("type") == "github":
                print(f"Checking {name}")
                completed = subprocess.run(
                    f"nix-prefetch-github {info['owner']} {info['repo']} --rev {info.get('branch', 'main')}",
                    shell=True,
                    stdout=subprocess.PIPE,
                    text=True
                )
                data = json.loads(completed.stdout)
                rev = data.get("rev")
                hash = data.get("hash")
                versions[name]["rev"] = rev
                versions[name]["hash"] = hash
                print(f"  Latest rev: {rev}")
                print(f"  Latest hash: {hash}\n")
    with open("version.json", "w") as f:
        json.dump(versions, f, indent=4, sort_keys=True)
