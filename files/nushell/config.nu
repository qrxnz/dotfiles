# Nushell Configuration File

#
# Theme (Catppuccin Mocha)
#
let base = "#1e1e2e"
let mantle = "#181825"
let crust = "#11111b"
let text = "#cdd6f4"
let subtext0 = "#a6adc8"
let subtext1 = "#bac2de"
let overlay0 = "#6c7086"
let overlay1 = "#7f849c"
let overlay2 = "#9399b2"
let surface0 = "#313244"
let surface1 = "#45475a"
let surface2 = "#585b70"
let blue = "#89b4fa"
let lavender = "#b4befe"
let sapphire = "#74c7ec"
let sky = "#89dceb"
let teal = "#94e2d5"
let green = "#a6e3a1"
let yellow = "#f9e2af"
let peach = "#fab387"
let maroon = "#eba0ac"
let red = "#f38ba8"
let mauve = "#cba6f7"
let pink = "#f5c2e7"
let flamingo = "#f2cdcd"
let rosewater = "#f5e0dc"

let color_config = {
    separator: $overlay0
    leading_trailing_space_bg: { fg: $overlay0 }
    header: { fg: $blue, attr: b }
    empty: $blue
    bool: { fg: $peach }
    int: { fg: $peach }
    filesize: { fg: $teal }
    duration: { fg: $teal }
    date: { fg: $mauve }
    range: { fg: $mauve }
    float: { fg: $peach }
    string: { fg: $green }
    nothing: $overlay0
    binary: { fg: $teal }
    cell-path: $text
    row_index: { fg: $subtext0 }
    record: $text
    list: $text
    block: $text
    hints: $overlay0
    search_result: { fg: $mantle, bg: $yellow }
    shape_and: { fg: $mauve, attr: b }
    shape_arrow: { fg: $mauve, attr: b }
    shape_bool: { fg: $peach }
    shape_custom: { fg: $green }
    shape_datetime: { fg: $mauve }
    shape_directory: { fg: $blue }
    shape_external: { fg: $teal }
    shape_external_resolved: { fg: $sky, attr: b }
    shape_externalarg: { fg: $green }
    shape_filepath: { fg: $blue }
    shape_flag: { fg: $blue, attr: b }
    shape_float: { fg: $peach }
    shape_garbage: { fg: $red, attr: u }
    shape_glob_interpolation: { fg: $teal }
    shape_globpattern: { fg: $teal }
    shape_int: { fg: $peach }
    shape_internalcall: { fg: $sky, attr: b }
    shape_keyword: { fg: $mauve, attr: b }
    shape_list: { fg: $text }
    shape_literal: { fg: $blue }
    shape_match_pattern: { fg: $green }
    shape_matching_brackets: { bg: $surface2 }
    shape_nothing: { fg: $overlay0 }
    shape_operator: { fg: $mauve }
    shape_or: { fg: $mauve, attr: b }
    shape_pipe: { fg: $mauve, attr: b }
    shape_range: { fg: $mauve }
    shape_record: { fg: $text }
    shape_redirection: { fg: $mauve, attr: b }
    shape_signature: { fg: $green, attr: b }
    shape_string: { fg: $green }
    shape_string_interpolation: { fg: $teal }
    shape_table: { fg: $blue }
    shape_variable: { fg: $lavender }
    shape_vardecl: { fg: $lavender }
}

#
# Settings
#
$env.config = (
  $env.config
  | default {}
  | merge {
    edit_mode: vi
    color_config: $color_config
    show_banner: false
  }
)

$env.config.history = (
  $env.config.history?
  | default {}
  | merge {
    max_size: 10000
    sync_on_enter: true
    file_format: "sqlite"
  }
)

