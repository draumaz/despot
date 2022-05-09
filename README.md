# despot
**d**raumaz's **e**lastic **s**ightless **p**ackage-**o**fficiation **t**ool.

- i switched to debian in april 2022, and despite enjoying it a lot, i noticed a lot of tiny packages were missing, and there weren't even any alternate repos to find them from.
- i started building packages manually, until i started automating the process, where despot was born.

## install
- ```git clone https://github.com/draumaz/despot```
- ```cd despot; chmod +x despot```

### compiling packages
- ```./despot --install [PKG]```

### removing packages
- ```./despot --remove [PKG]```

### learn more
- ```./despot --help```

## available build scripts
- <a href="https://github.com/draumaz/despot/tree/main/pkg/repo">pkg/repo</a>
- the repo will remain extremely small, as i will only be maintaining packages i personally need.

## contributors
- <a href="https://github.com/DeltaDove">DeltaDove</a> - project name

## CURRENT ISSUES
- Some scripts have to constantly request superuser permissions during install.
