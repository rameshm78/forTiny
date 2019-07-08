FROM tsl0922/ttyd

RUN \
  apt-get update && apt-get install -y wget cmake libncurses5-dev flex bison && cd &&\
  wget "https://www.nethack.org/download/3.6.2/nethack-362-src.tgz" && \
  tar xzvf nethack-362-src.tgz && rm nethack-362-src.tgz && \
  cd /root/nethack-3.6.2/sys/unix && ./setup.sh hints/linux && cd ../../ && make && make install && \
  rm -rf /root/nethack-3.6.2 && \
  echo 'OPTIONS=windowtype:curses,splash_screen,color,guicolor' >> /root/nh/install/games/lib/nethackdir/sysconf && \
  echo "/usr/local/bin/ttyd -c ramesh:123 -p 80 '/root/nh/install/games/nethack'" > /root/start.sh

EXPOSE 80
ENTRYPOINT ["/bin/bash"]
CMD ["/root/start.sh"]
