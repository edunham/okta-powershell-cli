#
# Okta Management
# Allows customers to easily access the Okta Management APIs
# Version: 3.0.0
# Contact: devex-public@okta.com
# Generated by OpenAPI Generator: https://openapi-generator.tech
#

function Invoke-OktaApiClient {
    [OutputType('System.Collections.Hashtable')]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [string]$Uri,
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [string[]]$Accepts,
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [string[]]$ContentTypes,
        [Parameter(Mandatory)]
        [hashtable]$HeaderParameters,
        [Parameter(Mandatory)]
        [hashtable]$FormParameters,
        [Parameter(Mandatory)]
        [hashtable]$QueryParameters,
        [Parameter(Mandatory)]
        [hashtable]$CookieParameters,
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Body,
        [Parameter(Mandatory)]
        [string]$Method,
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$ReturnType,
        [Parameter(Mandatory)]
        [bool]$IsBodyNullable
    )

    'Calling method: Invoke-OktaApiClient' | Write-Debug
    $PSBoundParameters | Out-DebugParameter | Write-Debug

    $Configuration = Get-OktaConfiguration
    $RequestUri = $Configuration["BaseUrl"] + $Uri
    $SkipCertificateCheck = $Configuration["SkipCertificateCheck"]

    # cookie parameters
    foreach ($Parameter in $CookieParameters.GetEnumerator()) {
        if ($Parameter.Name -eq "cookieAuth") {
            $HeaderParameters["Cookie"] = $Parameter.Value
        } else {
            $HeaderParameters[$Parameter.Name] = $Parameter.Value
        }
    }
    if ($CookieParameters -and $CookieParameters.Count -gt 1) {
        Write-Warning "Multiple cookie parameters found. Currently only the first one is supported/used"
    }

    # accept, content-type headers
    $Accept = SelectHeaders -Headers $Accepts
    if ($Accept) {
        $HeaderParameters['Accept'] = $Accept
    }

    [string]$MultiPartBoundary = $null
    $ContentType= SelectHeaders -Headers $ContentTypes
    if ($ContentType) {
        $HeaderParameters['Content-Type'] = $ContentType
        if ($ContentType -eq 'multipart/form-data') {
            [string]$MultiPartBoundary = [System.Guid]::NewGuid()
            $MultiPartBoundary = "---------------------------$MultiPartBoundary"
            $HeaderParameters['Content-Type'] = "$ContentType; boundary=$MultiPartBoundary"
        }
    }

    # add default headers if any
    foreach ($header in $Configuration["DefaultHeaders"].GetEnumerator()) {
        $HeaderParameters[$header.Name] = $header.Value
    }

    # construct URL query string
    $HttpValues = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
    foreach ($Parameter in $QueryParameters.GetEnumerator()) {
        if ($Parameter.Value.Count -gt 1) { // array
            foreach ($Value in $Parameter.Value) {
                $HttpValues.Add($Parameter.Key + '[]', $Value)
            }
        } else {
            $HttpValues.Add($Parameter.Key,$Parameter.Value)
        }
    }
    # Build the request and load it with the query string.
    $UriBuilder = [System.UriBuilder]($RequestUri)
    $UriBuilder.Query = $HttpValues.ToString()

    # include form parameters in the request body
    if ($FormParameters -and $FormParameters.Count -gt 0) {
        if (![string]::IsNullOrEmpty($MultiPartBoundary)) {
            $RequestBody = ""
            $LF = "`r`n"
            $FormParameters.Keys | ForEach-Object {
                $value = $FormParameters[$_]
                $isFile = $value.GetType().FullName -eq "System.IO.FileInfo"

                $RequestBody += "--$MultiPartBoundary$LF"
                $RequestBody += "Content-Disposition: form-data; name=`"$_`""
                if ($isFile) {
                    $fileName = $value.Name
                    $RequestBody += "; filename=`"$fileName`"$LF"
                    $RequestBody += "Content-Type: application/octet-stream$LF$LF"
                    $RequestBody += Get-Content -Path $value.FullName
                } else {
                    $RequestBody += "$LF$LF"
                    $RequestBody += ([string]$value)
                }
                $RequestBody += "$LF--$MultiPartBoundary"
            }
            $RequestBody += "--"
        } else {
            $RequestBody = $FormParameters
        }
    }



    if ($Body -or $IsBodyNullable) {
        $RequestBody = $Body
        if ([string]::IsNullOrEmpty($RequestBody) -and $IsBodyNullable -eq $true) {
            $RequestBody = "null"
        }
    }

    $OktaUserAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome + " okta-powershell-module/1.0.0-beta"


    # Setting up vars for retry
    $RetryFlag = $true
    $RetryCount = 0
    $WaitInMilliseconds = 0
    $StartTime = Get-Date
    
    do {
        if ($SkipCertificateCheck -eq $true) {
            if ($null -eq $Configuration["Proxy"]) {
                # skip certification check, no proxy
                $RawResponse = Invoke-WebRequest -Uri $UriBuilder.Uri `
                                        -Method $Method `
                                        -Headers $HeaderParameters `
                                        -Body $RequestBody `
                                        -ErrorAction Stop `
                                        -UseBasicParsing `
                                        -SkipCertificateCheck `
                                        -UserAgent $OktaUserAgent
            } else {
                # skip certification check, use proxy
                $RawResponse = Invoke-WebRequest -Uri $UriBuilder.Uri `
                                        -Method $Method `
                                        -Headers $HeaderParameters `
                                        -Body $RequestBody `
                                        -ErrorAction Stop `
                                        -UseBasicParsing `
                                        -SkipCertificateCheck `
                                        -Proxy $Configuration["Proxy"].GetProxy($UriBuilder.Uri) `
                                        -ProxyUseDefaultCredentials `
                                        -UserAgent $OktaUserAgent
            }
        } else {
            if ($null -eq $Configuration["Proxy"]) {
                # perform certification check, no proxy
                $RawResponse = Invoke-WebRequest -Uri $UriBuilder.Uri `
                                        -Method $Method `
                                        -Headers $HeaderParameters `
                                        -Body $RequestBody `
                                        -ErrorAction Stop `
                                        -UseBasicParsing `
                                        -UserAgent $OktaUserAgent
            } else {
                # perform certification check, use proxy
                $RawResponse = Invoke-WebRequest -Uri $UriBuilder.Uri `
                                        -Method $Method `
                                        -Headers $HeaderParameters `
                                        -Body $RequestBody `
                                        -ErrorAction Stop `
                                        -UseBasicParsing `
                                        -Proxy $Configuration["Proxy"].GetProxy($UriBuilder.Uri) `
                                        -ProxyUseDefaultCredentials `
                                        -UserAgent $OktaUserAgent
            }

            $Response = DeserializeResponse -Response $RawResponse.Content -ReturnType $ReturnType -ContentTypes $RawResponse.Headers["Content-Type"]
            $StatusCode = $RawResponse.StatusCode
            $Headers = $RawResponse.Headers
            $ElapsedTimeInMilliseconds  = CalculateElapsedTime -StartTime $StartTime

            if (ShouldRetry -StatusCode $StatusCode -RetryCount $RetryCount -ElapsedTime $ElapsedTimeInMilliseconds) {
                $WaitInMilliseconds = CalculateDelay -Headers $Headers 

                if ($WaitInMilliseconds -gt 0) {
                    $RetryCount = $RetryCount + 1
                    $RequestId = $Headers['X-Okta-Request-Id'][0]
                    AddRetryHeaders -Headers $HeaderParameters -RequestId $RequestId -RetryCount $RetryCount
                    Start-Sleep -Milliseconds $WaitInMilliseconds
                }
                else {
                    $RetryFlag = $false
                }
            }
            else {
                $RetryFlag = $false
            }        
        }
    } while($RetryFlag)
    
    return @{
        Response = $Response
        StatusCode = $StatusCode
        Headers = $Headers
    }
}

