# Setup

In order to start working with the code contained within this folder, you must first install a few things!

## Linux

```bash
sudo apt install build-essential # Needed to install the g++ compiler command!
sudo apt install libboost-all-dev # Boost C++ Libraries
```

> [!NOTE]
> On Linux, the command `g++` will be available for use after all of this.

## Windows

On Windows, you need to install [MSYS2](https://www.msys2.org/)!

After installing *MSYS2*, you need to install the following pacman packages:

```bash
pacman -Syu # Update the package lists
pacman -S mingw-w64-x86_64-gcc # Install the C++ compiler
pacman -S mingw-w64-x86_64-boost # Boost C++ Libraries
```

> [!NOTE]
> On Windows, the command `gcc` will be available for use after all of this.
