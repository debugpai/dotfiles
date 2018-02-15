"============================== PLUGINS =============================="
call plug#begin('~/.vim/plugged')

	Plug 'joshdick/onedark.vim'
  Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-surround'
  Plug 'benekastah/neomake'
  " Plug 'ntpeters/vim-better-whitespace'
  Plug 'Raimondi/delimitMate'
  Plug 'tpope/vim-commentary'
  Plug 'othree/es.next.syntax.vim'
  " Plug 'mxw/vim-jsx'
  Plug 'othree/html5.vim' 
  Plug 'ssh://git.booking.com/gitroot/devtools/vim-booking.git'

call plug#end()

"nerdtree
  nnoremap <C-n> :NERDTreeToggle<Enter>
  let NERDTreeQuitOnOpen = 1
  let NERDTreeAutoDeleteBuffer = 1
  let NERDTreeMinimalUI = 1

"ctrlp
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|build)$',
    \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
  \ }
  let g:ctrlp_open_multiple_files = 'ir'
  let g:ctrlp_working_path_mode = 'w'

"airline
  let g:airline#extensions#tabline#enabled = 1
  set laststatus=2
  let g:airline_section_y = ''
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_section_warning = ''

"vim-easymotion
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  nmap s <Plug>(easymotion-s2)

"neomake
  let g:neomake_open_list = 2
  let g:neomake_list_height = 3
  let g:neomake_error_sign = {
    \ 'text': '✖>',
    \ 'texthl': 'SignifySignDelete',
  \ }

  if findfile('.eslintrc.yml', '.;') !=# ''
    let g:neomake_javascript_eslint_exe =  $PWD . '/node_modules/.bin/eslint'
    let g:neomake_javascript_enabled_makers = ['eslint']
		let g:neomake_jsx_enabled_makers = ['eslint']
  endif

  if findfile('.stylelintrc.yml', '.;') !=# ''
		let g:neomake_css_stylelint_maker = {
		\ 'errorformat':
            \ '%+P%f,' .
                \ '%*\s%l:%c  %t  %m,' .
            \ '%-Q',
		\ 'exe': $PWD . '/node_modules/.bin/stylelint'
    \ }
    let g:neomake_css_enabled_makers = ['stylelint']
  endif

  autocmd! BufWritePost * Neomake


"better-whitespace
  " autocmd! BufWritePre * StripWhitespace

"delimitMate
  let delimitMate_expand_cr = 1
  let delimitMate_expand_space = 1

"vim-jsx
  " let g:jsx_ext_required = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
	" bind \ (backward slash) to grep shortcut
	command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
	nnoremap \ :Ag<SPACE>
endif

"============================== GENERAL =============================="

"automatic reloading of .vimrc
  autocmd! bufwritepost .vimrc so % | AirlineRefresh

"colorscheme
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set background=dark
	let g:onedark_termcolors=16
  colorscheme onedark

"settings
  let mapleader="\<Space>"
  syntax enable
  set spelllang=en
  set nowrap
  set timeoutlen=500 ttimeoutlen=0
  set history=1000
  set undolevels=1000
  " set number
  set relativenumber
	set nocursorline
  set nocursorcolumn
	set noshowcmd
  set nolazyredraw
  set ttyfast
  set scrolloff=5
	set showmatch
  filetype plugin indent on

"stay vmode on indent
  vnoremap < <gv
  vnoremap > >gv

"disable swap files
  set nobackup
  set noswapfile

"code indenting
  set tabstop=2
  set softtabstop=0
  set shiftwidth=2
  set expandtab
  set shiftround
  set smartindent

"search settings
  set hlsearch
  set ignorecase
  set smartcase
  set incsearch

"buffer
  set hidden
  nnoremap <Leader>l :bnext<Enter>
  nnoremap <Leader>h :bprevious<Enter>
  nnoremap <Leader>q :bd <Bar> bprevious<Enter>
  au FocusLost,BufLeave * :silent! wa
  au FocusGained,BufEnter * :silent! !

"mouse
	set mouse=a

"vmode clipboard copy
	vnoremap y :y*<Enter>

"paste mode toggle
  set pastetoggle=<F2>

" <TAB>: completion.
imap <silent><expr> <TAB>
            \ <SID>check_back_space() ? "\<TAB>" :
            \ "<C-n>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || strpart(getline('.'), 0, col) =~ '^\s*$'
endfunction
 
" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>":
