#!/usr/bin/python2.7

import sys
#import random
import os.path
import subprocess
#import json
import logging
#from time import sleep
from google import pygoogle
#from multiprocessing import Process, Value, Manager, Array
from ctypes import c_char, c_char_p

MAX_OUTPUT = 100 * 1024

baseFunc = {"find": [],
            "python": [],
            "terminal": [],
            "exec": [],
            "google": [],
            "keyword": [],
            "xdg": []}

order = ["xdg", "find", "exec", "python", "terminal", "google"]


def clear_output():
    fonctions = {"find": [],
                 "python": [],
                 "terminal": [],
                 "exec": [],
                 "google": [],
                 "keyword": [],
                 "xdg": []}

    return fonctions


def sanitize_output(string):
    string = string.replace("{", "\{")
    string = string.replace("}", "\}")
    string = string.replace("|", "\|")
    string = string.replace("\n", " ")
    return string


def create_result(title, action):
    return "{" + title + " |" + action + " }"


def append_output(funcType, fonctions, title, action):
    title = sanitize_output(title)
    action = sanitize_output(action)

    # Store result value.
    fonctions[funcType].append(create_result(title, action))

    return fonctions


def update_output(fonctions):
    toSave = []
    for funcType in order:
        for result in fonctions[funcType]:
            toSave.append(result)

    print("".join(toSave))
    sys.stdout.flush()

google_thr = None


def google(query, fonctions):
    g = pygoogle(userInput, log_level=logging.CRITICAL)
    g.pages = 1
    out = g.get_urls()
    if (len(out) >= 1):
        append_output('google', fonctions, out[0], "xdg-open " + out[0])


find_thr = None


def find(query, fonctions):
    queryList = query.split()  # splitted at space (fuzzy finder implementation)

    command = ["| grep '%s' " % (elem) for elem in queryList]
    command = " ".join(command)

    user = os.path.expanduser('~')

    try:
        find_array = subprocess.check_output('find %s %s' % (user, command),
                                            shell=True,
                                            executable='/bin/bash').split('\n')
    except Exception:
        # When 'find' output nothing.
        fonctions = append_output("find", fonctions, "Nothing found.", "terminator")

    else:
        for i in xrange(min(3, len(find_array))):
            fonctions = append_output("find", fonctions, str(find_array[i]),
                                      "terminator --working-directory=%s" % (find_array[i]))
    finally:
        update_output(fonctions)


def get_process_output(process, formatting, action):
    process_out = str(subprocess.check_output(process))
    if "%s" in formatting:
        out_str = formatting % (process_out)
    else:
        out_str = formatting
    if "%s" in action:
        out_action = action % (process_out)
    else:
        out_action = action

    return (out_str, out_action)


def get_xdg_cmd(cmd):
    import re

    try:
        import xdg.BaseDirectory
        import xdg.DesktopEntry
        import xdg.IconTheme
    except ImportError as e:
        print(e)
        return

    def find_desktop_entry(cmd):

        search_name = "%s.desktop" % cmd
        desktop_files = list(xdg.BaseDirectory.load_data_paths('applications',
                                                               search_name))
        if not desktop_files:
            return
        else:
            # Earlier paths take precedence.
            desktop_file = desktop_files[0]
            desktop_entry = xdg.DesktopEntry.DesktopEntry(desktop_file)
            return desktop_entry

    def get_icon(desktop_entry):

        icon_name = desktop_entry.getIcon()
        if not icon_name:
            return
        else:
            icon_path = xdg.IconTheme.getIconPath(icon_name)
            return icon_path

    def get_xdg_exec(desktop_entry):

        exec_spec = desktop_entry.getExec()
        # The XDG exec string contains substitution patterns.
        exec_path = re.sub("%.", "", exec_spec).strip()
        return exec_path

    desktop_entry = find_desktop_entry(cmd)
    if not desktop_entry:
        return

    exec_path = get_xdg_exec(desktop_entry)
    if not exec_path:
        return

    icon = get_icon(desktop_entry)
    if not icon:
        menu_entry = cmd
    else:
        menu_entry = "%%I%s%%%s" % (icon, cmd)

    return (menu_entry, exec_path)


special = {
    # "vi": ('("vim", "terminator -x vim")'),
    "bat": (lambda x: get_process_output("acpi", "%s", ""))
}


while 1:
    userInput = sys.stdin.readline()
    userInput = userInput[:-1]

    # Clear results
    fonctions = clear_output()

    # Kill previous worker threads
    if google_thr is not None:
        google_thr.terminate()
    if find_thr is not None:
        find_thr.terminate()

    # We don't handle empty strings
    if userInput == '':
        update_output(fonctions)
        continue

    # Is this python?
    try:
        out = eval(userInput)
        # if (type(out) != str and str(out)[0] == '<'):
        #     pass  # We don't want gibberish type stuff
        # else:
        append_output('python', fonctions, "python: "+str(out),
                      "terminator -e python2.7 -i -c 'print %s'" % userInput)
    except Exception as e:
        pass

    try:
        complete = subprocess.check_output("compgen -c %s" % (userInput),
                                           shell=True, executable="/bin/bash")
        complete = complete.split('\n')

        for cmd_num in range(min(len(complete), 5)):
                # Look for XDG applications of the given name.
                xdg_cmd = get_xdg_cmd(complete[cmd_num])
                if xdg_cmd:
                    append_output('xdg', fonctions, *xdg_cmd)

    except:
        # if no command exist with the user input
        # but it can still be python or a special bash command
        pass

    finally:
        # Scan for keywords
        for keyword in special:
            if userInput[0:len(keyword)] == keyword:
                out = special[keyword](userInput)
                if out is not None:
                    append_output('keyword', fonctions, *out)

        # Could be a command...
        append_output("exec", fonctions, "execute '"+userInput+"'", userInput)

        # Could be bash...
        append_output("terminal", fonctions,
                      "run '%s' in a shell" % (userInput),
                      "terminator -e %s" % (userInput))

        # Spawn worker threads
        # google_thr = Process(target=google, args=(userInput, fonctions))
        # google_thr.start()
        # find_thr = Process(target=find, args=(userInput, fonctions))
        # find_thr.start()
        find(userInput, fonctions)

        # update_output(fonctions)
