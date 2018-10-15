FROM websphere-liberty

COPY postgresql-42.2.4.jar /opt/ibm/wlp/usr/shared/resources/
COPY server.xml /config/
ADD target/javaee-cafe.war /config/dropins/javaee-cafe.war
