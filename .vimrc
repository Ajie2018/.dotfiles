set nocompatible
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd InsertLeave * se nocul  " 用浅色高亮当前行
autocmd InsertEnter * se cul    " 用浅色高亮当前行
set fencs=utf-8,gb2312,gbk,gb18030,big5
set fenc=utf-8
set enc=utf-8
"==================================================
"display configuration
"==================================================
set number
set relativenumber
set cursorline

set noruler
set showcmd         
set cmdheight=1     
set scrolloff=3     

set iskeyword+=_,$,@,%,#,-
"set whichwrap+=<,>,h,l   
set backspace=2
set wildmenu
set clipboard+=unnamed 

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set hlsearch
set incsearch
set ignorecase
"==================================================
"Enable Altkey in terminal
"==================================================
set ttimeout
set ttimeoutlen=50
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc
"command! -nargs=0 -bang VimMetaInit call Terminal_MetaMode(<bang>0)
call Terminal_MetaMode(0)
"==================================================
"keymap configuration
"==================================================
let mapleader="\<Space>"
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>
nmap <leader>w :wq<CR>
nmap <leader>q :q!<CR>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

map <leader>l :vertical resize +5<CR>
map <leader>h :vertical resize -5<CR>
map <leader>k :resize +5<CR>
map <leader>j :resize -5<CR>

map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sl :set splitright<CR>:vsplit<CR>
map so :only<CR>
map sc :close<CR>

map ta :tabe<CR>
map tj :+tabnext<CR>
map tk :-tabnext<CR>
map to :tabonly<CR>
map tc :tabclose<CR>
"==================================================
"plug configuration
"==================================================
call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tomasr/molokai'
	Plug 'Valloric/YouCompleteMe'
	Plug 'rdnetto/YCM-Generator'
	Plug 'scrooloose/nerdtree'
	Plug 'majutsushi/tagbar'
	Plug 'SirVer/ultisnips'
    Plug 'dense-analysis/ale'

	Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'skywind3000/gutentags_plus'

	Plug 'Yggdroot/LeaderF'
	Plug 'yggdroot/indentline'
	Plug 'mhinz/vim-startify'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-unimpaired'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-fugitive'

	Plug 'derekwyatt/vim-fswitch'
	Plug 'justinmk/vim-dirvish'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'easymotion/vim-easymotion'
	Plug 'vim-scripts/vimwiki'
	Plug 'ryanoasis/vim-devicons'
call plug#end()

"let g:airline_theme="luna"
colorscheme molokai
"这个是安装字体后 必须设置此项"
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1      "tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ''   "tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '>'      "tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1

"--------------------------------------------------
"programming environment configuration
"--------------------------------------------------
set path +=/usr/local/include
set path +=/usr/include/x86_64-linux-gnu
set path +=/usr/lib/llvm-7/lib/clang/7.0.1/include						"used for clang compilator
set path +=/usr/lib/gcc/x86_64-linux-gnu/8/include						"used for gcc compilator

"--------------------------------------------------
"YouCompleteMe configuration
"--------------------------------------------------
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf='~/.config/.ycm_extra_conf.py'
"nnoremap <c-k> :YcmCompleter GoToDeclaration<CR>|
"nnoremap <c-h> :YcmCompleter GoToDefinition<CR>|
"nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|
let g:ycm_confirm_extra_conf = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:ycm_key_invoke_completion = ['<C-Space>']
"let g:ycm_key_list_stop_completion = ['<C-y>']
let g:ycm_semantic_triggers =  {
\   'c,cpp,python,java,go,erlang,perl':['re!\w{2}'],
\   'cs,lua,javascript':['re!\w{2}'],
\}
let g:ycm_add_preview_to_completeopt = 0

