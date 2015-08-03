#!/usr/bin/python3

import multiprocessing as mp
import json
import subprocess as sp
import sys


def print_out(results):
    res = str()
    for result in results:
        if result is not None:
            res += result

    print(res)


def launch_script(script_name, query, results_array, index):
    if '/' in script_name:
        cmd = '%s %s' % (script_name, query)
    else:
        cmd = './%s %s' % (script_name, query)

    output = sp.check_output(cmd, shell=True, executable='/bin/sh')

    results_array[index] = output.decode('utf-8')

    print_out(results_array)


if __name__ == "__main__":
    scripts_file = open("./scripts.json")
    scripts = json.loads(scripts_file.read())
    processList = []
    manager = mp.Manager()
    # results = mp.Array("c",  range(len(scripts)))
    results = manager.list()

    while 1:
        request = sys.stdin.readline()[:-1]

        for process in processList:
            process.terminate()
        processList = []

        # Array like list
        results = manager.list([None for x in range(len(scripts))])

        for i, script_name in enumerate(scripts):
            process = mp.Process(launch_script(script_name,
                                               request,
                                               results,
                                               i)
                                 )
            process.start()
            processList.append(process)
