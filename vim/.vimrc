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
set tabstop=4 "按tap键自动缩进4个空格
set softtabstop=4 "tap转为4个空格
set shiftwidth=4 "按》增加一级缩进 按《取消一级缩机 按==取消全部缩进,每一级的字符数
set autoindent "换行自动缩进
set cindent "按照C语言语法缩进,自动调整缩机长度
set cursorline "光标所在行高亮
set ruler "在状态栏显示光标的当前位置（位于哪一行哪一列）


"先安装 vim-plug
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree' "vim旁边的路径目录
call plug#end()
"nerdtree设置快捷键Ctrl+e打开
map <silent> <C-e> :NERDTreeToggle<CR>
map <silent> <C-w> :NERDTreeFind<CR>
