# reMARS-MiniPupper

## Activity 1: Simulate the Dance Robot

The README refers to the [Building Cloud Connected Robots](https://catalog.us-east-1.prod.workshops.aws/workshops/fa208b8e-83d6-4cc1-8356-bfa5b6184fae/en-US/introduction)  of AWS Workshop Studio

### Step 1: Setup the RoboMaker IDE

choose **ROS Melodic**

### Step 2: Build the Robot and Simulation Applications

* Clone Packages

```sh
cd ~/environment
git clone https://github.com/mrkoz/reMARS-MiniPupper
```

* Install Dependencies

```sh
sudo apt-get update
cd reMARS-MiniPupper/robot_ws
rosdep install --from src -i -y
```

* Compile Robot Applications and Set Executable

```sh
colcon build
cd install/mini_pupper_dance/share/mini_pupper_dance/scripts/
sudo chmod +x *
```

* Compile Simulation Package

```sh
cd ~/environment/reMARS-MiniPupper/simulation_ws/
colcon build
```

### Step 3: Run the Simulation

* Launch Simulation

```sh
# terminal 1
export DISPLAY=:1
source /opt/ros/melodic/setup.bash
source ~/environment/reMARS-MiniPupper/simulation_ws/install/setup.bash
source ~/environment/reMARS-MiniPupper/robot_ws/install/setup.bash
roslaunch mini_pupper_simulation gazebo.launch
```

* Launch Robot Application (Dancing Demo)

```sh
# terminal 2
source /opt/ros/melodic/setup.bash
source ~/environment/reMARS-MiniPupper/simulation_ws/install/setup.bash
source ~/environment/reMARS-MiniPupper/robot_ws/install/setup.bash
roslaunch mini_pupper_dance dance.launch hardware_connected:=false
```

* Send a Message to Make Robot Dancing

```sh
# terminal 3
source /opt/ros/melodic/setup.bash
rostopic pub /dance_config std_msgs/String "data: 'demo'"
```

### Step 4: Modify the Dance Routine

* Create a new Python file in the robot application folder. Example: my_demo.py

```sh
cd ~/environment/reMARS-MiniPupper/routines
touch my_demo.py
```

* Copy this template into the new file.

```python
#!/usr/bin/env python

# the duration of every command
interval_time = 0.6 # seconds

# there are 10 commands you can choose:
# move_forward: the robot will move forward
# move_backward: the robot will move backward
# move_left: the robot will move to the left
# move_right: the robot will move to the right
# look_up: the robot will look up
# look_down: the robot will look down
# look_left: the robot will look left
# look_right: the robot will look right
# stop: the robot will stop the last command and return to the default standing posture
# stay: the robot will keep the last command
dance_commands = [
'move_forward',
'stop',
'look_down',
'look_up',

'move_backward',
'stop',
'look_left',
'look_right',

'move_left',
'stop',
'look_up',
'look_left',

'move_right',
'stop',
'look_down',
'look_right',

'look_up',
'look_left',
'look_down',
'look_right',

'look_down',
'look_left',
'look_up',
'look_right'
]
```

* Modify the file, changing the name, artist, and the dance steps.
* Save your new dance routine. If not already open, open two command line tabs in the RoboMaker IDE.
* Build and Source and run the ROS application.

```sh
# terminal 1, launch simulation
export DISPLAY=:1
source /opt/ros/melodic/setup.bash
source ~/environment/reMARS-MiniPupper/simulation_ws/install/setup.bash
source ~/environment/reMARS-MiniPupper/robot_ws/install/setup.bash
roslaunch mini_pupper_simulation gazebo.launch
```

```sh
# terminal 2, launch robot application
source /opt/ros/melodic/setup.bash
source ~/environment/reMARS-MiniPupper/simulation_ws/install/setup.bash
source ~/environment/reMARS-MiniPupper/robot_ws/install/setup.bash
roslaunch mini_pupper_dance dance.launch hardware_connected:=false
```

* Send a Message to Make Robot Dancing

```sh
# terminal 3, send a message to specify which dance routine you choose
source /opt/ros/melodic/setup.bash
rostopic pub /dance_config std_msgs/String "data: 'my_demo'"
```

## Activity 2: Deploy and Run the Dance Robot

We haven't done this greengrass part yet. If you want to test the dancing routines on real robot, please refer to the follow instructions. The repository cloned on real robot is the same repository cloned in this repo.
Please also refer to our pre-build image file, [20220521.1707.V0.2.MiniPupper_remars_RoboMakerSimulation.ROS_Ubuntu21.10.0.img](https://drive.google.com/drive/folders/1gl-S3kokcna5GoSeIXZ5TD5rQhk48ALX?usp=sharing).

```sh
# on Mini Pupper's Terminal
# clone this repo
# if you use our pre-build image file,no need to execute the below 4 line commands
cd ~
git clone https://github.com/mrkoz/reMARS-MiniPupper.git
cd reMARS-MiniPupper/robot_ws
catkin_make
```

```sh
# terminal 1
source /opt/ros/melodic/setup.bash
source ~/reMARS-MiniPupper/robot_ws/devel/setup.bash
roslaunch mini_pupper_dance dance.launch dance_config_path:=/home/ubuntu/reMARS_MiniPupper/routines
```

```sh
# terminal 2
source /opt/ros/melodic/setup.bash
rostopic pub /dance_config std_msgs/String "data: 'demo'"
```

As for control in Docker, please refer to the below setting and the pre-build image sample [mini_pupper_remars_docker_IPDisplay.20220513](https://drive.google.com/drive/folders/1gl-S3kokcna5GoSeIXZ5TD5rQhk48ALX?usp=sharing).

```sh
sudo docker run -id --name ros_noetic --network host \
--privileged -v /dev:/dev -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 \
-v /sys/class/pwm:/sys/class/pwm \
-v /sys/bus/i2c/devices/3-0050/eeprom:/sys/bus/i2c/devices/3-0050/eeprom \
-v /sys/class/pwm:/sys/class/pwm \
-v /sys/bus/i2c/devices/3-0050/eeprom:/sys/bus/i2c/devices/3-0050/eeprom \
0nhc/mnpp:test
sudo xhost +
```
