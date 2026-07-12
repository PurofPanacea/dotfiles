# ==========================================
# 1. YOUR EXISTING CONFIGURATIONS
# ==========================================

set -U fish_user_paths $fish_user_paths ~/.julia/juliaup/bin

# Created by `pipx` on 2025-02-20 07:54:56
set PATH $PATH /Users/danz/.local/bin

# --- Added for ASCII Font Hoarding ---
# --- Optimized for Wide Screens ---
set -gx FIGLET_FONTDIR "/Users/danz/fonts"

if test -d $FIGLET_FONTDIR
    for font_path in $FIGLET_FONTDIR/*.flf
        set -l font_path_no_ext (string replace ".flf" "" $font_path)
        set -l font_file (basename $font_path .flf)
        set -l font_alias (string replace -ra "[\s-]" "_" $font_file | string replace -ra "[^a-zA-Z0-9_]" "" | string lower)
        
        # -w (tput cols) ensures it uses all 382 columns
        # Removed -k to fix the "no such option" error
        eval "function fig-$font_alias; pyfiglet -w (tput cols) -f \"$font_path_no_ext\" \$argv | lolcat; end"
    end
end

# ==========================================
# 2. NEW CLI TOOLS CONFIGURATION (FISH NATIVE)
# ==========================================

# ----- #1: fzf (Fuzzy Finder) & Previews -----
# Basic fzf variables for native fallback behavior
set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Define a shared previewer layout (Directories use eza tree, files use bat)
set -l show_file_or_dir_preview "if test -d {}; eza --tree --color=always {} | head -200; else; bat -n --color=always --line-range :500 {}; end"

# If you choose the Option A plugin (`fzf.fish`), these variables control its previews:
set -gx fzf_preview_file_cmd "$show_file_or_dir_preview"
set -gx fzf_preview_dir_cmd "eza --tree --color=always {} | head -200"

# Custom theme variables for fzf UI colors
set -l fg "#CBE0F0"
set -l bg "#011628"
set -l bg_highlight "#143652"
set -l purple "#B388FF"
set -l blue "#06BCE4"
set -l cyan "#2CF9ED"
set -gx FZF_DEFAULT_OPTS "--color=fg:$fg,bg:$bg,hl:$purple,fg+:$fg,bg+:$bg_highlight,hl+:$purple,info:$blue,prompt:$cyan,pointer:$cyan,marker:$cyan,spinner:$cyan,header:$cyan"

# ---- FOOLPROOF CUSTOM KEYBINDINGS ----
function fish_user_key_bindings
    bind \cf _fzf_search_directory     # Ctrl + F = Search Files & Folders
    bind \cd _fzf_search_directory     # Ctrl + D = Search Directories
    bind \cr _fzf_search_history       # Ctrl + R = Search History
    bind \cs _fzf_search_git_status    # Ctrl + S = Search Git Status
    bind \cl _fzf_search_git_log       # Ctrl + L = Search Git Log
end


# ----- #2: bat (Better cat) -----
set -gx BAT_THEME tokyonight_night


# ----- #4: eza (Better ls) -----
# FIXED: Replaced layout-collapsing arguments with explicit verbose flags
# -g: shows the user group column
# --time-style=default: explicitly forces standard timestamp layout columns
alias ls="eza --long --header --icons=always -g --git --group-directories-first --time-style=default"


# ----- #6: thefuck (Auto-correct commands) -----
# FIXED: Replaced the broken Python 3.12 `thefuck --alias` evaluation with a stable Fish function loop
if type -q thefuck
    function __run_thefuck
        set -l last_command $history[1]
        set -l env_strings (env TF_ALIAS=fuck thefuck $last_command 2>/dev/null)
        if test -n "$env_strings"
            eval $env_strings
        end
    end

    alias fuck="__run_thefuck"
    alias fk="__run_thefuck"
end


# ----- #7: zoxide (Better cd) -----
if type -q zoxide
    zoxide init fish | source
    alias cd="z" 
end

# ==========================================
# 3. ACTIVE: TIDE GRUVBOX LIGHT HARD THEME OVERRIDES
# ==========================================
# Palette -> Sand BG: f9f5d7 | Charcoal: 3c3836 | Gruv-BG Blocks: ebdbb2 / bdae93

# 1. Directory Block (Muted light tan background, dark charcoal text)
set -g tide_pwd_bg_color ebdbb2
set -g tide_pwd_color_dirs 3c3836
set -g tide_pwd_color_anchor 000000

# 2. Git Status Block (Warm gray background, green branch accent text)
set -g tide_git_bg_color bdae93
set -g tide_git_bg_color_untracked bdae93
set -g tide_git_color_branch 79740e
set -g tide_git_color_operation 9d0006

# 3. Prompt Execution/Character Status Block (Dark charcoal segment, sand status text)
set -g tide_status_bg_color 3c3836
set -g tide_status_bg_color_failure 9d0006
set -g tide_status_color b57614
set -g tide_status_color_failure f9f5d7

# 4. Command Duration & Timestamp Block
set -g tide_cmd_duration_bg_color bdae93
set -g tide_cmd_duration_color 3c3836
set -g tide_time_bg_color ebdbb2
set -g tide_time_color 3c3836


# ==========================================
# 4. ARCHIVED: TIDE TRANS PRIDE THEME OVERRIDES
# ==========================================
# Uncomment these line blocks below if you ever want to switch back to Trans Pride colors:
#
# # 1. Directory Block (Light Blue background)
# set -g tide_pwd_bg_color 5BCEFA
# set -g tide_pwd_color_dirs 3c3836
# set -g tide_pwd_color_anchor 000000
#
# # 2. Git Status Block (Pink background)
# set -g tide_git_bg_color F5A9B8
# set -g tide_git_bg_color_untracked F5A9B8
# set -g tide_git_color_branch 3c3836
# set -g tide_git_color_operation 3c3836
#
# # 3. Prompt Execution/Character Status Block (White background)
# set -g tide_status_bg_color FFFFFF
# set -g tide_status_bg_color_failure F5A9B8
# set -g tide_status_color 5BCEFA
# set -g tide_status_color_failure FFFFFF
#
# # 4. Command Duration & Timestamp Block (Pink/Blue right-anchored accents)
# set -g tide_cmd_duration_bg_color F5A9B8
# set -g tide_cmd_duration_color 3c3836
# set -g tide_time_bg_color 5BCEFA
# set -g tide_time_color 3c3836


# ==========================================
# 5. ARCHIVED/OLD TIDE DEFAULT SETTINGS (RESTORE VALUE)
# ==========================================
# Uncomment these line blocks below if you ever want to revert back to defaults:
#
# # 1. Original Directory
# set -g tide_pwd_bg_color 343F44
# set -g tide_pwd_color_dirs E6E2E2
# set -g tide_pwd_color_anchor F2EFEE
#
# # 2. Original Git
# set -g tide_git_bg_color 4F5B58
# set -g tide_git_bg_color_untracked 4F5B58
# set -g tide_git_color_branch A7C080
# set -g tide_git_color_operation E68183
#
# # 3. Original Status/Character
# set -g tide_status_bg_color 3D484D
# set -g tide_status_bg_color_failure E67E80
# set -g tide_status_color A7C080
# set -g tide_status_color_failure FDF6E3
#
# # 4. Original Right Prompt Items
# set -g tide_cmd_duration_bg_color 475257
# set -g tide_cmd_duration_color DBBC7F
# set -g tide_time_bg_color 343F44
# set -g tide_time_color 859289

# Set the default editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Set the editor specifically for sudoedit
# We use (which nvim) to ensure it gets the absolute path
set -gx SUDO_EDITOR (which nvim)
