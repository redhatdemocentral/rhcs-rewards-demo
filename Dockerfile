# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Andrew Block, Eric D. Schabell

# Environment Variables 
ENV BPMS_HOME /opt/jboss/bpms/jboss-eap-6.4
ENV BPMS_VERSION_MAJOR 6
ENV BPMS_VERSION_MINOR 1
ENV BPMS_VERSION_MICRO 0
ENV BPMS_VERSION_BUILD BZ-1299002

ENV EAP_VERSION_MAJOR 6
ENV EAP_VERSION_MINOR 4
ENV EAP_VERSION_MICRO 0

# ADD Installation Files
COPY support/installation-bpms support/installation-eap support/installation-bpms.variables support/installation-eap.variables installs/jboss-bpmsuite-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.$BPMS_VERSION_BUILD.jar installs/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO-installer.jar  /opt/jboss/

# Update Permissions on Installers
USER root
RUN chown jboss:jboss /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO-installer.jar /opt/jboss/jboss-bpmsuite-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.$BPMS_VERSION_BUILD.jar 
USER jboss

# Prepare and run installer and cleanup installation components
RUN sed -i "s:<installpath>.*</installpath>:<installpath>$BPMS_HOME</installpath>:" /opt/jboss/installation-eap \
    && sed -i "s:<installpath>.*</installpath>:<installpath>$BPMS_HOME</installpath>:" /opt/jboss/installation-bpms \
	&& java -jar /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO-installer.jar  /opt/jboss/installation-eap -variablefile /opt/jboss/installation-eap.variables \
	&& java -jar /opt/jboss/jboss-bpmsuite-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.$BPMS_VERSION_BUILD.jar  /opt/jboss/installation-bpms -variablefile /opt/jboss/installation-bpms.variables \
	&& rm -rf /opt/jboss/jboss-bpmsuite-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.$BPMS_VERSION_BUILD.jar /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO-installer.jar /opt/jboss/installation-bpms /opt/jboss/installation-bpms.variables /opt/jboss/installation-eap /opt/jboss/installation-eap.variables $BPMS_HOME/standalone/configuration/standalone_xml_history/


# Copy demo and support files
COPY support/bpm-suite-demo-niogit $BPMS_HOME/bin/.niogit
COPY support/userinfo.properties $BPMS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/
COPY support/application-roles.properties support/standalone.xml $BPMS_HOME/standalone/configuration/

# Swtich back to root user to perform build and cleanup
USER root

# Adjust permissions and cleanup
RUN chown -R jboss:jboss $BPMS_HOME/bin/.niogit $BPMS_HOME/standalone/configuration/application-roles.properties $BPMS_HOME/standalone/configuration/standalone.xml $BPMS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/userinfo.properties

# Run as JBoss 
USER jboss

# Expose Ports
EXPOSE 9990 9999 8080

# Run BPMS
CMD ["/opt/jboss/bpms/jboss-eap-6.4/bin/standalone.sh","-c","standalone.xml","-b", "0.0.0.0","-bmanagement","0.0.0.0"]
