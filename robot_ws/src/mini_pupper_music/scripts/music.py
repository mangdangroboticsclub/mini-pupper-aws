#!/usr/bin/env python3
import rospy
from sound_play.msg import SoundRequest
from sound_play.libsoundplay import SoundClient

rospy.init_node('play_sound_file')
sound_client = SoundClient()
rospy.sleep(1)
sound_client.playWave('/home/hzx/ROS_WS/sim2real_ws/src/mini_pupper_remars/mini_pupper_robot/mini_pupper_music/music/robot1.wav', 1.0)
