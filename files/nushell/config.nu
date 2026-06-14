# config.nu
# Nushell Configuration File
# Mapped from .zshrc and ~/.config/zshrc/zshrc

#
# Theme (Rosé Pine)
#
let base = "#191724"
let surface = "#1f1d2e"
let overlay = "#26233a"
let muted = "#6e6a86"
let subtle = "#908caa"
let text = "#e0def4"
let love = "#eb6f92"
let gold = "#f6c177"
let rose = "#ebbcba"
let pine = "#31748f"
let foam = "#9ccfd8"
let iris = "#c4a7e7"

let color_config = {
    separator: $text
    leading_trailing_space_bg: { attr: 'n' }
    header: { fg: $rose, attr: b }
    empty: $foam
    bool: {|| if $in { $pine } else { $gold } }
    int: $iris
    filesize: {|e|
        if $e == 0b {
            $text
        } else if $e < 1mb {
            $pine
        } else {
            { fg: $foam }
        }
    }
    duration: $gold
    date: {|| (date now) - $in |
        if $in < 1hr {
            { fg: $text, attr: b }
        } else if $in < 6hr {
            $text
        } else if $in < 1day {
            $gold
        } else if $in < 3day {
            $rose
        } else if $in < 1wk {
            { fg: $rose, attr: b }
        } else if $in < 6wk {
            $pine
        } else if $in < 52wk {
            $foam
        } else { 'dark_gray' }
    }
    range: $gold
    float: $text
    string: $rose
    nothing: $text
    binary: $iris
    cell-path: $text
    row_index: { fg: $rose, attr: b }
    record: $pine
    list: $pine
    block: $foam
    hints: $muted
    search_result: { fg: $base, bg: $text }
    shape_and: { fg: $iris, attr: b }
    shape_arrow: { fg: $iris, attr: b }
    shape_binary: { fg: $iris, attr: b }
    shape_block: { fg: $foam, attr: b }
    shape_bool: $pine
    shape_closure: { fg: $pine, attr: b }
    shape_custom: $rose
    shape_datetime: { fg: $pine, attr: b }
    shape_directory: $pine
    shape_external: $pine
    shape_external_resolved: $pine
    shape_externalarg: { fg: $rose, attr: b }
    shape_filepath: $pine
    shape_flag: { fg: $foam, attr: b }
    shape_float: { fg: $text, attr: b }
    shape_garbage: { fg: "#FFFFFF", bg: "#FF0000", attr: b }
    shape_glob_interpolation: { fg: $pine, attr: b }
    shape_globpattern: { fg: $pine, attr: b }
    shape_int: { fg: $iris, attr: b }
    shape_internalcall: { fg: $pine, attr: b }
    shape_keyword: { fg: $iris, attr: b }
    shape_list: { fg: $pine, attr: b }
    shape_literal: $foam
    shape_match_pattern: $rose
    shape_matching_brackets: { attr: 'u' }
    shape_nothing: $text
    shape_operator: $gold
    shape_or: { fg: $iris, attr: b }
    shape_pipe: { fg: $iris, attr: b }
    shape_range: { fg: $gold, attr: b }
    shape_record: { fg: $pine, attr: b }
    shape_redirection: { fg: $iris, attr: b }
    shape_signature: { fg: $rose, attr: b }
    shape_string: $rose
    shape_string_interpolation: { fg: $pine, attr: b }
    shape_table: { fg: $foam, attr: b }
    shape_variable: $iris
    shape_vardecl: { fg: $foam, attr: u }
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
  | upsert env_change {
    PWD: [
      {
        code: { |before, after|
          if (which direnv | is-not-empty) {
            direnv export json | from json | default {} | load-env
          }
        }
      }
    ]
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
  git clone --recursive $"git@github.com:($repo).git"
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

# Database query helper using Nushell open and query db
def db-query [db_file: path, query: string] {
  open $db_file | query db $query
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

# Fuzzy cd using fd and fzf
def --env fcd [] {
  let target = (fd --type d --hidden --exclude .git --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv --exclude .direnv | fzf | str trim)
  if ($target | is-not-empty) {
    z $target
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

# Zoxide (modern cd replacement)
# In Nushell, we hook cd to zoxide using `--cmd cd` in env.nu.

alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../..
alias ...... = cd ../../../../../

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
alias rel = exec nu
alias gdb = gdb --quiet
alias cds = du -h --max-depth=1 .
alias www = sudo python3 -m http.server 80
alias ai = opencode
alias purl = curl -x http://127.0.0.1:8080/ -k
alias sql = sqlit
