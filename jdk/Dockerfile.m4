FROM REPOSITORY/base

# OpenJDK
RUN apt-get update -y -q && apt-get install -y -q openjdk-8-jdk-headless
