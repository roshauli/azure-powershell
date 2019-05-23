---
external help file: Az.WebSite-help.xml
Module Name: Az.WebSite
online version: https://docs.microsoft.com/en-us/powershell/module/az.website/get-azwebsitemanagedapi
schema: 2.0.0
---

# Get-AzWebSiteManagedApi

## SYNOPSIS
Gets a managed API.

## SYNTAX

### List (Default)
```
Get-AzWebSiteManagedApi -Location <String> -SubscriptionId <String[]> [-DefaultProfile <PSObject>]
 [<CommonParameters>]
```

### Get
```
Get-AzWebSiteManagedApi -ApiName <String> -Location <String> -SubscriptionId <String[]> [-Export <Boolean>]
 [-DefaultProfile <PSObject>] [<CommonParameters>]
```

### GetViaIdentity
```
Get-AzWebSiteManagedApi -InputObject <IWebSiteIdentity> [-Export <Boolean>] [-DefaultProfile <PSObject>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets a managed API.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ApiName
The managed API name.

```yaml
Type: System.String
Parameter Sets: Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultProfile
The credentials, account, tenant, and subscription used for communication with Azure.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases: AzureRMContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Export
flag showing whether to export API definition in format specified by Accept header.

```yaml
Type: System.Boolean
Parameter Sets: Get, GetViaIdentity
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Identity Parameter

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.WebSite.Models.IWebSiteIdentity
Parameter Sets: GetViaIdentity
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Location
The location.

```yaml
Type: System.String
Parameter Sets: List, Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubscriptionId
Your Azure subscription ID.
This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).

```yaml
Type: System.String[]
Parameter Sets: List, Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Azure.PowerShell.Cmdlets.WebSite.Models.Api20150801Preview.IApiEntity
## NOTES

## RELATED LINKS

[https://docs.microsoft.com/en-us/powershell/module/az.website/get-azwebsitemanagedapi](https://docs.microsoft.com/en-us/powershell/module/az.website/get-azwebsitemanagedapi)
