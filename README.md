Installation
------------
### Windows
1. git clone --recursive git@github.com:perses76/vim.git vimfiles
2. Compile YouCompleteMe (see YouCompleteMe in Plugins section)


Plugins
-------
### Pathogen
https://github.com/tpope/vim-pathogen<br/>
Manage your 'runtimepath' with ease. In practical terms, pathogen.vim makes it super easy to install plugins and runtime files in their own private directories.

#### CSApprox
http://www.vim.org/scripts/script.php?script_id=2390<br/>
Make gvim-only colorschemes work transparently in terminal vim

#### NERD tree
https://github.com/scrooloose/nerdtree<br/>
A tree explorer plugin for navigating the filesystem

#### YouCompleteMe
https://github.com/Valloric/YouCompleteMe<br/>
A code-completion engine for Vim
##### Windows 7 x64 installation
1. Install YouCompleteMe with pathogen
2. Install Visual Studio 2015 (we need C++ compiler only)
2. Intall cmake (http://www.cmake.org/cmake/resources/software.html)
3. Open Commad Promt for Visual Studio
4. cd %USERPROFILE%
5. mkdir build
6. cd build
7. "%ProgramFiles(x86)%\CMake\bin\cmake.exe" -G "Visual Studio 14 Win64" . %USERPROFILE%\vimfiles\bundle\YouCompleteMe\cpp
8. msbuild /t:ycm_core;ycm_client_support /property:configuration=Release YouCompleteMe.sln
9. copy files from %USERPROFILE%\vimfiles\bundle\YouCompleteMe\Release folder to %USERPROFILE%\vimfiles\bundle\YouCompleteMe\

#### Bufexplorer
https://github.com/jlanzarotta/bufexplorer</br>
Quickly and easily switch between buffers by using the one of the default public interfaces

#### UltiSnips
https://github.com/SirVer/ultisnips</br>
The ultimate snippet solution for Vim

#### Vim-indent-object
https://github.com/michaeljsmith/vim-indent-object</br>
Defines a new text object representing lines of code at the same indent level. Useful for python.

#### CtrlP
https://github.com/kien/ctrlp.vim</br>
Fuzzy file, buffer, mru, tag, etc finder.

#### Vim-surround
https://github.com/tpope/vim-surround<br/>
surround.vim: quoting/parenthesizing made simple

#### Vim-github-colorscheme
https://github.com/endel/vim-github-colorscheme
A vim colorscheme based on Github's syntax highlighting.

#### Syntastic
https://github.com/scrooloose/syntastic<br/>
Syntastic is a syntax checking plugin for Vim that runs files through external syntax checkers and displays any resulting errors to the user. 
NOTE: required flake8 (pip install flake8) for python checker.

#### Vim-python-pep8-indent
https://github.com/hynek/vim-python-pep8-indent
This small script modifies vim’s indentation behavior to comply with PEP8 and my aesthetic preferences.

#### vim-session
https://github.com/xolox/vim-session
The vim-session plug-in improves upon Vim's built-in :mksession command by enabling you to easily and (if you want) automatically persist and restore your Vim editing sessions

Colors
------
#### Github theme
http://www.vim.org/scripts/script.php?script_id=2855<br/>
A gvim colorscheme based on github's syntax highlighting


