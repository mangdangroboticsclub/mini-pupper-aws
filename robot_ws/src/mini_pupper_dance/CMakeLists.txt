cmake_minimum_required(VERSION 2.8.3)
project(mini_pupper_dance)

find_package(catkin REQUIRED COMPONENTS)

catkin_package()

install(PROGRAMS
  scripts/pose_controller.py
  scripts/dance.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY scripts launch routines
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
