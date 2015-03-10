#!/usr/bin/python2.7

import sys
import os.path
import subprocess
import logging
from google import pygoogle
from multiprocessing import Process


class Output:
    def __init__(self):
        self.fonctions = {"find": [],
                          "python": [],
                          "terminal": [],
                          "exec": [],
                          "google": [],
                          "keyword": [],
                          "xdg": []}

        self.order = ["xdg", "find", "exec", "python", "terminal", "google"]

    def clear_output(self):
        for fonctionType in self.fonctions:
            del self.fonctions[fonctionType][:]

    def sanitize_output(self, string):
        string = string.replace("{", "\{")
        string = string.replace("}", "\}")
        string = string.replace("|", "\|")
        string = string.replace("\n", " ")
        return string

    def create_result(self, title, action):
        return "{" + title + " |" + action + " }"

    def append_output(self, funcType, title, action):
        title = self.sanitize_output(title)
        action = self.sanitize_output(action)

        # Store result value.
        self.fonctions[funcType].append(self.create_result(title, action))

    def update_output(self):
        toSave = []
        for funcType in self.order:
            for result in self.fonctions[funcType]:
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


class Process_Func:
    """
    Here are the mosts time comsuming fonctions of the script.
    Those are launched with the mutliprocessing Process() function.
    """
    def __init__(self, out):
        self.out = out

        self.videoPlayer = 'mpv'
        self.pdfReader = 'zathura'
        self.editor = 'vim'

        self.processList = []

        # New function should be refered here.
        self.funcNames = [self.google, self.find]

    def spawn(self, query):
        """
        Create a process for each function in funcNames.
        """
        for function in self.funcNames:
            process = Process(target=function, args=(query,))
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
        Get the first result of the 'query' google search.
        """
        g = pygoogle(query, log_level=logging.CRITICAL)
        g.pages = 1
        out = g.get_urls()
        if (len(out) >= 1):
            self.out.append_output("google", out[0], "xdg-open " + out[0])
            self.out.update_output()

    def find(self, query):
        """
        Little fuzzy finder implementation that work with  a bash command,
        it also launch different filetype.
        """
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
            self.out.append_output("find", "No path found.", "terminator")

        else:
            find_array.sort(key=len)
            for i in xrange(min(3, len(find_array))):
                if os.path.isdir(find_array[i]):
                    self.out.append_output("find", str(find_array[i]),
                                           "terminator --working-directory=%s" % (find_array[i]))

                elif '.pdf' in find_array[i] or '.ps' in find_array[i]:
                    self.out.append_output("find", str(find_array[i]),
                                           "terminator -e 'zathura %s'" % (find_array[i]))

                elif '.mp3' in find_array[i]:
                    self.out.append_output("find", str(find_array[i]),
                                           "terminator -e 'mpv %s'" % (find_array[i]))

                elif os.path.isfile(find_array[i]):
                    self.out.append_output("find", str(find_array[i]),
                                           "terminator -e 'vim %s'" % (find_array[i]))

        finally:
            self.out.update_output()


class Function:
    def __init__(self, out):
        self.out = out

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
        try:
            complete = subprocess.check_output("compgen -c %s" % (query),
                                               shell=True, executable="/bin/bash")
            complete = complete.split('\n')

            if len(splittedInput) == 1:
                # Application don't have spaced name.
                # Look for XDG applications of the given name.
                for cmd_num in range(min(len(complete), 5)):
                        xdg_cmd = func.get_xdg_cmd(complete[cmd_num])
                        if xdg_cmd:
                            self.out.append_output('xdg', *xdg_cmd)

        except:
            # if no command exist with the user input
            pass


if __name__ == '__main__':
    out = Output()
    threaded_func = Process_Func(out)
    func = Function(out)

    userInput = ''

    special = {
        "bat": (lambda x: func.get_process_output("acpi", "%s", ""))
    }

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

        # Scan for keywords
        for keyword in special:
            if userInput[0:len(keyword)] == keyword:
                out = special[keyword](userInput)
                if out is not None:
                    out.append_output('keyword', *out)

        if len(splittedInput) == 1:
            # Could be an xdg app
            func.find_xdg(userInput)

        # Could be a command...
        out.append_output("exec", "execute '"+userInput+"'", userInput)

        # Could be bash...
        out.append_output("terminal", "run '%s' in a shell" % (userInput),
                          "terminator -e %s" % (userInput))

        out.update_output()

        # Start threads
        threaded_func.spawn(userInput)
