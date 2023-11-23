## Wazuh-sysmon-integration

https://wazuh.com/blog/monitoring-commonly-abused-windows-utilities/

#Setup Sysmon and log collection
On the endpoint, download Sysmon from the Microsoft Sysinternals page.
Next, download this Sysmon XML configuration file.
Install Sysmon with this configuration via Command Prompt(Administrator user):

```.\Sysmon.exe -accepteula -i .\sysmonconfig.xml```

On the Wazuh manager, edit the shared configuration file at /var/ossec/etc/shared/default/agent.conf file. This specifies the location to collect Sysmon logs which are sent from the agent to the manager. This will apply to all agents in the default group:


```conf
<agent_config os="windows">
  <localfile>
    <location>Microsoft-Windows-Sysmon/Operational</location>
    <log_format>eventchannel</log_format>
  </localfile>
</agent_config>
```

## Deploy Sysmon via GPO 

Step 1. Create a file “sysmon” in the path c:\program files\

Step 2. Copy Sysmon64.exe and your config file (e.g. config.xml) to the new folder

Step 3. modify NTFS rights so only admins have full rights to config file

Step 4. Configure schedule task to run a powershell command at startup: 


```Start-process Sysmon64.exe -arguments “-acceptEULA —I c:\program files\config.xml”```

Here’s more info on config file:

https://github.com/SwiftOnSecurity/sysmon-config


## Add better Wazuh Rules for sysmon

https://github.com/socfortress/Wazuh-Rules

Install as Root

```curl -so ~/wazuh_socfortress_rules.sh https://raw.githubusercontent.com/socfortress/Wazuh-Rules/main/wazuh_socfortress_rules.sh && bash ~/wazuh_socfortress_rules.sh```


