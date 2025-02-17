FROM tiryoh/ros2-desktop-vnc:humble-amd64-20230115T1406
ENV GAZEBO_MODEL_PATH /home/ubuntu/Desktop/gazebo_models
WORKDIR /home/ubuntu/Desktop
RUN git clone https://github.com/osrf/gazebo_models.git
WORKDIR /home/ubuntu/Desktop
RUN apt-get update && apt-get install -y \
    ros-humble-turtlebot3* \
    ros-humble-navigation* \
    ros-humble-rosbag2-storage-mcap \
    htop \
    && rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/foxglove/studio/releases/download/v1.40.0/foxglove-studio-1.40.0-linux-amd64.deb && \
    sudo dpkg -i foxglove-studio-*.deb && \
    rm foxglove-studio-*.deb
ENV TURTLEBOT3_MODEL burger
COPY asound.conf /etc/asound.conf
ENV LIBGL_ALWAYS_SOFTWARE 1
RUN mkdir -p /home/ubuntu/Desktop/colcon_ws/src
WORKDIR /home/ubuntu/Desktop/colcon_ws/src
COPY rviz/rosbag_play.rviz /home/ubuntu/.rviz2/rosbag_play.rviz
COPY workspace.repos /home/ubuntu/Desktop/colcon_ws/src/workspace.repos
