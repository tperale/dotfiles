#!/usr/bin/python3
import sys
import argparse as ag
from collections import Counter
import subprocess as sp


def history_search(sett):
    out = str()
    cmd = "cat '%s'" % sett.history_location
    for arg in sett.user_input.split():
        cmd += " | grep %s" % arg
    try:
        history = sp.check_output(cmd,
                                    shell=True,
                                    executable='/bin/sh').decode("utf-8").split("\n")
        hist_count = Counter(history)
        max_hist = max(hist_count, key=lambda x: hist_count[x])
        out = "{History: %%B'%s'%%|%s %s}" % (max_hist, sett.term, max_hist)
    except sp.CalledProcessError:
        pass

    return out


def basic(sett):
    out = str()
    if sett.check_exist:
        # Check the existence of the command the user enter.
        # if it don't exist it won't ouput the command.
        try:
            for arg in [x for x in sett.user_input.split() if x.isalpha()]:
                capture = sp.check_output("type %s" % arg,
                        shell=True, executable='/bin/sh')
        except sp.CalledProcessError:
            return ''

    if sett.show_execute:
        out += "{Execute %%B'%s'%%|%s}" % (sett.user_input.replace("|", "\\|"),
                                           sett.user_input.replace("|", "\\|"))
    if sett.show_in_shell:
        out += "{Run the command in a shell %%B'%s'%%|%s -e %s}" % (sett.user_input.replace("|", "\\|"),
                                                                    sett.term,
                                                                    sett.user_input.replace("|", "\\|")
                                                                    )

    return out

if __name__ == "__main__":
    parser = ag.ArgumentParser()
    parser.add_argument("user_input")
    parser.add_argument("-show_execute", default=True, type=bool)
    parser.add_argument("-show_in_shell", default=True, type=bool)
    parser.add_argument("-check_exist", default=True, type=bool)
    parser.add_argument("-term", default="urvxt", type=str)
    parser.add_argument("-history_search", default=1, type=int)
    parser.add_argument("-history_location", default="/home/thomas/.bash_history", type=str)
    settings = parser.parse_args()

    cmd = basic(settings)
    if settings.history_search:
        cmd += history_search(settings)
    if cmd:
        # Checking it has a value.
        cmd = "{%CBasic Functions%}"  + cmd
    print(cmd)
