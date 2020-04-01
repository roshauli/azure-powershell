$kustoCommonPath = Join-Path $PSScriptRoot 'common.ps1'
. ($kustoCommonPath)
$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'New-AzKustoDatabase.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'New-AzKustoDatabase' {
    It 'CreateExpanded' {
        $databaseFullName = $env.clusterName + "/" + $env.databaseName

        $databaseCreated = New-AzKustoDatabase -ResourceGroupName $env.resourceGroupName -ClusterName $env.clusterName -Name $env.databaseName -Kind ReadWrite -Location $env.location
        Validate_Database $databaseCreated $databaseFullName $env.location $env.databaseType $null $null
    }

    It 'Create' {
        $databaseName = $env.databaseName
        $softDeletePeriodInDays =  Get-Soft-Delete-Period-In-Days
        $hotCachePeriodInDays =  Get-Hot-Cache-Period-In-Days
        $databaseFullName = $env.clusterName + "/" + $databaseName

        $databaseProperties = New-Object -Type Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20200215.ReadWriteDatabase -Property @{Location=$env.location; SoftDeletePeriod=$softDeletePeriodInDays; HotCachePeriod=$hotCachePeriodInDays; Kind="ReadWrite"}
        $databaseCreated = New-AzKustoDatabase -ResourceGroupName $env.resourceGroupName -ClusterName $env.clusterName -Name $databaseName -Parameter $databaseProperties
        Validate_Database $databaseCreated $databaseFullName $env.location $env.databaseType $softDeletePeriodInDays $hotCachePeriodInDays
    }
}
