Custom metrics with the AWS Unified CloudWatch Agent for Windows using statsd

The CloudWatch Agent, after adding the statsd config in CloudWatchWindowsConfig.json and restarting the service, launches a statsd server within the Agent and listens on UDP/8125 (confirmed by running ‘netstat -abp UDP’). get-rdp-session-count.ps1 runs every minute via Task Scheduler to get active and total RDP sessions, then sends that data using the PowerShell statsd client send-statsd.ps1 to the Agent's local statsd server. The Agent collects those metrics and sends them off to CloudWatch for monitoring/alerting.

# start CloudWatch service
cd "C:\Program Files\Amazon\AmazonCloudWatchAgent"
.\amazon-cloudwatch-agent-ctl.ps1 -a fetch-config -m ec2 -c file:"C:\Program Files\Amazon\AmazonCloudWatchAgent\CloudWatchWindowsConfig.json" -s

# stop CloudWatch service
cd "C:\Program Files\Amazon\AmazonCloudWatchAgent"
.\amazon-cloudwatch-agent-ctl.ps1 -m ec2 -a stop

# check CloudWatch service Status
cd "C:\Program Files\Amazon\AmazonCloudWatchAgent"
.\amazon-cloudwatch-agent-ctl.ps1 -m ec2 -a status


# send-statsd.ps1 provided by Joe at https://github.com/joehack3r/powershell-statsd