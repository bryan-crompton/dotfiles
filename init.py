import yaml, os, subprocess

HOST = os.uname().nodename
with open("config.yaml") as f:
    config = yaml.safe_load(f)

host_tags = config["meta"]["hosts"][HOST]["tags"]

def should_install(item):
    if "hosts" in item and HOST not in item["hosts"]:
        return False
    if "exclude_tags" in item and any(t in host_tags for t in item["exclude_tags"]):
        return False
    if "tags" in item and not any(t in host_tags for t in item["tags"]):
        return False
    return True

for pkg in config["packages"]["apt"]["default"]:
    subprocess.run(["sudo", "apt", "install", "-y", pkg])

for pkg in config["packages"]["apt"].get("extra", []):
    if should_install(pkg):
        subprocess.run(["sudo", "apt", "install", "-y", pkg["name"]])
