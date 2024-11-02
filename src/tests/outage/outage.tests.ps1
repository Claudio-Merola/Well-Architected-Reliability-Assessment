BeforeAll {
    $modulePath = "$PSScriptRoot/../../modules/wara/outage/outage.psm1"
    Import-Module -Name $modulePath -Force
}

Describe 'Get-AzureRestMethodUriPath' {
    Context 'When to get an Azure REST API URI path' {
        BeforeEach {
            $commonCmdletParams = @{
                SubscriptionId       = '11111111-1111-1111-1111-111111111111'
                ResourceProviderName = 'Resource.Provider'
                ResourceType         = 'resourceType'
                ApiVersion           = '0000-00-00'
            }
        }

        It 'Should return the path that does contains resource group' {
            $commonCmdletParams.ResourceGroupName = 'test-rg'
            $commonCmdletParams.Name = 'resource1'
            $result = Get-AzureRestMethodUriPath @commonCmdletParams

            $expected = '/subscriptions/11111111-1111-1111-1111-111111111111/resourcegroups/test-rg/providers/Resource.Provider/resourceType/resource1?api-version=0000-00-00'

            $result | Should -BeExactly $expected
        }

        It 'Should return the path that does contains resource group with query string' {
            $commonCmdletParams.ResourceGroupName = 'test-rg'
            $commonCmdletParams.Name = 'resource1'
            $commonCmdletParams.QueryString = 'test=test'
            $result = Get-AzureRestMethodUriPath @commonCmdletParams

            $expected = '/subscriptions/11111111-1111-1111-1111-111111111111/resourcegroups/test-rg/providers/Resource.Provider/resourceType/resource1?api-version=0000-00-00&test=test'

            $result | Should -BeExactly $expected
        }

        It 'Should return the path that does not contains resource group' {
            $result = Get-AzureRestMethodUriPath @commonCmdletParams

            $expected = '/subscriptions/11111111-1111-1111-1111-111111111111/providers/Resource.Provider/resourceType?api-version=0000-00-00'

            $result | Should -BeExactly $expected
        }

        It 'Should return the path that does not contains resource group with query string' {
            $commonCmdletParams.QueryString = 'test=test'
            $result = Get-AzureRestMethodUriPath @commonCmdletParams

            $expected = '/subscriptions/11111111-1111-1111-1111-111111111111/providers/Resource.Provider/resourceType?api-version=0000-00-00&test=test'

            $result | Should -BeExactly $expected
        }
    }
}

