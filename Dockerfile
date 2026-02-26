FROM tomcat:8.0
COPY target/java-tomcat-maven-example.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
