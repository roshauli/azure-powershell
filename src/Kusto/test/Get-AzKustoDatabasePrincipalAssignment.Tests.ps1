$kustoCommonPath = Join-Path $PSScriptRoot 'common.ps1'
. ($kustoCommonPath)
$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'Get-AzKustoDatabasePrincipalAssignment.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'Get-AzKustoDatabasePrincipalAssignment' {
    It 'List' {
        $resourceGroupName = Get-RG-Name
        $clusterName = Get-Cluster-Name
        $databaseName = Get-Database-Name
        $principalAssignmentName = Get-PrincipalAssignment-Name
        $principalId = Get-PrincipalAssignment-PrincipalId
        $role = Get-Database-PrincipalAssignment-Role
        $principalType = Get-PrincipalAssignment-PrincipalType
        $principalAssignmentFullName = "$clusterName/$databaseName/$principalAssignmentName"

        [array]$principalAssignmentGet = Get-AzKustoDatabasePrincipalAssignment -ResourceGroupName $resourceGroupName -ClusterName $clusterName -DatabaseName $databaseName
        $principalAssignment = $principalAssignmentGet[0]
        Validate_PrincipalAssignment $principalAssignment $principalAssignmentFullName $principalId $principalType $role
    }

    It 'Get' {
        $resourceGroupName = Get-RG-Name
        $clusterName = Get-Cluster-Name
        $databaseName = Get-Database-Name
        $principalAssignmentName = Get-PrincipalAssignment-Name
        $principalId = Get-PrincipalAssignment-PrincipalId
        $role = Get-Database-PrincipalAssignment-Role
        $principalType = Get-PrincipalAssignment-PrincipalType
        $principalAssignmentFullName = "$clusterName/$databaseName/$principalAssignmentName"

        $principalAssignment = Get-AzKustoDatabasePrincipalAssignment -ResourceGroupName $resourceGroupName -ClusterName $clusterName -DatabaseName $databaseName -PrincipalAssignmentName  $principalAssignmentName
        Validate_PrincipalAssignment $principalAssignment $principalAssignmentFullName $principalId $principalType $role
    }
}
