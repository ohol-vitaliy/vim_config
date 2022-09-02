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
" Plug 'Konfekt/FastFold'  " fast folding
Plug 'godlygeek/tabular'
Plug 'kana/vim-surround'
Plug 'jiangmiao/auto-pairs'  ", { 'on': 'PAIRSToggle' }
Plug 'w0rp/ale'  ", { 'on': 'ALEToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'rakr/vim-one'
Plug 'airblade/vim-rooter'
Plug 'liuchengxu/vim-which-key'

Plug 'preservim/vim-markdown', { 'for': 'markdown' }
Plug 'zaid/vim-rec'
Plug 'ledger/vim-ledger'
Plug 'scy/vim-remind'
Plug 'Gavinok/vim-troff'

Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" JS {{{
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript', {'for': 'javascript' }
Plug 'mxw/vim-jsx', {'for': 'javascript' }
Plug 'pangloss/vim-javascript', {'for': 'javascript' }
Plug 'leafgarland/typescript-vim', {'for': 'javascript' }
Plug 'peitalin/vim-jsx-typescript', {'for': 'javascript' }
Plug 'styled-components/vim-styled-components', { 'branch': 'main', 'for': ['javascript','typescript','css','html'] }
" }}}
" PYTHON {{{
" Plug 'davidhalter/jedi-vim', {'for': 'python'}   " jedi for python
Plug 'tmhedberg/SimpylFold', {'for': 'python'}  " for nice python folding
" Plug 'tweekmonster/impsort.vim', {'for': 'python'}  " color and sort imports
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


set nowrap textwidth=79 " colorcolumn=80
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
set mouse=a
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
function! LinterStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))
	let l:all_errors = l:counts.error + l:counts.style_error
	let l:all_non_errors = l:counts.total - l:all_errors

	return l:counts.total == 0 ? 'OK' : printf(
	\   '%dW %dE',
	\   all_non_errors,
	\   all_errors
	\)
endfunction

if has('statusline')
    set statusline=%<%f\    " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=\ [%{&ff}/%Y]            " filetype
    set statusline+=\ [%{getcwd()}]          " current dir
    set statusline+=\ %{fugitive#statusline()} "  Git Hotnes
    set statusline+=\ %{LinterStatus()}
    set statusline+=%*
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif
"}}}
" WILDIGNORE {{{
set wildignorecase
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~
set wildignore+=*.so,*.swp
set wildignore+=*.gem,*.rbc,*.class
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=__pycache__,*.pyc,*.luac
set wildignore+=.hg,.git,.svn
set wildignore+=*.o,*.obj,*.dll,*.manifest
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

autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldmarker={{{,}}}
autocmd FileType vim setlocal foldlevel=1
autocmd FileType vim normal zM

autocmd FileType awk,c,cpp,java,javascript,typescript,json,css,php,conf setlocal foldmethod=marker
autocmd FileType awk,c,cpp,java,javascript,typescript,json,css,php,conf setlocal foldmarker={,}
autocmd FileType awk,c,cpp,java,javascript,typescript,json,css,php,conf setlocal foldlevel=1
autocmd FileType awk,c,cpp,java,javascript,typescript,json,css,php,conf normal zM

autocmd FileType html,xhtml,xml,haml,jst setlocal foldmethod=indent
autocmd FileType html,xhtml,xml,haml,hst setlocal foldlevel=20
autocmd FileType html,xhtml,xml,haml,jst normal zR

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable comment new line

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


" Folding focus
nnoremap <leader>z zMzvzz

" Move blocks of text around
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

nnoremap <leader>sudo :w !sudo tee % <CR><CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>x :q!<CR>

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
nnoremap <leader>fef ggVG=

" jump to matching pair
" nnoremap <Leader>m %

" Visually select the text that was last edited/pasted
nnoremap gV `[v`]

