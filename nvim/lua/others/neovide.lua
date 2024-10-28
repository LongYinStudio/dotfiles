-- Neovide配置https://neovide.dev/configuration.html
if vim.g.neovide then
	-- 字体
	vim.opt.guifont = "JetbrainsMono Nerd Font Mono:h14"
	-- 行距
	vim.opt.linespace = 1
	-- 比例
	vim.g.neovide_scale_factor = 1.0
	-- 字体渲染
	vim.g.neovide_text_gamma = 0.0
	vim.g.neovide_text_contrast = 0.5
	-- 边距
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0
	-- 背景
	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.0
	vim.g.transparency = 0.8
	vim.g.neovide_background_color = "#0f1117" .. alpha()
	-- 模糊
	vim.g.neovide_window_blurred = true
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	-- 阴影
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	-- 角半径
	vim.g.neovide_floating_corner_radius = 0.0
	-- 透明度
	vim.g.neovide_transparency = 0.8
	-- 边框
	vim.g.neovide_show_border = true

	-- 滚动动画
	vim.g.neovide_scroll_animation_length = 0.3

	-- 隐藏鼠标
	vim.g.neovide_hide_mouse_when_typing = true

	-- 下划线自动缩放
	vim.g.neovide_underline_stroke_scale = 1.0

	-- 主题
	vim.g.neovide_theme = "auto"

	-- 刷新率
	vim.g.neovide_refresh_rate = 120

	-- 空闲刷新率
	vim.g.neovide_refresh_rate_idle = 5

	-- 空闲设置
	vim.g.neovide_no_idle = false

	-- 确定退出
	vim.g.neovide_confirm_quit = true

	-- 全屏
	vim.g.neovide_fullscreen = false

	-- 记住当前的窗口大小
	vim.g.neovide_remember_window_size = true

	-- 记住当前的窗口位置
	vim.g.neovide_remember_window_position = true

	-- 分析器
	vim.g.neovide_profiler = false

	-- 光标动画长度
	vim.g.neovide_cursor_animation_length = 0.13

	-- 光标动画痕迹大小
	vim.g.neovide_cursor_trail_size = 0.5

	-- 光标抗锯齿
	vim.g.neovide_cursor_antialiasing = true

	-- 光标插入模式动画
	vim.g.neovide_cursor_animate_in_insert_mode = true

	-- 光标切换到命令行动画
	vim.g.neovide_cursor_animate_in_insert_mode = true

	-- 光标无聚焦宽度
	vim.g.neovide_cursor_unfocused_outline_width = 0.125

	-- 光标动画
	vim.g.neovide_cursor_vfx_mode = ""
end
