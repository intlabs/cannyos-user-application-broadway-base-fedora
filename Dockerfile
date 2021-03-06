#
# CannyOS User Storage Dropbox
#
# https://github.com/intlabs/cannyos-user-application-broadway-base-fedora
#
# Copyright 2014 Pete Birley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Pull base image.
FROM intlabs/dockerfile-cannyos-fedora-fuse

# Set environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Set the working directory
WORKDIR /

#****************************************************
#                                                   *
#         INSERT COMMANDS BELLOW THIS               *
#                                                   *
#****************************************************

#Allow remote root login with password
#RUN sed -i -e 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && /etc/init.d/ssh restart

#Install the gtk3 & Broadway
RUN yum install -y gtk3

#Install gedit
#RUN yum install -y gedit

#Build and install libreoffice with broadway support
WORKDIR /CannyOS/Host
RUN yum install -y yum-utils && \
yum-builddep libreoffice -y && \
yum install -y gstreamer-devel gstreamer-plugins-base-devel pangox-compat&& \
wget http://download.documentfoundation.org/libreoffice/src/4.2.5/libreoffice-4.2.5.1.tar.xz && \
tar xvfJ libreoffice-4.2.5.1.tar.xz && \
cd libreoffice* && \
./autogen.sh --enable-gtk3 --without-java --disable-firebird-sdbc && \
make && \
make install

#****************************************************
#                                                   *
#         ONLY PORT RULES BELLOW THIS               *
#                                                   *
#****************************************************

#SSH
#EXPOSE 22/tcp

#HTTP (broadway)
EXPOSE 80/tcp

#****************************************************
#                                                   *
#         NO COMMANDS BELLOW THIS                   *
#                                                   *
#****************************************************

# Add startup 
ADD /CannyOS/startup.sh /CannyOS/startup.sh
RUN chmod +x /CannyOS/startup.sh

# Add post-install script
#ADD /CannyOS/post-install.sh /CannyOS/post-install.sh
#RUN chmod +x /CannyOS/post-install.sh

# Define default command.
ENTRYPOINT ["/CannyOS/startup.sh"]