Describe 'Invoke-AzureRestApi' {
    Context 'When to invoke an Azure REST API with a path WITH resource group' {
        BeforeAll {
            $expected = 'JsonText'

            Mock Invoke-AzRestMethod {
                return @{ Content = $expected }
            } -ModuleName 'outage' -Verifiable
        }

        BeforeEach {
            $commonCmdletParams = @{
                Method               = 'GET'
                SubscriptionId       = '11111111-1111-1111-1111-111111111111'
                ResourceGroupName    = 'test-rg'
                ResourceProviderName = 'Resource.Provider'
                ResourceType         = 'resourceType'
                Name                 = 'resource1'
                ApiVersion           = '0000-00-00'
            }
        }

        It 'Should call Get-AzureRestMethodUriPath and Invoke-AzRestMethod then return the response from the Azure REST API' {
            $result = Invoke-AzureRestApi @commonCmdletParams

            Should -InvokeVerifiable
            $result.Content | Should -BeExactly $expected
        }

        It 'Should call Get-AzureRestMethodUriPath and Invoke-AzRestMethod then return the response from the Azure REST API with query string' {
            $commonCmdletParams.QueryString = 'test=test'
            $result = Invoke-AzureRestApi @commonCmdletParams

            Should -InvokeVerifiable
            $result.Content | Should -BeExactly $expected
        }

        It 'Should call Get-AzureRestMethodUriPath and Invoke-AzRestMethod then return the response from the Azure REST API with request body' {
            $commonCmdletParams.RequestBody = 'test'
            $result = Invoke-AzureRestApi @commonCmdletParams

            Should -InvokeVerifiable
            $result.Content | Should -BeExactly $expected
        }

        It 'Should call Get-AzureRestMethodUriPath and Invoke-AzRestMethod then return the response from the Azure REST API with query string and request body' {
            $commonCmdletParams.QueryString = 'test=test'
            $commonCmdletParams.RequestBody = 'test'
            $result = Invoke-AzureRestApi @commonCmdletParams

            Should -InvokeVerifiable
            $result.Content | Should -BeExactly $expected
        }
    }
    
    Context 'When to invoke an Azure REST API with a path WITHOUT resource group' {
        BeforeAll {
            $expected = 'JsonText'

            Mock Invoke-AzRestMethod {
                return @{ Content = $expected }
            } -ModuleName 'outage' -Verifiable
        }

        BeforeEach {
            $commonCmdletParams = @{
                Method               = 'GET'
                SubscriptionId       = '11111111-1111-1111-1111-111111111111'
                ResourceProviderName = 'Resource.Provider'
                ResourceType         = 'resourceType'
                ApiVersion           = '0000-00-00'
            }
        }

        It 'Should call Get-AzureRestMethodUriPath and Invoke-AzRestMethod then return the response from the Azure REST API' {
            $result = Invoke-AzureRestApi @commonCmdletParams

            Should -InvokeVerifiable
            $result.Content | Should -BeExactly $expected
        }

        It 'Should call Get-AzureRestMethodUriPath and Invoke-AzRestMethod then return the response from the Azure REST API with query string' {
            $commonCmdletParams.QueryString = 'test=test'
            $result = Invoke-AzureRestApi @commonCmdletParams

            Should -InvokeVerifiable
            $result.Content | Should -BeExactly $expected
        }

        It 'Should call Get-AzureRestMethodUriPath and Invoke-AzRestMethod then return the response from the Azure REST API with request body' {
            $commonCmdletParams.RequestBody = 'test'
            $result = Invoke-AzureRestApi @commonCmdletParams

            Should -InvokeVerifiable
            $result.Content | Should -BeExactly $expected
        }

        It 'Should call Get-AzureRestMethodUriPath and Invoke-AzRestMethod then return the response from the Azure REST API with query string and request body' {
            $commonCmdletParams.QueryString = 'test=test'
            $commonCmdletParams.RequestBody = 'test'
            $result = Invoke-AzureRestApi @commonCmdletParams

            Should -InvokeVerifiable
            $result.Content | Should -BeExactly $expected
        }
    }
}