nnoremap <silent> <leader>bn :bn<cr>
nnoremap <silent> <leader>bp :bp<cr>
nnoremap <leader>bd :bdelete<cr>
" nnoremap <leader>bb :buffers<cr>:buffer
"}}}
" PLUGIN KEYBINDS {{{
nnoremap   <silent>   <leader>     :WhichKey ','<CR>
nnoremap   <silent>   <C-r>        :AsyncRun ctags -R.<cr>
nnoremap   <silent>   <leader>.    :GFiles<cr>
nnoremap   <silent>   <leader>n    :Lf<cr>
nnoremap   <silent>   <leader>ff   :Rg<cr>
nnoremap   <silent>   <leader>tt   :Tags<cr>
nnoremap   <silent>   <leader>bb   :Buffers<cr>

nnoremap   <silent>   <leader>gd   <Plug>(coc-definition)
nnoremap   <silent>   <leader>gt   <Plug>(coc-type-definition)
nnoremap   <silent>   <leader>gi   <Plug>(coc-implementation)
nnoremap   <silent>   <leader>gr   <Plug>(coc-references)
nnoremap   <silent>   <leader>d    :<C-u>CocList diagnostics<cr>
nnoremap   <silent>   <leader>e    :<C-u>CocList extensions<cr>
nnoremap   <silent>   <leader>cc   :<C-u>CocList commands<cr>
nnoremap   <silent>   <leader>o    :<C-u>CocList outline<cr>
nnoremap   <silent>   <leader>oo    :<C-u>CocList -I symbols<cr>

nnoremap   <silent>   <leader>ac   <Plug>(coc-codeaction)
nnoremap   <silent>   <leader>rn   <Plug>(coc-rename)
nnoremap   <silent>   <leader>qf   <Plug>(coc-fix-current)
nnoremap   <silent>   <leader>ca   <Plug>(coc-calc-result-append)
nnoremap   <silent>   <leader>cr   <Plug>(coc-calc-result-replace)
"}}}
" COC {{{
let g:coc_disable_startup_warning = 1
let g:coc_global_extensions = [
			\ 'coc-calc',
			\ 'coc-cmake',
			\ 'coc-json',
			\ 'coc-lists',
			\ 'coc-yank',
			\ 'coc-yaml',
			\ 'coc-highlight',
			\ 'coc-docker',
			\ 'coc-sql',
			\ 'coc-vimlsp',
			\ ]
			" \
			" \ 'coc-css',
			" \ 'coc-cssmodules',
			" \ 'coc-emmet',
			" \ 'coc-eslint',
			" \ 'coc-html',
			" \ 'coc-html-css-support',
			" \ 'coc-tsserver',
			" \ 'coc-tailwindcss',
			" \ '@yaegassy/coc-pylsp'
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1):
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ CheckBackspace() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)


" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx,*json,*.html,*.css :Format

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx :OR

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}\ %{get(b:,'coc_current_function','')}\ 

" }}}
" AUTO-PAIRS {{{
let g:AutoPairsCenterLine=1
let g:AutoPairsMapSpace=1
let g:AutoPairsFlyMode=0
"}}}
" ALE {{{
let g:ale_python_pylint_options = '-j 0 --max-line-length=120'
let g:ale_linters = {
\'python': ['mypy', 'pylint'],
\'bib': 'all',
\'bash': 'all',
\'sh': 'all',
\'vim': 'all',
\'latex': 'all',
\'tex': 'all',
\'text': 'all',
\'markdown': 'all',
\'javascript': 'all'
\}
let g:ale_fixers = {
\'*': ['remove_trailing_lines', 'trim_whitespace'],
\'python': ['isort', 'autopep8', 'yapf', 'add_blank_lines_for_python_control_statements'],
\'bash': 'shfmt',
\'sh': 'shfmt',
\'javascript': 'eslint'
\}

let g:ale_list_window_size = 6
let g:ale_sign_column_always = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_completion_enabled=0

" Options are in .pylintrc!
highlight VertSplit ctermbg=253
highlight ALEWarning cterm=underline
highlight ALEError cterm=underline
"highlight ALEWarning ctermfg=Yellow cterm=underline
"highlight ALEError ctermfg=Red cterm=underline

