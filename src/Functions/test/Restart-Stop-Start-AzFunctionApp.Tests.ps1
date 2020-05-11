$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'Restart-Start-Stop-AzFunctionApp.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'Restart-AzFunctionApp, Stop-AzFunctionApp and Start-AzFunctionApp' {

    BeforeAll {
        $PSDefaultParameterValues["Disabled"] = $true
    }

    AfterAll {
        $PSDefaultParameterValues["Disabled"] = $false
    }

    # ByName
    foreach ($functionDefinition in $env.functionAppsToCreate)
    {
        It "ByName '$($functionDefinition.Name)'" {
            Restart-AzFunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName -Force
            $functionApp = Get-AzfunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp.Status | Should -Be "Running"

            Stop-AzFunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName -Force
            $functionApp = Get-AzfunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp.Status | Should -Be "Stopped"

            Start-AzFunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp = Get-AzfunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp.Status | Should -Be "Running"
        }
    }

    # ByObjectInput
    foreach ($functionDefinition in $env.functionAppsToCreate)
    {
        It "ByObjectInput '$($functionDefinition.Name)'" {
            $functionApp = Get-AzfunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp | Restart-AzFunctionApp -Force
            $functionApp = Get-AzfunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp.Status | Should -Be "Running"

            $functionApp = Get-AzfunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp | Stop-AzFunctionApp -Force
            $functionApp = Get-AzfunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp.Status | Should -Be "Stopped"

            $functionApp = Get-AzfunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp | Start-AzFunctionApp
            $functionApp = Get-AzfunctionApp -Name $functionDefinition.Name -ResourceGroupName $functionDefinition.ResourceGroupName
            $functionApp.Status | Should -Be "Running"
        }
    }
}
