#!/bin/bash
set -e
rsync -r --ignore-existing --include=* install_isolated/ ~/ros_catkin_ws/install_isolated/
