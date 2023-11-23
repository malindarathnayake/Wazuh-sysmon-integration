# Wazuh-sysmon-integration


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
