#!/usr/bin/env python3
from datetime import datetime
import yaml
import subprocess
import shutil
from pathlib import Path

# Load YAML
with open("playbook-small.yaml", "r") as f:  
    config = yaml.safe_load(f)

# apt_packages = config.get("apt", {}).get("default", [])
# if apt_packages:
#     print(f"Installing {len(apt_packages)} apt packages...")
#     subprocess.run(["sudo", "apt", "update"], check=True)
#     subprocess.run(["sudo", "apt", "install", "-y"] + apt_packages, check=True)
# else:
#     print("No apt packages found in config.")
# --- Dotfile setup ---
dotfiles_dir = Path("dotfiles")
home = Path.home()
backup_dir = home / f".dotfile_backups_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
backup_dir.mkdir(exist_ok=True)

dotfiles = config.get("dotfiles", [])
if not dotfiles:
    print("⚠️  No dotfiles listed in config.")
else:
    print(f"🔗 Setting up {len(dotfiles)} dotfiles...")
    for rel_path in dotfiles:
        src = dotfiles_dir / rel_path

        if not src.exists():
            print(f"❌ Skipping {rel_path}: source {src} does not exist.")
            continue

        dst = home / rel_path
        dst.parent.mkdir(parents=True, exist_ok=True)

        # Backup existing item
        if dst.exists() or dst.is_symlink():
            backup_path = backup_dir / rel_path
            backup_path.parent.mkdir(parents=True, exist_ok=True)
            print(f"💾 Backing up existing {dst} → {backup_path}")

            # Copy file or directory (following symlink rules)
            if dst.is_dir() and not dst.is_symlink():
                shutil.copytree(dst, backup_path, dirs_exist_ok=True)
                shutil.rmtree(dst)
            else:
                shutil.copy2(dst, backup_path)
                dst.unlink(missing_ok=True)

        # Create symlink
        print(f"➡️  Linking {src} → {dst}")
        dst.symlink_to(src.resolve())

    print(f"✅ All dotfiles linked (backups at {backup_dir})")

print("🎉 Setup complete.")