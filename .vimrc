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
Plug 'skywind3000/asyncrun.vim'
Plug 'Konfekt/FastFold'  " fast folding
" Plug 'godlygeek/tabular'
Plug 'kana/vim-surround'
Plug 'jiangmiao/auto-pairs'  ", { 'on': 'PAIRSToggle' }
Plug 'w0rp/ale', { 'on': 'ALEToggle' }
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'
" Plug 'ycm-core/YouCompleteMe', {'on': 'YCMToggle'}
" COMPLETION {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'ervandew/supertab'  " for autocompletion using <TAB>
"Plug 'Shougo/neco-syntax'
"Plug 'Shougo/neco-vim'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'prabirshrestha/asyncomplete-file.vim'
"Plug 'yami-beta/asyncomplete-omni.vim'
"Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
"Plug 'prabirshrestha/asyncomplete-tags.vim'
"Plug 'prabirshrestha/asyncomplete-necovim.vim'
" }}}
" JS {{{
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
Plug 'tweekmonster/impsort.vim', {'for': 'python'}  " color and sort imports
" }}}
" GIT {{{
" Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'tpope/vim-fugitive'
" }}}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'sainnhe/sonokai'
Plug 'rakr/vim-one'
call plug#end()
" }}}

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
set showmatch
set spelllang=en,ru,pl,ua
set synmaxcol=800
set tags=tags;/,codex.tags;/ " look for tags in current dir and up and
set ts=4 sts=4 sw=4 noexpandtab smarttab
set ttimeoutlen=0
set undolevels=1000
set updatetime=500

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
autocmd FileType python,javascript setlocal ts=4 sw=4 sts=4 expandtab autoindent
autocmd FileType php,snippets setlocal ts=4 sw=4 sts=4 noexpandtab
autocmd FileType html,xhtml setlocal ts=2 sts=2 sw=2
autocmd FileType make setlocal ts=4 sts=2 sw=2 noexpandtab

autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldmarker={{{,}}}
autocmd FileType vim setlocal foldlevel=1
autocmd FileType vim normal zM

autocmd FileType c,cpp,java,javascript,css,php,conf setlocal foldmethod=marker
autocmd FileType c,cpp,java,javascript,css,php,conf setlocal foldmarker={,}
autocmd FileType c,cpp,java,javascript,css,php,conf setlocal foldlevel=1
autocmd FileType c,cpp,java,javascript,css,php,conf normal zM

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
nnoremap <leader>a ggVG

" Format entire file
nnoremap <leader>fef ggVG=

" jump to matching pair
nnoremap <Leader>m %

" Visually select the text that was last edited/pasted
nnoremap gV `[v`]

nnoremap <silent> <leader>bn :bn<cr>
nnoremap <silent> <leader>bp :bp<cr>
nnoremap <leader>bd :bdelete<cr>
nnoremap <leader>bb :buffers<cr>:buffer
"}}}
" PLUGIN KEYBINDS {{{
" nnoremap <C-n> :NERDTreeToggle<CR>
" nnoremap <C-t> :TagbarToggle<CR>
" nnoremap <C-e> :UndotreeToggle<CR>
" nnoremap <C-w> :call asyncrun#quickfix_toggle(8)<CR>
" nnoremap <C-r> :AsyncRun ctags -R .<CR>
" nnoremap <C-t> :set nosplitright<CR>:TagbarToggle<CR>:set splitright<CR>
"}}}
" NERDTREE {{{
" Tweaks for browsing
" let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=4  " open in prior window
" let g:netrw_altv=1          " open splits to the right
" let g:netrw_liststyle=3     " tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" 
" let g:NERDTreeMinimalUI = 1
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" let g:NERDTreeChDirMode=2
" let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
" let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
" let g:NERDTreeShowBookmarks=1
" let g:nerdtree_tabs_focus_on_files=1
" let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
" let g:NERDTreeWinSize = 50
" }}}
" COC {{{
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

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
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
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

nmap <silent> <C-M> <Plug>(ale_previous_wrap)
nmap <silent> <C-m> <Plug>(ale_next_wrap)
"}}}
" JEDI {{{
" let g:jedi#auto_initialization = 1
" let g:jedi#completions_enabled = 0
" let g:jedi#popup_on_dot = 1
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#smart_auto_mappings = 0
" let g:jedi#show_call_signatures = "1"
" let g:jedi#show_call_signatures_delay = 0
" let g:jedi#use_tabs_not_buffers = 0
" let g:jedi#show_call_signatures_modes = 'i'  " ni = also in normal mode
" let g:jedi#enable_speed_debugging=0
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
" if executable('pyls')
"     " pip install python-language-server
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'whitelist': ['python'],
"         \ })
" endif

" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
"     \ 'name': 'file',
"     \ 'whitelist': ['*'],
"     \ 'priority': 10,
"     \ 'completor': function('asyncomplete#sources#file#completor')
"     \ }))
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
"     \ 'name': 'omni',
"     \ 'whitelist': ['*'],
"     \ 'blacklist': ['python'],
"     \ 'completor': function('asyncomplete#sources#omni#completor')
"     \  }))
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
"     \ 'name': 'necosyntax',
"     \ 'whitelist': ['*'],
"     \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
"     \ }))
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
"     \ 'name': 'tags',
"     \ 'whitelist': ['c'],
"     \ 'completor': function('asyncomplete#sources#tags#completor'),
"     \ 'config': {
"     \    'max_file_size': 50000000,
"     \  },
"     \ }))
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
"     \ 'name': 'necovim',
"     \ 'whitelist': ['vim'],
"     \ 'completor': function('asyncomplete#sources#necovim#completor'),
"     \ }))


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
" IMPSORT {{{
hi pythonImportedObject ctermfg=127
hi pythonImportedFuncDef ctermfg=127
hi pythonImportedClassDef ctermfg=127
"}}}
" EMMET {{{
let g:user_emmet_leader_key=','
let g:user_emmet_settings = { 'javascript.jsx' : { 'extends' : 'jsx', } }
" }}}
" PIPENV {{{
" let g:pipenv_auto_activate=1
"}}}
" ASYNCRUN {{{
let g:asyncrun_mode=0
let g:asyncrun_open=3
"}}}
" COLORSCHEME {{{
if has('termguicolors')
	set termguicolors
endif

let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1

" colorscheme sonokai

colorscheme one
" set background=dark " for the dark version
set background=light " for the light version
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