# Calculate the elapsed time given a datetime in milliseconds
function CalculateElapsedTime{
    Param(
        [Parameter(Mandatory)]
        [datetime]$StartTime 
    )

    $ElapsedTimeInMilliseconds = (New-TimeSpan -Start $StartTime -End $(Get-Date)).TotalMilliseconds

    return $ElapsedTimeInMilliseconds
}

# Select JSON MIME if present, otherwise choose the first one if available
function SelectHeaders {
    Param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [String[]]$Headers
    )

    foreach ($Header in $Headers) {
        if (IsJsonMIME -MIME $Header) {
            return $Header
        }
    }

    if (!($Headers) -or $Headers.Count -eq 0) {
        return $null
    } else {
        return $Headers[0] # return the first one
    }
}

function IsJsonMIME {
    Param(
        [Parameter(Mandatory)]
        [string]$MIME
    )

    if ($MIME -match "(?i)^(application/json|[^;/ \t]+/[^;/ \t]+[+]json)[ \t]*(;.*)?$") {
        return $true
    } else {
        return $false
    }
}

function DeserializeResponse {
    Param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$ReturnType,
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Response,
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [string[]]$ContentTypes
    )

    If ($null -eq $ContentTypes) {
        $ContentTypes = [string[]]@()
    }

    If ([string]::IsNullOrEmpty($ReturnType) -and $ContentTypes.Count -eq 0) { # void response
        return $Response
    } Elseif ($ReturnType -match '\[\]$') { # array
        return ConvertFrom-Json $Response
    } Elseif (@("String", "Boolean", "System.DateTime") -contains $ReturnType) { # string, boolean ,datetime
        return $Response
    } Else { # others (e.g. model, file)
        if ($ContentTypes) {
            $ContentType = $null
            if ($ContentTypes.Count -gt 1) {
                $ContentType = SelectHeaders -Headers $ContentTypes
            } else {
                $ContentType = $ContentTypes[0]
            }

            if (IsJsonMIME -MIME $ContentType) { # JSON
                return ConvertFrom-Json $Response
            } else { # XML, file, etc
                return $Response
            }
        } else { # no content type in response header, returning raw response
            return $Response
        }
    }
}
