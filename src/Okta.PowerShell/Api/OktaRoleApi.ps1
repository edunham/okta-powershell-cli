#
# Okta Management
# Allows customers to easily access the Okta Management APIs
# Version: 3.0.0
# Contact: devex-public@okta.com
# Generated by OpenAPI Generator: https://openapi-generator.tech
#

<#
.SYNOPSIS

Create a Permission

.DESCRIPTION

No description available.

.PARAMETER RoleIdOrLabel
`id` or `label` of the role

.PARAMETER PermissionType
An okta permission type


.PARAMETER Uri

Specifies the absolute Uri to be used when making the request. Recommended for paginated results. Optional.

.PARAMETER WithHttpInfo

A switch when turned on will return a hash table of Response, StatusCode and Headers instead of just the Response

.PARAMETER IncludeNullValues

A switch when turned on will include any null values in the payload; Null values are removed by default. Optional.

.OUTPUTS

None
#>
function Add-OktaRolePermission {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${RoleIdOrLabel},
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${PermissionType},
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${Uri},
        [Switch]
        $WithHttpInfo,
        [Switch]
        $IncludeNullValues        
    )

    Process {
        'Calling method: Add-OktaRolePermission' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $LocalVarAccepts = @()
        $LocalVarContentTypes = @()
        $LocalVarQueryParameters = @{}
        $LocalVarHeaderParameters = @{}
        $LocalVarFormParameters = @{}
        $LocalVarPathParameters = @{}
        $LocalVarCookieParameters = @{}
        $LocalVarBodyParameter = $null

        $Configuration = Get-OktaConfiguration
        # HTTP header 'Accept' (if needed)
        $LocalVarAccepts = @('application/json')

        $LocalVarUri = '/api/v1/iam/roles/{roleIdOrLabel}/permissions/{permissionType}'
        if (!$RoleIdOrLabel) {
            throw "Error! The required parameter `RoleIdOrLabel` missing when calling addRolePermission."
        }
        $LocalVarUri = $LocalVarUri.replace('{roleIdOrLabel}', [System.Web.HTTPUtility]::UrlEncode($RoleIdOrLabel))
        if (!$PermissionType) {
            throw "Error! The required parameter `PermissionType` missing when calling addRolePermission."
        }
        $LocalVarUri = $LocalVarUri.replace('{permissionType}', [System.Web.HTTPUtility]::UrlEncode($PermissionType))

        if ($Uri) {
            $ParsedUri = Invoke-ParseAbsoluteUri -Uri $Uri
            $LocalVarUri = $ParsedUri["RelativeUri"]
            $LocalVarQueryParameters = $ParsedUri["QueryParameters"]
        }

        if ($Configuration["ApiKey"] -and $Configuration["ApiKey"]["apiToken"]) {
            $LocalVarHeaderParameters['apiToken'] = $Configuration["ApiKey"]["apiToken"]
            Write-Verbose ("Using API key 'apiToken' in the header for authentication in {0}" -f $MyInvocation.MyCommand)
        }


        if ($Configuration["AccessToken"]) {
            $LocalVarHeaderParameters['Authorization'] = "Bearer " + $Configuration["AccessToken"]
            Write-Verbose ("Using Bearer authentication in {0}" -f $MyInvocation.MyCommand)
        }

        $LocalVarResult = Invoke-OktaApiClient -Method 'POST' `
                                -Uri $LocalVarUri `
                                -Accepts $LocalVarAccepts `
                                -ContentTypes $LocalVarContentTypes `
                                -Body $LocalVarBodyParameter `
                                -HeaderParameters $LocalVarHeaderParameters `
                                -QueryParameters $LocalVarQueryParameters `
                                -FormParameters $LocalVarFormParameters `
                                -CookieParameters $LocalVarCookieParameters `
                                -ReturnType "" `
                                -IsBodyNullable $false

        if ($WithHttpInfo.IsPresent) {
            if ($null -ne $LocalVarResult.Headers.Link) {
                foreach($Link in $LocalVarResult.Headers.Link)   {
                    # Link looks like '<https://myorg.okta.com/api/v1/groups?after=00g9erhe4rJGXhdYs5d7&limit=1>;rel="next"
                    if ($Link.Contains('rel="next"', 'InvariantCultureIgnoreCase')) {
                        $LinkValue = $Link.split(";")[0].ToString()
                        $LocalVarResult.NextPageUri = $LinkValue -replace '[<>]',''
                    }
                }
            }
            return $LocalVarResult
        } else {
            return $LocalVarResult["Response"]
        }
    }
}

<#
.SYNOPSIS

Create a Role

.DESCRIPTION

