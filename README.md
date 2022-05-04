# bildo
an extremely tiny package manager

## why did you make this?
- installing and managing source-based packages on debian is a major pain

## pkg/repo
- <a href="https://github.com/draumaz/bildo/tree/main/pkg/repo">a disappointingly small collection of build scripts</a>

## commands
- ```./bildo --update``` git pulls your packages in pkg/src
- ```./bildo --upgrade``` upgrades your packages if i've written a build script for it

## install
- ```git clone https://github.com/draumaz/bildo```
- ```chmod +x bildo/bildo```
- ```mv ./bildo ~/Builds```

## tracking projects
- ```cd ~/Builds/pkg/src```
- ```git clone https://github.com/blahblah/coolrepo```

## CURRENT ISSUES
- Scripts have to constantly request superuser permissions during install
