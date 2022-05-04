# bildo
an extremely tiny package manager

## commands
- ```./bildo update``` git pulls your packages in pkg/src
- ```./bildo upgrade``` upgrades your packages if i've written a build script for it

## pkg/repo
- a disappointingly small collection of build scripts
- feast your eyes upon them <a href="https://github.com/draumaz/bildo/tree/main/pkg/repo">here</a>

## install
- ```git clone https://github.com/draumaz/bildo```
- ```chmod +x bildo/bildo```
- ```mv ./bildo ~/Builds```

## loading projects
- ```mkdir ~/Builds/pkg/src && cd ~/Builds/pkg/src```
- ```git clone https://github.com/blarg/coolrepo```
