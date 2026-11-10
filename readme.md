# TeREp 2 build environment and guide

I created this project because I wanted a separate build environmet for this awesome project, what unfortunately haven't had the binaries in it.
Disclaimer, I'm not a C developer, I just put this together with some help from LLM.
I will try to be very details so someone with zero experience would be able to follow.

I wrote this guide from the state of this commit, I will occasionally try to update the guide if it breaks, but at this stage it works.
https://github.com/harrison3000/terep2-re/commit/9319f3e17fbdfadce236afa8ef0830602581a243

### pre-requisit
I assume you are on Linux and you must have docker on your system. If not, you can follow the guide from [digitalocean](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04) to install it.

## Steps for Linux build - (in the linux folder)
1. clone this repository to a folder:

`git clone https://github.com/Bacce/terep2-re-build-guide`

2. run the following command in one terminal:

`docker compose up --build`

3. When it finishes with the installs, you could connect to it from another terminal with the following command:

`docker compose exec build bash`

4. clone the project with the following command:

`git clone https://github.com/harrison3000/terep2-re.git`

5. open the folder

`cd terep2-re`

6. get the submodules for the project

`git submodule update --init --recursive`

7. create the build folder

`mkdir build`

8. run the build command (the shell script fails because the parameter order is not correct for this setup, so I run this command instead of the build_linux.sh)

`gcc -Og -g sdl_port/the_thing.c lifted/maincode.c lifted/othathings.c insulator/insulator.c -lSDL3 -lm -o build/terep2re_sdl`

9. exit from the docker environment

`exit`

10. in the build folder you should find the terep2re_sdl file, copy it into a terep 2 folder

11. you might need to install dependencies on the base system, I needed this:

`sudo apt install libsdl3-0`

12. run the executable from the game folder


## Steps for Windows build from Linux - (in the windows folder)

1-6. same as for linux build

7. make the shell script executable

`chmod +x build_windows.sh`

8. run the build

`./build_windows.sh`

9. exit from the docker environment

`exit`

10. in the build folder you should find the terep2re32.exe and terep2re64.exe files, copy it into a terep 2 folder, ignore the rest of the .o files

11. run the executable from the game folder

