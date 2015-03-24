# Release Notes

## Development commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/v2.5-community...master)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/v2.5-community...master)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/v2.5-community...master)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.5-community...master)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.5-community...master)  

## v2.5 - Mars 20th, 2015

### New features and bug fixes from v2.4.2

- Added the Event server
- Improved authorization mechinisme
- Improved logging
- Improved the collector
- Improved stability of the /vms resource when there is a huge amount of VMs
- Improved the Run dialog on the UI:
  - The Cloud for all node can be selected at one place
  - The two checkboxes in the user profile to define the `keep running` behaviour was converted into a dropdown menu
  - The `keep running` behaviour can be redefined
  - Tags can be defined when creating a Run.
  - The value selected for `Cloud` and `Keep running` dropdown menus correspond to the default of the user profile. 
  - It's now possible to create a Run even if there is no SSH key in the user profile
  - An error is displayed if SSH access is asked but there is no key in the user profile
- Improved the time needed to terminate VMs with `stratuslabiter-terminate-instances`.
- Increased the maximum amount of items returned by /vms and /run to 500
- New packaging for the community edition.
- Fixed a bug where deployment scripts were not executed when running a simple image.
- Bugfixes

### Migration

**IMPORTANT: v2.5 requires data migration from v2.4.2. The following steps MUST be followed:**
 1. Upgrade SlipStream
 2. Ensure SlipStream is running
 3. Execute the following python script *012_edit_save_all_users.py* from the directory */opt/slipstream/server/migrations/*
 
 ```bash
 cd /opt/slipstream/server/migrations/
 python 012_edit_save_all_users.py <username> <password>
 ```
    `<username>` and `<password>` have to be credentials of a SlipStream administrator.
 4. Stop SlipStream
 
 ```bash
 service slipstream stop
 ```
 5. Stop HSQLDB (or your DB engine)
 
 ```bash
 java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql 'SHUTDOWN;' 
 ```
 6. Execute the following SQL script */opt/slipstream/server/migrations/013_convert_to_keep_running.sql*:
 
 ```bash
 java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/013_convert_to_keep_running.sql
 ```
 7. Start HSQLDB (or your DB engine)
 
 ```bash
 service hsqldb start # ignore start error
 ```
 8. Start SlipStream
 
 ```bash
 service slipstream start
 ```

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/v2.4.2...v2.5-community)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/v2.4.2...v2.5-community)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/v2.4.2...v2.5-community)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.4.2...v2.5-community)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.4.2...v2.5-community)  

## v2.4.2 - February 28th, 2015

### New features and bug fixes from v2.4.0

- Change monitoring implementation to avoid corrupted dashboard information
- Improve monitoring implementation to avoid peaks in activity
- Allow deployments to set a tolerance for provisioning failures
- Fix bug that caused service catalog entries to be deleted
- Allow style of UI to be more easily customized
- Validate multiplicity values in deployments
- SlipStream client now backs off and waits when server is loaded
- Add network mapping parameters for OpenStack connector
- Add pagination support for VM listings on dashboard
- Optimize uploading of reports to improve performance
- Numerous minor improvements and bug fixes in UI

### Migration

**IMPORTANT: v2.4.2 requires data migration from v2.4.0. The following steps MUST be followed:**
 1. Stop SlipStream
 2. Stop HSQLDB (or your DB engine)
 3. Execute the following SQL files located in /opt/slipstream/server/migrations:
  * 011_add_maxprovisioningfailures_in_node.sql
 4. Start HSQLDB (or your DB engine)
 5. Start SlipStream**

Command to stop HSQLDB:
```
java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql 'SHUTDOWN;' 
```

Example command to execute the migration script:
```
java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/011_add_maxprovisioningfailures_in_node.sql
```

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/v2.4.0...v2.4.2)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/v2.4.0...v2.4.2)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/v2.4.0...v2.4.2)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.4.0...v2.4.2)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.4.0...v2.4.2)  

## v2.4.1 - February 20th, 2015

This release is deprecated because of problems discovered after deployment.  Use the v2.4.2 release.

