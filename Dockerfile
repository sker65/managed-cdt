FROM openjdk:8

MAINTAINER Stefan Rinke version: 0.1

WORKDIR /work
RUN apt-get -y update || true 
RUN apt-get -y install make lib32z1 lib32ncurses5 zip
RUN wget -q https://launchpad.net/gcc-arm-embedded/5.0/5-2015-q4-major/+download/gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2 && tar xf gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2 && rm gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2
RUN export PATH=$PATH:/work/gcc-arm-none-eabi-5_2-2015q4/bin && arm-none-eabi-gcc --version
RUN wget -q -O eclipse-cpp-luna-SR2-linux-gtk-x86_64.tar.gz "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/luna/SR2/eclipse-cpp-luna-SR2-linux-gtk-x86_64.tar.gz&mirror_id=1"  && tar xzf eclipse-cpp-luna-SR2-linux-gtk-x86_64.tar.gz && rm eclipse-cpp-luna-SR2-linux-gtk-x86_64.tar.gz
RUN eclipse/eclipse -application org.eclipse.equinox.p2.director -noSplash -repository 'http://gnuarmeclipse.sourceforge.net/updates,http://download.eclipse.org/releases/luna/' -installIU ilg.gnuarmeclipse.core,ilg.gnuarmeclipse.managedbuild.cross.feature.group

RUN mkdir /workspace
VOLUME /workspace

ENTRYPOINT eclipse/eclipse --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -data /workspace -import /workspace/$project -cleanBuild $project/$target