Describe 'New-WAFOutageObject' {
    Context 'When to get an OutageObject' {
        BeforeAll {
            $outageDescriptionFilePath = "$PSScriptRoot/../data/outage/outageDescriptionData.txt"
        }

        BeforeEach {
            $commonCmdletParams = @{
                SubscriptionId  = '11111111-1111-1111-1111-111111111111'
                TrackingId      = 'XXXX-XXX'
                Status          = 'Active'
                LastUpdateTime  = Get-Date -Year 2024 -Month 1 -Day 2 -Hour 3 -Minute 4 -Second 5
                StartTime       = Get-Date -Year 2024 -Month 1 -Day 2 -Hour 3 -Minute 4 -Second 5
                EndTime         = Get-Date -Year 2024 -Month 1 -Day 2 -Hour 3 -Minute 4 -Second 5
                Level           = 'Warning'
                Title           = 'Mitigated - Storage Metrics UI Regression Impacting Non-Classic Storage Accounts in Azure Monitor'
                Summary         = "<p><strong>What happened?</strong></p>"
                Header          = 'Your service might have been impacted by an Azure service issue'
                Description     = Get-Content $outageDescriptionFilePath -Raw
            }

            $expected = @{
                subscription    = $commonCmdletParams.SubscriptionId
                trackingId      = $commonCmdletParams.TrackingId
                status          = $commonCmdletParams.Status
                lastUpdateTime  = $commonCmdletParams.LastUpdateTime.ToString('yyyy-MM-dd HH:mm:ss')
                startTime       = $commonCmdletParams.StartTime.ToString('yyyy-MM-dd HH:mm:ss')
                endTime         = $commonCmdletParams.EndTime.ToString('yyyy-MM-dd HH:mm:ss')
                level           = $commonCmdletParams.Level
                title           = $commonCmdletParams.Title
                summary         = $commonCmdletParams.Summary
                header          = $commonCmdletParams.Header
                description     = $commonCmdletParams.Description
            }
        }

        It 'Should return an OutageObject with a single impacted service' {
            $commonCmdletParams.ImpactedService = 'Network Infrastructure'
            $result = New-WAFOutageObject @commonCmdletParams

            $expected.impactedService = ($commonCmdletParams.ImpactedService -join ', ')

            $result | Should -BeOfType [PSCustomObject]
            $result.Subscription | Should -BeExactly $expected.subscription
            $result.TrackingId | Should -BeExactly $expected.trackingId
            $result.Status | Should -BeExactly $expected.status
            $result.LastUpdateTime | Should -BeExactly $expected.lastUpdateTime
            $result.StartTime | Should -BeExactly $expected.startTime
            $result.EndTime | Should -BeExactly $expected.endTime
            $result.Level | Should -BeExactly $expected.level
            $result.Title | Should -BeExactly $expected.title
            $result.Summary | Should -BeExactly $expected.summary
            $result.Header | Should -BeExactly $expected.header
            $result.ImpactedService | Should -BeExactly $expected.impactedService
            $result.Description | Should -BeExactly $expected.description
        }

        It 'Should return an OutageObject with multiple impacted services' {
            $commonCmdletParams.ImpactedService = 'Network Infrastructure', 'Azure Database for MySQL', 'Automation'
            $result = New-WAFOutageObject @commonCmdletParams

            $expected.impactedService = ($commonCmdletParams.ImpactedService -join ', ')

            $result | Should -BeOfType [PSCustomObject]
            $result.Subscription | Should -BeExactly $expected.subscription
            $result.TrackingId | Should -BeExactly $expected.trackingId
            $result.Status | Should -BeExactly $expected.status
            $result.LastUpdateTime | Should -BeExactly $expected.lastUpdateTime
            $result.StartTime | Should -BeExactly $expected.startTime
            $result.EndTime | Should -BeExactly $expected.endTime
            $result.Level | Should -BeExactly $expected.level
            $result.Title | Should -BeExactly $expected.title
            $result.Summary | Should -BeExactly $expected.summary
            $result.Header | Should -BeExactly $expected.header
            $result.ImpactedService | Should -BeExactly $expected.impactedService
            $result.Description | Should -BeExactly $expected.description
        }
    }
}

