#escape=`
FROM windowsserver-java:v1

SHELL ["powershell"]
ARG BASE_URL
ARG SECRET

# Remoting versions can be found in Remoting sub-project changelog
# https://github.com/jenkinsci/remoting/blob/master/CHANGELOG.md
ENV SLAVE_FILENAME=slave.jar `
    REMOTING_VERSION=3.15

ENV SLAVE_HASH_FILENAME=$SLAVE_FILENAME.sha1

# Get the Slave from the Jenkins Artifacts Repository
RUN Invoke-WebRequest "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$env:REMOTING_VERSION/remoting-$env:REMOTING_VERSION.jar" -OutFile $env:SLAVE_FILENAME -UseBasicParsing; `
    Invoke-WebRequest "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$env:REMOTING_VERSION/remoting-$env:REMOTING_VERSION.jar.sha1" -OutFile $env:SLAVE_HASH_FILENAME -UseBasicParsing; `
    if ((Get-FileHash $env:SLAVE_FILENAME -Algorithm SHA1).Hash -ne $(Get-Content $env:SLAVE_HASH_FILENAME)) {exit 1};

ENTRYPOINT ["C:\\Java\\jre1.8.0_91\\bin\\java.exe", "-jar", ".\\slave.jar"]