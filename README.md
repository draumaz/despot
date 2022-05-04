# bildo
an extremely tiny package manager

## why did you make this?
- installing <a href="https://github.com/Airblader/i3">i3-gaps</a> on debian is a major pain
- automation makes life a little less agonizing

## commands
- ```./bildo --update``` git pulls your packages in pkg/src
- ```./bildo --upgrade``` upgrades your packages if i've written a build script for it

## pkg/repo
- <a href="https://github.com/draumaz/bildo/tree/main/pkg/repo">a disappointingly small collection of build scripts</a>

## install
- ```git clone https://github.com/draumaz/bildo```
- ```chmod +x bildo/bildo```
- ```mv ./bildo ~/Builds```

## loading projects
- If you haven't already, ```mkdir -p ~/Builds/pkg/src```
- ```cd ~/Builds/pkg/src```
- ```git clone https://github.com/blahblah/coolrepo```

## CURRENT ISSUES
- ```./bildo --upgrade``` will upgrade all packages, even when it's not necessary
- Scripts have to constantly request superuser permissions during install
