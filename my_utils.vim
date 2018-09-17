function! ActivateVirutalEnv(path)
python << endpython
import vim
import sys
import os

path = vim.eval("a:path")

with open(path) as fo:
    f = fo.read()

code = compile(f, path, 'exec')
exec(code, dict(__file__=path))
print('Virtual environment activated!')
endpython
endfunction

