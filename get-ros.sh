#!/bin/bash
set -e
ROS_DISTRO=melodic
ROS_PKG=$1  #vision_opencv
if [ -z "$ROS_PKG" ] 
then
{
      echo "ROS Package is empty";
      exit 1 
}
else
      echo "Get Package $ROS_PKG"
fi

rosinstall_generator $ROS_PKG --rosdistro $ROS_DISTRO --deps --tar > $ROS_DISTRO-$ROS_PKG.rosinstall
echo "Get source code.."

set +e
wstool init -j4 src $ROS_DISTRO-$ROS_PKG.rosinstall
if [ $? -eq 0 ]; then
    echo "Get source code completed."
else
    #if fail
    wstool update -j4 -t src
fi

set -e

echo "Resolving Dependencies"
#rosdep install --from-paths src --ignore-src --rosdistro melodic -y
catkin_make