#
# Direnv Hook
#
$env.config.hooks = (
  $env.config.hooks?
  | default {}
  | merge {
    env_change: (
      $env.config.hooks.env_change?
      | default {}
      | merge {
        PWD: (
          $env.config.hooks.env_change.PWD?
          | default []
          | append {
            condition: { |before, after| (not ($after | is-empty) and ($after | path join ".envrc" | path exists)) or (not ($before | is-empty) and ($before | path join ".envrc" | path exists)) }
            code: { |before, after|
              if (which direnv | is-empty) == false {
                let exports = (do { direnv export json } | complete)
                if $exports.exit_code == 0 and ($exports.stdout | is-not-empty) {
                  $exports.stdout | from json | default {} | load-env
                }
              }
            }
          }
        )
      }
    )
  }
)

#
# External Integrations (Starship & Zoxide)
#
source ~/.cache/nushell/starship_init.nu
source ~/.cache/nushell/zoxide_init.nu

#
# Custom Commands (replaces functions)
#

# Interactive repository viewer using gh and gum
def repos [] {
  if (which gh | is-empty) or (which gum | is-empty) {
    print "Error: 'gh' and 'gum' are required for this command."
    return
  }
  gh repo list --limit 100 --json name,owner --jq ".[] | \"\\(.owner.login)/\\(.name)\""
  | gum filter --placeholder "Choose repository..."
  | xargs gh repo view
}

# Clone GitHub repository easily
def clone [repo: string] {
  git clone $"git@github.com:($repo).git"
}

# Interactive branch & PR switcher
def gs [] {
  # Check if the 'gh' command is available and if the user is logged in
  let has_gh = (which gh | is-not-empty)
  let logged_in = (if $has_gh { (do { gh auth status } | complete | get exit_code) == 0 } else { false })

  if not $has_gh or not $logged_in {
    let branches = (git branch --format='%(refname:short)' | lines)
    if ($branches | is-empty) {
      print "No local branches found."
      return
    }
    let selection = ($branches | gum choose --header "Select branch (GitHub CLI not available)")
    if ($selection | is-not-empty) {
      git switch $selection
    }
    return
  }

  # Combine local branches and open PRs
  let branches = (git branch --format='%(refname:short)' | lines)
  let prs_raw = (gh pr list --limit 40 --json number,title --jq '.[] | "pr#\\(.number) \\(.title)"' | lines)
  let selection = ($branches | append $prs_raw | gum choose --header "Select a branch or Pull Request" --height 20 | str trim)

  if ($selection | is-empty) {
    print "Cancelled."
    return
  }

  if ($selection | str starts-with "pr#") {
    let pr_number = ($selection | parse -r "pr#(?P<num>[0-9]+)" | get num.0)
    print $"Checking out Pull Request #($pr_number)..."
    gh pr checkout $pr_number
  } else {
    print $"Switching to branch '($selection)'..."
    git switch $selection
  }
}

# Create a tmux session named after the current directory
def tmd [] {
  let session_name = ($env.PWD | path basename)
  tmux new-session -A -s $session_name
}

# Manage tmux sessions interactively using tv
def tmg [] {
  if (which tv | is-empty) {
    print "Error: 'tv' is required for tmg."
    return
  }
  let repo = (do { tv git-repos --source-output '{}' --keybindings 'enter="confirm_selection"' } | str trim)
  if ($repo | is-empty) {
    return
  }
  let session = ($repo | path basename)

  let has_session = (do { tmux has-session -t $"=($session)" } | complete | get exit_code) == 0
  if not $has_session {
    tmux new-session -d -s $session -c $repo "nvim"
    let win_id = (tmux new-window -t $session -c $repo -P -F '#{window_id}' "agy --sandbox" | str trim)
    tmux split-window -h -t $win_id -c $repo
    tmux new-window -t $session -c $repo "gh dash"
  }

  if ($env.TMUX? | is-not-empty) {
    tmux switch-client -t $"=($session)"
  } else {
    tmux attach -t $"=($session)"
  }
}

# Print file info and show hexyl head
def info [...args: string] {
  if ($args | is-empty) {
    print "[i] Usage: path to file (options)"
  } else {
    let file_out = (do { file ...$args } | complete)
    if $file_out.exit_code == 0 {
      print $file_out.stdout
      hexyl ...$args | head -n 10
    } else {
      print -e $file_out.stderr
    }
  }
}

