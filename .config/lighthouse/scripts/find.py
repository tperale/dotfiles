#!/usr/bin/python2
import subprocess
import sys
import os
import mimetypes
import argparse


def find(queryList, settings):
    """
    Little fuzzy finder implementation that work with a bash command,
    it also work different according to filetype.
    """
    command = ["| grep %s " % (elem) for elem in queryList.split()]
    command = " ".join(command)

    user = os.path.expanduser('~')

    try:
        find_array = subprocess.check_output('find %s %s' % (user, command),
                                             shell=True,
                                             executable='/bin/sh').split('\n')

    except Exception:
        # When 'find' output nothing.
        return "{No path found.| %s }" % settings.term

    else:
        res = ''
        find_array.sort(key=len)
        if len(find_array[0]) == 0:
            find_array.pop(0)

        for i in xrange(min(settings.number_of_output, len(find_array))):
            clearedOut = find_array[i].strip().replace(' ', '\\ ').replace('\n', ' ')
            # Path with space don't work.

            mime_type = subprocess.check_output("file --mime-type -b %s" % clearedOut,
                                                shell=True,
                                                executable='/bin/sh')
            if os.path.isdir(find_array[i]):
                # 'foo bar' is considered as a folder in python
                # but 'foo\ bar' is not.
                dirFile = " " + "%N ".join(os.listdir(str(find_array[i])))
                if len(dirFile):
                    res += "{%s |%s --working-directory=%s |%%CFiles in directory%%%%L%s}" % (str(find_array[i]), settings.term, clearedOut, dirFile)
                else:
                    res += "{%s |%s --working-directory=%s |%%CFiles in directory%%}" % (str(find_array[i]), settings.term, clearedOut)
            elif mime_type and "image" in mime_type:
                res += "{%s |xdg-open '%s'|%%CPreview%%L%%I%s%%%%}" % (
                    str(find_array[i]), str(find_array[i]), clearedOut)

            elif mime_type and "text" in mime_type:
                preview_file = open(clearedOut)
                preview_text = str()
                for x in range(15):
                    preview_text += preview_file.readline().replace("\n", "%N")
                if len(preview_text):
                    res += "{%s |xdg-open %s|%%CPreview%%%%L%s}" % (str(find_array[i]), clearedOut, preview_text)
                else:
                    res += "{%s |xdg-open %s|%%CNo preview%%}" % (str(find_array[i]), clearedOut)
                preview_file.close()

            else:
                # Check for every file extension the user specified in the
                # begining of this script file

                res += "{%s |xdg-open %s|%%C%s%%}" % (
                    str(find_array[i]), str(find_array[i]), mime_type)

        return res

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("query")
    parser.add_argument("--number_of_output", default=3, type=int)
    parser.add_argument("--term", default="urvxt", type=str)
    settings = parser.parse_args()
    print("{%CFind%}" + find(settings.query, settings))
