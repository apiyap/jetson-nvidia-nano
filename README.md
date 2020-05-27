# jetson-nvidia-nano (r32.4.2)
Prepare Jetson novidia nono for ROS , Tensorflow OpenCV and Open AI

cd ~/jetson-nvidia-nano
# Setup
1. Install more swap file for jetson nvidia nano
<div class="highlight highlight-source-shell"><pre>
chmod +x swap-ins.sh
./swap-ins.sh
</pre></div>
2. Install ROS (melodic)<br>
<p>Official instructions can be found <a href="http://wiki.ros.org/melodic/Installation/Ubuntu" rel="nofollow">here</a></p>
<div class="highlight highlight-source-shell"><pre>
chmod +x ros-melodic-ins.sh
./ros-melodic-ins.sh
</pre></div>
3. Install OpenCV3
https://github.com/apiyap/buildOpenCV3

4. Install tensorflow 
<div class="highlight highlight-source-shell"><pre>
chmod +x tensorflow-ins.sh
./chmod +x 
</pre></div>
  
# Note
Installing Node,js using the Node Version Manager (NVM)
<pre>
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm ls-remote #list version
nvm install v8.17.0

</pre>
