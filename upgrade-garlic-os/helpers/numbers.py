from datetime import datetime
from datetime import timezone

def human(num, suffix='B'):
    units = ['', 'K', 'M', 'G', 'T', 'P', 'E', 'Z']
    last_unit = 'Y'
    div = 1000.0

    for unit in units:
        if abs(num) < div:
            return "%3.1f %s%s" % (num, unit, suffix)

        num /= div

    return "%.1f %s%s" % (num, last_unit, suffix)

def getTimestamp():
    return datetime.fromtimestamp(
        datetime.now().timestamp(),
        tz=timezone.utc,
    ).strftime("%Y%m%dT%H%M%SZ")