let g:ycm_error_symbol = 'e>'
let g:ycm_warning_symbol = 'w>'
let g:ycm_enable_diagnostic_highlighting = 0
"--------------------------------------------------
"NerdTree configuration
"--------------------------------------------------
map <F2> :NERDTreeToggle<CR>
""修改树的显示图标
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeAutoCenter=1
" 显示行号
let NERDTreeShowLineNumbers=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=25
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"--------------------------------------------------
"tagbar configuration
"--------------------------------------------------
map <F3> :TagbarToggle<CR>
let g:tagbar_width=30
let g:tagbar_right_=1

"--------------------------------------------------
"gutentags configuration
"--------------------------------------------------
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_exclude_project_root = [expand('~/.vim')]
let g:gutentags_cache_dir = expand('~/.cache/gutentags')

let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" Universal Ctags support Wildcard in options.
let g:gutentags_ctags_extra_args = ['--fields=*', '--extras=*', '--all-kinds=*']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
if executable('rg')
  let g:gutentags_file_list_command = 'rg --files'
else
  let g:gutentags_ctags_extra_args += ['--exclude=.git', '--exclude=node_modules', '--exclude=test', '--exclude=build']
endif

" If built-in parser exists for the target, it is used.
" Else if pygments parser exists it is used.
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = expand('/usr/local/share/gtags/gtags.conf')

let g:gutentags_define_advanced_commands = 1

augroup dirvish_config
    autocmd!
    autocmd FileType dirvish
                \  nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
                \ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
    autocmd FileType dirvish nnoremap <silent><buffer>
                \ gr :<C-U>Dirvish %<CR>
    " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
    autocmd FileType dirvish nnoremap <silent><buffer>
                \ gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>
augroup END
map <Leader>ew :edit <c-r>=expand("%:p:h")."/"<CR>
let g:vimwiki_list = [{'path': '~/vimwiki/',
					\  'syntax': 'markdown',
					\  'ext': '.md'}]



"let :gutentags_plus_nomap = 1
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>


noremap <m-u> :PreviewScroll -1<cr>
noremap <m-d> :PreviewScroll +1<cr>
inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>

autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
"--------------------------------------------------
"LeaderF configuration
"--------------------------------------------------
let g:Lf_Ctags = "/usr/local/bin/ctags"
"let g:Lf_ShortcutF = '<m-p>'
"let g:Lf_ShortcutB = '<m-b>'
noremap <m-m> :LeaderfMru<cr>
noremap <m-f> :LeaderfFunction!<cr>
noremap <m-b> :LeaderfBuffer<cr>
noremap <m-t> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
"let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
"--------------------------------------------------
"indent display configuration
"--------------------------------------------------
let g:indentLine_char = '┊'
"--------------------------------------------------
"FSwitch configuration
"--------------------------------------------------
augroup mycppfiles
autocmd!
autocmd BufEnter *.h let b:fswitchdst  = 'c' | let b:fswitchlocs = 'reg:/inc/src/,ifrel:|/inc/|../src|,./'
autocmd BufEnter *.c let b:fswitchdst  = 'h' | let b:fswitchlocs = 'reg:/src/inc/,ifrel:|/src/|../inc|,./'
augroup END
nnoremap <silent> <leader>sf :FSHere<cr>
nnoremap <silent> <leader>sl :FSRight<cr>
nnoremap <silent> <leader>sL :FSSplitRight<cr>
nnoremap <silent> <leader>sh :FSLeft<cr>
nnoremap <silent> <leader>sH :FSSplitLeft<cr>
nnoremap <silent> <leader>sk :FSAbove<cr>
nnoremap <silent> <leader>sK :FSSplitAbove<cr>
nnoremap <silent> <leader>sj :FSBelow<cr>
nnoremap <silent> <leader>sj :FSBelow<cr>
nnoremap <silent> <leader>sJ :FSSplitBelow<cr>
nnoremap <silent> <leader>sd :!mkdir -p %:p:h<cr>
"--------------------------------------------------
"cscope configuration
"--------------------------------------------------
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
nnoremap <C-a>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-a>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-a>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-a>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-a>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-a>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-a>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-a>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-a>a :cs find a <C-R>=expand("<cword>")<CR><CR>
"--------------------------------------------------
"other configuration
"--------------------------------------------------
