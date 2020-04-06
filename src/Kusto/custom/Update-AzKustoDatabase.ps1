
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Updates a database.
.Description
Updates a database.
.Example
PS C:\> $2ds = New-TimeSpan -Days 2
PS C:\> $4ds = New-TimeSpan -Days 4
PS C:\> $databaseProperties = New-Object -Type Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20200215.ReadWriteDatabase -Property @{Location='East US'; SoftDeletePeriod=$4ds; HotCachePeriod=$2ds}
PS C:\> Update-AzKustoDatabase -ResourceGroupName testrg -ClusterName testnewkustocluster -Name mykustodatabase -Parameter $databaseProperties

Kind      Location Name                                Type
----      -------- ----                                ----
ReadWrite East US  testnewkustocluster/mykustodatabase Microsoft.Kusto/Clusters/Databases

.Link
https://docs.microsoft.com/en-us/powershell/module/az.kusto/update-azkustodatabase
#>
function Update-AzKustoDatabase {
    [OutputType([Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20200215.IDatabase])]
    [CmdletBinding(DefaultParameterSetName = 'UpdateExpanded', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [System.String]
        # The name of the Kusto cluster.
        ${ClusterName},

        [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
        [Alias('DatabaseName')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [System.String]
        # The name of the database in the Kusto cluster.
        ${Name},

        [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [System.String]
        # The name of the resource group containing the Kusto cluster.
        ${ResourceGroupName},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Runtime.DefaultInfo(Script = '(Get-AzContext).Subscription.Id')]
        [System.String]
        # Gets subscription credentials which uniquely identify Microsoft Azure subscription.
        # The subscription ID forms part of the URI for every service call.
        ${SubscriptionId},

        [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.IKustoIdentity]
        # Identity Parameter
        # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
        ${InputObject},

        [Parameter(Mandatory)]
        [ArgumentCompleter( { param ( $CommandName, $ParameterName, $WordToComplete, $CommandAst, $FakeBoundParameters ) return @('ReadWrite', 'ReadOnlyFollowing') })]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Support.Kind]
        # Kind of the database
        ${Kind},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.TimeSpan]
        # The time the data should be kept in cache for fast queries in TimeSpan.
        ${HotCachePeriod},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Support.ProvisioningState]
        # The provisioned state of the resource.
        ${ProvisioningState},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.TimeSpan]
        # The time the data should be kept before it stops being accessible to queries in TimeSpan.
        ${SoftDeletePeriod},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20200215.IDatabaseStatistics]
        # The statistics of the database.
        ${Statistics},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [float]
        # The database size - the total size of compressed data and index in bytes.
        ${StatisticsSize},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # Indicates whether the database is followed.
        ${IsFollowed},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The name of the attached database configuration cluster.
        ${AttachedDatabaseConfigurationName},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The name of the leader cluster.
        ${LeaderClusterResourceId},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Support.PrincipalsModificationKind]
        # The principals modification kind of the database.
        ${PrincipalsModificationKind},

        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # Resource location.
        ${Location},

        [Parameter()]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Azure')]
        [System.Management.Automation.PSObject]
        # The credentials, account, tenant, and subscription used for communication with Azure.
        ${DefaultProfile},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command as a job
        ${AsJob},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline
        ${HttpPipelinePrepend},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command asynchronously
        ${NoWait},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
    )

    process {
        try {
            if ($PSBoundParameters['Kind'] -eq 'ReadWrite') {
                $Parameter = [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20200215.ReadWriteDatabase]::new()

                if ($PSBoundParameters.ContainsKey('IsFollowed')) {
                    $Parameter.IsFollowed = $PSBoundParameters['IsFollowed']
                    $null = $PSBoundParameters.Remove('IsFollowed')
                }
            }
            else {
                $Parameter = [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20200215.ReadOnlyFollowingDatabase]::new()
            
                if ($PSBoundParameters.ContainsKey('AttachedDatabaseConfigurationName')) {
                    $Parameter.AttachedDatabaseConfigurationName = $PSBoundParameters['AttachedDatabaseConfigurationName']
                    $null = $PSBoundParameters.Remove('AttachedDatabaseConfigurationName')
                }

                if ($PSBoundParameters.ContainsKey('LeaderClusterResourceId')) {
                    $Parameter.LeaderClusterResourceId = $PSBoundParameters['LeaderClusterResourceId']
                    $null = $PSBoundParameters.Remove('LeaderClusterResourceId')
                }

                if ($PSBoundParameters.ContainsKey('PrincipalsModificationKind')) {
                    $Parameter.PrincipalsModificationKind = $PSBoundParameters['PrincipalsModificationKind']
                    $null = $PSBoundParameters.Remove('PrincipalsModificationKind')
                }
            }

            $null = $PSBoundParameters.Remove('Kind')

            $Parameter.Location = $PSBoundParameters['Location']
            $null = $PSBoundParameters.Remove('Location')

            if ($PSBoundParameters.ContainsKey('HotCachePeriod')) {
                $Parameter.HotCachePeriod = $PSBoundParameters['HotCachePeriod']
                $null = $PSBoundParameters.Remove('HotCachePeriod')
            }

            if ($PSBoundParameters.ContainsKey('ProvisioningState')) {
                $Parameter.ProvisioningState = $PSBoundParameters['ProvisioningState']
                $null = $PSBoundParameters.Remove('ProvisioningState')
            }

            if ($PSBoundParameters.ContainsKey('SoftDeletePeriod')) {
                $Parameter.SoftDeletePeriod = $PSBoundParameters['SoftDeletePeriod']
                $null = $PSBoundParameters.Remove('SoftDeletePeriod')
            }

            if ($PSBoundParameters.ContainsKey('Statistics')) {
                $Parameter.Statistics = $PSBoundParameters['Statistics']
                $null = $PSBoundParameters.Remove('Statistics')
            }

            if ($PSBoundParameters.ContainsKey('StatisticsSize')) {
                $Parameter.StatisticsSize = $PSBoundParameters['StatisticsSize']
                $null = $PSBoundParameters.Remove('StatisticsSize')
            }

            $null = $PSBoundParameters.Add('Parameter', $Parameter)

            Az.Kusto.internal\Update-AzKustoDatabase @PSBoundParameters
        }
        catch {
            throw
        }
    }
}