No description available.

.PARAMETER Instance
No description available.


.PARAMETER Uri

Specifies the absolute Uri to be used when making the request. Recommended for paginated results. Optional.

.PARAMETER WithHttpInfo

A switch when turned on will return a hash table of Response, StatusCode and Headers instead of just the Response

.PARAMETER IncludeNullValues

A switch when turned on will include any null values in the payload; Null values are removed by default. Optional.

.OUTPUTS

IamRole
#>
function New-OktaRole {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [PSCustomObject]
        ${Instance},
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${Uri},
        [Switch]
        $WithHttpInfo,
        [Switch]
        $IncludeNullValues        
    )

    Process {
        'Calling method: New-OktaRole' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $LocalVarAccepts = @()
        $LocalVarContentTypes = @()
        $LocalVarQueryParameters = @{}
        $LocalVarHeaderParameters = @{}
        $LocalVarFormParameters = @{}
        $LocalVarPathParameters = @{}
        $LocalVarCookieParameters = @{}
        $LocalVarBodyParameter = $null

        $Configuration = Get-OktaConfiguration
        # HTTP header 'Accept' (if needed)
        $LocalVarAccepts = @('application/json')

        # HTTP header 'Content-Type'
        $LocalVarContentTypes = @('application/json')

        $LocalVarUri = '/api/v1/iam/roles'

        if ($Uri) {
            $ParsedUri = Invoke-ParseAbsoluteUri -Uri $Uri
            $LocalVarUri = $ParsedUri["RelativeUri"]
            $LocalVarQueryParameters = $ParsedUri["QueryParameters"]
        }

        if (!$Instance) {
            throw "Error! The required parameter `Instance` missing when calling createRole."
        }

        

        if ($IncludeNullValues.IsPresent) {
            $LocalVarBodyParameter = $Instance | ConvertTo-Json -Depth 100
        }
        else{
            $LocalVarBodyParameter = Remove-NullProperties -InputObject $Instance | ConvertTo-Json -Depth 100
        }

        if ($Configuration["ApiKey"] -and $Configuration["ApiKey"]["apiToken"]) {
            $LocalVarHeaderParameters['apiToken'] = $Configuration["ApiKey"]["apiToken"]
            Write-Verbose ("Using API key 'apiToken' in the header for authentication in {0}" -f $MyInvocation.MyCommand)
        }


        if ($Configuration["AccessToken"]) {
            $LocalVarHeaderParameters['Authorization'] = "Bearer " + $Configuration["AccessToken"]
            Write-Verbose ("Using Bearer authentication in {0}" -f $MyInvocation.MyCommand)
        }

        $LocalVarResult = Invoke-OktaApiClient -Method 'POST' `
                                -Uri $LocalVarUri `
                                -Accepts $LocalVarAccepts `
                                -ContentTypes $LocalVarContentTypes `
                                -Body $LocalVarBodyParameter `
                                -HeaderParameters $LocalVarHeaderParameters `
                                -QueryParameters $LocalVarQueryParameters `
                                -FormParameters $LocalVarFormParameters `
                                -CookieParameters $LocalVarCookieParameters `
                                -ReturnType "IamRole" `
                                -IsBodyNullable $false

        if ($WithHttpInfo.IsPresent) {
            if ($null -ne $LocalVarResult.Headers.Link) {
                foreach($Link in $LocalVarResult.Headers.Link)   {
                    # Link looks like '<https://myorg.okta.com/api/v1/groups?after=00g9erhe4rJGXhdYs5d7&limit=1>;rel="next"
                    if ($Link.Contains('rel="next"', 'InvariantCultureIgnoreCase')) {
                        $LinkValue = $Link.split(";")[0].ToString()
                        $LocalVarResult.NextPageUri = $LinkValue -replace '[<>]',''
                    }
                }
            }
            return $LocalVarResult
        } else {
            return $LocalVarResult["Response"]
        }
    }
}

<#
.SYNOPSIS

Delete a Role

.DESCRIPTION

No description available.

.PARAMETER RoleIdOrLabel
`id` or `label` of the role


.PARAMETER Uri

Specifies the absolute Uri to be used when making the request. Recommended for paginated results. Optional.

.PARAMETER WithHttpInfo

A switch when turned on will return a hash table of Response, StatusCode and Headers instead of just the Response

.PARAMETER IncludeNullValues

A switch when turned on will include any null values in the payload; Null values are removed by default. Optional.

.OUTPUTS

