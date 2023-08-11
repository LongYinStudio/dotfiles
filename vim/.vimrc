set t_Co=256 "记得注释或删除
set encoding=UTF-8
if has("termguicolors")
	set termguicolors
endif
syntax on "语法高亮
set hlsearch "查找结果高亮
set background=dark
colorscheme onedark
set mouse=a "启用鼠标
set number "显示行号
"set relativenumber "相对行号，对跳转行号有帮助
set tabstop=4 "按tap键自动缩进4个空格
set softtabstop=4 "tap转为4个空格
set shiftwidth=4 "按》增加一级缩进 按《取消一级缩机 按==取消全部缩进,每一级的字符数
set autoindent "换行自动缩
set cindent "按照C语言语法缩进,自动调整缩机长度
set cursorline "光标所在行高亮
set ruler "在状态栏显示光标的当前位置（位于哪一行哪一列）
set clipboard=unnamedplus    " 使用系统剪切版 -> Vim
set clipboard=unnamed      " Vim -> 系统剪切版
set ignorecase smartcase " 有一个或多个大写字母，进行大写敏感搜索

" 快捷退出insert
inoremap jk <Esc>  

"先安装 vim-plug
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree' "vim旁边的路径目录
Plug 'SirVer/ultisnips' "snippets
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs' "自动补全()、{}等等
Plug 'easymotion/vim-easymotion' "跳转
Plug 'vim-airline/vim-airline' "airline
Plug 'vim-airline/vim-airline-themes' "airline-theme
Plug 'ryanoasis/vim-devicons' "图标
call plug#end()

let mapleader=";" "定义leader键
"nerdtree设置快捷键";e"打开
map <leader>e :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

nmap <leader>w :w<CR> ";w --> 保存
nmap <leader>q :q<CR> ";q --> 退出
nmap <leader>nh :set nohlsearch<CR> "--> 退出搜索高亮

"snippets快捷键
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-d>"
let g:UltiSnipsJumpBackwardTrigger="<c-a>"
let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/'] 自定义snippets

" easymotion快捷键
nmap ss <Plug>(easymotion-s2)

"vim-airline
set laststatus=2 " 始终显示状态栏
let g:airline#extensions#tabline#enabled=1 " 开启 tab 栏
let g:airline_theme='simple' " airline theme

nmap <leader>1 <Plug>AirlineSelectTab1 ";1 --> tab1
nmap <leader>2 <Plug>AirlineSelectTab2 ";2 --> tab2
nmap <leader>3 <Plug>AirlineSelectTab3 ";3 --> tab3
nmap <leader>4 <Plug>AirlineSelectTab4 ";4 --> tab4
nmap <leader>5 <Plug>AirlineSelectTab5 ";5 --> tab5
nmap <leader>6 <Plug>AirlineSelectTab6 ";6 --> tab6
nmap <leader>7 <Plug>AirlineSelectTab7 ";7 --> tab7
nmap <leader>8 <Plug>AirlineSelectTab8 ";8 --> tab8
nmap <leader>9 <Plug>AirlineSelectTab9 ";9 --> tab9

set nocompatible              " 去除编辑mode限制
filetype off                  " 移除默认的filetype检测，必须位于插件包括之前

" 配置vim-devicons
