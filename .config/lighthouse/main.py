#!/usr/bin/python3

import multiprocessing as mp
import shlex
import json
import subprocess as sp
import sys


def print_out(results):
    res = str()
    for result in results:
        if result is not None:
            res += result

    print(res)


def get_result(subprocess, results_array, i):
    results_array[i] = subprocess.stdout.read().decode('utf-8').replace("\n", "")
    print_out(results_array)


if __name__ == "__main__":
    subprocess_array = []
    scripts_file = open("/home/thomas/.config/lighthouse/scripts.json")
    scripts = json.loads(scripts_file.read())
    processList = []
    manager = mp.Manager()
    subprocess_list = manager.list()
    # results = mp.Array("c",  range(len(scripts)))

    while 1:
        request = sys.stdin.readline()[:-1]

        # TODO
        for p in processList:
            p.terminate()
            del p
        processList = []
        for p in subprocess_list:
            p.terminate()
            del p
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
