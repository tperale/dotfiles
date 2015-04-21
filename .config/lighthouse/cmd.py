#!/usr/bin/python2.7

import sys
import os.path
import os
import subprocess
import logging
from google import pygoogle
from multiprocessing import Process, Manager


# Terminal emulator used by default.
TERM = 'terminator'
EDITOR = 'nvim'

# dictionnary associating program with extension.
# ex: "feh": ['.jpeg', '.jpg', '.png']
# We could also add icon to with those program
fileChoose = {"mpv": ['.mp3', '.mp4', '.mkv', '.flv', '.avi'],
              "zathura": ['.pdf', '.ps'],
              # "nvim": ['.txt'],
              "feh": ['.jpeg', '.jpg', '.png'],
              "gimp": []}

# Alliases, associate with function.
# for the key you write with which word you want to output, your function,
# and for the value you use a lambda function.
special = {
    "bat": lambda x: out.get_process_output("acpi", "%s", ""),
    "qbit": lambda x: out.append_output("xdg", "qbittorrent", "qbittorrent")
}


class Output:
    def __init__(self):
        self.defaultOrder = ["xdg",
                             "find",
                             "exec",
                             "python",
                             "terminal",
                             "keyword",
                             "google"]

        self.order = self.defaultOrder[:]

        manager = Manager()
        self.functions = manager.dict()
        for name in self.defaultOrder:
            self.functions[name] = []

    def clear_output(self):
        for functionType in self.order:
            self.functions[functionType] = []

        self.order[:] = self.defaultOrder

    def sanitize_output(self, string):
        string = string.replace("{", "\{")
        string = string.replace("}", "\}")
        string = string.replace("|", "\|")
        string = string.replace("\n", " ")
        return string

    def create_result(self, title, action):
        return "{" + title + " |" + action + " }"

    def append_output(self, funcType, title, action):
        """
        """
        title = self.sanitize_output(title)
        action = self.sanitize_output(action)

        # Store result value.
        self.functions[funcType] = \
            self.functions[funcType] + [self.create_result(title, action)]

    def update_output(self):
        toSave = []
        for funcType in self.order:
            for result in self.functions[funcType]:
                toSave.append(result)

        print("".join(toSave))
        sys.stdout.flush()

    def get_process_output(self, process, formatting, action):
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

    def change_order(self, newOrder):
        """
        Change the output order.
        """
        self.order = newOrder

    def move_bottom(self, funcType):
        """
        Change order to output the specified 'funcType' in the last position.
        """
        funcIndex = self.order.index(funcType)
        self.change_order(self.order[:funcIndex]
                          + self.order[funcIndex+1:] + [funcType])


class Process_Func:
    """
    Here are the mosts time comsuming functions of the script.
    Those are launched with the mutliprocessing Process() function.
    """
    def __init__(self, out):
        self.processList = []
        self.output = []

        self.out = out

        # List of all function you want ot launch in the next process,
        # New function should be refered here.
        self.funcNames = [self.google,
                          self.find,
                          self.basic_function,
                          self.find_xdg,
                          self.special_word]

    def spawn(self, query):
        """
        Create a process for each function in funcNames.
        """
        for function in self.funcNames:
            process = Process(target=function, args=(query, ))
            process.start()
            self.processList.append(process)

    def kill(self):
        """
        Kill all processes previously started in self.processList
        """
        for process in self.processList:
            process.terminate()

        self.processList = []

    def google(self, query):
        """
        Append the first result of the 'query' google search.
        """
        try:
            g = pygoogle(query, log_level=logging.CRITICAL)
            g.pages = 1
            googleOut = g.get_urls()
        except:
            # When no connection.
            pass
        else:
            if (len(googleOut) >= 1):
                self.out.append_output("google", googleOut[0],
                                       "xdg-open " + googleOut[0])
                self.out.update_output()

    def find(self, query):
        """
        Little fuzzy finder implementation that work with  a bash command,
        it also launch different filetype.
        """
        queryList = query.split()

        command = ["| grep '%s' " % (elem) for elem in queryList]
        command = " ".join(command)

        user = os.path.expanduser('~')

        try:
            find_array = subprocess.check_output('find %s %s' % (user, command),
                                                 shell=True,
                                                 executable='/bin/bash').split('\n')

        except Exception:
            # When 'find' output nothing.
            self.out.append_output("find", "No path found.", TERM)
            self.out.move_bottom("find")

        else:
            find_array.sort(key=len)
            for i in xrange(min(3, len(find_array))):
                clearedOut = find_array[i].strip().replace(' ', '\ ')
                # Path with space on them wasn't working.

                if os.path.isdir(find_array[i]):
                    # 'foo bar' is considered as a folder in python
                    # but 'foo\ bar' is not.
                    self.out.append_output("find", str(find_array[i]),
                                           "%s --working-directory=%s" % (TERM, clearedOut))

                else:
                    # Check for every file extension the user specified in the
                    # begining of this script file
                    state = False
                    for name, extensions in fileChoose.items():
                        j = 0
                        while j < len(extensions) and \
                                extensions[j] not in clearedOut:
                            j += 1

                        if j < len(extensions):
                            state = True
                            self.out.append_output("find", str(find_array[i]),
                                                   "%s %s" % (name, clearedOut))
                            break

                    if not state and os.path.isfile(clearedOut):
                        # If no extension was found you can still open it with
                        # your text editor.
                        self.out.append_output("find", str(clearedOut),
                                               "%s -e '%s %s'" % (TERM, EDITOR, clearedOut))

        finally:
            self.out.update_output()

    def basic_function(self, userInput):
        """
        Append to the output some basic, command for the user.
        """
        # Could be a command...
        out.append_output("exec", "execute '%s'" % (userInput),
                          userInput)
        # Could be bash...
        self.out.append_output("terminal", "run '%s' in a shell" % (userInput),
                               TERM + " -e %s" % (userInput))

        self.out.update_output()

    def get_xdg_cmd(self, cmd):
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

    def find_xdg(self, query):
        """
        Look for XDG applications of the given name.
        """
        try:
            complete = subprocess.check_output("compgen -c %s" % (query),
                                               shell=True,
                                               executable="/bin/bash")
            complete = complete.split()

            for cmd_num in range(min(len(complete), 5)):
                xdg_cmd = self.get_xdg_cmd(complete[cmd_num])
                if xdg_cmd:
                    self.out.append_output('xdg', *xdg_cmd)

        except:
            # if no command exist with the user input
            pass

    def special_word(self, userInput):
        # Scan for keywords
        for keyword in special:
            if (userInput[0:len(keyword)] == keyword):
                special_out = special[keyword](userInput)
                if special_out is not None:
                    self.out.append_output('keyword', *special_out)


if __name__ == '__main__':
    out = Output()
    threaded_func = Process_Func(out)

    userInput = ''

    while 1:
        userInput = sys.stdin.readline()[:-1]

        threaded_func.kill()

        splittedInput = userInput.split()

        # Clear results
        out.clear_output()

        # We don't handle empty strings
        if userInput == '':
            out.update_output()
            continue

        #if len(splittedInput) == 1:
            # Application don't have spaced name.

        # start threads
        threaded_func.spawn(userInput)
