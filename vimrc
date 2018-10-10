set nocompatible
let mapleader = ","


call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-syntastic/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'michaeljsmith/vim-indent-object'
if has('win64')
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --msvc 14' }
else
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
endif
Plug 'vim-scripts/indentpython.vim'

call plug#end()

map <Leader><Leader> <Plug>(easymotion-s)

syntax enable

set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " show line numbers
set relativenumber        " always show relative line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set encoding=utf-8
set fileencodings=utf-8
set laststatus=2

set expandtab
set noswapfile  " no swap files
set autowriteall " Automatically save file on buffer change

set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
set splitright
set splitbelow

" usetab - if buffer with file existed, then open it, otherwise open new tab
" newtab - open new tab for quickfix windows.
" set switchbuf+=usetab,newtab

" import my custom utils for common using
" source ~\vimfiles\my_utils.vim

filetype plugin indent on
au FileType yaml setl sw=2 sts=2 et
au FileType python setl sw=4 sts=4 et
autocmd FileType python nnoremap <buffer> <C-]> :rightbelow vertical YcmCompleter GoTo<CR>
autocmd FileType python nnoremap <buffer> <S-k> :YcmCompleter GetDoc<CR>


command! RemoveTrailingWhitespace :%s/\s\+$//e
command! FormatJson :%!python -m json.tool
command! Vimrc :tabnew $MYVIMRC



function! PythonCurrentFile()
python << endpython
import vim
# do important stuff
print('test')
# vim.command("return 1") # return from the Vim function!
endpython
endfunction


" change the font depending of OS and terminal type
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h9:cANSI
  endif
endif


if &term =~ "xterm"
  " 256 colors
  let &t_Co = 256
  hi CursorLine ctermbg=251

endif

colorscheme github

if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal
endif


" TABLINE BEGIN ----------------------------------------
if has('gui')
  set guioptions-=e
endif
if exists("+showtabline")
  function! MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let s .= i . ':'
      let s .= winnr . '/' . tabpagewinnr(i,'$')
      let s .= ' %*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
        let file = '[No Name]'
      endif
      let s .= file
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=2
  set tabline=%!MyTabLine()
endif
" TABLINE END ------------------------------------------

" ------------------------------------------------------------------------------------
" PLUGINS SETTINGS

" YouCompleteMe
let g:ycm_python_binary_path = 'python'
let g:ycm_python_interpreter_path = 'python'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_goto_buffer_command = 'split'

" UltiSnips
let g:UltiSnipsEditSplit="vertical"  " If you want :UltiSnipsEdit to split your window.

let g:UltiSnipsSnippetsDir = "~/vimfiles/UltiSnips"
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" NERDTree
let NERDTreeIgnore = ['\.pyc$']

" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! OpenNERDTreeAndSync()
    NERDTreeFind
    wincmd p
endfunction

nnoremap <Leader>n :call OpenNERDTreeAndSync()<CR>

" Syntactic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l/%L:%c


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']


" Last command ---------------------------------
" Save last command and run it later
function! LastCommandPop()
    return g:last_command
endfunction

function! LastCommandPush(cmd)
    let g:last_command = a:cmd
endfunction

function! LastCommandRun()
    let cmd = LastCommandPop()
    execute cmd
endfunction

function! LastCommand(cmd)
    call LastCommandPush(a:cmd)
    call LastCommandRun()
endfunction

nnoremap <Leader>r : call LastCommandRun()<CR>
inoremap <Leader>r : <ESC> call LastCommandRun()<CR>
command! -nargs=1 LastCommand call LastCommand(<f-args>)


" PLIGINS SETTINGS END
"-----------------------------------------------------------------------------------
if filereadable('.idea/vimrc')
	source .idea/vimrc
endif

