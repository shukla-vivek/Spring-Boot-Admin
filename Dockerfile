FROM openjdk:8-jre-alpine
ENV HTTP_PROXY YOUR_PROXY_GOES_HERE
ENV HTTPS_PROXY YOUR_PROXY_GOES_HERE
RUN export http_proxy=$HTTP_PROXY && export https_proxy=$HTTPS_PROXY && apk add --update busybox-suid && apk --update add tzdata && cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime
ARG SERVICE_JAR_FILE
ARG REQ_SERVICE_FILE_LOCATION
ADD ${SERVICE_JAR_FILE} springBootAdmin.jar
#COPY ${REQ_SERVICE_FILE_LOCATION}/appconfig.properties /config/
EXPOSE 54067
ENTRYPOINT ["java","-Dspring.profiles.active=${SPRING.PROFILES.ACTIVE}", \
           "-Dspring.config.location=classpath:application.yml", \
           "-jar","springBootAdmin.jar"]