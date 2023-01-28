"set t_Co=256 记得注释或删除
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
set autoindent "换行自动缩进
set cindent "按照C语言语法缩进,自动调整缩机长度
set cursorline "光标所在行高亮
set ruler "在状态栏显示光标的当前位置（位于哪一行哪一列）
set clipboard=unnamedplus    " 使用系统剪切版 -> Vim
set clipboard=unnamed      " Vim -> 系统剪切版

"先安装 vim-plug
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree' "vim旁边的路径目录
Plug 'SirVer/ultisnips' "snippets
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs' "自动补全()、{}等等
call plug#end()

let mapleader=";" "定义leader键
"nerdtree设置快捷键";e"打开
map <leader>e :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

nmap <leader>w :w<CR> ";w --> 保存
nmap <leader>q :q<CR> ";q --> 退出
nmap <leader>t :set nohlsearch<CR> --> 退出搜索高亮

"snippets快捷键
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-d>"
let g:UltiSnipsJumpBackwardTrigger="<c-a>"
let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/'] 自定义snippets
