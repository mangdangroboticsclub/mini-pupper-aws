#!/bin/bash
source /opt/ros/melodic/setup.bash
source /usr/share/gazebo-9/setup.sh
source /home/robomaker/workspace/robot_ws/install/setup.sh
source ./install/setup.sh

export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$(rospack find mini_pupper_simulation)/worlds/meshes
printenv

exec "${@:1}"