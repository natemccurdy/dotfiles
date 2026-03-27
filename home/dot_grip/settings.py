def find_token():
    import subprocess
    import re
    cmd = ['security', 'find-generic-password', '-gs', 'grip_github_token']
    pwinfo = subprocess.Popen(cmd, stdout = subprocess.PIPE,
            stderr = subprocess.PIPE)
    pwline = pwinfo.stderr.read().strip()
    return re.sub('password: "(.*)"', '\\1', pwline)


# username needs to be an empty string: https://github.com/joeyespo/grip/issues/221
USERNAME = ''
PASSWORD = find_token()
