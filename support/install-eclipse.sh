#!/usr/bin/env sh

# Simple and more or less error prone eclipse installer.
# It works on newer version of Ubuntu. Debian and Fedora based
# distributions should work too. So should Mac OS X. But it may
# fial. There's no distro specific version checking. Nothing but
# Ubuntu was ever tested. The script does not even care if you
# have 64-bit os. It just assume you have.

eclipse_home="${1:-$HOME/eclipse.scala}"

ECLIPSE_MIRROR="http://carroll.aset.psu.edu/pub/eclipse/technology/epp/downloads/release"

mkdir -p "$eclipse_home"

if ! uname -a | grep '^Darwin\|^Linux' >/dev/null; then
  echo "Unsupported OS - neither linux, neither mac os!"
  exit 1
fi

#which git >/dev/null || sudo apt-get install -y git
#mvn -version 2>&1 | grep 'Apache Maven 3\.' >/dev/null || sudo apt-get install -y maven

if ! javac -version 2>&1 | grep '1\.7\.' >/dev/null; then
  echo ">>>> installing jdk..."
  which apt-get >/dev/null && sudo apt-get install -y openjdk-7-jdk #openjdk-7-source
  which yum >/dev/null && su -c "yum install java-1.7.0-openjdk"
  uname -a | grep '^Darwin' >/dev/null && echo "WARNING: No java 7 compiler found on PATH. You should install one!"
fi

uname -a | grep '^Linux' >/dev/null && arch="linux-gtk-x86_64"
uname -a | grep '^Darwin' >/dev/null && arch="macosx-cocoa-x86_64"
filename="eclipse-java-juno-SR2-$arch.tar.gz"

if [ ! -e "$eclipse_home/$filename" ]; then
  echo ">>>> downloading eclipse..."
  wget -O "$eclipse_home/$filename" "$ECLIPSE_MIRROR/juno/SR2/$filename"
fi

if [ ! -d "$eclipse_home/eclipse.ini" ]; then
  echo ">>>> extracting..."
  tar -xzf "$eclipse_home/$filename" --directory "$eclipse_home" --strip 1
fi

echo ">>>> installing plugins..."
$eclipse_home/eclipse -nosplash -application org.eclipse.equinox.p2.director \
  -data "$eclipse_home/workspace" \
  -repository http://download.scala-ide.org/sdk/e38/scala210/dev/site/ \
  -repository http://download.eclipse.org/releases/juno/ \
  -repository http://alchim31.free.fr/m2e-scala/update-site/ \
  -repository http://eclipse.schedenig.name/ \
  -destination "$eclipse_home" \
  -installIU org.maven.ide.eclipse.scala_feature.feature.group \
  -installIU org.scala-ide.sdt.feature.feature.group \
  -installIU org.scala-ide.sdt.scalatest.feature.feature.group \
  -installIU org.scala-ide.sdt.weaving.feature.feature.group \
  -installIU org.scalaide.worksheet.feature.feature.group \
  -installIU name.schedenig.eclipse.grepconsole.feature.group \
  | tee "$eclipse_home/eclipse-installation.log"
