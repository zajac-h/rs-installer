# Rust (game) server install script

## This script was created to make installing and using RustDedicated easier.

## Script dependencies:
##### • wget
##### • tmux
##### • [distro dependant](https://developer.valvesoftware.com/wiki/SteamCMD#Linux)

## Installation proces:
##### 1. Install required dependencies.
##### 2. Download [```rs.sh```](https://raw.githubusercontent.com/zajac-h/rs-installer/main/rs.sh) or clone this repo.
##### 3. Make the downloaded file executable (```chmod +x rs.sh```).
##### 4. Run ```./rs.sh install```.
##### 5. Change ```rcon.password``` in ```start.sh``` file.

After this five steps RustDedicated is ready for use as a vanilla server.
To change any server properties you simply edit ```start.sh``` file just like ```start.bat``` on Windows.

## Commands:
##### • ```./rs.sh install``` - installs SteamCMD and Rust server
##### • ```./rs.sh update``` - updates the server
##### • ```./rs.sh run``` - starts the server (opens new tmux session and executes ```start.sh```)
##### • ```./rs.sh oxide``` - installs oxide
##### • ```./rs.sh help``` - prints usage

## For newbies:
Tmux is a terminal multiplexer. It creates a new terminal in which your server runs.
This way you can always attach it (```tmux attach -t rustserver```) when you need to do something there and then detach it (```Ctrl + b  d```) and leave it running in the background. 
