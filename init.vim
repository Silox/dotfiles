" Load up {{{
set nocompatible
filetype off
set rtp+=/usr/local/opt/fzf

" }}}
" Bundles {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'fugitive.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
call plug#end()

filetype plugin indent on

call deoplete#enable()
" }}}
" Leader {{{

let mapleader=','
let maplocalleader=','

" }}}
" Plugin settings {{{
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
nnoremap <leader>gt :Gstatus<cr>

let NERDTreeIgnore = ['\.pyc$', '\.hi', '\.o']

let g:Powerline_symbols = 'fancy'
let g:haddock_browser="open"

let g:pymode_options_max_line_length = 120
let g:pymode_rope = 0

" }}}
" General options {{{
set number
set ruler
syntax on
set autoindent
set smartindent
set encoding=utf-8
set backspace=indent,eol,start
set modelines=0
set laststatus=2
set showcmd
if v:version > 703
  set undofile
  set undoreload=10000
  set undodir=~/.vim/tmp/undo/     " undo files
endif
set splitright
set splitbelow
set autoread " auto reload file on change

set scrolloff=8 "keep 8 lines below/above cursor
" }}}
" Colorscheme {{{
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_contrast="normal"
let g:solarized_underline=0
let g:solarized_termtrans=0
syntax enable
set background=dark
colorscheme solarized

let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
" }}}
" Wrapping {{{
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list
set listchars=tab:\ \ ,trail:·

function! s:setupWrapping()
  setlocal wrap
  setlocal wrapmargin=2
  setlocal textwidth=80
  if v:version > 703
    setlocal colorcolumn=+1
  endif
endfunction