## v2.4.0 - January 13th, 2015

### New features and bug fixes

- New UI based on [Bootstrap](http://getbootstrap.com/)
- Added export of users as CSV
- Image Run will attach extra disk if defined in cloud parameters and the action is supported by the cloud connector
- Minor updates and fixes in StratusLab and StratusLabIter connector

### Migration

No DB migration (from v2.3.9) is required.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/v2.3.9...v2.4.0)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/v2.3.9...v2.4.0)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/v2.3.9...v2.4.0)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.3.9...v2.4.0)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.3.9...v2.4.0)  

## v2.3.9 - December 19th, 2014

### New features and bug fixes

- Bugfix of the service catalog on the welcome page.
- Improvements in documentation around traoubleshooting of the user deployemnts.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/v2.3.8...v2.3.9)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/v2.3.8...v2.3.9)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/v2.3.8...v2.3.9)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.3.8...v2.3.9)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.3.8...v2.3.9)  

## v2.3.8 - December 17th, 2014

### Migration procedure

**IMPORTANT: v2.3.8 requires data migration from v2.3.7. The following steps MUST be followed:**
 1. Stop SlipStream
 2. Stop HSQLDB (or your DB engine)
 3. Execute the following SQL files located in /opt/slipstream/server/migrations:
  * 010_varchar_size_fix_3.sql
 4. Start HSQLDB (or your DB engine)
 5. Start SlipStream**

Command to stop HSQLDB:
```
java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql 'SHUTDOWN;' 
```

Example command to execute the migration script:
```
java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/010_varchar_size_fix_3.sql
```

### New features and bug fixes

- Performance improvement for Runs with a big amount of VMs.
- StratusLab connector was refactored.
- Support Cloud images without wget preinstalled (fallback to curl).
- Bug fixes.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.7...v2.3.8)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.7...v2.3.8)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.7...v2.3.8)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/SlipStreamConnectors-2.3.7...v2.3.8)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.7...v2.3.8)  

## v2.3.7 - November 7th, 2014

### New features and bug fixes

- Refactored cloud connector base classes to simplify connector development and maintenance on both Java and Python parts.
- EC2 connector: migrated to the AWS python-boto 2.32.
- StratusLab connector: RPM name changed - `slipstream-connector-stratuslab-python` obsoletes `stratuslab-slipstream-downloads`.
- Bug fixes.

### Migration

No DB migration (from v2.3.6) is required.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.6...SlipStreamServer-2.3.7)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.6...SlipStreamUI-2.3.7)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.6...SlipStreamClient-2.3.7)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/SlipStreamConnectors-2.3.6...SlipStreamConnectors-2.3.7)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.6...SlipStreamDocumentation-2.3.7)


## v2.3.6 - October 29th, 2014

### New features and bug fixes

- Removed all usage of the deprecated SSLv3
- Prefer the usage of TLSv1 for secure communications.
- Bug fixes

### Migration

No DB migration (from v2.3.5) is required.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.5...SlipStreamServer-2.3.6)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.5...SlipStreamUI-2.3.6)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.5...SlipStreamClient-2.3.6)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.5...SlipStreamDocumentation-2.3.6)  


## v2.3.5 - October 23th, 2014

### New features and bug fixes

- Removed autocreation of the users test and sixsq.
- Improvement of the logging.
- Fixed a bug where the ownership of a module can be changed implicitly when editing the module (#14).
- Fixed a bug in the orchestrator that can generate a error in a mutable run (#15).
- Fixed a bug in the StratusLab connector that prevent to Run an Image with an extra disk (#16).
- Fixed a bug in the vCloud connector that prevent it to work with SlipStream v2.3.4+ (#17).
- Added support for building an image with ss-execute.

### Migration

No DB migration (from v2.3.4) is required.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.4...SlipStreamServer-2.3.5)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.4...SlipStreamUI-2.3.5)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.4...SlipStreamClient-2.3.5)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.4...SlipStreamDocumentation-2.3.5)  


## v2.3.4 - October 3rd, 2014

### Migration procedure

