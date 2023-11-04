# FROM maven:3-openjdk-17 as build_stage
# 
# WORKDIR /workspace
# 
# COPY pom.xml .
# 
# RUN mvn install

# RUN mkdir lib
# 
# WORKDIR /workspace/lib
# 
# RUN cp $(find /root/.m2/repository -type f -name "*.jar") .

FROM ubuntu:22.04

RUN apt update \
    && apt install -y git g++ wget \
        default-jdk python3 maven
        
RUN ln -s /bin/python3 /bin/python

RUN wget -qO /usr/local/bin/ninja.gz https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip \
    && gunzip /usr/local/bin/ninja.gz \
    && chmod a+x /usr/local/bin/ninja

WORKDIR /workspace

RUN  git clone https://github.com/chen3feng/blade-build.git

COPY pom.xml .

RUN mvn install

WORKDIR /workspace/blade-build

RUN ./install \
    && . /root/.profile

RUN ln -s /workspace/blade-build/blade /bin/blade

COPY blade.conf .

COPY builtin_tools.py src/blade

WORKDIR /code

COPY bin .

# COPY --from=build_stage /root/.m2/repository /root/.m2/repository

RUN blade run //src/main/java/example:BladeApp

# ENTRYPOINT ["blade"]
# 
# CMD ["build", ":BladeApp"]