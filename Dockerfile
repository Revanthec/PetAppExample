FROM openjdk:8u181-jdk-alpine3.8 
#RUN apt-get install maven
#apt-get install maven
#WORKDIR /home/namitha_kavi/my_build
RUN mvn -DskipTests clean install
COPY target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar spring-petclinic.jar
EXPOSE 8080
CMD ["java", "-jar", "-Xms256m", "-Xmx768m", "spring-petclinic.jar"]
