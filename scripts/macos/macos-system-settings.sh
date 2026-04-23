#!/bin/zsh

set -euo pipefail

ACTIVATE_SETTINGS="/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings"
GREEN=$'\033[32m'
RED=$'\033[31m'
BLUE=$'\033[34m'
RESET=$'\033[0m'

prompt_choice() {
  local allow_quit=""
  if [[ "$1" == "--quit-on-q" ]]; then
    allow_quit=1
    shift
  fi
  local prompt="$1"
  shift
  local -a options=("$@")
  local choice=""

  while true; do
    echo
    echo "$prompt"
    local i=1
    for option in "${options[@]}"; do
      printf '  %d) %s\n' "$i" "$option"
      ((i++))
    done
    printf '> Enter a number and press Return: '
    read -r choice

    if [[ -n "$allow_quit" && "$choice" == [qQ] ]]; then
      REPLY="Quit"
      return 0
    fi
    if [[ "$choice" == <-> ]] && (( choice >= 1 && choice <= ${#options[@]} )); then
      REPLY="${options[$choice]}"
      return 0
    fi

    echo "${RED}Invalid choice. Enter a number between 1 and ${#options[@]}, or q to quit.${RESET}"
  done
}

ask_keep_enable_disable() {
  prompt_choice "$1" "Keep current setting" "Enable" "Disable"

  case "$REPLY" in
    "Keep current setting") REPLY="keep" ;;
    "Enable") REPLY="enable" ;;
    "Disable") REPLY="disable" ;;
  esac
}

restart_dock() {
  killall Dock >/dev/null 2>&1 || true
}

refresh_system_settings() {
  if [[ -x "$ACTIVATE_SETTINGS" ]]; then
    "$ACTIVATE_SETTINGS" -u >/dev/null 2>&1 || true
  fi
}

hot_corner_value() {
  case "$1" in
    "Disable") echo 0 ;;
    "Mission Control") echo 2 ;;
    "Application Windows") echo 3 ;;
    "Desktop") echo 4 ;;
    "Start Screen Saver") echo 5 ;;
    "Disable Screen Saver") echo 6 ;;
    "Put Display to Sleep") echo 10 ;;
    "Launchpad") echo 11 ;;
    "Notification Center") echo 12 ;;
    "Lock Screen") echo 13 ;;
    "Quick Note") echo 14 ;;
    *) return 1 ;;
  esac
}

zoom_modifier_mask() {
  case "$1" in
    "Control") echo 262144 ;;
    "Option") echo 524288 ;;
    "Command") echo 1048576 ;;
    *) return 1 ;;
  esac
}

configure_tap_to_click() {
  ask_keep_enable_disable "Trackpad > Point & Click > Tap to click"

  case "$REPLY" in
    keep) return 0 ;;
    enable)
      defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
      defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
      defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
      defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
      ;;
    disable)
      defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
      defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
      defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
      defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
      ;;
  esac

  refresh_system_settings
  echo "${GREEN}Updated Tap to click.${RESET}"
}

configure_natural_scrolling() {
  ask_keep_enable_disable "Trackpad > Scroll & Zoom > Natural scrolling"

  case "$REPLY" in
    keep) return 0 ;;
    enable) defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true ;;
    disable) defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false ;;
  esac

  echo "${GREEN}Updated Natural scrolling.${RESET}"
}

configure_dock_autohide() {
  ask_keep_enable_disable "Desktop & Dock > Automatically hide and show the Dock"

  case "$REPLY" in
    keep) return 0 ;;
    enable) defaults write com.apple.dock autohide -bool true ;;
    disable) defaults write com.apple.dock autohide -bool false ;;
  esac

  restart_dock
  echo "${GREEN}Updated Dock auto-hide.${RESET}"
}

configure_minimize_effect() {
  prompt_choice \
    "Desktop & Dock > Minimize windows using" \
    "Keep current setting" \
    "Scale effect" \
    "Genie effect"

  case "$REPLY" in
    "Keep current setting") return 0 ;;
    "Scale effect") defaults write com.apple.dock mineffect -string scale ;;
    "Genie effect") defaults write com.apple.dock mineffect -string genie ;;
  esac

  restart_dock
  echo "${GREEN}Updated Dock minimize effect.${RESET}"
}

