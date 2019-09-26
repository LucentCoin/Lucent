# Lucent Core v0.12.3.3 Setup Debian + Masternode Setup #
## Introductory ##

Welcome to the Lucent Core v0.12.3.3 Masternode Setup! This document will try to teach you or at least guide you towards the right direction to running a Masternode on your Debian device, more inclined towards the Raspberry Pi.

If you do get lost at some point point throughout this document, feel free to contact the Lucent Core Community at the [Official Lucent Core Discord Server](https://discord.gg/28Vbdeq), or read up on the official documentation found both at the [Lucent Core Documentations](https://github.com/LucentCoin/Lucent/tree/master/doc) and [Lucent Sentinel GitHub](https://github.com/C1ph3r117/Lucent-Sentinel).

## Masternode FAQ ##

If you intend on setting up a masternode along with Lucent Core, check out [TODO: MAKE MASTERNODE FAQ DOC OR SOMETHING SIMILAR].

## Optional Procedures ##

If the guide didn't ask you to read this part, feel free to ignore this section.

* Swap Memory
  * Swap memory can be very useful for Debian devices that do not have a lot of RAM and processing power to efficiently run complex programs. By adding swap memory to your system, it will enable the ability to run more complex programs without running out of memory. Of course, there is a downside to swap memory, so we do not recommend going over 2x the amount of RAM you already have. Swap memory can only be done if you have enough space on your system.
* Procedure:
  * `swapoff -a` to turn off all swap memory so you're able to modify, add, or extend your swap memory.
  * `sudo fallocate -l 2G /var/swap-0` creates a 2 GB swap file in `/var/` named `swap-0`. You can change the value as needed.
  * ` sudo chmod 600 /var/swap-0` sets the permissions so that only the owner can read/write.
  * `sudo mkswap /var/swap-0` prepares the file to be used as swapping space for the system.
  * `sudo swapon -a` enables the swap partition `/var/swap-0` and any other partitions already prepared.
  * Verify the new swap partition is working by `sudo swapon --show`
  * To make this swap partition permanent, you must add it to a `fstab` file by `sudo nano /etc/fstab` and write the line: `/var/swap-0 swap swap sw 0 0`
  * You can check via `swapon -l` that the partition is active.
 
## Prerequisites ##
* Debian-Based device that can reliably run for long periods of time, preferably 24/7.
* At least 4 GB of storage capacity for Lucent Core, required packages, swap memory, and the blockchain.
* Stable connection to the internet.
 * Allow your device to receive incoming requests. Make sure it is visible to the outside world.
* **For masternode setup,** have at least 16k (16,000.00) Lucent to yourself.

## Build Instructions ##
1. Run `sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade` to ensure your system is up-to-date.
2. If your system does not have the **unzip package** installed, you can install it by `sudo apt install unzip`
3. Download the necessary build requirements by running `sudo apt-get install build-essential libtool autotools-dev automake pkg-config lbssl-dev libevent-dev bsdmainutils`
4. Run `wget https://github.com/LucentCoin/Lucent/archive/v0.12.3.3.zip && unzip v0.12.3.3.zip && rm v0.12.3.3.zip && cd Lucent-0.12.3.3` to download the release file, then unzip, remove the zip file, and enter the unzipped folder.
5. Run `./autogen.sh` and wait for it to complete.
6. Run `./configure --without-gui --with-incompatible-bdb`.
   1. You can remove the flag `--without-gui` if you'd like a GUI, but you'll need to read some portions of the [UNIX build documentation](https://github.com/LucentCoin/Lucent/blob/master/doc/build-unix.md)
7. Before continuing, the following process WILL consume your RAM and will take a very long time to complete. Run the command `sudo make` to begin the process, or `sudo make -j[X]` "X" representing the amount of parallel jobs (should be less than the amount of CPU cores your system has).
   1. If you need to, please proceed to do the **Swap Memory** optional procedure, and come back to this when you are done. You may need this if your system cannot `make` the project.
8. Run `sudo make install`
9. Run `cd && cd .lucentcore/`
10. Run `wget https://github.com/LucentCoin/Lucent/releases/download/v0.12.3.3/lucent_conf_updated_5_6_19.zip && unzip lucent_conf_updated_5_6_19.zip` and you will be prompted if you'd like to replace "lucent.conf," in which you will type `Y` then `ENTER`.
11. To verify Lucent Core has been successfully installed, run `lucentd --daemon` and give it a few seconds, then run `lucent-cli getmininginfo` which you should check every few seconds to see if it is downloading the blockchain.

## Sentinel Installation and Setup ##
If you plan to run a Lucent Masternode, you will need to install **Sentinel,** which is crucial to running a Masternode (MN) otherwise your MN may enter a state of "SENTINEL_PING_EXPIRED," in which you will NOT be paid!

# Procedures #
1. Run `cd`
2. You'll need to ensure you have Python version 2.7.x or above installed by running `python --version`.
3. Update system packages if you haven't already done by running `sudo apt-get update`.
4. Install **virtualenv** by running `sudo apt-get -y install python-virtualenv`
5. Install **Sentinel** by running `git clone https://github.com/C1ph3r117/Lucent-Sentinel.git && cd Lucent-Sentinel && virtualenv ./venv && ./venv/bin/pip install -r requirements.txt`
6. Prepare a **crontab entry** to call Sentinel every minute by running `crontab -e`
7. In the entry, type `* * * * * cd [PATH] && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1`
  7. Make sure to replace "[PATH]" to the directory of Lucent-Sentinel.
8. Alternatively, you can also configure **sentinel.conf** in Lucent-Sentinel/ to point to your **lucent.conf** by running `sudo nano sentinel.conf` and writing in the lines `lucent_conf=[PATH]/lucent.conf` with [PATH] directing to where `.lucentcore/lucent.conf` is.
