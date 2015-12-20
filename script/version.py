#!/usr/bin/python

import argparse
import plistlib
import subprocess
import fileinput

PLIST_PATH = "MVVMKit/Info.plist"

def increment_version(version):
    components = str(version).split('.')
    init, last = components[:-1], components[-1:]
    init.append(str(int(last[0]) + 1))
    return ".".join(init)


def get_version():
    global PLIST_PATH
    plist = plistlib.readPlist(PLIST_PATH)
    return plist["CFBundleVersion"]


def set_plist_version(version):
    subprocess.check_output(["agvtool", "new-version", "-all", version])


def set_version(version):
    old_version = get_version()
    set_plist_version(version)
    print "Updated version from [%s] to [%s]." \
        % (old_version, version)


def set_version_automatically():
    current_version = get_version()
    next_version = increment_version(current_version)
    set_version(next_version)


def git_add_all():
    subprocess.check_output(["git", "add", "-A", "."])


def git_commit(message):
    subprocess.check_output(["git", "commit", "-m", message])


def git_push():
    subprocess.check_output(["git", "push"])
    subprocess.check_output(["git", "push", "--tags"])


def git_tag(name, message):
    subprocess.check_output(["git", "tag", "-a", name, "-m", message])


def push_version():
    version = get_version()
    git_add_all()
    git_commit("Bumped version %s;" % version)
    git_tag(version, "%s tag;" % version)
    git_push()


def main():
    parser = argparse.ArgumentParser(description='Version bumper')
    parser.add_argument("-n", "--new", help="set new version number")
    parser.add_argument("-a", "--auto", help="autoincrement version number",
                        action="store_true")
    parser.add_argument("-p", "--push",
                        help="commit and push changes to repositories",
                        action="store_true")

    args = parser.parse_args()
    if args.auto:
        set_version_automatically()
    elif args.new:
        set_version(args.new)
    elif args.push:
        push_version()


if __name__ == "__main__":
    main()
