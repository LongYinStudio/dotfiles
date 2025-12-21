-- ╔═════════════════════════════════════════════════════════╗
-- ║                        注释美化                         ║
-- ╚═════════════════════════════════════════════════════════╝
-- NOTE: 用法
-- :CBxy[box|line] n
-- x: Position of the box or line (l: left, c: center, r: right)
-- y: text justification (l: left, c: center, r: right).
--    For the box, it can be a ("adapted"): the size of the box will be adapted to the size of the text (up to box_width)
-- n: optional an apply a style from the catalog. (:CBcatalog)
return { "LudoPinelli/comment-box.nvim", event = "VeryLazy", keys = { { "gC", "<Cmd>CBlcbox 7<CR>" } } }