# Extract wav audio from YouTube using yt-dlp
def yt2wav [...args: string] {
  if ($args | is-empty) {
    print "[i] Usage: Enter a valid link (options)"
  } else {
    yt-dlp --extract-audio --audio-format wav ...$args
  }
}

# Extract mp3 audio from YouTube using yt-dlp
def yt2mp3 [...args: string] {
  if ($args | is-empty) {
    print "[i] Usage: Enter a valid link (options)"
  } else {
    yt-dlp --extract-audio --audio-format mp3 ...$args
  }
}

# Download video from YouTube using yt-dlp
def yt2mp4 [...args: string] {
  if ($args | is-empty) {
    print "[i] Usage: Enter a valid link (options)"
  } else {
    yt-dlp -S res,ext:mp4:m4a --recode mp4 ...$args
  }
}

# Save pip requirements to file
def pyreq [] {
  pip freeze | save -f requirements.txt
}

# Start a simple netcat tcp server logging to output.log
def tcp-server [] {
  cd /tmp
  loop {
    do { ^nc -l -p 4444 | ^tee output.log }
    sleep 1sec
  }
}

# Task runner helper using yq, gum, and task
def t [] {
  yq '.tasks | keys | .[]' Taskfile.yml | gum choose | xargs task
}


#
# Aliases
#

# Git
alias gaa = git add .
alias gcm = git commit -m
alias gd = git diff --cached
alias gsu = git submodule update --remote
alias gsa = git submodule add
alias gpush = git push -u origin
alias gpull = git pull
alias grb = git rebase
alias grbc = git rebase --continue
alias gch = git checkout
alias grr = git review -R
alias gwl = git worktree list
alias glog = git log --graph --topo-order --pretty="%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N" --abbrev-commit

# Eza (modern ls replacement)
alias ls = eza --icons
alias ll = eza -l --icons
alias l = eza -l -a --icons
alias tree = eza -l -a --icons --tree --ignore-glob=".git"
alias tre = eza -l -a --icons --tree --level 2 --ignore-glob=".git"

# Bat (modern cat replacement)
alias cat = bat -pp
alias less = bat --paging=always
alias catn = /bin/cat

# Zoxide (modern cd replacement)
# Note: We do NOT alias 'cd' to 'z' in Nushell.
# In Nushell, zoxide integrates natively via directory change hooks (env_change.PWD),
# so the built-in 'cd' automatically registers directories. Aliasing 'cd' to 'z'
# would cause infinite recursion. Use the built-in 'cd' to change directories,
# and use 'z' or 'zi' to jump using zoxide.
alias .. = z ..
alias ... = z ../..
alias .... = z ../../..
alias ..... = z ../../../..
alias ...... = z ../../../../../

# Neovim
alias v = nvim
alias vi = nvim
alias nano = nvim

# Tmux
alias tm = tmux new-session -A -s main
alias tma = tmux attach

# Nix
alias x = nix run .
alias nd = nix develop
alias nfu = nix flake update

# Direnv
alias da = direnv allow
alias dda = direnv disallow

# Clear typos / alias aliases
alias lcs = clear
alias cleare = clear
alias clea = clear
alias cear = clear
alias lcear = clear
alias clera = clear
alias celar = clear
alias cler = clear
alias claer = clear
alias clearc = clear
alias cleawr = clear
alias caler = clear
alias calar = clear
alias cclear = clear
alias rclear = clear
alias rlear = clear
alias rcle = clear
alias rcler = clear
alias cls = clear
alias csl = clear

# Others
alias j = just
alias o = once
alias df = duf
alias gr = go run .
alias nw = newsboat
alias rel = exec nu
alias gdb = gdb --quiet
alias www = sudo python3 -m http.server 80
alias ai = agy --sandbox
alias purl = curl -x http://127.0.0.1:8080/ -k
alias sql = sqlit