**IMPORTANT: v2.3.4 requires data migration from v2.3.0. The following steps MUST be followed:**
 1. Stop SlipStream
 2. Stop HSQLDB (or your DB engine)
 3. Execute the following SQL files located in /opt/slipstream/server/migrations:
  * 008_runtimeparameter_new_name_column.sql
  * 009_embedded_authz_in_module.sql
 4. Start HSQLDB (or your DB engine)
 5. Start SlipStream**

Command to stop HSQLDB:
```
java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql 'SHUTDOWN;' 
```

Example command to execute the migration script:
```
java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/008_runtimeparameter_new_name_column.sql
```

### New features and bug fixes

- Database performance improvement.
- Added support of mutable Run in ss-execute.
- All server-side connectors are now extracted in individual packages.
- Added per-connector config files.
- Improved XML importation.
- Improved error reporting from SlipStream Clients to the SlipStream Server.
- Increase the maximal size of runtime parameter values to 4096 bytes.
- Fixed a bug which prevent to get the runtimeparameters 'ids' and 'multiplicity' with ss-get.
- Fixed a bug where a failure in a deployment script might not be detected.
- Fixed a bug where deployment refuse to start if the cloudservice is set to 'default'.
- Fixed a bug of circular reference in modules.
- Updated the documentation.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.3.0...SlipStreamServer-2.3.4)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.3.0...SlipStreamUI-2.3.4)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.3.0...SlipStreamClient-2.3.4)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.3.0...SlipStreamDocumentation-2.3.4)  


## v2.3.0 - August 14th, 2014

### New features and bug fixes

- Mutable Run.
- Some UI improvements related to the mutable run.
- SlipStream Client is now tolerant to network fault.
- Refactored the SlipStream Client. Connectors needs to be upgraded to work with this version.
- Improved the security of all resources by generating a restricted cookie for each Run.
- When Metering is disabled the data collection is now also disabled.
- Overall performance improvements.

### Migration

No DB migration (from v2.2.5) is required.


### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.5...SlipStreamServer-2.3.0)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.5...SlipStreamUI-2.3.0)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.5...SlipStreamClient-2.3.0)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.5...SlipStreamDocumentation-2.3.0)  


## v2.2.5 - June 18th, 2014

### New features and bug fixes

- Some UI improvements related to the new state machine.
- In the UI when a Run page is loaded the delay of 10 seconds before the first update of the overview section was removed.
- Added the ability for privileged users to see the vmstate in the Runs of other users.
- Improved the migration of the garbage collector.
- Improved the logging and the error handling of describeInstance.
- Fixed an HTTP 500 when there is no user-agent in the request.
- Fixed a bug where when you try to build an image, run a deployment or run an image, the latest version is always used even if you were not on the latest version when creating the Run.


### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.4...SlipStreamServer-2.2.5)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.4...SlipStreamUI-2.2.5)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.4...SlipStreamClient-2.2.5)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.4...SlipStreamDocumentation-2.2.5)  


## v2.2.4 - June 13th, 2014

### Migration procedure

**IMPORTANT: v2.2.4 requires data migration from v2.2.3. The following steps MUST be followed:**
 1. Stop SlipStream
 2. Stop HSQLDB (or your DB engine)
 3. Execute the SQL files located in /opt/slipstream/server/migrations (files 006 and 007) 
 4. Start HSQLDB (or your DB engine)
 5. Start SlipStream**

Example command to execute the migration script:
```
java -jar /opt/hsqldb/lib/sqltool.jar --debug --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/006_run_states_fix.sql
```

### New features and bug fixes

- New State Machine.
- New logic for the garbage collector.
- Auto-discovery of connectors.
- Fixed a bug where module parameters disappear of the old version when a new version is saved.
- Improved some RuntimeParameters.
- Fixed a bug where SSH login with keys doesn't work on images with SELinux enabled.
- Improved messages displayed during a Build.
- Added target script termination when abort flag is raised.
- Improved the detection of VMs not killed in a final state.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.3...SlipStreamServer-2.2.4)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.3...SlipStreamUI-2.2.4)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.3...SlipStreamClient-2.2.4)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.3...SlipStreamDocumentation-2.2.4)  


