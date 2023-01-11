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

"先安装 vim-plug
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree' "vim旁边的路径目录
call plug#end()
"nerdtree设置快捷键Ctrl+e打开
map <silent> <C-e> :NERDTreeToggle<CR>
map <silent> <C-w> :NERDTreeFind<CR>
