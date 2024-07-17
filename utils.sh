if ! command -v gum &> /dev/null; then
    cd "$HOME"/Downloads
    GUM_VERSION="0.14.1" # Use known good version
    wget -O gum.deb "https://github.com/charmbracelet/gum/releases/latest/download/gum_${GUM_VERSION}_amd64.deb"
    sudo apt install -y ./gum.deb
    rm gum.deb
fi

ensure_installed() {
    local program=$1
    if ! command -v "$program" &> /dev/null; then
        if confirm "Please ensure $program is installed"; then
            ensure_installed $program
        else
            return 1
        fi
    fi
    return 0
}

print_colored_message() {
  local message="$1"
  local color="$2"

  case "$color" in
    "info")
      gum style --foreground "#00ffff" "$message" ;; # Blue color
    "success")
      gum style --foreground "#00ff00" "$message" ;; # Green color
    "error")
      gum style --foreground "#ff0000" "$message" ;; # Red color
    *)
      echo "$message" ;; # No color specified, print the message as is
  esac
}

input() {
  local message="$1"
  gum input --placeholder "$message"
}

print_info() {
  local message="$1"
  print_colored_message "$message" "info"
}

print_success() {
  local message="$1"
  print_colored_message "$message" "success"
}

print_error() {
  local message="$1"
  print_colored_message "$message" "error"
}

prompt() {
  print_success "$1"
  gum input --placeholder "Press Enter to continue"
}

confirm() {
  local message="$1"
  gum confirm "$message" --default=1
  local response=$?

  if [[ $response -eq 1 ]]; then
    return 1
  elif [[ $response -eq 0 ]]; then
    return 0
  else
    print_error "Invalid response. Please try again."
    confirm "$message"
  fi
}

generate_ssh_key() {
  ssh_key_file=~/.ssh/id_rsa

  # Check if the key file exists
  if [ -f "$ssh_key_file" ]; then
      print_info "SSH key already generated."
  else
      # Generate a new SSH key
      ssh-keygen -t rsa -b 4096 -N "" -f $ssh_key_file

      # Check the success of key generation
      if [ $? -eq 0 ]; then
          print_success "SSH key successfully generated."
      else
          print_error "Error generating SSH key."
      fi
  fi
}

copy_ssh_key_to_clipboard() {
  pub_key=$(cat ~/.ssh/id_rsa.pub)

  echo -n "$pub_key" | xclip -selection clipboard

  if [ $? -eq 0 ]; then
      print_success "SSH key successfully copied to clipboard"
      print_info "Now you can paste your key to Gitlab/Github."
  else
    print_error "Copy ssh key to clipboard failed"
  fi
}

create_symbolic_link() {
  local from="$1"
  local to="$2"

  print_info "creating symlink from $from to $to"

  sudo ln -sf "$from" "$to"

  if [[ $? -eq 0 ]]; then
    print_success "created symlink from $from to $to"
  else
    print_error "failed to create symlink from $from to $to"
  fi
}

create_symbolic_links() {
  # Check the arguments passed to the function
  if [ $# -ne 2 ]; then
    print_error "Error: The function should take two arguments: source directory and destination directory."
    return 1
  fi

  source_dir="$1"
  destination_dir="$2"

  # Check if the directories exist
  if [ ! -d "$source_dir" ]; then
    print_error "Error: Source directory '$source_dir' does not exist."
    return 1
  fi

  if [ ! -d "$destination_dir" ]; then
    print_error "Error: Destination directory '$destination_dir' does not exist."
    return 1
  fi

  # Change to the source directory
  cd "$source_dir" || return

  # Get a list of all files in the directory (excluding subdirectories)
  files=$(find . -maxdepth 1 -type f -printf "%f\n")

  # Iterate over the files and create symbolic links in the destination directory
  for file in $files; do
    # Create a symbolic link to the file in the destination directory

    create_symbolic_link "$source_dir/$file" "$destination_dir/$file"
  done
}

ensure_installed() {
    local program=$1
    if ! command -v "$program" &> /dev/null; then
        if confirm "Please ensure $program is installed"; then
            ensure_installed $program
        else
            return 1
        fi
    fi
    return 0
}

run_in_background() {
    ( "$@" & ) > /dev/null 2>&1
}

execute_script() {
    local script="$1"
    if [ -f "$script" ]; then
        print_info "Executing: $script"
        . "$script" || {
            print_error "Error executing $script"
            continue
        }
    else
        print_error "$script is not a valid file."
    fi
}

declare -a success_messages
declare -a error_messages
print_results() {
    print_info "================================"
    print_info "Successful executions:"
    print_info "================================"
    for msg in "${success_messages[@]}"; do
        print_success "$msg"
    done

    if [ ${#error_messages[@]} -gt 0 ]; then
        print_info "================================"
        print_info "Failed executions:"
        print_info "================================"
        for msg in "${error_messages[@]}"; do
            print_error "$msg"
        done
    else
        print_info "No failed executions."
    fi
}


execute_script() {
    local script="$1"
    if [ -f "$script" ]; then
        print_info "Executing: $script"
        . "$script"
        if [ $? -eq 0 ]; then
            success_messages+=("Successfully executed: $script")
        else
            error_messages+=("Error executing: $script")
        fi
    else
        print_info "There is no $script file."
    fi
}

execute_scripts_in_directory() {
    local target_directory="$1"
    for script in "$target_directory"/*.sh; do
        execute_script $script
    done
}


load() {
    local target="$1"
    local next="$target"/next

    execute_scripts_in_directory "$target"

    if [[ -d "$next" ]]; then
        load "$next"
    fi
}
