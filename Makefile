## Pupper make file
##--------------------------------------------------------
help:                      ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build-base:                ## Build base image
	sudo docker build . -t mini-pupper-base:1.0 -f Dockerfile-Base


build-robot:               ## Cuild robot image
	sudo docker build . -t mini-pupper-robot:1.0 -f Dockerfile-Robot

run-local:                 ## Run the robot in a container (non-physical)
	docker run -it --net=host --privileged -u robomaker --rm \
	-e GAZEBO_MASTER_URI=http://localhost:5555 \
	-e ROS_MASTER_URI=http://localhost:11311 \
	-e DISPLAY -e QT_X11_NO_MITSHM=1 \
	-e HARDWARE=false \
	-v /tmp/.X11-unix/:/tmp/.X11-unix/ \
	-v /home/ubuntu/environment/config:/config \
	-v /greengrass:/greengrass \
	--name pupper-robot mini-pupper-robot:1.0

run-robot:                 ## Run the robot (physical)
	sudo docker run -it --net=host --privileged -u root --rm \
	-e GAZEBO_MASTER_URI=http://localhost:5555 \
	-e ROS_MASTER_URI=http://localhost:11311 \
	-e DISPLAY -e QT_X11_NO_MITSHM=1 \
	-e HARDWARE=true \
	-v /tmp/.X11-unix/:/tmp/.X11-unix/ \
	-v /home/ubuntu/environment/config:/config \
	-v /greengrass:/greengrass \
	-v /dev:/dev \
	-v /sys:/sys \
	--name pupper-robot mini-pupper-robot:1.0

update-ip:                 ## update the ip on the screen
	python3 /home/ubuntu/minipupper_ros_bsp/mangdang/LCD/demo.py
