# 说明

1. `about:config` 中找到 `toolkit.legacyUserProfileCustomizations.stylesheets`， 将其值设为true
2. 将chrome文件夹复制到一下目录(没有就自行创建):
   - Linux: `$HOME/.mozilla/firefox/######.default-release/`
   - MacOS: `Users/[USERNAME]/Library/Application Support/Firefox/Profiles/######.default-release`
   - Windows: `C:\Users\[USERNAME]\AppData\Roaming\Mozilla\Firefox\Profiles\######.default-release`
3. 重启firefox即可生效

插件
Github Code Font Changer  (JetBrainsMono Nerd Font)

好看的自定义界面
https://github.com/Alan-Kuan/Firefox-Mod-Blur

> Firefox 调试自己界面

To inspect Firefox's UI you can use the Browser Toolbox.
Enable the Browser Toolbox

    Press F12 to open the Page Inspector.
    Alternate: Right click the page then "Inspect Element (Q)".

    Press F1 to open the Page Inspector Settings.
    Alternate: In the top right of the Page Inspector next to the close button; press the "⋯" button then "Settings".

    Ensure the following settings are checked:
        "Enable Browser chrome and add-on debugging toolbox"
        "Enable remote debugging"

Open the Browser Toolbox

    Press alt, "Tools", "Web Developer" then "Browser Toolbox".
    Alternate: Press ctrlaltshifti
