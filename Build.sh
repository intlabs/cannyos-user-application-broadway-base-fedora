#!/bin/sh
#
# CannyOS cannyos-user-application-broadway-fedora-base container build script
#
# https://github.com/intlabs/cannyos-user-application-broadway-fedora-base
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
clear
curl https://raw.githubusercontent.com/intlabs/cannyos-user-application-broadway-fedora-base/master/CannyOS/CannyOS.splash
#     *****************************************************
#     *                                                   *
#     *        _____                    ____  ____        *
#     *       / ___/__ ____  ___  __ __/ __ \/ __/        *
#     *      / /__/ _ `/ _ \/ _ \/ // / /_/ /\ \          *
#     *      \___/\_,_/_//_/_//_/\_, /\____/___/          *
#     *                         /___/                     *
#     *                                                   *
#     *                                                   *
#     *****************************************************
echo "*                                                   *"
echo "*         Ubuntu docker container builder           *"
echo "*                                                   *"
echo "*****************************************************"
echo ""

# Build base container image
sudo docker build -t="intlabs/cannyos-user-application-broadway-fedora-base" github.com/intlabs/cannyos-user-application-broadway-fedora-base

echo ""
echo "*****************************************************"
echo "*                                                   *"
echo "*         Built base container image                *"
echo "*                                                   *"
echo "*****************************************************"
echo ""

# Make shared directory on host
sudo mkdir -p "/CannyOS/build/cannyos-user-application-broadway-fedora-base"
# Ensure that there it is clear
sudo rm -r -f "/CannyOS/build/cannyos-user-application-broadway-fedora-base/*"

# Remove any existing containers
sudo docker stop cannyos-user-application-broadway-fedora-base

# Launch built base container image
sudo docker run -i -t --rm \
 --privileged=true --lxc-conf="native.cgroup.devices.allow = c 10:229 rwm" \
 --volume "/CannyOS/build/cannyos-user-application-broadway-fedora-base":"/CannyOS/Host" \
 --name "cannyos-user-application-broadway-fedora-base" \
 --user "root" \
 -p 80:80 \
 intlabs/cannyos-user-application-broadway-fedora-base 