None
#>
function Invoke-OktaDeleteRole {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${RoleIdOrLabel},
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${Uri},
        [Switch]
        $WithHttpInfo,
        [Switch]
        $IncludeNullValues        
    )

    Process {
        'Calling method: Invoke-OktaDeleteRole' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $LocalVarAccepts = @()
        $LocalVarContentTypes = @()
        $LocalVarQueryParameters = @{}
        $LocalVarHeaderParameters = @{}
        $LocalVarFormParameters = @{}
        $LocalVarPathParameters = @{}
        $LocalVarCookieParameters = @{}
        $LocalVarBodyParameter = $null

        $Configuration = Get-OktaConfiguration
        # HTTP header 'Accept' (if needed)
        $LocalVarAccepts = @('application/json')

        $LocalVarUri = '/api/v1/iam/roles/{roleIdOrLabel}'
        if (!$RoleIdOrLabel) {
            throw "Error! The required parameter `RoleIdOrLabel` missing when calling deleteRole."
        }
        $LocalVarUri = $LocalVarUri.replace('{roleIdOrLabel}', [System.Web.HTTPUtility]::UrlEncode($RoleIdOrLabel))

        if ($Uri) {
            $ParsedUri = Invoke-ParseAbsoluteUri -Uri $Uri
            $LocalVarUri = $ParsedUri["RelativeUri"]
            $LocalVarQueryParameters = $ParsedUri["QueryParameters"]
        }

        if ($Configuration["ApiKey"] -and $Configuration["ApiKey"]["apiToken"]) {
            $LocalVarHeaderParameters['apiToken'] = $Configuration["ApiKey"]["apiToken"]
            Write-Verbose ("Using API key 'apiToken' in the header for authentication in {0}" -f $MyInvocation.MyCommand)
        }


        if ($Configuration["AccessToken"]) {
            $LocalVarHeaderParameters['Authorization'] = "Bearer " + $Configuration["AccessToken"]
            Write-Verbose ("Using Bearer authentication in {0}" -f $MyInvocation.MyCommand)
        }

        $LocalVarResult = Invoke-OktaApiClient -Method 'DELETE' `
                                -Uri $LocalVarUri `
                                -Accepts $LocalVarAccepts `
                                -ContentTypes $LocalVarContentTypes `
                                -Body $LocalVarBodyParameter `
                                -HeaderParameters $LocalVarHeaderParameters `
                                -QueryParameters $LocalVarQueryParameters `
                                -FormParameters $LocalVarFormParameters `
                                -CookieParameters $LocalVarCookieParameters `
                                -ReturnType "" `
                                -IsBodyNullable $false

        if ($WithHttpInfo.IsPresent) {
            if ($null -ne $LocalVarResult.Headers.Link) {
                foreach($Link in $LocalVarResult.Headers.Link)   {
                    # Link looks like '<https://myorg.okta.com/api/v1/groups?after=00g9erhe4rJGXhdYs5d7&limit=1>;rel="next"
                    if ($Link.Contains('rel="next"', 'InvariantCultureIgnoreCase')) {
                        $LinkValue = $Link.split(";")[0].ToString()
                        $LocalVarResult.NextPageUri = $LinkValue -replace '[<>]',''
                    }
                }
            }
            return $LocalVarResult
        } else {
            return $LocalVarResult["Response"]
        }
    }
}

<#
.SYNOPSIS

Delete a Permission

.DESCRIPTION

No description available.

.PARAMETER RoleIdOrLabel
`id` or `label` of the role

.PARAMETER PermissionType
An okta permission type


.PARAMETER Uri

Specifies the absolute Uri to be used when making the request. Recommended for paginated results. Optional.

.PARAMETER WithHttpInfo

A switch when turned on will return a hash table of Response, StatusCode and Headers instead of just the Response

.PARAMETER IncludeNullValues

A switch when turned on will include any null values in the payload; Null values are removed by default. Optional.

.OUTPUTS

