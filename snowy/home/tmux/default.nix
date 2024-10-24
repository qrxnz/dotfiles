{
  pkgs,
  config,
  username,
  ...
}: {
  programs.tmux = {
	  enable = true;
	  clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery false
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10

          # left icon
          set -g @dracula-show-left-icon session

          # modules
          set -g @dracula-plugins "network-ping cpu-usage ram-usage"
        '';
      }
    ];

	extraConfig = ''
    # Bar position
    set-option -g status-position top

    # Mouse on
		set -g mouse on

    # Base index
    set -g base-index 1

    # Renumber all windows when any window is closed
    set -g renumber-windows on

    # Set the control character to Ctrl+Spacebar (instead of Ctrl+B)
    set -g prefix C-space
    unbind-key C-b
    bind-key C-space send-prefix

    # Set new panes to open in current directory
    bind c new-window -c "#{pane_current_path}"
    bind '"' split-window -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
	'';
  };
}
