FROM openjdk:8u181-jdk-alpine3.8 
RUN git clone https://github.com/Revanthec/PetAppExample.git
RUN mkdir -p /usr/app
RUN cp -R PetAppExample /usr/app/
#RUN echo $WORKDIR
#RUN ls 	/workspace/
RUN echo $PWD
RUN apk add --no-cache curl tar bash
ARG MAVEN_VERSION=3.3.9
#ARG USER_HOME_DIR="/root"
RUN mkdir -p /usr/share/maven && \
curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzC /usr/share/maven --strip-components=1 && \
ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
# speed up Maven JVM a bit
#ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"
#ENTRYPOINT ["/usr/bin/mvn"]
#RUN apt-get install maven
#apt-get install maven
#WORKDIR /home/namitha_kavi/my_build
#RUN cd /PetAppExample
#RUN cd PetAppExample
RUN cd /usr/app/PetAppExample
RUN mvn -DskipTests clean install
COPY target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar spring-petclinic.jar
EXPOSE 8080
CMD ["java", "-jar", "-Xms256m", "-Xmx768m", "spring-petclinic.jar"]
