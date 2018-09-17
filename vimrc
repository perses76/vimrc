set nocompatible
let mapleader = ","


call plug#begin('C:\Users\Vadim\vimfiles\plugged')

Plug 'easymotion/vim-easymotion'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-syntastic/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

call plug#end()


let g:ycm_autoclose_preview_window_after_completion = 1


syntax enable

set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
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

" import my custom utils for common using
" source ~\vimfiles\my_utils.vim


filetype plugin indent on
au FileType yaml setl sw=2 sts=2 et
au FileType python setl sw=4 sts=4 et
autocmd FileType python nnoremap <buffer> <C-]> :YcmCompleter GoTo<CR>
autocmd FileType python nnoremap <buffer> <S-k> :YcmCompleter GetDoc<CR>

nnoremap <Leader>d :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>D :YcmCompleter GoToDeclaration<CR>
nnoremap <F5> :Pyrun<CR>

command! Pyrun execute "wa | ! python run_tests.py test_like_comment.py"
command! RemoveTrailingWhitespace :%s/\s\+$//e
command! FormatJson :%!python -m json.tool



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

colorscheme github
hi normal ctermbg=white guibg=white

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
" let g:ycm_python_binary_path = 'C:\Users\Vadim\Projects\QuantifiedSkin\webapi\envs\webapi1\Scripts\python.exe'

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
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']


" PLIGINS SETTINGS END
"-----------------------------------------------------------------------------------
if filereadable('.exrc/vimrc')
	source .exrc/vimrc
endif