None
#>
function Invoke-OktaDeleteRolePermission {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${RoleIdOrLabel},
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${PermissionType},
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${Uri},
        [Switch]
        $WithHttpInfo,
        [Switch]
        $IncludeNullValues        
    )

    Process {
        'Calling method: Invoke-OktaDeleteRolePermission' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $LocalVarAccepts = @()
        $LocalVarContentTypes = @()
        $LocalVarQueryParameters = @{}
        $LocalVarHeaderParameters = @{}
        $LocalVarFormParameters = @{}
        $LocalVarPathParameters = @{}
        $LocalVarCookieParameters = @{}
        $LocalVarBodyParameter = $null

        $Configuration = Get-OktaConfiguration
        # HTTP header 'Accept' (if needed)
        $LocalVarAccepts = @('application/json')

        $LocalVarUri = '/api/v1/iam/roles/{roleIdOrLabel}/permissions/{permissionType}'
        if (!$RoleIdOrLabel) {
            throw "Error! The required parameter `RoleIdOrLabel` missing when calling deleteRolePermission."
        }
        $LocalVarUri = $LocalVarUri.replace('{roleIdOrLabel}', [System.Web.HTTPUtility]::UrlEncode($RoleIdOrLabel))
        if (!$PermissionType) {
            throw "Error! The required parameter `PermissionType` missing when calling deleteRolePermission."
        }
        $LocalVarUri = $LocalVarUri.replace('{permissionType}', [System.Web.HTTPUtility]::UrlEncode($PermissionType))

        if ($Uri) {
            $ParsedUri = Invoke-ParseAbsoluteUri -Uri $Uri
            $LocalVarUri = $ParsedUri["RelativeUri"]
            $LocalVarQueryParameters = $ParsedUri["QueryParameters"]
        }

        if ($Configuration["ApiKey"] -and $Configuration["ApiKey"]["apiToken"]) {
            $LocalVarHeaderParameters['apiToken'] = $Configuration["ApiKey"]["apiToken"]
            Write-Verbose ("Using API key 'apiToken' in the header for authentication in {0}" -f $MyInvocation.MyCommand)
        }


        if ($Configuration["AccessToken"]) {
            $LocalVarHeaderParameters['Authorization'] = "Bearer " + $Configuration["AccessToken"]
            Write-Verbose ("Using Bearer authentication in {0}" -f $MyInvocation.MyCommand)
        }

        $LocalVarResult = Invoke-OktaApiClient -Method 'DELETE' `
                                -Uri $LocalVarUri `
                                -Accepts $LocalVarAccepts `
                                -ContentTypes $LocalVarContentTypes `
                                -Body $LocalVarBodyParameter `
                                -HeaderParameters $LocalVarHeaderParameters `
                                -QueryParameters $LocalVarQueryParameters `
                                -FormParameters $LocalVarFormParameters `
                                -CookieParameters $LocalVarCookieParameters `
                                -ReturnType "" `
                                -IsBodyNullable $false

        if ($WithHttpInfo.IsPresent) {
            if ($null -ne $LocalVarResult.Headers.Link) {
                foreach($Link in $LocalVarResult.Headers.Link)   {
                    # Link looks like '<https://myorg.okta.com/api/v1/groups?after=00g9erhe4rJGXhdYs5d7&limit=1>;rel="next"
                    if ($Link.Contains('rel="next"', 'InvariantCultureIgnoreCase')) {
                        $LinkValue = $Link.split(";")[0].ToString()
                        $LocalVarResult.NextPageUri = $LinkValue -replace '[<>]',''
                    }
                }
            }
            return $LocalVarResult
        } else {
            return $LocalVarResult["Response"]
        }
    }
}

<#
.SYNOPSIS

Retrieve a Role

.DESCRIPTION

No description available.

.PARAMETER RoleIdOrLabel
`id` or `label` of the role


.PARAMETER Uri

Specifies the absolute Uri to be used when making the request. Recommended for paginated results. Optional.

.PARAMETER WithHttpInfo

A switch when turned on will return a hash table of Response, StatusCode and Headers instead of just the Response

.PARAMETER IncludeNullValues

A switch when turned on will include any null values in the payload; Null values are removed by default. Optional.

.OUTPUTS

