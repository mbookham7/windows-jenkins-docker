cd C:\Docker\Jenkins\Java

# Build Windows Server Core with Java
docker build -t windowsserver-java:v1 .

cd C:\Docker\Jenkins\Master

# Build a Jenkins Master Server based on Windows Server Java Image.
docker build -t jenkins-master:v1.0 .

# Run the Image for the Master.
docker run --name jenkins-master -p 8080:8080 -d jenkins-master:v1.0

# Check logs to get the first use password.
docker logs jenkins-master

f0d03fba07994ae89ff3c3f202a38f39

# Find the IP for the container
docker inspect jenkins-master

# Open in a web browser...

cd C:\Docker\Jenkins\Slave

# Build the slave agent
docker build --build-arg BASE_URL=http://172.18.135.220:8080 -t jenkins_windows_slave:v1.0 .

# Run the slave agent.
docker run -ti jenkins_windows_slave:v1.0 -jnlpUrl http://172.18.135.220:8080/computer/Windows_CI/slave-agent.jnlp -secret 0290a124683c6b42751b447b106ff34a30768cbf535cfe861621feddc445c3c6

# Build Second Jenkins slave

cd C:\Docker\Jenkins\SecondSlave\

docker build -t jenkins_windows_slave2:v1.0 .

docker run -ti jenkins_windows_slave2:v1.0 -jnlpUrl http://172.18.135.220:8080/computer/Windows_CI/slave-agent.jnlp -secret 0290a124683c6b42751b447b106ff34a30768cbf535cfe861621feddc445c3c6


# Build Second Jenkins slave

cd C:\Docker\Jenkins\forthSlave\

docker build -t jenkins_windows_slave4:v1.0 .
docker build -t gitlab.platform-engineering.com:4567/dow/jenkins_windows_agent:v100 .

# Build Fifth Jenkins Slave

CD C:\Docker\Jenkins\FifthSlave

docker build -t jenkins_windows_slave5:v1.0 .
docker run -it -e "URL=http://172.18.135.220:8080/computer/Windows_CI_5/slave-agent.jnlp" -e "SECRET=01a2b166ab8c71d7c712199268cb56f30f2007f55ebad84d33778a606c11f0a4" jenkins_windows_slave5:v1.0


docker build -t gitlab.platform-engineering.com:4567/dow/jenkins_windows_slave:v1.0 .
docker push gitlab.platform-engineering.com:4567/dow/jenkins_windows_slave:v1.0


docker run -ti gitlab.platform-engineering.com:4567/dow/jenkins_windows_agent:v100