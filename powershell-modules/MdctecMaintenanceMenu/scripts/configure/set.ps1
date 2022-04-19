[Environment]::SetEnvironmentVariable($args[0], $args[1], 'Machine')
[Environment]::SetEnvironmentVariable($args[0], $args[1], 'Process')

Write-Host "SetEnvironmentVariable($($args[0]),$($args[1]))"