IamRole
#>
function Get-OktaRole {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${RoleIdOrLabel},
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${Uri},
        [Switch]
        $WithHttpInfo,
        [Switch]
        $IncludeNullValues        
    )

    Process {
        'Calling method: Get-OktaRole' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $LocalVarAccepts = @()
        $LocalVarContentTypes = @()
        $LocalVarQueryParameters = @{}
        $LocalVarHeaderParameters = @{}
        $LocalVarFormParameters = @{}
        $LocalVarPathParameters = @{}
        $LocalVarCookieParameters = @{}
        $LocalVarBodyParameter = $null

        $Configuration = Get-OktaConfiguration
        # HTTP header 'Accept' (if needed)
        $LocalVarAccepts = @('application/json')

        $LocalVarUri = '/api/v1/iam/roles/{roleIdOrLabel}'
        if (!$RoleIdOrLabel) {
            throw "Error! The required parameter `RoleIdOrLabel` missing when calling getRole."
        }
        $LocalVarUri = $LocalVarUri.replace('{roleIdOrLabel}', [System.Web.HTTPUtility]::UrlEncode($RoleIdOrLabel))

        if ($Uri) {
            $ParsedUri = Invoke-ParseAbsoluteUri -Uri $Uri
            $LocalVarUri = $ParsedUri["RelativeUri"]
            $LocalVarQueryParameters = $ParsedUri["QueryParameters"]
        }

        if ($Configuration["ApiKey"] -and $Configuration["ApiKey"]["apiToken"]) {
            $LocalVarHeaderParameters['apiToken'] = $Configuration["ApiKey"]["apiToken"]
            Write-Verbose ("Using API key 'apiToken' in the header for authentication in {0}" -f $MyInvocation.MyCommand)
        }


        if ($Configuration["AccessToken"]) {
            $LocalVarHeaderParameters['Authorization'] = "Bearer " + $Configuration["AccessToken"]
            Write-Verbose ("Using Bearer authentication in {0}" -f $MyInvocation.MyCommand)
        }

        $LocalVarResult = Invoke-OktaApiClient -Method 'GET' `
                                -Uri $LocalVarUri `
                                -Accepts $LocalVarAccepts `
                                -ContentTypes $LocalVarContentTypes `
                                -Body $LocalVarBodyParameter `
                                -HeaderParameters $LocalVarHeaderParameters `
                                -QueryParameters $LocalVarQueryParameters `
                                -FormParameters $LocalVarFormParameters `
                                -CookieParameters $LocalVarCookieParameters `
                                -ReturnType "IamRole" `
                                -IsBodyNullable $false

        if ($WithHttpInfo.IsPresent) {
            if ($null -ne $LocalVarResult.Headers.Link) {
                foreach($Link in $LocalVarResult.Headers.Link)   {
                    # Link looks like '<https://myorg.okta.com/api/v1/groups?after=00g9erhe4rJGXhdYs5d7&limit=1>;rel="next"
                    if ($Link.Contains('rel="next"', 'InvariantCultureIgnoreCase')) {
                        $LinkValue = $Link.split(";")[0].ToString()
                        $LocalVarResult.NextPageUri = $LinkValue -replace '[<>]',''
                    }
                }
            }
            return $LocalVarResult
        } else {
            return $LocalVarResult["Response"]
        }
    }
}

<#
.SYNOPSIS

Retrieve a Permission

.DESCRIPTION

No description available.

.PARAMETER RoleIdOrLabel
`id` or `label` of the role

.PARAMETER PermissionType
An okta permission type


.PARAMETER Uri

Specifies the absolute Uri to be used when making the request. Recommended for paginated results. Optional.

.PARAMETER WithHttpInfo

A switch when turned on will return a hash table of Response, StatusCode and Headers instead of just the Response

.PARAMETER IncludeNullValues

A switch when turned on will include any null values in the payload; Null values are removed by default. Optional.

.OUTPUTS

Permission
#>
function Get-OktaRolePermission {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${RoleIdOrLabel},
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${PermissionType},
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${Uri},
        [Switch]
        $WithHttpInfo,
        [Switch]
        $IncludeNullValues        
    )

    Process {
        'Calling method: Get-OktaRolePermission' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $LocalVarAccepts = @()
        $LocalVarContentTypes = @()
        $LocalVarQueryParameters = @{}
        $LocalVarHeaderParameters = @{}
        $LocalVarFormParameters = @{}
        $LocalVarPathParameters = @{}
        $LocalVarCookieParameters = @{}
        $LocalVarBodyParameter = $null

        $Configuration = Get-OktaConfiguration
        # HTTP header 'Accept' (if needed)
        $LocalVarAccepts = @('application/json')

        $LocalVarUri = '/api/v1/iam/roles/{roleIdOrLabel}/permissions/{permissionType}'
        if (!$RoleIdOrLabel) {
            throw "Error! The required parameter `RoleIdOrLabel` missing when calling getRolePermission."
        }
        $LocalVarUri = $LocalVarUri.replace('{roleIdOrLabel}', [System.Web.HTTPUtility]::UrlEncode($RoleIdOrLabel))
        if (!$PermissionType) {
            throw "Error! The required parameter `PermissionType` missing when calling getRolePermission."
        }
        $LocalVarUri = $LocalVarUri.replace('{permissionType}', [System.Web.HTTPUtility]::UrlEncode($PermissionType))

        if ($Uri) {
            $ParsedUri = Invoke-ParseAbsoluteUri -Uri $Uri
            $LocalVarUri = $ParsedUri["RelativeUri"]
            $LocalVarQueryParameters = $ParsedUri["QueryParameters"]
        }

        if ($Configuration["ApiKey"] -and $Configuration["ApiKey"]["apiToken"]) {
            $LocalVarHeaderParameters['apiToken'] = $Configuration["ApiKey"]["apiToken"]
            Write-Verbose ("Using API key 'apiToken' in the header for authentication in {0}" -f $MyInvocation.MyCommand)
        }


        if ($Configuration["AccessToken"]) {
            $LocalVarHeaderParameters['Authorization'] = "Bearer " + $Configuration["AccessToken"]
            Write-Verbose ("Using Bearer authentication in {0}" -f $MyInvocation.MyCommand)
        }

        $LocalVarResult = Invoke-OktaApiClient -Method 'GET' `
                                -Uri $LocalVarUri `
                                -Accepts $LocalVarAccepts `
                                -ContentTypes $LocalVarContentTypes `
                                -Body $LocalVarBodyParameter `
                                -HeaderParameters $LocalVarHeaderParameters `
                                -QueryParameters $LocalVarQueryParameters `
                                -FormParameters $LocalVarFormParameters `
                                -CookieParameters $LocalVarCookieParameters `
                                -ReturnType "Permission" `
                                -IsBodyNullable $false

        if ($WithHttpInfo.IsPresent) {
            if ($null -ne $LocalVarResult.Headers.Link) {
                foreach($Link in $LocalVarResult.Headers.Link)   {
                    # Link looks like '<https://myorg.okta.com/api/v1/groups?after=00g9erhe4rJGXhdYs5d7&limit=1>;rel="next"
                    if ($Link.Contains('rel="next"', 'InvariantCultureIgnoreCase')) {
                        $LinkValue = $Link.split(";")[0].ToString()
                        $LocalVarResult.NextPageUri = $LinkValue -replace '[<>]',''
                    }
                }
            }
            return $LocalVarResult
        } else {
            return $LocalVarResult["Response"]
        }
    }
}