Describe 'Get-WAFOutage' {
    Context 'When to get an OutageObject' {
        BeforeAll {
            $moduleNameToInjectMock = 'outage'
        }

        It 'Should return an OutageObject' {
            $restApiResponseFilePath = "$PSScriptRoot/../data/outage/restApiSingleResponseData.json"
            $restApiResponseContent = Get-Content $restApiResponseFilePath -Raw

            Mock Invoke-AzureRestApi {
                return @{ Content = $restApiResponseContent }
            } -ModuleName $moduleNameToInjectMock -Verifiable

            $subscriptionId = '11111111-1111-1111-1111-111111111111'

            $responseObject = ($restApiResponseContent | ConvertFrom-Json -Depth 15).value
            $expected = @{
                subscription    = $subscriptionId
                trackingId      = $responseObject.name
                status          = $responseObject.properties.status
                lastUpdateTime  = $responseObject.properties.lastUpdateTime.ToString('yyyy-MM-dd HH:mm:ss')
                startTime       = $responseObject.properties.impactStartTime.ToString('yyyy-MM-dd HH:mm:ss')
                endTime         = $responseObject.properties.impactMitigationTime.ToString('yyyy-MM-dd HH:mm:ss')
                level           = $responseObject.properties.level
                title           = $responseObject.properties.title
                summary         = $responseObject.properties.summary
                header          = $responseObject.properties.header
                impactedService = $responseObject.properties.impact.impactedService -join ', '
                description     = $responseObject.properties.description
            }

            $result = Get-WAFOutage -SubscriptionId $subscriptionId

            Should -InvokeVerifiable
            $result | Should -BeOfType [PSCustomObject]
            $result.Subscription | Should -BeExactly $expected.subscription
            $result.TrackingId | Should -BeExactly $expected.trackingId
            $result.Status | Should -BeExactly $expected.status
            $result.LastUpdateTime | Should -BeExactly $expected.lastUpdateTime
            $result.StartTime | Should -BeExactly $expected.startTime
            $result.EndTime | Should -BeExactly $expected.endTime
            $result.Level | Should -BeExactly $expected.level
            $result.Title | Should -BeExactly $expected.title
            $result.Summary | Should -BeExactly $expected.summary
            $result.Header | Should -BeExactly $expected.header
            $result.ImpactedService | Should -BeExactly $expected.impactedService
            $result.Description | Should -BeExactly $expected.description
        }

        It 'Should return multiple OutageObjects' {
            $restApiResponseFilePath = "$PSScriptRoot/../data/outage/restApiMultipleResponseData.json"
            $restApiResponseContent = Get-Content $restApiResponseFilePath -Raw

            Mock Invoke-AzureRestApi {
                return @{ Content = $restApiResponseContent }
            } -ModuleName $moduleNameToInjectMock -Verifiable

            $subscriptionId = '11111111-1111-1111-1111-111111111111'

            $responseObjects = ($restApiResponseContent | ConvertFrom-Json -Depth 15).value
            $expectedValues = foreach ($responseObject in $responseObjects) {
                @{
                    subscription    = $subscriptionId
                    trackingId      = $responseObject.name
                    status          = $responseObject.properties.status
                    lastUpdateTime  = $responseObject.properties.lastUpdateTime.ToString('yyyy-MM-dd HH:mm:ss')
                    startTime       = $responseObject.properties.impactStartTime.ToString('yyyy-MM-dd HH:mm:ss')
                    endTime         = $responseObject.properties.impactMitigationTime.ToString('yyyy-MM-dd HH:mm:ss')
                    level           = $responseObject.properties.level
                    title           = $responseObject.properties.title
                    summary         = $responseObject.properties.summary
                    header          = $responseObject.properties.header
                    impactedService = $responseObject.properties.impact.impactedService -join ', '
                    description     = $responseObject.properties.description
                }
            }

            $results = Get-WAFOutage -SubscriptionId $subscriptionId

            Should -InvokeVerifiable
            $results.Length | Should -BeExactly $expectedValues.Length

            for ($i = 0; $i -lt $results.Length; $i++) {
                $result = $results[$i]
                $expected = $expectedValues[$i]

                $result | Should -BeOfType [PSCustomObject]
                $result.Subscription | Should -BeExactly $expected.subscription
                $result.TrackingId | Should -BeExactly $expected.trackingId
                $result.Status | Should -BeExactly $expected.status
                $result.LastUpdateTime | Should -BeExactly $expected.lastUpdateTime
                $result.StartTime | Should -BeExactly $expected.startTime
                $result.EndTime | Should -BeExactly $expected.endTime
                $result.Level | Should -BeExactly $expected.level
                $result.Title | Should -BeExactly $expected.title
                $result.Summary | Should -BeExactly $expected.summary
                $result.Header | Should -BeExactly $expected.header
                $result.ImpactedService | Should -BeExactly $expected.impactedService
                $result.Description | Should -BeExactly $expected.description
            }
        }
    }
}
