$kustoCommonPath = Join-Path $PSScriptRoot 'common.ps1'
. ($kustoCommonPath)
$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'New-AzKustoCluster.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'New-AzKustoCluster' {
    It 'CreateExpanded' {
        $location = Get-Location
        $resourceGroupName = Get-RG-Name
        $clusterName = Get-Cluster-Name
        $skuName = Get-SkuName
        $skuTier = Get-SkuTier
        $resourceType =  Get-Cluster-Resource-Type
        $capacity = Get-Cluster-Default-Capacity

        $clusterCreated = New-AzKustoCluster -ResourceGroupName $resourceGroupName -Name $clusterName -Location $location -SkuName $skuName -SkuTier $skuTier
        Validate_Cluster $clusterCreated $clusterName  $location  "Running" "Succeeded" $resourceType $skuName $skuTier $capacity
    }
}