<#
.SYNOPSIS

List all Permissions

.DESCRIPTION

No description available.

.PARAMETER RoleIdOrLabel
`id` or `label` of the role


.PARAMETER Uri

Specifies the absolute Uri to be used when making the request. Recommended for paginated results. Optional.

.PARAMETER WithHttpInfo

A switch when turned on will return a hash table of Response, StatusCode and Headers instead of just the Response

.PARAMETER IncludeNullValues

A switch when turned on will include any null values in the payload; Null values are removed by default. Optional.

.OUTPUTS

Permissions
#>
function Invoke-OktaListRolePermissions {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${RoleIdOrLabel},
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${Uri},
        [Switch]
        $WithHttpInfo,
        [Switch]
        $IncludeNullValues        
    )

    Process {
        'Calling method: Invoke-OktaListRolePermissions' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $LocalVarAccepts = @()
        $LocalVarContentTypes = @()
        $LocalVarQueryParameters = @{}
        $LocalVarHeaderParameters = @{}
        $LocalVarFormParameters = @{}
        $LocalVarPathParameters = @{}
        $LocalVarCookieParameters = @{}
        $LocalVarBodyParameter = $null

        $Configuration = Get-OktaConfiguration
        # HTTP header 'Accept' (if needed)
        $LocalVarAccepts = @('application/json')

        $LocalVarUri = '/api/v1/iam/roles/{roleIdOrLabel}/permissions'
        if (!$RoleIdOrLabel) {
            throw "Error! The required parameter `RoleIdOrLabel` missing when calling listRolePermissions."
        }
        $LocalVarUri = $LocalVarUri.replace('{roleIdOrLabel}', [System.Web.HTTPUtility]::UrlEncode($RoleIdOrLabel))

        if ($Uri) {
            $ParsedUri = Invoke-ParseAbsoluteUri -Uri $Uri
            $LocalVarUri = $ParsedUri["RelativeUri"]
            $LocalVarQueryParameters = $ParsedUri["QueryParameters"]
        }

        if ($Configuration["ApiKey"] -and $Configuration["ApiKey"]["apiToken"]) {
            $LocalVarHeaderParameters['apiToken'] = $Configuration["ApiKey"]["apiToken"]
            Write-Verbose ("Using API key 'apiToken' in the header for authentication in {0}" -f $MyInvocation.MyCommand)
        }


        if ($Configuration["AccessToken"]) {
            $LocalVarHeaderParameters['Authorization'] = "Bearer " + $Configuration["AccessToken"]
            Write-Verbose ("Using Bearer authentication in {0}" -f $MyInvocation.MyCommand)
        }

        $LocalVarResult = Invoke-OktaApiClient -Method 'GET' `
                                -Uri $LocalVarUri `
                                -Accepts $LocalVarAccepts `
                                -ContentTypes $LocalVarContentTypes `
                                -Body $LocalVarBodyParameter `
                                -HeaderParameters $LocalVarHeaderParameters `
                                -QueryParameters $LocalVarQueryParameters `
                                -FormParameters $LocalVarFormParameters `
                                -CookieParameters $LocalVarCookieParameters `
                                -ReturnType "Permissions" `
                                -IsBodyNullable $false

        if ($WithHttpInfo.IsPresent) {
            if ($null -ne $LocalVarResult.Headers.Link) {
                foreach($Link in $LocalVarResult.Headers.Link)   {
                    # Link looks like '<https://myorg.okta.com/api/v1/groups?after=00g9erhe4rJGXhdYs5d7&limit=1>;rel="next"
                    if ($Link.Contains('rel="next"', 'InvariantCultureIgnoreCase')) {
                        $LinkValue = $Link.split(";")[0].ToString()
                        $LocalVarResult.NextPageUri = $LinkValue -replace '[<>]',''
                    }
                }
            }
            return $LocalVarResult
        } else {
            return $LocalVarResult["Response"]
        }
    }
}

