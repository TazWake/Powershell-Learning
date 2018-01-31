# Currently this script does not work as intended

# Check a file has been passed
param([string]$path="")

if ($path -eq "") {
    Write-Host "Missing Path"
    Exit
}


[xml]$holder = Get-Content $path

$block = $holder.nmaprun
# Powershell arrays are annoying
# Enumerate total number of ports open
$a = $holder.nmaprun.host.ports.port | Measure-Object -Line | Select -ExpandProperty Lines
$role = New-Object string[] $a
$c = 0
foreach ($obj in $block) {
    $ips = $holder.nmaprun.host.ipaddr | Select -ExpandProperty Addr
    $hostname = $block.host.hostnames.hostname | Select -ExpandProperty Name
    $portz = $block.host.ports
    foreach ($t in $portz) {
        $box = $t.port
        $cat = $t.port | Select -ExpandProperty portid
        $stat = $t.port | Select -ExpandProperty state
        foreach ($b in $box) {
            if ($b -eq "445") {
                $role[$c] = "Probable Windows - Port 445 in use"
            }
            else {
                if ($b -eq "22") {
                    $role[$c] = "Nix or Networking - Port 22 in use"
                    }
                else {
                    $role[$c] = "Unknown"
                    }
                }
        }
        $c = $c + 1
    }
}


$c = 0
foreach ($a in $ips) { 
    # Error Check
    Write-Host $ips[$c] " - " $role[$c]
    $c = $c + 1 
}
