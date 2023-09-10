import sys

try:
    import colorama
except:
    False

#-------------------------------------------------------------------------------
# Define color wrappers.

def cerror(message):
    try:
        return colorama.Back.RED + colorama.Fore.WHITE + colorama.Style.BRIGHT + message + colorama.Style.RESET_ALL
    except:
        return message

def cinfo(message):
    try:
        return colorama.Back.BLUE + colorama.Fore.WHITE + colorama.Style.BRIGHT + message + colorama.Style.RESET_ALL
    except:
        return message

def chilite(message):
    try:
        return colorama.Fore.YELLOW + colorama.Style.BRIGHT + message + colorama.Style.RESET_ALL
    except:
        return message

def crun(message):
    try:
        return colorama.Fore.BLACK + colorama.Style.BRIGHT + "[RUN]==> " + message + colorama.Style.RESET_ALL
    except:
        return message

def pr(message):
    print(message, file=sys.stderr)
