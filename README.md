# despot
**d**raumaz's **e**lastic **s**ightless **p**ackage-**o**fficiation **t**ool.

this is a POSIX shell-compliant package manager focused on Debian (and soon Fedora) systems.

i have two goals with despot:

- collect strange, fascinating packages
- provide a convenient, fast, and __not annoying__ tool to maintain them

## install
- ```curl https://raw.githubusercontent.com/draumaz/despot/master/bootstrap.sh | sudo sh```

### compiling packages
- ```./despot install [PKG]```

### removing packages
- ```./despot uninstall [PKG]```

### learn more
- ```./despot help```

### the repo
- <a href="https://github.com/draumaz/despot-repo">where all the dbuilds are found.</a>
- a dbuild is a shell script that uses despot build functions and variables.
- contribution should be extremely simple - check out the <a href="https://github.com/draumaz/despot-repo/blob/master/skel.dbuild">skel.dbuild</a> if you're interested!

## contributors
- <a href="https://github.com/DeltaDove">DeltaDove</a> - project name
