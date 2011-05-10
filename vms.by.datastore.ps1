$PortGroup = "MyNetwork"
$Cluster = "MyCluster"
$TotalHD = @{
  Name = "HD"
  Expression = {(Get-HardDisk -vm $_ | Measure -Property capacitykb -sum).sum / 1MB}
}
$InVMSAN = @{
  Name = "VMSAN"
  Expression = {Get-NetworkAdapter $_ | Where {$_.NetworkName -eq "$PortGroup"}}
}
$Datastore = @{
  Name = "Datastore"
  Expression = {Get-Datastore –VM $_}
}
Get-Cluster $Cluster | get-vm | Select Name,$Datastore,$TotalHD,ResourcePool,$InVMSAN | Sort Datastore | Export-CSV c:\temp\vms.csv