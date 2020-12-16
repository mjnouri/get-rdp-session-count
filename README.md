Custom metrics with the AWS Unified CloudWatch Agent for Windows using statsd

The CloudWatch Agent, after adding the statsd config in CloudWatchWindowsConfig.json and restarting the service, launches a statsd daemon within the Agent and listens on UDP/8125 (confirm by running ‘netstat -abp UDP’). get-rdp-session-count.ps1 runs every minute via Task Scheduler to get active and total RDP sessions, then sends that data using a PowerShell statsd client (send-statsd.ps1) to the Agent's local statsd server. The Agent collects those metrics and sends them off to CloudWatch for monitoring/alerting.

send-statsd.ps1 client provided by Joe at https://github.com/joehack3r/powershell-statsd
