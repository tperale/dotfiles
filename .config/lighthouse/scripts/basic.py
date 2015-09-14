#!/usr/bin/python3
import sys
import argparse as ag
from collections import Counter
import subprocess as sp


def basic(sett):
    out = str()
    if sett.show_execute:
        out += "{Execute %%B'%s'%%|%s}" % (sett.user_input,
                                           sett.user_input)
    if sett.show_in_shell:
        out += "{Run the command in a shell %%B'%s'%%|%s %s}" % (sett.user_input,
                                                                 sett.term,
                                                                 sett.user_input
                                                                 )
    if sett.history_search:
        cmd = "cat '%s'" % sett.history_location
        for arg in sett.user_input.split():
            cmd += " | grep %s" % arg
        try:
            history = sp.check_output(cmd,
                                      shell=True,
                                      executable='/bin/sh').decode("utf-8").split("\n")
            hist_count = Counter(history)
            max_hist = max(hist_count, key=lambda x: hist_count[x])
            out += "{History: %%B'%s'%%|%s %s}" % (max_hist, sett.term, max_hist)
        except:
            pass

    return out

if __name__ == "__main__":
    parser = ag.ArgumentParser()
    parser.add_argument("user_input")
    parser.add_argument("-show_execute", default=True, type=bool)
    parser.add_argument("-show_in_shell", default=True, type=bool)
    parser.add_argument("-term", default="urvxt", type=str)
    parser.add_argument("-history_search", default=1, type=int)
    parser.add_argument("-history_location", default="/home/thomas/.bash_history", type=str)
    settings = parser.parse_args()
    print("{%CBasic Functions%}" + basic(settings))
