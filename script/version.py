#!/usr/bin/python

import argparse
import plistlib
from subprocess import check_output


def get_version_next(version):
    components = str(version).split('.')
    init, last = components[:-1], components[-1:]
    init.append(str(int(last[0]) + 1))
    return ".".join(init)


def set_version(version):
    return check_output(
        ["/usr/bin/agvtool new-version -all %s" % version],
        shell=True)


def set_version_automatically():
    plist = plistlib.readPlist("MVVMKit/Info.plist")
    current_version = plist["CFBundleVersion"]
    next_version = get_version_next(current_version)
    set_version(next_version)
    print "Updated version from [%s] to [%s]." \
        % (current_version, next_version)


def main():
    parser = argparse.ArgumentParser(description='Version bumper')
    parser.add_argument("-n", "--new", help="set new version number")
    parser.add_argument("-a", "--auto", help="autoincrement version number",
                        action="store_true")

    args = parser.parse_args()
    if args.auto:
        set_version_automatically()
    elif args.new:
        set_version(args.new)


if __name__ == "__main__":
    main()
