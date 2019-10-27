FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift
VOLUME /tmp
COPY target/*.jar ./
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","./app.jar"]