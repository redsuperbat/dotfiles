show_git_branch() {
	local index icon color text module

	index=$1

	icon="$(get_tmux_option "@catppuccin_k8s_icon" "󰊢")"
	color="$(get_tmux_option "@catppuccin_k8s_color" "#e7eca3")"
	text="$(get_tmux_option "@catppuccin_k8s_text" "#(git -C \"#{pane_current_path}\" rev-parse --abbrev-ref  HEAD | cut -c1-30)")"

	module=$(build_status_module "$index" "$icon" "$color" "$text")

	echo "$module"
}
