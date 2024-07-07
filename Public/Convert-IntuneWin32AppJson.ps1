function Convert-IntuneWin32AppJson {
    <#
    .SYNOPSIS
        Converts a JSON file available locally to an IntuneWin32App-Object.

    .DESCRIPTION
        Converts a JSON file containing all needed parameters to an IntuneWin32App-Object.
        This can be used to parse this parameters directly to Add-IntuneWin32App.

    .PARAMETER FilePath
        Specify an existing local path to where the JSON file is located.

    .NOTES
        Author:      Markus Danner
        Contact:     @dannmark
        Created:     2024-07-07
        Updated:     2024-07-07

        Version history:
        1.0.0 - (2024-07-07) Function created
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(

        [parameter(Mandatory = $true, ParameterSetName = "JSON", HelpMessage = "Specify an existing local path to where the JSON file is located.")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                # Check if file name contains any invalid characters
                if ((Split-Path -Path $_ -Leaf).IndexOfAny([IO.Path]::GetInvalidFileNameChars()) -ge 0) {
                    throw "File name '$(Split-Path -Path $_ -Leaf)' contains invalid characters"
                }
                else {
                    # Check if full path exist
                    if (Test-Path -Path $_) {
                        # Check if file extension is json
                        $FileExtension = [System.IO.Path]::GetExtension((Split-Path -Path $_ -Leaf))
                        if ($FileExtension -like ".json") {
                            return $true
                        }
                        else {
                            throw "Given file name '$(Split-Path -Path $_ -Leaf)' contains an unsupported file extension. Supported extension is '.json'"
                        }
                    }
                    else {
                        throw "File or folder does not exist"
                    }
                }
            })]
        [string]$FilePath
    )
    Begin {

        # Handle error action preference for non-cmdlet code
        $ErrorActionPreference = "Stop"

        Class IntuneWin32App {

            #ToDo Write class and fill with json parameter
            #ToDo Allow ValuesFromPipeline in Add-IntuneWin32App.ps1

        }

    }
    Process {

        Try {
            $JsonObject = Get-Content -Path $FilePath | ConvertFrom-Json

            $JsonObject



        }
        catch [System.Exception] {
            Write-Warning -Message "An error occurred while converting the json file. Error message: $($_.Exception.Message)"
        }

    }
}