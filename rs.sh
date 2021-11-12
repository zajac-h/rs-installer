#!/bin/bash
#Author: https://github.com/zajac-h 

i_flag='' #install RustDedicated
u_flag='' #update 
r_flag='' #run
o_flag='' #install oxide (uMod)
h_flag='' #print help

print_usage() {
    echo ""
    echo "Usage:"
    echo "  -i (--install) install Rust server"
    echo "  -u (--update) update Rust server"
    echo "  -r (--run) run Rust server"
    echo "  -o (--oxide) install or update Oxide (uMod)"
    echo "  -h (--help) print help"
    echo ""
}

space() {
    local message="$1"

    echo " "
    echo "${message}"
    echo " "
}

error() {
    local error_message="$1"
    echo "${error_message}"
    echo " "
    exit 1 
}

[ -z "$1" ] && print_usage  

while test $# -gt 0; do
    case "$1" in
        -i|--install) i_flag='true'                 && break ;;
        -u|--update) u_flag='true'                  && break ;;
        -r|--run) r_flag='true'                     && break ;;
        -o|--oxide) o_flag='true'                   && break ;;
        -h|--help) print_usage                      && exit 1 ;;
        *) echo "Unknown command." && print_usage   && exit 1 ;;
    esac
done


if [[ $i_flag == 'true' ]] ; then
    space "Installing Rust server."

    mkdir SteamCMD || error "Seems that SteamCMD is already installed. If you want to install it anyway delete SteamCMD directory." 
    cd SteamCMD 
    wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" || error "Failed to download SteamCMD."
    tar -vzxf steamcmd_linux.tar.gz || error "Failed to extract the archive."
    
    ./steamcmd.sh +login anonymous +force_install_dir .. +app_update 258550 validate +quit || error "Installation failed."
    
    cd ..

    echo './RustDedicated +server.port 28015 +server.level "Procedural Map" +server.seed 1234 +server.worldsize 4000 +server.maxplayers 25 +server.hostname "Server name" +server.description "Server description" +rcon.port 28016 +rcon.password changeitplease' > start.sh
    chmod +x start.sh

    space "Installed succesfully."
fi


if [[ $u_flag == 'true' ]] ; then
    space "Updating Rust server."

    cd SteamCMD || error "Seems that server isn't installed, make sure to install it first."
    ./steamcmd.sh +login anonymous +force_install_dir .. +app_update 258550 validate +quit || error "SteamCMD seems to be missing."
    cd ..

    echo " "
fi


if [[ $r_flag == 'true' ]] ; then
    space "Starting server."

    cat start.sh || error 'start.sh file not found. '

    tmux new-session -d -s rustserver './start.sh' || error "Tmux not found, make sure to install tmux before starting the server."
    tmux a
fi


if [[ $o_flag == 'true' ]] ; then
    space "Installing oxide."

    wget "https://umod.org/games/rust/download/develop" || error "Failed to download Oxide." 
    mv develop oxide.zip
    echo " "
    unzip -o oxide.zip
    rm oxide.zip

    space "Oxide installed succesfully."
fi


exit 0