<#
.SYNOPSIS

List all Roles

.DESCRIPTION

No description available.

.PARAMETER After
The cursor to use for pagination. It is an opaque string that specifies your current location in the list and is obtained from the `Link` response header. See [Pagination](/#pagination) for more information.


.PARAMETER Uri

Specifies the absolute Uri to be used when making the request. Recommended for paginated results. Optional.

.PARAMETER WithHttpInfo

A switch when turned on will return a hash table of Response, StatusCode and Headers instead of just the Response

.PARAMETER IncludeNullValues

A switch when turned on will include any null values in the payload; Null values are removed by default. Optional.

.OUTPUTS

IamRoles
#>
function Invoke-OktaListRoles {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${After},
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${Uri},
        [Switch]
        $WithHttpInfo,
        [Switch]
        $IncludeNullValues        
    )

    Process {
        'Calling method: Invoke-OktaListRoles' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $LocalVarAccepts = @()
        $LocalVarContentTypes = @()
        $LocalVarQueryParameters = @{}
        $LocalVarHeaderParameters = @{}
        $LocalVarFormParameters = @{}
        $LocalVarPathParameters = @{}
        $LocalVarCookieParameters = @{}
        $LocalVarBodyParameter = $null

        $Configuration = Get-OktaConfiguration
        # HTTP header 'Accept' (if needed)
        $LocalVarAccepts = @('application/json')

        $LocalVarUri = '/api/v1/iam/roles'

        if ($Uri) {
            $ParsedUri = Invoke-ParseAbsoluteUri -Uri $Uri
            $LocalVarUri = $ParsedUri["RelativeUri"]
            $LocalVarQueryParameters = $ParsedUri["QueryParameters"]
        }

        if ($After) {
            $LocalVarQueryParameters['after'] = $After
        }

        if ($Configuration["ApiKey"] -and $Configuration["ApiKey"]["apiToken"]) {
            $LocalVarHeaderParameters['apiToken'] = $Configuration["ApiKey"]["apiToken"]
            Write-Verbose ("Using API key 'apiToken' in the header for authentication in {0}" -f $MyInvocation.MyCommand)
        }


        if ($Configuration["AccessToken"]) {
            $LocalVarHeaderParameters['Authorization'] = "Bearer " + $Configuration["AccessToken"]
            Write-Verbose ("Using Bearer authentication in {0}" -f $MyInvocation.MyCommand)
        }

        $LocalVarResult = Invoke-OktaApiClient -Method 'GET' `
                                -Uri $LocalVarUri `
                                -Accepts $LocalVarAccepts `
                                -ContentTypes $LocalVarContentTypes `
                                -Body $LocalVarBodyParameter `
                                -HeaderParameters $LocalVarHeaderParameters `
                                -QueryParameters $LocalVarQueryParameters `
                                -FormParameters $LocalVarFormParameters `
                                -CookieParameters $LocalVarCookieParameters `
                                -ReturnType "IamRoles" `
                                -IsBodyNullable $false

        if ($WithHttpInfo.IsPresent) {
            if ($null -ne $LocalVarResult.Headers.Link) {
                foreach($Link in $LocalVarResult.Headers.Link)   {
                    # Link looks like '<https://myorg.okta.com/api/v1/groups?after=00g9erhe4rJGXhdYs5d7&limit=1>;rel="next"
                    if ($Link.Contains('rel="next"', 'InvariantCultureIgnoreCase')) {
                        $LinkValue = $Link.split(";")[0].ToString()
                        $LocalVarResult.NextPageUri = $LinkValue -replace '[<>]',''
                    }
                }
            }
            return $LocalVarResult
        } else {
            return $LocalVarResult["Response"]
        }
    }
}

