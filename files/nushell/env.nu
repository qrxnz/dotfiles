# env.nu
# Nushell Environment Config File
# Mapped from .zshrc and ~/.config/zshrc/zshrc

# Directories to search for scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

# Directories to search for plugin binaries
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# Homebrew initialization (macOS)
if ("/opt/homebrew/bin/brew" | path exists) {
    $env.HOMEBREW_PREFIX = "/opt/homebrew"
    $env.HOMEBREW_CELLAR = "/opt/homebrew/Cellar"
    $env.HOMEBREW_REPOSITORY = "/opt/homebrew"
    
    $env.PATH = (
        $env.PATH
        | prepend "/opt/homebrew/bin"
        | prepend "/opt/homebrew/sbin"
        | uniq
    )
    
    $env.INFOPATH = (
        $env.INFOPATH? | default []
        | split row (char esep) 
        | prepend "/opt/homebrew/share/info" 
        | uniq
    )
}

# Add local bin, cargo, and go paths
$env.PATH = (
    $env.PATH
    | prepend "/Users/qrxnz/.local/bin"
    | prepend $"($env.HOME)/.local/bin"
    | append "/Users/qrxnz/.lmstudio/bin"
    | append $"($env.HOME)/.cargo/bin"
    | append $"($env.HOME)/go/bin"
    | uniq
)

# Go configuration
$env.GOPATH = $"($env.HOME)/go"
if ($env.GOROOT? | is-not-empty) {
    $env.PATH = ($env.PATH | append $"($env.GOROOT)/bin")
}

# Terminal environment
$env.TERM = "xterm-256color"

# Bat theme
$env.BAT_THEME = "Catppuccin Mocha"

# Nix configuration path
$env.NIX_CONF_DIR = $"($env.HOME)/.config/nix"

# Colima / Docker configuration
$env.DOCKER_HOST = $"unix://($env.HOME)/.colima/default/docker.sock"

# Function to source POSIX shell scripts (e.g. for Nix) and load their environment variables
def --env source-sh-env [script_path: string] {
    if ($env | get -o _NUSHELL_SOURCING_SH_ENV | is-not-empty) {
        return
    }
    let expanded_path = ($script_path | path expand)
    if ($expanded_path | path exists) {
        let env_out = (do {
            with-env { _NUSHELL_SOURCING_SH_ENV: "1" } {
                bash --norc --noprofile -c $"source '($expanded_path)' && env"
            }
        } | complete)
        if $env_out.exit_code == 0 {
            let env_rows = ($env_out.stdout 
                | lines 
                | parse -r '^(?P<key>[^=]+)=(?P<value>.*)$'
            )
            
            for row in $env_rows {
                if ($row.key | str starts-with "NIX_") or $row.key == "NIX_SSL_CERT_FILE" or $row.key == "NIX_PATH" {
                    load-env { ($row.key): $row.value }
                } else if $row.key == "PATH" {
                    let new_paths = ($row.value | split row (char esep))
                    $env.PATH = ($env.PATH | append $new_paths | uniq)
                }
            }
        }
    }
}

# Source Nix environment if profiles exist
source-sh-env $"($env.HOME)/.nix-profile/etc/profile.d/nix.sh"
source-sh-env "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"

# Cache directory for dynamically initialized tools
let cache_dir = ($env.HOME | path join ".cache" "nushell")
if not ($cache_dir | path exists) {
    mkdir $cache_dir
}

# Initialize starship prompt
let starship_init_path = ($cache_dir | path join "starship_init.nu")
if (which starship | is-not-empty) {
    starship init nu | save -f $starship_init_path
} else {
    # Write empty file to prevent Nushell parse errors
    "" | save -f $starship_init_path
}

# Initialize zoxide
let zoxide_init_path = ($cache_dir | path join "zoxide_init.nu")
if (which zoxide | is-not-empty) {
    zoxide init nushell --cmd cd | save -f $zoxide_init_path
} else {
    # Write empty file to prevent Nushell parse errors
    "" | save -f $zoxide_init_path
}
