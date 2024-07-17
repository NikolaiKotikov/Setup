function import-wg-config() {
  nmcli connection import type wireguard file "$@"
}

function jr() {
    cd $(find ~/Repos -maxdepth 3 -type d \( -path "*/node_modules" -path "*/.vscode" -o -path "*/.github" -o -path "*/.git" -o -path "*/.idea" \) -prune -o -type d -print | fzf)
}

function run_in_background() {
    ( "$@" & ) > /dev/null 2>&1
}

function ws() {
    run_in_background webstorm "$@"
}

function dump_tilix_config() {
    dconf dump /com/gexperts/Tilix/ > tilix.dconf
}

function reset_jb_trial() {
    for product in IntelliJIdea WebStorm; do
        echo "[+] Resetting trial period for $product"

        echo "[+] Removing Evaluation Key..."
        rm -rf ~/.config/$product*/eval 2> /dev/null

        # Above path not working on latest version, Fixed below
        rm -rf ~/.config/JetBrains/$product*/eval 2> /dev/null

        echo "[+] Removing all evlsprt properties in options.xml..."
        sed -i 's/evlsprt//' ~/.config/$product*/options/other.xml 2> /dev/null

        # Above path not working on latest version, Fixed below
        sed -i 's/evlsprt//' ~/.config/JetBrains/$product*/options/other.xml 2> /dev/null

        echo
    done

    echo "Removing userPrefs files..."
    rm -rf ~/.java/.userPrefs 2> /dev/null
}
