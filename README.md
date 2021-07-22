# offpkg - script to download apt packages offline


./offpkg [options] [programs]

        -a | --all = get, download and install the packets of the programs automatically
        -g | --get = just get the list of packets of the programs
        -i | --install = install the packets of the programs

                ./offpkg --all nmap whois
                ./offpkg -g dnsutils
                ./offpkg -i *