<#
.SYNOPSIS

Replace a Role

.DESCRIPTION

No description available.

.PARAMETER RoleIdOrLabel
`id` or `label` of the role

.PARAMETER Instance
No description available.


.PARAMETER Uri

Specifies the absolute Uri to be used when making the request. Recommended for paginated results. Optional.

.PARAMETER WithHttpInfo

A switch when turned on will return a hash table of Response, StatusCode and Headers instead of just the Response

.PARAMETER IncludeNullValues

A switch when turned on will include any null values in the payload; Null values are removed by default. Optional.

.OUTPUTS

IamRole
#>
function Invoke-OktaReplaceRole {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${RoleIdOrLabel},
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [PSCustomObject]
        ${Instance},
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false)]
        [String]
        ${Uri},
        [Switch]
        $WithHttpInfo,
        [Switch]
        $IncludeNullValues        
    )

    Process {
        'Calling method: Invoke-OktaReplaceRole' | Write-Debug
        $PSBoundParameters | Out-DebugParameter | Write-Debug

        $LocalVarAccepts = @()
        $LocalVarContentTypes = @()
        $LocalVarQueryParameters = @{}
        $LocalVarHeaderParameters = @{}
        $LocalVarFormParameters = @{}
        $LocalVarPathParameters = @{}
        $LocalVarCookieParameters = @{}
        $LocalVarBodyParameter = $null

        $Configuration = Get-OktaConfiguration
        # HTTP header 'Accept' (if needed)
        $LocalVarAccepts = @('application/json')

        # HTTP header 'Content-Type'
        $LocalVarContentTypes = @('application/json')

        $LocalVarUri = '/api/v1/iam/roles/{roleIdOrLabel}'
        if (!$RoleIdOrLabel) {
            throw "Error! The required parameter `RoleIdOrLabel` missing when calling replaceRole."
        }
        $LocalVarUri = $LocalVarUri.replace('{roleIdOrLabel}', [System.Web.HTTPUtility]::UrlEncode($RoleIdOrLabel))

        if ($Uri) {
            $ParsedUri = Invoke-ParseAbsoluteUri -Uri $Uri
            $LocalVarUri = $ParsedUri["RelativeUri"]
            $LocalVarQueryParameters = $ParsedUri["QueryParameters"]
        }

        if (!$Instance) {
            throw "Error! The required parameter `Instance` missing when calling replaceRole."
        }

        

        if ($IncludeNullValues.IsPresent) {
            $LocalVarBodyParameter = $Instance | ConvertTo-Json -Depth 100
        }
        else{
            $LocalVarBodyParameter = Remove-NullProperties -InputObject $Instance | ConvertTo-Json -Depth 100
        }

        if ($Configuration["ApiKey"] -and $Configuration["ApiKey"]["apiToken"]) {
            $LocalVarHeaderParameters['apiToken'] = $Configuration["ApiKey"]["apiToken"]
            Write-Verbose ("Using API key 'apiToken' in the header for authentication in {0}" -f $MyInvocation.MyCommand)
        }


        if ($Configuration["AccessToken"]) {
            $LocalVarHeaderParameters['Authorization'] = "Bearer " + $Configuration["AccessToken"]
            Write-Verbose ("Using Bearer authentication in {0}" -f $MyInvocation.MyCommand)
        }

        $LocalVarResult = Invoke-OktaApiClient -Method 'PUT' `
                                -Uri $LocalVarUri `
                                -Accepts $LocalVarAccepts `
                                -ContentTypes $LocalVarContentTypes `
                                -Body $LocalVarBodyParameter `
                                -HeaderParameters $LocalVarHeaderParameters `
                                -QueryParameters $LocalVarQueryParameters `
                                -FormParameters $LocalVarFormParameters `
                                -CookieParameters $LocalVarCookieParameters `
                                -ReturnType "IamRole" `
                                -IsBodyNullable $false

        if ($WithHttpInfo.IsPresent) {
            if ($null -ne $LocalVarResult.Headers.Link) {
                foreach($Link in $LocalVarResult.Headers.Link)   {
                    # Link looks like '<https://myorg.okta.com/api/v1/groups?after=00g9erhe4rJGXhdYs5d7&limit=1>;rel="next"
                    if ($Link.Contains('rel="next"', 'InvariantCultureIgnoreCase')) {
                        $LinkValue = $Link.split(";")[0].ToString()
                        $LocalVarResult.NextPageUri = $LinkValue -replace '[<>]',''
                    }
                }
            }
            return $LocalVarResult
        } else {
            return $LocalVarResult["Response"]
        }
    }
}

