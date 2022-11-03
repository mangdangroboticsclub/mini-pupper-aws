/*
* minipupper-dancing-with-music
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <std_srvs/Trigger.h>

#include "ros/ros.h"
#include "std_msgs/String.h"

#define FRAME_LEN	640 
#define	BUFFER_SIZE	4096

int wakeupFlag   = 0 ;



bool WakeUp(std_srvs::Trigger::Request  &req,std_srvs::Trigger::Response &res)
{
    printf("waking up\r\n");
    usleep(700*1000);
    wakeupFlag=1;
    return true;
}


int main(int argc, char* argv[])
{
    // 初始化ROS
    ros::init(argc, argv, "musicPlay");
    ros::NodeHandle n;
    ros::Rate loop_rate(10);

    // service
    // 接受播放音乐的命令
    //ros::Subscriber wakeUpSub = n.subscribe("music", 1000, WakeUp); 
    ros::ServiceServer command_service = n.advertiseService("/music_command",WakeUp);
    ROS_INFO("Sleeping...");
    int count=0;




    while(ros::ok())
    {
        // 语音识别唤醒     
        if(wakeupFlag)
        {
            ROS_INFO("Wakeup...");

	        printf("Demo playing\n");
	        
	        popen("play ~/ROS_WS/sim2real_ws/src/re_mars/mini_pupper_dance/mini_pupper_music/music/robot1.mp3","r");
            
            wakeupFlag=0;
        }


        ros::spinOnce();
        loop_rate.sleep();
        count++;
    }

	return 0;
}
