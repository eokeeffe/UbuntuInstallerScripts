#!/usr/bin/env bash

wget -P /tmp/ http://eclipse.mirror.triple-it.nl/technology/epp/downloads/release/kepler/SR1/eclipse-standard-kepler-SR1-linux-gtk-x86_64.tar.gz

tar -xzf /tmp/eclipse-standard-kepler-SR1-linux-gtk-x86_64.tar.gz -C /opt/
chown -R root: /opt/eclipse/

cat <<- 'EOF' > /usr/bin/eclipse42
    #!/bin/sh    
    export ECLIPSE_HOME="/opt/eclipse"
    $ECLIPSE_HOME/eclipse "$@"
EOF

chmod +x /usr/bin/eclipse42

cat <<- EOF > /usr/share/applications/eclipse42.desktop
    [Desktop Entry]
    Encoding=UTF-8
    Name=Eclipse
    Comment=Eclipse IDE
    Exec=eclipse42
    Icon=/opt/eclipse/icon.xpm
    Terminal=false
    Type=Application
    Categories=GNOME;Application;Development;IDE;
    StartupNotify=true
EOF
