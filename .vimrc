auto BufEnter * let &titlestring = "vim"

if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif


if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_install
    au!
    au! VimEnter * PlugInstall
  augroup END
endif


" PLUGINS {{{
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'
Plug 'kana/vim-surround'
" Plug 'jiangmiao/auto-pairs'  ", { 'on': 'PAIRSToggle' }
" Plug 'w0rp/ale' ", { 'on': 'ALEToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rakr/vim-one'
Plug 'airblade/vim-rooter'
Plug 'liuchengxu/vim-which-key'
" Plug 'ycm-core/YouCompleteMe' ", { 'on': 'YCMToggle' }
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'yegappan/lsp'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'


" JS {{{
" Plug 'pangloss/vim-javascript', {'for': 'javascript' }
" Plug 'styled-components/vim-styled-components', { 'branch': 'main', 'for': ['javascript','typescript','css','html'] }
" }}}
" PYTHON {{{
" Plug 'davidhalter/jedi-vim', {'for': 'python'}   " jedi for python
" Plug 'tmhedberg/SimpylFold', {'for': 'python'}  " for nice python folding
" }}}
call plug#end()
" }}}

" SETTINGS {{{
let g:is_bash=1
set shell=$SHELL
if &compatible
  set nocompatible
endif
syntax on
filetype plugin indent on
scriptencoding utf-8
packadd! termdebug


set nowrap " textwidth=79 " colorcolumn=80
set autochdir
set autoindent smartindent
set autoread
set backspace=indent,eol,start
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,gb18030,gb2312,default,latin1
set fileformats=unix,dos,mac
set fillchars=diff:⣿,vert:│
set gcr=a:blinkon0
set hidden
set history=700
set hlsearch incsearch ignorecase smartcase
set laststatus=2
set lazyredraw
set list lcs=tab:\ \ ,extends:›,precedes:‹,nbsp:·,trail:·
set listchars=eol:$,tab:>-,trail:·,extends:❯,precedes:❮
set magic
set matchpairs+=<:>            " Highlight <>.
set matchtime=2
set mouse=
set nobackup nowritebackup noswapfile
set noeb vb
set nojoinspaces
set number relativenumber ruler
set pastetoggle=<F2>
set path+=**
set shortmess=atI
set showcmd showmode
set cmdheight=1
set showmatch
set spelllang=en,ru,pl,ua
set synmaxcol=800
set tags=tags;/,codex.tags;/ " look for tags in current dir and up and
set ts=4 sts=4 sw=4 noexpandtab smarttab
set ttimeoutlen=0
set undolevels=1000
set updatetime=300
" set modeline
" set modelines=5
set nomodeline
set foldlevelstart=0
set nofoldenable

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif

if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
set clipboard+=unnamedplus


" highlight line and column
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline nocursorcolumn
set cursorline nocursorcolumn

set sessionoptions=blank,buffers,curdir,folds,help,localoptions,tabpages,winsize
set switchbuf=useopen,usetab
" }}}

" STATUSLINE {{{
" function! LinterStatus() abort
" 	let l:counts = ale#statusline#Count(bufnr(''))
" 	let l:all_errors = l:counts.error + l:counts.style_error
" 	let l:all_non_errors = l:counts.total - l:all_errors

" 	return l:counts.total == 0 ? 'OK' : printf(
" 	\   '%dW %dE',
" 	\   all_non_errors,
" 	\   all_errors
" 	\)
" endfunction

if has('statusline')
    set statusline=%<%f\    " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=\ [%{&ff}/%Y]            " filetype
    set statusline+=\ [%{getcwd()}]          " current dir
    set statusline+=\ %{fugitive#statusline()} "  Git Hotnes
    " set statusline+=\ %{LinterStatus()}
    set statusline+=%*
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif
"}}}
" WILDIGNORE {{{
set wildignorecase
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*~
set wildignore+=*.so,*.swp
set wildignore+=*.gem,*.rbc,*.class
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=__pycache__,*.pyc,*.luac
set wildignore+=.hg,.git,.svn
set wildignore+=*.o,*.obj,*.su,*.dll,*.manifest
set wildignore+=*.spl,*.sw?
set wildignore+=migrations,*.orig,*.class
set wildignore+=*vim/backups*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=log/**
set wildignore+=tmp/**,*/tmp/*
"}}}
" AUTOCMD {{{
autocmd FileType python,javascript,typescript,json setlocal ts=4 sw=4 sts=4 expandtab autoindent
autocmd FileType php,snippets setlocal ts=4 sw=4 sts=4 noexpandtab
autocmd FileType html,xhtml setlocal ts=2 sts=2 sw=2
autocmd FileType make setlocal ts=4 sts=2 sw=2 noexpandtab
autocmd FileType yaml setlocal ts=2 sw=2 sts=2 expandtab

autocmd FileType yaml,vim setlocal foldmethod=marker
autocmd FileType yaml,vim setlocal foldmarker={{{,}}}
autocmd FileType yaml,vim setlocal foldlevel=20
autocmd FileType yaml,vim normal zR

autocmd FileType sh,awk,c,cpp,hpp,h,java,javascript,typescript,json,css,php,conf setlocal foldmethod=marker
autocmd FileType sh,awk,c,cpp,hpp,h,java,javascript,typescript,json,css,php,conf setlocal foldmarker={,}
autocmd FileType sh,awk,c,cpp,hpp,h,java,javascript,typescript,json,css,php,conf setlocal foldlevel=20
autocmd FileType sh,awk,c,cpp,hpp,h,java,javascript,typescript,json,css,php,conf normal zR

autocmd FileType html,xhtml,xml,haml,jst setlocal foldmethod=indent
autocmd FileType html,xhtml,xml,haml,jst setlocal foldlevel=20
autocmd FileType html,xhtml,xml,haml,jst normal zR

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable comment new line
autocmd FileType * setlocal foldlevel=20
autocmd FileType * norm zR

autocmd BufRead,BufNewFile,BufEnter * norm zR

" autocmd BufWritePost *.js,*.jsx AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
autocmd BufWritePost *aliasrc,*bashrc,*bash_prompt !source %
" autocmd BufWritePost *vimrc :source % " take to much time to reload
autocmd BufWritePost *tmux.conf !tmux source-file %

"autocmd FileType cpp,java setlocal equalprg=astyle\ -A1sCSNLYpHUEk1xjcn
autocmd FileType python setlocal makeprg=pylint
autocmd FileType python setlocal formatprg=autopep8\ -
"autocmd FileType c setlocal commentstring=//\ %s
"autocmd FileType cpp setlocal commentstring=//\ %s

autocmd BufEnter * syntax match Type /\v\.[a-zA-Z0-9_]+\ze(\[|\s|$|,|\]|\)|\.|:)/hs=s+1
autocmd BufEnter * syntax match pythonFunction /\v[[:alnum:]_]+\ze(\s?\()/
hi def link pythonFunction Function
autocmd BufEnter * syn match Self "\(\W\|^\)\@<=self\(\.\)\@="
highlight self ctermfg=239

au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
au BufNewFile,BufRead *.js setlocal filetype=javascript
au BufNewFile,BufRead *.jsx setlocal filetype=javascript.jsx
"}}}
" KEYMAPPING {{{
nnoremap <bs> <nop>
nnoremap <delete> <nop>
nnoremap <Space> <nop>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor


let mapleader=","
let g:mapleader = ","
map <space> <leader>

nmap Q q

" Allows to go throw wrapped lines
nnoremap <silent> j gj
vnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> k gk


" jk is now esc
"inoremap jk <esc>
"cnoremap jk <esc>
"vnoremap jk <esc>

" Move blocks of text around
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

nnoremap <leader>sudo :w !sudo tee % <CR><CR>
nnoremap <silent><nowait> <leader>q :q<CR>
nnoremap <silent><nowait> <leader>w :w<CR>
nnoremap <silent><nowait> <leader>x :q!<CR>

nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l


" yy to yank whole line
nnoremap yy Y
nnoremap Y y$

" searching will keep cursor on middle of screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Make shifting indent in visual mode not removing the visual selection
vnoremap > >gv
vnoremap < <gv

" upper/lower first char of word
nnoremap <leader>u mQviwU`Q
nnoremap <leader>d mQviwu`Q
nnoremap <leader>U mQgewvU'Q
nnoremap <leader>D mQgewvu'Q

" select all text in current buffer
" nnoremap <leader>a ggVG

" Format entire file
nnoremap <leader>= ggVG=

" jump to matching pair
" nnoremap <Leader>m %

" Visually select the text that was last edited/pasted
nnoremap gV `[v`]

nnoremap <silent><nowait> <leader>bn :bn<cr>
nnoremap <silent><nowait> <leader>bp :bp<cr>
nnoremap <silent><nowait> <leader>bd :bdelete<cr>
" nnoremap <leader>bb :buffers<cr>:buffer
"}}}
" PLUGIN KEYBINDS {{{
" nnoremap   <silent>   g            :WhichKey 'g'<CR>
" nnoremap   <silent>   <leader>     :WhichKey ','<CR>
nnoremap   <silent>   <leader>.    :GFiles<cr>
nnoremap   <silent>   <leader>,    :Files<cr>
nnoremap   <silent>   <leader>ff   :Rg<cr>
nnoremap   <silent>   <leader>ft   :Tags<cr>
nnoremap   <silent>   <leader>bb   :Buffers<cr>
" nnoremap              <C-f>        :Tab /
"}}}
" AUTO-PAIRS {{{
let g:AutoPairsCenterLine=1
let g:AutoPairsMapSpace=1
let g:AutoPairsFlyMode=0
"}}}
" ALE {{{
 " let g:ale_linters = {
 " \'python': ['mypy', 'ruff'],
 " \'bib': 'all',
 " \'bash': 'all',
 " \'sh': 'all',
 " \'vim': 'all',
 " \'latex': 'all',
 " \'tex': 'all',
 " \'text': 'all',
 " \'markdown': 'all',
 " \'javascript': 'all'
 " \}
 " let g:ale_fixers = {
 " \'*': ['remove_trailing_lines', 'trim_whitespace'],
 " \'python': ['ruff', 'add_blank_lines_for_python_control_statements'],
 " \'bash': 'shfmt',
 " \'sh': 'shfmt',
 " \'javascript': 'eslint'
 " \}

" let g:ale_list_window_size = 6
" let g:ale_sign_column_always = 0
" let g:ale_open_list = 1
" let g:ale_keep_list_window_open = 0
" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_save = 1
" let g:ale_completion_enabled=0

" " Options are in .pylintrc!
" highlight VertSplit ctermbg=253
" highlight ALEWarning cterm=underline
" highlight ALEError cterm=underline
" highlight ALEWarning ctermfg=Yellow cterm=underline
" highlight ALEError ctermfg=Red cterm=underline

" nmap <silent> <C-M> <Plug>(ale_previous_wrap)
" nmap <silent> <C-m> <Plug>(ale_next_wrap)
"}}}
" ROOTER {{{
let g:rooter_targets = '/,*'
let g:rooter_patterns = ['Makefile', '.clangd', '.git', '*.sln', 'build/env.sh', 'setup.sh', 'node_modules']
" }}}
" JEDI {{{
"" let g:python_host_prog= '/usr/bin/python'
"" let g:python3_host_prog= '/usr/bin/python3'
"let g:jedi#auto_initialization = 1
"let g:jedi#completions_enabled = 1
"let g:jedi#popup_on_dot = 1
"let g:jedi#auto_vim_configuration = 0
"let g:jedi#smart_auto_mappings = 0
"let g:jedi#show_call_signatures = "1"
"let g:jedi#show_call_signatures_delay = 0
"let g:jedi#use_tabs_not_buffers = 0
"let g:jedi#show_call_signatures_modes = 'ni'
"let g:jedi#enable_speed_debugging=0
"" 
"" let g:jedi#goto_command = "<leader>d"
"" let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = "<leader>v"
"" let g:jedi#documentation_command = "<leader>c"
"let g:jedi#usages_command = "<leader>n"
"" let g:jedi#completions_command = "C-Space"
"" let g:jedi#rename_command = "<leader>r"
"}}}
" COMPLETION {{{


if executable('global')
	" Omni completion using GNU GLOBAL
	let s:global_command   = 'global'
	let s:min_len_invoke   = 1  " trigger after this many chars
	let s:split_char       = "\n"

	function! GtagsOmniComplete(findstart, base) abort
		if a:findstart
			let l:line  = getline('.')
			let l:start = col('.') - 1

			while l:start > 0 && l:line[l:start - 1] =~# '\w'
				let l:start -= 1
			endwhile

			" echom '--- Omni Debug ---'
			" echom 'findstart: ' . a:findstart
			" echom 'base: ' . a:base
			" echom 'line: "' . l:line . '"'
			" echom 'computed start: ' . l:start
			" echom 'substring from start: "' . strpart(l:line, l:start, col('.') - l:start) . '"'
			" echom '--------------------'

			" No word under cursor
			if l:start == col('.') - 1
				return -1
			endif

			return l:start
		else
			if empty(a:base) || strlen(a:base) < s:min_len_invoke
				return []
			endif

			let l:raw = systemlist(s:global_command . ' -ic ' . shellescape(a:base))
			call filter(l:raw, 'v:val !=# ""')
			call map(l:raw, "{'word': v:val, 'menu': 'gtags'}")

			return l:raw
		endif
	endfunction


	function! s:FzfGlobalRefs()
		let l:word = expand('<cword>')
		let l:lines = systemlist('global -rti ' . shellescape(l:word))

		if empty(l:lines)
			echo "No results"
			return
		endif

		" " If only one match, open directly
		" if len(l:lines) == 1
		" 	call s:open_file_at_line(l:lines[0])
		" 	return
		" endif

		let l:preview = "tail -n +{3} {2} | head -n 10"

		call fzf#run(fzf#wrap({
					\ 'source': l:lines,
					\ 'sink':   function('s:open_file_at_line'),
					\ 'options': '--prompt "global> " --delimiter="\t" --preview ' .shellescape(l:preview) . ' --preview-window=up:60%',
					\ 'window': { 'width': 0.9, 'height': 0.8, 'relative': v:true, 'yoffset': 0.5 }
					\ }))
	endfunction

	function! s:open_file_at_line(selected)
		let l:parts = split(a:selected, '\t')
		if len(l:parts) < 3
			echo "Invalid line: " . a:selected
			return
		endif
		let l:file = l:parts[1]
		let l:lnum = l:parts[2]

		normal! m'
		execute 'edit' fnameescape(l:file)
		execute l:lnum
	endfunction

	function! s:open_file(selected)
	  execute 'edit' fnameescape(a:selected)
	endfunction

	nnoremap <leader>vv :call s:FzfGlobalRefs()<CR>
	au FileType c,cpp,h,hpp setl ofu=GtagsOmniComplete
endif

" au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
" au FileType css setl ofu=csscomplete#CompleteCSS
" au FileType c,cpp setl ofu=ccomplete#Complete
" au FileType c,h,cpp,hpp set ofu=omni#cpp#complete#Main

set omnifunc=syntaxcomplete#Complete
set completeopt+=preview
set completeopt+=menuone
set completeopt+=noinsert
"}}}
" LSP {{{
" if executable('clangd')
"     au User lsp_setup call lsp#register_server({
"     \ 'name': 'clangd',
"     \ 'cmd': {server_info->['clangd', '--background-index', '--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/arm-none-eabi-g++', '--enable-config', '--clang-tidy']},
"     \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"     \ })
" endif
" autocmd FileType c,cpp,h,hpp setl omnifunc=lsp#complete
" autocmd FileType c,cpp,h,hpp setl tagfunc=lsp#tagfunc

let lspOpts = #{
	\	autoHighlight: v:true,
	\	autoHighlightDiags: v:true,
	\	completionMatcher: 'fuzzy',
	\	showDiagOnStatusLine: v:true,
	\	showInlayHints: v:true,
	\	showSignature: v:true
	\}
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [#{
	\	name: 'clang',
	\	filetype: ['c', 'cpp'],
	\	path: 'clangd',
	\	args: ['--background-index', '--query-driver=g++,arm-none-eabi-g++,gcc,arm-none-eabi-gcc', '--enable-config', '--clang-tidy']
	\ },#{
	\	name: 'typescriptlang',
	\	filetype: ['javascript', 'typescript'],
	\	path: 'typescript-language-server',
	\	args: ['--stdio']
	\ }]
autocmd User LspSetup call LspAddServer(lspServers)

if executable('clangd')
	autocmd FileType c,cpp,h,hpp nnoremap K <Cmd>LspHover<CR>
	autocmd FileType c,cpp,h,hpp nnoremap L <Cmd>LspPeekReferences<CR>
	autocmd FileType c,cpp,h,hpp nnoremap H <Cmd>LspDocumentSymbol<CR>
	autocmd FileType c,cpp,h,hpp nnoremap <leader><space> <Cmd>LspDiagCurrent<CR>
	autocmd FileType c,cpp,h,hpp nnoremap <C-]> <Cmd>LspGotoDefinition<CR>
	autocmd FileType c,cpp,h,hpp nnoremap <leader>] <Cmd>LspGotoDefinition<CR>
	autocmd FileType c,cpp,h,hpp nnoremap <C-r><C-r> <Cmd>LspRename<CR>
	autocmd FileType c,cpp,h,hpp nnoremap <F2> <Cmd>LspRename<CR>
	autocmd FileType c,cpp,h,hpp nnoremap <C-f> <Cmd>LspFormat<CR>
endif
" }}}
" SuperTab {{{
let g:SuperTabDefaultCompletionType = "context"
" }}}
" COLORSCHEME {{{
if has('termguicolors')
	set termguicolors
endif

set t_Co=256   " This is may or may not needed.
set background=dark " for the dark version

let g:one_allow_italics = 1 " I love italic for comments

colorscheme one
" }}}

