show_k8s() {
	local index icon color text module

	index=$1

	icon="$(get_tmux_option "@catppuccin_k8s_icon" "󰻈")"
	color="$(get_tmux_option "@catppuccin_k8s_color" "$thm_orange")"
	text="$(get_tmux_option "@catppuccin_k8s_text" "#(kubectl config current-context)")"

	module=$(build_status_module "$index" "$icon" "$color" "$text")

	echo "$module"
}
