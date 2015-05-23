#!/usr/bin/env bash

# Simple and more or less error prone eclipse installer.
# It works on newer version of Ubuntu. Debian and Fedora based
# distributions should work too. So should Mac OS X. But it may
# fial. There's no distro specific version checking. Nothing but
# Ubuntu was ever tested. The script does not even care if you
# have 64-bit os. It just assume you have.

ECLIPSE_MIRROR="http://carroll.aset.psu.edu/pub/eclipse/technology/epp/downloads/release"
ECLIPSE_VERSION="luna"
ECLIPSE_RELEASE="SR2"

eclipse_home="${1:-$HOME/eclipse.$ECLIPSE_VERSION.$ECLIPSE_RELEASE.scala}"

mkdir -p "$eclipse_home"

if ! uname -a | grep '^Darwin\|^Linux' >/dev/null; then
  echo "Unsupported OS - neither linux, neither mac os!"
  exit 1
fi

#which git >/dev/null || sudo apt-get install -y git
#mvn -version 2>&1 | grep 'Apache Maven 3\.' >/dev/null || sudo apt-get install -y maven

if ! javac -version 2>&1 | grep '1\.7\.' >/dev/null; then
  echo ">>>> installing jdk..."
  which apt-get >/dev/null && ( dpkg -s openjdk-7-jdk >/dev/null 2>&1 || sudo apt-get install -y openjdk-7-jdk ) # openjdk-7-source
  which yum >/dev/null && su -c "yum install java-1.7.0-openjdk"
  uname -a | grep '^Darwin' >/dev/null && echo "WARNING: No java 7 compiler found on PATH. You should install one!"
fi

uname -a | grep '^Linux' >/dev/null && arch="linux-gtk-x86_64"
uname -a | grep '^Darwin' >/dev/null && arch="macosx-cocoa-x86_64"
filename="eclipse-java-$ECLIPSE_VERSION-$ECLIPSE_RELEASE-$arch.tar.gz"

if [ ! -e "$eclipse_home/$filename" ]; then
  echo ">>>> downloading eclipse..."
  wget -O "$eclipse_home/$filename" "$ECLIPSE_MIRROR/$ECLIPSE_VERSION/$ECLIPSE_RELEASE/$filename"
fi

if [ ! -e "$eclipse_home/eclipse.ini" ]; then
  echo ">>>> extracting..."
  tar -xzf "$eclipse_home/$filename" --directory "$eclipse_home" --strip 1
fi

function install_eclipse_plugin {
  plugin="$1"
  echo ">>>> installing plugin: $plugin" | tee -a "$eclipse_home/eclipse-installation.log"
  $eclipse_home/eclipse -nosplash -application org.eclipse.equinox.p2.director \
    -data "$eclipse_home/workspace" \
    -repository http://download.eclipse.org/releases/$ECLIPSE_VERSION/ \
    -repository http://download.scala-ide.org/sdk/lithium/e44/scala211/stable/site  \
    -repository http://alchim31.free.fr/m2e-scala/update-site/ \
    -repository http://eclipse.schedenig.name/ \
    -repository http://winterwell.com/software/updatesite/ \
    -repository https://raw.github.com/satyagraha/gfm_viewer/master/p2-composite/ \
    -repository http://eclipsefp.sf.net/updates \
    -repository http://jd.benow.ca/jd-eclipse/update \
    -repository http://dl.bintray.com/ajermakovics/InstaSearch/ \
    -repository http://pydev.org/updates \
    -repository http://updatesite.ccw-ide.org/stable \
    -repository http://download.jboss.org/jbosstools/updates/m2e-extensions/m2e-apt \
    -destination "$eclipse_home" \
    -installIU $plugin
# repos: eclipse-release, scala-ide, scala-maven, grepconsole, markdown-editor, github-flavored-markdown-viewer, haskell, java-decompiler, insta-search, python, clojure
}

(
echo ">>>> installing plugins..."
install_eclipse_plugin org.scala-ide.sdt.feature.feature.group
install_eclipse_plugin org.scala-ide.sdt.scalatest.feature.feature.group
install_eclipse_plugin org.scala-ide.sdt.weaving.feature.feature.group
install_eclipse_plugin org.scala.tools.eclipse.search.feature.feature.group
install_eclipse_plugin org.scalaide.worksheet.feature.feature.group
install_eclipse_plugin org.maven.ide.eclipse.scala_feature.feature.group
install_eclipse_plugin name.schedenig.eclipse.grepconsole.feature.group
install_eclipse_plugin markdown.editor.feature.feature.group
install_eclipse_plugin code.satyagraha.gfm.viewer.feature.feature.group

install_eclipse_plugin net.sf.eclipsefp.haskell.feature.group
#install_eclipse_plugin org.eclipse.php.feature.group

install_eclipse_plugin jd.ide.eclipse.feature.feature.group
install_eclipse_plugin it.unibz.instasearch.feature.indigo.feature.group
#install_eclipse_plugin org.python.pydev.feature.feature.group
#install_eclipse_plugin ccw.feature.feature.group

#install_eclipse_plugin org.eclipse.mat.feature.feature.group
#install_eclipse_plugin org.eclipse.mat.chart.feature.feature.group

install_eclipse_plugin org.jboss.tools.maven.apt.feature.feature.group
) 2>&1 | tee -a "$eclipse_home/eclipse-installation.log"

curl http://projectlombok.org/downloads/lombok.jar -o "$eclipse_home/lombok.jar"
curl http://search.maven.org/remotecontent?filepath=org/springframework/springloaded/1.2.3.RELEASE/springloaded-1.2.3.RELEASE.jar -o "$eclipse_home/springloaded-1.2.3.RELEASE.jar"

cp -r diff/* "$eclipse_home"

#echo "-javaagent:$eclipse_home/lombok.jar" >> "$eclipse_home/eclipse.ini"
sed -i 's/-Xms40m/-Xms1280m/' "$eclipse_home/eclipse.ini"
sed -i 's/-Xmx512m/-Xmx1280m/' "$eclipse_home/eclipse.ini"
#sed -i 's/-XX:MaxPermSize=256m/-XX:MaxPermSize=320m/' "$eclipse_home/eclipse.ini"
