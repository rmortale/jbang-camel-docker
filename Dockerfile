FROM eclipse-temurin:21-jdk-ubi9-minimal

ENV JBANG_VERSION=0.126.1
# /!\ Camel version must be changed in the entrypoint line too
ENV CAMEL_VERSION=4.11.0

RUN wget -c https://github.com/jbangdev/jbang/releases/download/v$JBANG_VERSION/jbang.tar -O - | tar xv && chmod +x jbang/bin/jbang
ENV PATH="${PATH}:/jbang/bin"
ENV JBANG_PATH=/jbang/bin

RUN jbang trust add https://github.com/apache/camel

# used to initiliaze dependencies in the docker image
RUN jbang -Dcamel.jbang.version=$CAMEL_VERSION camel@apache/camel version
    
ENTRYPOINT [ "jbang", "-Dcamel.jbang.version=4.11.0", "camel@apache/camel"]
