#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p "python3.withPackages (ps: with ps; [ ])" -p skopeo -p nix-prefetch-github -p git

import json
import os
import subprocess
import sys
import tempfile
import urllib.request


if __name__ == "__main__":
    repo_path = os.path.expanduser("~/nixpkgs")
    upstream_ref = "https://github.com/nixos/nixpkgs.git"
    branch = "nixos-unstable"
    fork_remote = "https://github.com/cryolitia-forks/nixpkgs.git"

    print("Syncing ~/nixpkgs with upstream nixos-unstable")
    try:
        subprocess.run(
            ["git", "fetch", upstream_ref, branch],
            cwd=repo_path,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=True,
        )
    except subprocess.CalledProcessError as e:
        print(f"git fetch failed: {e}", file=sys.stderr)
        if e.stderr:
            print(e.stderr, file=sys.stderr)
        if e.stdout:
            print(e.stdout, file=sys.stderr)
        raise
    subprocess.run(
        ["git", "checkout", "-B", branch, "FETCH_HEAD"],
        cwd=repo_path,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        check=True,
    )

    patch_file = "patch.txt"
    with open(patch_file) as f:
        patch_urls = [line.strip() for line in f if line.strip() and not line.strip().startswith("#")]

    if not patch_urls:
        print("No patches found in patch.txt")
    else:
        print(f"Applying {len(patch_urls)} patch(es) from patch.txt")

    for url in patch_urls:
        print(f"  Applying patch: {url}")
        with tempfile.NamedTemporaryFile(mode="wb", suffix=".patch", delete=False) as temp_patch:
            temp_path = temp_patch.name
            with urllib.request.urlopen(url) as response:
                temp_patch.write(response.read())
        try:
            completed = subprocess.run(
                ["git", "am", "--3way", temp_path],
                cwd=repo_path,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                check=True,
            )
            print("    Result: applied")
            if completed.stdout:
                print(completed.stdout.strip())
            if completed.stderr:
                print(completed.stderr.strip())
        except subprocess.CalledProcessError as e:
            print("    Result: failed", file=sys.stderr)
            if e.stderr:
                print(e.stderr.strip(), file=sys.stderr)
            if e.stdout:
                print(e.stdout.strip(), file=sys.stderr)
            raise
        finally:
            os.unlink(temp_path)

    print(f"Force pushing {branch} to {fork_remote}")
    try:
        subprocess.run(
            ["git", "push", "--force", fork_remote, f"HEAD:{branch}"],
            cwd=repo_path,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=True,
        )
    except subprocess.CalledProcessError as e:
        print(f"git push failed: {e}", file=sys.stderr)
        if e.stderr:
            print(e.stderr, file=sys.stderr)
        if e.stdout:
            print(e.stdout, file=sys.stderr)
        raise

    with open("version.json") as f:
        versions = json.load(f)
        for name, info in versions.items():
            if info.get("type") == "container":
                print(f"Checking {name}")
                completed = subprocess.run(
                    f"skopeo inspect docker://{info['url']}:latest",
                    shell=True,
                    stdout=subprocess.PIPE,
                    text=True
                )
                data = json.loads(completed.stdout)
                if "ghcr.io" in info["url"]:
                    tag = data.get("Labels").get("org.opencontainers.image.version")
                    versions[name]["latest"] = tag
                    print(f"  Latest version: {tag}\n")
                else:
                    digest = data.get("Digest")
                    versions[name]["digest"] = digest
                    print(f"  Latest digest: {digest}\n")
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