## v2.2.3 - June 2nd, 2014

### New features and bug fixes

- Improved error handling of CloudStack connector
- Fixed a bug with SSH (paramiko)
- Updated RPM packaging of SlipStream client
- Updated xFilesFactor of graphite.  For local update run the following 
```bash
for f in $(find /var/lib/carbon/whisper/slipstream/ -name *.wsp); do whisper-resize $f --xFilesFactor=0 --aggregationMethod=max 10s:6h 1m:7d 10m:5y; done
```

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.2...SlipStreamServer-2.2.3)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.2...SlipStreamUI-2.2.3)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.2...SlipStreamClient-2.2.3)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.2...SlipStreamDocumentation-2.2.3)  



## v2.2.2 - May 27th, 2014

### New features and bug fixes

- Updated CloudStack connector to use the new TasksRunner when terminating instances
- Force draw on usage panel, since now default section

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.1...SlipStreamServer-2.2.2)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.1...SlipStreamUI-2.2.2)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.1...SlipStreamClient-2.2.2)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.1...SlipStreamDocumentation-2.2.2)  


## v2.2.1 - May 26th, 2014

### Migration procedure

**IMPORTANT: v2.2.1 requires data migration from v2.2.0. The following steps MUST be followed:**
 1. Stop SlipStream
 2. Stop HSQLDB (or your DB engine)
 3. Execute the SQL files located in /opt/slipstream/server/migrations (file 005)
 4. Start HSQLDB (or your DB engine)
 5. Start SlipStream**

### New features and bug fixes

- Multi-thread bulk VM creation can be limited for clouds that can't cope
- Added support for CloudStack Advanced Zones as a sub-connector
- Fix issues related to API doc and xml processing
- Made c3p0 optional (see jar-persistence/src/main/resources/META-INF/persistence.xml for details)
- Add persistence support for MySQL and Postgres
- Update the OpenStack connector to use the new OpenStack CLI
- Update poms following SlipStreamParent -> SlipStream git repo rename
- Upgrade c3p0 version
- Now using Apache HTTP client connector unstead of default Restlet Client connector
- Streamline log entries for asynchronous activity
- Upgrade Restlet to v2.2.1
- Metering update communicate via temporary file instead of stdin
- Remove StratusLab from default configuration
- Fix strange orm issue with JPA 2.0
- A few more minor bug fixes

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.2.0...SlipStreamServer-2.2.1)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.2.0...SlipStreamUI-2.2.1)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.2.0...SlipStreamClient-2.2.1)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.2.0...SlipStreamDocumentation-2.2.1)  


## v2.2.0 - May 10th, 2014

### Migration procedure

**IMPORTANT: v2.2.0 requires data migration from v2.1.x. The following steps MUST be followed:**
 1. Stop SlipStream
 2. Stop HSQLDB (or your DB engine)
 3. Execute the SQL files located in /opt/slipstream/server/migrations (files 001..004)
 4. Start HSQLDB (or your DB engine)
 5. Start SlipStream**

### New features and bug fixes

- Fixed performance issue under heavy load due to HashMap causing infinite loop
- Wrapping parameters of Parameterized into ConcurrentHashMap
- Improved asynchronious behaviour
- Improved metering feature
- Removed dependency on jclouds-slf4j
- Removed hibernate3 maven plugin
- Added SQL migration scripts
- Removed Nexus tasks for repo generation
- Migrate to Hibernate 4.3.5
- Fix checkbox not set correctly in edit mode for user
- Enable c3p0 database connection pooling by default
- Improve ergonomics of run dashboard
- Fixed issue with the metering legend items ending with a parenthesis
- Fix several minor bug

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/SlipStreamServer-2.1.16...SlipStreamServer-2.2.0)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/SlipStreamUI-2.1.16...SlipStreamUI-2.2.0)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/SlipStreamClient-2.1.16...SlipStreamClient-2.2.0)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/SlipStreamDocumentation-2.1.16...SlipStreamDocumentation-2.2.0)  
