cd C:\Scripts
qwinsta /counter | Select-String -Pattern 'Disc|Active' | Select-String -Pattern 'services|sessions' -NotMatch > rdp-total-session-list.log
$line_count = Get-Content rdp-total-session-list.log | Measure-Object –Line
$rdp_total_session_count = $line_count.lines
# echo "There are $rdp_total_session_count total RDP sessions."
.\send-statsd.ps1 "RDPTotalSessionCount:$rdp_total_session_count|g"

qwinsta /counter | Select-String -Pattern 'Active' > rdp-active-session-list.log
$line_count = Get-Content rdp-active-session-list.log | Measure-Object –Line
$rdp_active_session_count = $line_count.lines
# echo "There are $rdp_active_session_count active RDP sessions."
.\send-statsd.ps1 "RDPActiveSessionCount:$rdp_active_session_count|g"