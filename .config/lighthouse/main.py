#!/usr/bin/python3

import multiprocessing as mp
import shlex
import json
import subprocess as sp
import sys
import signal


def print_out(results):
    print("".join(map(lambda x: x if not None, results)))


def clean_subprocesses(processList, subprocess_list):
    """
    Stop all processes started.
    """
    for p in processList:
        p.terminate()
        del p
    for p in subprocess_list:
        p.terminate()
        del p


def get_result(subprocess, results_array, i):
    """
    """
    results = subprocess.stdout.read().decode('utf-8').replace("\n", "")
    if results.strip() != '':
        results_array[i] = results
        print_out(results_array)


if __name__ == "__main__":
    signal.signal(signal.SIGTERM, clean_subprocesses)
    subprocess_array = []
    scripts_file = open("/home/thomas/.config/lighthouse/scripts.json")
    scripts = json.loads(scripts_file.read())
    processList = []
    manager = mp.Manager()
    subprocess_list = manager.list()
    # results = mp.Array("c",  range(len(scripts)))

    while 1:
        request = sys.stdin.readline()[:-1]

        clean_subprocesses(processList, subprocess_list)
        processList = []
        subprocess_list = manager.list()

        results_array = manager.list([None for x in range(len(scripts))])
        process_array = []

        for i, script_name in enumerate(scripts):
            cmd = '%s %s' % (script_name, request)
            args = shlex.split(cmd)
            subprocess = sp.Popen(args, stdout=sp.PIPE)
            process_array.append(subprocess)

            process = mp.Process(target=get_result,
                                 args=(subprocess,
                                       results_array,
                                       i
                                       )
                                 )
            process.start()
            processList.append(subprocess)
