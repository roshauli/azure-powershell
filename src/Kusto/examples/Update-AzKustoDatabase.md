### Example 1: Update an existing database by name
```powershell
PS C:\> $2ds = New-TimeSpan -Days 2
PS C:\> $4ds = New-TimeSpan -Days 4
PS C:\> $databaseProperties = New-Object -Type Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20200215.ReadWriteDatabase -Property @{Location='East US'; SoftDeletePeriod=$4ds; HotCachePeriod=$2ds}
PS C:\> Update-AzKustoDatabase -ResourceGroupName testrg -ClusterName testnewkustocluster -Name mykustodatabase -Parameter $databaseProperties

Kind      Location Name                                Type
----      -------- ----                                ----
ReadWrite East US  testnewkustocluster/mykustodatabase Microsoft.Kusto/Clusters/Databases
```

The above command updates the soft deletion period of the Kusto database "mykustodatabase" in the cluster "testnewkustocluster" found in the resource group "testrg".