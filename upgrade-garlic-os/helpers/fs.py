import os
import pathlib

def isPathExist(path):
    if os.path.exists(path):
        return True
    else:
        return False

def isPathWritable(path):
    if os.access(os.path.dirname(path), os.W_OK):
        return True
    else:
        return False

def getVolumePaths(volume, exclude_dirs=[], sort_list=False):
    fs = []

    for dirpath, dirnames, files in os.walk(volume, topdown=True):
        for d in dirnames:
            dirnames[:] = [d for d in dirnames if not d.startswith('.')]
            dirnames[:] = [d for d in dirnames if d not in exclude_dirs]

        for f in files:
            files[:] = [f for f in files if not f.startswith('.')]

        for f in files:
            fs.append(pathlib.Path(volume, dirpath, f))

    if sort_list == True:
        fs.sort(key=str)

    return fs

def getVolumeSize(fpaths):
    return sum(pathlib.Path(f).stat().st_size for f in fpaths)
