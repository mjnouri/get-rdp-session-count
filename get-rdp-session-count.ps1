qwinsta /counter | Select-String -Pattern 'Disc|Active' | Select-String -Pattern 'services|sessions' -NotMatch > C:\rdp-total-session-count.log
$line_count = Get-Content C:\rdp-total-session-count.log | Measure-Object –Line
$rdp_session_count = $line_count.lines
Get-AWSPowerShellVersion | Out-Null
$rdp_session_count_cw = New-Object -TypeName Amazon.CloudWatch.Model.MetricDatum
$Dimension = [Amazon.CloudWatch.Model.Dimension]::new()
$Dimension.Name = 'RDP Session Count'
$hostname = Get-Content env:computername
$Dimension.Value = $hostname
$rdp_session_count_cw.Dimensions = $Dimension
$rdp_session_count_cw.value = $rdp_session_count
$rdp_session_count_cw.MetricName = "RDP Total Session Count"
$rdp_session_count_cw.Timestamp = [DateTime]::UtcNow
Write-CWMetricData -Namespace CWAgent -MetricData $rdp_session_count_cw

qwinsta /counter | Select-String -Pattern 'Active' > C:\rdp-active-session-count.log
$line_count = Get-Content C:\rdp-active-session-count.log | Measure-Object –Line
$rdp_session_count = $line_count.lines
$rdp_session_count_cw = New-Object -TypeName Amazon.CloudWatch.Model.MetricDatum
$Dimension = [Amazon.CloudWatch.Model.Dimension]::new()
$Dimension.Name = 'RDP Session Count'
$hostname = Get-Content env:computername
$Dimension.Value = $hostname
$rdp_session_count_cw.Dimensions = $Dimension
$rdp_session_count_cw.value = $rdp_session_count
$rdp_session_count_cw.MetricName = "RDP Active Session Count"
$rdp_session_count_cw.Timestamp = [DateTime]::UtcNow
Write-CWMetricData -Namespace CWAgent -MetricData $rdp_session_count_cw