configure_mru_spaces() {
  ask_keep_enable_disable "Desktop & Dock > Mission Control > Automatically rearrange Spaces based on most recent use"

  case "$REPLY" in
    keep) return 0 ;;
    enable) defaults write com.apple.dock mru-spaces -bool true ;;
    disable) defaults write com.apple.dock mru-spaces -bool false ;;
  esac

  restart_dock
  echo "${GREEN}Updated automatic Spaces rearranging.${RESET}"
}

configure_group_windows_by_app() {
  ask_keep_enable_disable "Desktop & Dock > Mission Control > Group windows by application"

  case "$REPLY" in
    keep) return 0 ;;
    enable) defaults write com.apple.dock expose-group-apps -bool true ;;
    disable) defaults write com.apple.dock expose-group-apps -bool false ;;
  esac

  restart_dock
  echo "${GREEN}Updated window grouping in Mission Control.${RESET}"
}

configure_drag_to_mission_control() {
  ask_keep_enable_disable "Desktop & Dock > Mission Control > Drag windows to top of screen to enter Mission Control"

  case "$REPLY" in
    keep) return 0 ;;
    enable) defaults write com.apple.dock enterMissionControlByTopWindowDrag -bool true ;;
    disable) defaults write com.apple.dock enterMissionControlByTopWindowDrag -bool false ;;
  esac

  restart_dock
  echo "${GREEN}Updated drag-to-Mission-Control behavior.${RESET}"
}

configure_hot_corners() {
  local -a corner_names=("Top-left" "Top-right" "Bottom-left" "Bottom-right")
  local -a corner_codes=("tl" "tr" "bl" "br")
  local idx=1

  for idx in {1..4}; do
    prompt_choice \
      "Hot Corners > ${corner_names[$idx]}" \
      "Keep current setting" \
      "Disable" \
      "Mission Control" \
      "Application Windows" \
      "Desktop" \
      "Start Screen Saver" \
      "Disable Screen Saver" \
      "Put Display to Sleep" \
      "Apps (Launchpad)" \
      "Notification Center" \
      "Lock Screen" \
      "Quick Note"

    if [[ "$REPLY" == "Keep current setting" ]]; then
      continue
    fi

    defaults write com.apple.dock "wvous-${corner_codes[$idx]}-corner" -int "$(hot_corner_value "$REPLY")"
    defaults write com.apple.dock "wvous-${corner_codes[$idx]}-modifier" -int 0
  done

  restart_dock
  echo "${GREEN}Updated Hot Corners.${RESET}"
}

main() {
  echo "${BLUE}macOS System Settings Helper${RESET}"
  echo "${BLUE}Choose a setting to update. Press Ctrl+C or type q to exit.${RESET}"

  while true; do
    prompt_choice --quit-on-q \
      "Which macOS setting would you like to change?" \
      "Trackpad: Tap to click" \
      "Trackpad: Natural scrolling" \
      "Dock: Automatically hide and show the Dock" \
      "Dock: Minimize windows using" \
      "Mission Control: Automatically rearrange Spaces" \
      "Mission Control: Group windows by application" \
      "Mission Control: Drag windows to top of screen" \
      "Hot Corners" \
      "Quit"

    case "$REPLY" in
      "Trackpad: Tap to click") configure_tap_to_click ;;
      "Trackpad: Natural scrolling") configure_natural_scrolling ;;
      "Dock: Automatically hide and show the Dock") configure_dock_autohide ;;
      "Dock: Minimize windows using") configure_minimize_effect ;;
      "Mission Control: Automatically rearrange Spaces") configure_mru_spaces ;;
      "Mission Control: Group windows by application") configure_group_windows_by_app ;;
      "Mission Control: Drag windows to top of screen") configure_drag_to_mission_control ;;
      "Hot Corners") configure_hot_corners ;;
      "Quit") exit 0 ;;
    esac
  done
}

main "$@"
