" Basic Settings
syntax on
set number
highlight LineNr ctermfg=yellow
set mouse=a

" Indentation Settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Search Settings
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase

" UI Settings
set clipboard=unnamedplus
set ruler
set scrolloff=8
set sidescrolloff=8

" File Type Settings
filetype plugin on
filetype indent on

" Color Scheme
colorscheme slate

" Compilation Settings for C files
autocmd FileType c setlocal makeprg=gcc\ -Wall\ -Wextra\ %\ -o\ %<

" Custom Compile and Run Command
command! CompileAndRun w | !clear && gcc -Wall -Wextra % -o %< && ./%<

" Key Mappings
" Note: <C-c> might conflict with terminal interrupt, consider using <F5> instead
nnoremap <C-j> :CompileAndRun<CR>
" Alternative mapping that keeps <C-c> if preferred
" nnoremap <C-c> :CompileAndRun<CR>