" nmap <silent> <C-M> <Plug>(ale_previous_wrap)
" nmap <silent> <C-m> <Plug>(ale_next_wrap)
"}}}
" MARKDOWN {{{
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_folding_disabled = 1
" }}}
" ROOTER {{{
let g:rooter_targets = '/,*'
let g:rooter_patterns = ['=src', '.git', 'Makefile', '*.sln', 'build/env.sh', 'setup.sh', 'node_modules']
" }}}
" LF {{{
let g:lf_map_keys = 0 " disable default keymap
let g:lf_replace_netrw = 1 " Open lf when vim opens a directory
" }}}
" JEDI {{{
let g:python_host_prog= '/usr/bin/python'
let g:python3_host_prog= '/usr/bin/python3.8'
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 1
let g:jedi#popup_on_dot = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'ni'
 let g:jedi#enable_speed_debugging=0
" 
" let g:jedi#goto_command = "<leader>d"
" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_definitions_command = "<leader>v"
" let g:jedi#documentation_command = "<leader>c"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "C-Space"
" let g:jedi#rename_command = "<leader>r"
"}}}
" COMPLETION {{{
set omnifunc=syntaxcomplete#Complete
"au FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS

set completeopt+=preview
set completeopt+=menuone
set completeopt+=noinsert

" let g:SuperTabDefaultCompletionType="<C-X><C-O>"
"let g:SuperTabDefaultCompletionType="context"

"let g:asyncomplete_auto_popup = 0

"function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"endfunction

"" to do text select via j/k
"inoremap <expr> j     ((pumvisible())?("\<C-n>"):("j"))
"inoremap <expr> k     ((pumvisible())?("\<C-p>"):("k"))
"inoremap <expr> <cr>  ((pumvisible())?("\<C-y>"):("<cr>"))
"inoremap <silent><expr> <TAB>  (pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : asyncomplete#force_refresh())
""inoremap <expr> <S-TAB> ((pumvisible())?("\<C-p>"):("\<C-h>"))
"autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"}}}
" SimpylFold {{{
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_import=1
"}}}
" EMMET {{{
let g:user_emmet_leader_key=','
let g:user_emmet_settings = { 'javascript.jsx' : { 'extends' : 'jsx', } }
" }}}
" ASYNCRUN {{{
let g:asyncrun_mode=0
let g:asyncrun_open=3
"}}}
" COLORSCHEME {{{
if has('termguicolors')
	set termguicolors
endif

" set t_Co=256   " This is may or may not needed.
set background=dark " for the dark version
" set background=light " for the light version

let g:one_allow_italics = 1 " I love italic for comments

colorscheme one
" }}}
" RUN FUNC {{{
" nnoremap <leader>r :call <SID>compile_and_run()<CR>
" " command R :call Runit()
" 
" let pipenv_venv_path = system('pipenv --venv')
" if shell_error == 0
"   let venv_path = substitute(pipenv_venv_path, '\n', '', '')
"   let g:python3_host_prog = pipenv_venv_path . '/bin/python3.5'
"   let g:python_host_prog = pipenv_venv_path . '/bin/python'
" else
"   let g:python3_host_prog = '/usr/bin/python3.5'
"   let g:python_host_prog = '/usr/bin/python2'
" endif
" 
" function! s:compile_and_run()
"     exec 'w'
"     if &filetype == 'c'
"         exec "AsyncRun! gcc % -o %<; time ./%<"
"     elseif &filetype == 'cpp'
"        exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
"     elseif &filetype == 'java'
"        exec "AsyncRun! javac %; time java %<"
"     elseif &filetype == 'sh'
"        exec "! time bash %"
"     elseif &filetype == 'python'
"        exec "AsyncRun! time python3.5 %"
"     elseif &filetype == 'ruby'
"        exec "AsyncRun! time ruby %"
"     elseif &filetype == 'javascript'
"        exec "AsyncRun! time node %"
"     elseif &filetype == 'lua'
"        exec "AsyncRun! time lua %"
"     elseif &filetype == 'coffee'
"        exec "AsyncRun! time coffee %"
"     elseif &filetype == 'php'
"        exec "AsyncRun! time php %"
"     elseif &filetype == 'tex'
"        exec "AsyncRun! time latexmk -pvc -pdf %"
"     endif
" endfunction
"}}}

