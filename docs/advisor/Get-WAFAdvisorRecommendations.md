---
external help file: advisor-help.xml
Module Name: advisor
online version:
schema: 2.0.0
---

# Get-WAFAdvisorRecommendations

## SYNOPSIS
Retrieves high availability recommendations from Azure Advisor.

## SYNTAX

```
Get-WAFAdvisorRecommendations [[-Subid] <Object>] [<CommonParameters>]
```

## DESCRIPTION
The Get-WAFAdvisorRecommendations function queries Azure Advisor for recommendations related to high availability.
It uses Azure Resource Graph to fetch and join relevant resource data.

## EXAMPLES

### EXAMPLE 1
```
$subId = "22222222-2222-2222-2222-222222222222"
```

## PARAMETERS

### -Subid
The subscription ID for which to retrieve recommendations.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Claudio Merola
Date: 2024-08-07

## RELATED LINKS