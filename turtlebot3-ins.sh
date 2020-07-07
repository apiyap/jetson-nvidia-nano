#!/bin/bash
set -e

mkdir -p ~/ws/turtlebot3/src
cd ~/ws/turtlebot3/src
catkin_init_workspace
git clone -b melodic-devel https://github.com/ROBOTIS-GIT/turtlebot3_msgs
git clone -b melodic-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations
git clone -b melodic-devel https://github.com/ROBOTIS-GIT/turtlebot3
git clone -b melodic-devel https://github.com/ROBOTIS-GIT/hls_lfcd_lds_driver
git clone -b develop https://github.com/RobotWebTools/rosbridge_suite.git

cd ~/ws/turtlebot3
rosdep update
rosdep install --from-paths src --ignore-src -r -y
catkin_make
