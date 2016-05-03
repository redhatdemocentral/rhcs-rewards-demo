App Dev Cloud with JBoss Rewards Demo
=====================================
This demo is to install JBoss BPM Suite Rewards Demo in the Cloud based on leveraging the Red Hat 
Container Development Kit (CDK) and the provided OpenShift Enterprise (OSE) image. 
It delivers a fully functioning JBoss BPM Mortgage example containerized on OSE.

This is the HR employee rewards demo that provides examples of human task integration, form designer
and a custom email work item handler.


Install on Red Hat CDK OpenShift Enterprise image
-------------------------------------------------
1. First complete the installation and start the OpenShift image supplied in the
	 [cdk-install-demo](https://github.com/redhatdemocentral/cdk-install-demo).

2. Install [OpenShift Client Tools](https://developers.openshift.com/managing-your-applications/client-tools.html) if you have not
	 done so previously.

2. [Download and unzip this demo.](https://github.com/redhatdemocentral/rhcs-rewards-demo/archive/master.zip)

3. Add products to installs directory.

5. Run 'init.sh' or 'init.bat' file. 'init.bat' must be run with Administrative privileges.

6. Login to JBoss BPM Suite to start developing your BPM projects:

    [http://rhcs-rewards-demo.10.1.2.2.xip.io/business-central](http://rhcs-rewards-demo.10.1.2.2.xip.io/business-central)
    ( u:erics / p:bpmsuite1! )


Notes
-----
Should your local network DNS not handle the resolution of the above address, giving you page not found errors, you can apply the
following to your local hosts file:

```
$ sudo vi /etc/hosts

# add host for CDK demo resolution.
10.1.2.2   rhcs-rewards-demo.10.1.2.2.xip.io    rhcs-mortage-demo.10.1.2.2.xip.io
```

This project is pre-loaded into the JBoss BPM Suite, after starting it you can login,
examine the rule, process, and data model from within the various product components.

After claiming the user task as a manager (to approve or deny the award), if task completion takes longer
than 1 minutes it will te reassigned back into the group so other managers can claim it. The short time frame
of 1 minutes is for demo purposes, should talk about days to complete instead as if a manager that claimed a
task got sick and failed to complete the claimed task.

Optional: A task notification has also been setup to alert the members of the group responsible if a task sits 
longer than 2 minutes without being started (claimed). 


Supporting Articles
-------------------
- [How to put the JBoss HR Employee Rewards project into the Cloud](http://www.schabell.org/2016/05/howto-put-jboss-hr-employee-rewards-into-cloud.html)

- [Build rewards demo project with online workshop.](http://bpmworkshop-onthe.rhcloud.com)


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.0 - JBoss BPM Suite 6.2.0-BZ-1299002 on JBoss EAP 6.4.4 with rewards demo installed on Red Hat CDK using OpenShift Enterprise image.

![Cloud Pod](https://raw.githubusercontent.com/redhatdemocentral/rhcs-rewards-demo/master/docs/demo-images/rhcs-rewards-pod.png)

![Cloud Build](https://raw.githubusercontent.com/redhatdemocentral/rhcs-rewards-demo/master/docs/demo-images/rhcs-rewards-build.png)

![Process](https://raw.githubusercontent.com/redhatdemocentral/rhcs-rewards-demo/master/docs/demo-images/rewards-process.png)

![Process & Task Dashboard](https://raw.githubusercontent.com/redhatdemocentral/rhcs-rewards-demo/master/docs/demo-images/mock-bpm-data.png)

[![Video Rewards Run](https://raw.githubusercontent.com/eschabell/erics-images/master/brms_bpms_workshop/image309.png)](http://vimeo.com/ericschabell/bpms-hr-employee-rewards-demo-run)