" }}}
" Searching and movement {{{
" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Easier to type, and I never use the default behavior. <3 sjl
noremap H ^
noremap L g_
" }}}
" Backups and undo {{{
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files
set backup                       " enable backups
set backupskip=/tmp/*,/private/tmp/*"
" }}}
" Folding {{{
set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . ' ' . repeat(" ",fillcharcount) . ' ' . foldedlinecount . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" I hate K {{{
nnoremap K <nop>
" }}}
" Filetype specific {{{
" Markdown {{{

augroup ft_markdown
  au!

  au BufNewFile,BufRead *.m*down setlocal filetype=markdown
  au BufNewFile,BufRead *.md setlocal filetype=markdown
  au Filetype markdown call s:setupWrapping()

  " Use <localleader>1/2/3 to add headings.
  au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
  au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
  au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
augroup END
" }}}
" C# {{{
augroup c_sharp
  au!
  au Filetype cs setlocal ts=4 sw=4 sts=4
augroup END
" }}}
" C {{{
augroup c_lang
  au!
  au Filetype cpp setlocal ts=2 sw=2 sts=2
  au Filetype c setlocal ts=2 sw=2 sts=2
augroup END
" }}}
" Haskell {{{
augroup haskell
  au!
  au Filetype haskell setlocal ts=4 sw=4 sts=4
  au FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END
" }}}
" JavaScript {{{
augroup javascript
  au!
  au Filetype javascript setlocal ts=4 sw=4 sts=4

augroup END
" }}}
" Java {{{
au BufRead *.scala set ft=java
augroup java
  au!
  au Filetype java setlocal ts=4 sw=4 sts=4
  au BufRead *.g4 set ft=java

augroup END
" }}}
" Latex {{{
augroup ft_latex
  au!

  au Filetype tex call s:setupWrapping()
  au Filetype tex setlocal spell

augroup END
" }}}
" Python {{{
augroup ft_python
  au!

  au BufRead *.py3 set ft=python
  au FileType python setlocal ts=4 sw=4 sts=4
  au FileType python setlocal wrap wrapmargin=2 textwidth=80 colorcolumn=+1

augroup END
" }}}
" Ruby {{{
augroup ft_ruby
  au!

  au FileType ruby call s:setupWrapping()

augroup END
" }}}
" Nginx {{{
augroup ft_nginx
  au!

  au FileType nginx setlocal ts=4 sts=4 sw=4

augroup END
" }}}
" Prolog {{{
  au BufRead *.pl set ft=prolog
" }}}
" Php {{{
  au BufRead *.inc setlocal ts=2 sw=2 sts=2
  au BufRead *.inc set ft=php
  au BufRead *.module setlocal ts=2 sw=2 sts=2
  au BufRead *.module set ft=php
  au BufRead *.php5 setlocal ts=2 sw=2 sts=2
  au BufRead *.php5 set ft=php
" }}}
" HTML {{{
  au BufRead *.html setlocal ts=2 sw=2 sts=2
  au BufRead *.html set ft=html
" }}}
" TLA {{{
  au BufRead *.tla set ft=tla
  au BufRead *.cfg set ft=tlacfg
" }}}
" }}}
" Mappings {{{
nnoremap <silent> <C-l> :noh<CR><C-L>
" edit and source vimrc easily
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>

" rewrite file with sudo
cmap w!! w !sudo tee % >/dev/null
nnoremap _md :set ft=markdown<CR>

" open shell
nnoremap <leader>sh :VimShellPop<CR>

nnoremap <leader><leader> :FZF<CR>
" }}}
" Tab completion for commands {{{
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
" }}}
" some autocommands {{{
augroup unrelated_au
  au!

  " function to remove trailing whitespace without moving to it
  function! s:removeTrailingWhitespace()
    normal! ma
    :%s/\s\+$//e
    normal! `a
  endfunction

  " Remove trailing whitespace
  autocmd BufWritePre * :call s:removeTrailingWhitespace()

  " Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

  " json == javascript
  au BufNewFile,BufRead *.json set ft=javascript

  au BufRead {.vimrc,vimrc} set foldmethod=marker

  au BufRead /etc/nginx/* set ft=nginx

augroup END
"}}}
" Relative number toggle {{{
function! ToggleNumberRel()
  if &relativenumber
    setlocal number
  else
    setlocal relativenumber
  endif
endfunction

" Quickly toggle between relativenumber and number
noremap <leader>rr :call ToggleNumberRel()<CR>
" }}}
" Ignore patterns {{{
  " Don't display these kinds of files

  " Nerdtree {{{
  let NERDTreeIgnore=['\~$', '\.pyc', '\.swp$', '\.git', '\.hg', '\.svn',
        \ '\.ropeproject', '\.o', '\.bzr', '\.ipynb_checkpoints$',
        \ '__pycache__',
        \ '\.egg$', '\.egg-info$', '\.tox$', '\.idea$', '\.sass-cache',
        \ 'env$', '\.env$', '\.env[0-9]$', '\.coverage$', '\.tmp$', '\.gitkeep$',
        \ '\.coverage$', '\.webassets-cache$', '\.vagrant$', '\.DS_Store',
        \ '\.env-pypy$']
  " }}}

  " Vimfiler {{{
  let g:vimfiler_ignore_pattern='\%(.ini\|.sys\|.bat\|.BAK\|.DAT\|.pyc\|.egg-info\)$\|'.
    \ '^\%(.gitkeep\|.coverage\|.webassets-cache\|.vagrant\|)$\|'.
    \ '^\%(env\|.env\|.ebextensions\|.elasticbeanstalk\|Procfile\)$\|'.
    \ '^\%(.git\|.tmp\|__pycache__\|.DS_Store\|.o\|.tox\|.idea\|.ropeproject\)$'
  " }}}

  " Wildignore {{{
  set wildignore=*.o,*.obj,*~,*.pyc "stuff to ignore when tab completing
  set wildignore+=env
  set wildignore+=.env
  set wildignore+=.env[0-9]+
  set wildignore+=.env-pypy
  set wildignore+=.git,.gitkeep
  set wildignore+=.tmp
  set wildignore+=.coverage
  set wildignore+=*DS_Store*
  set wildignore+=.sass-cache/
  set wildignore+=__pycache__/
  set wildignore+=.webassets-cache/
  set wildignore+=vendor/rails/**
  set wildignore+=vendor/cache/**
  set wildignore+=*.gem
  set wildignore+=log/**
  set wildignore+=tmp/**
  set wildignore+=.tox/**
  set wildignore+=.idea/**
  set wildignore+=.vagrant/**
  set wildignore+=.coverage/**
  set wildignore+=*.egg,*.egg-info
  set wildignore+=*.png,*.jpg,*.gif
  set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
  set wildignore+=*/.nx/**,*.app
  " }}}

  " Netrw {{{
  let g:netrw_list_hide='\.o,\.obj,*~,\.pyc,' "stuff to ignore when tab completing
  let g:netrw_list_hide.='\.env,'
  let g:netrw_list_hide.='\env,'
  let g:netrw_list_hide.='\.env[0-9].,'
  let g:netrw_list_hide.='\.env-pypy'
  let g:netrw_list_hide.='\.git,'
  let g:netrw_list_hide.='\.gitkeep,'
  let g:netrw_list_hide.='\.vagrant,'
  let g:netrw_list_hide.='\.tmp,'
  let g:netrw_list_hide.='\.coverage$,'
  let g:netrw_list_hide.='\.DS_Store,'
  let g:netrw_list_hide.='__pycache__,'
  let g:netrw_list_hide.='\.webassets-cache/,'
  let g:netrw_list_hide.='\.sass-cache/,'
  let g:netrw_list_hide.='\.ropeproject/,'
  let g:netrw_list_hide.='vendor/rails/,'
  let g:netrw_list_hide.='vendor/cache/,'
  let g:netrw_list_hide.='\.gem,'
  let g:netrw_list_hide.='\.ropeproject/,'
  let g:netrw_list_hide.='\.coverage/,'
  let g:netrw_list_hide.='log/,'
  let g:netrw_list_hide.='tmp/,'
  let g:netrw_list_hide.='\.tox/,'
  let g:netrw_list_hide.='\.idea/,'
  let g:netrw_list_hide.='\.egg,\.egg-info,'
  let g:netrw_list_hide.='\.png,\.jpg,\.gif,'
  let g:netrw_list_hide.='\.so,\.swp,\.zip,/\.Trash/,\.pdf,\.dmg,/Library/,/\.rbenv/,'
  let g:netrw_list_hide.='*/\.nx/**,*\.app'
  " }}}

" }}}
" Fancy selectors {{{
  vnoremap > >gv
  vnoremap < <gv
" }}}
" NERDCommenter {{{
  let NERDSpaceDelims = 1
" }}}

" for some reason vim searches for something
:noh
