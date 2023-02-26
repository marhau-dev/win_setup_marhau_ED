Import-Module -DisableNameChecking $PSScriptRoot\..\lib\"title-templates.psm1"
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\debloat-helper\"windows-feature-handler.psm1"

# Adapted from: https://github.com/ChrisTitusTech/win10script/pull/131/files

function Optimize-WindowsFeaturesList() {
    [CmdletBinding()]
    param (
        [Switch] $Revert
    )

    $DisableFeatures = @(
        "FaxServicesClientPackage"             # Windows Fax and Scan
        "IIS-*"                                # Internet Information Services
        "Internet-Explorer-Optional-*"         # Internet Explorer
        "LegacyComponents"                     # Legacy Components
        "MediaPlayback"                        # Media Features (Windows Media Player)
        "MicrosoftWindowsPowerShellV2"         # PowerShell 2.0
        "MicrosoftWindowsPowershellV2Root"     # PowerShell 2.0
        "Printing-PrintToPDFServices-Features" # Microsoft Print to PDF
        "Printing-XPSServices-Features"        # Microsoft XPS Document Writer
        "WorkFolders-Client"                   # Work Folders Client
    )

    $EnableFeatures = @(
        "NetFx3"                            # NET Framework 3.5
        "NetFx4-AdvSrvs"                    # NET Framework 4
        "NetFx4Extended-ASPNET45"           # NET Framework 4.x + ASPNET 4.x
    )

    Write-Title "Optional Features Tweaks"
    Write-Section "Uninstall Optional Features from Windows"

    If ($Revert) {
        Write-Status -Types "*", "OptionalFeature" -Status "Reverting the tweaks is set to '$Revert'." -Warning
        Set-OptionalFeatureState -State 'Enabled' -OptionalFeatures $DisableFeatures
    } Else {
        Set-OptionalFeatureState -State 'Disabled' -OptionalFeatures $DisableFeatures
    }

    Write-Section "Install Optional Features from Windows"
    Set-OptionalFeatureState -State 'Enabled' -OptionalFeatures $EnableFeatures
}

function Main() {
    # List all Optional Features:
    #Get-WindowsOptionalFeature -Online | Select-Object -Property State, FeatureName, DisplayName, Description | Sort-Object State, FeatureName | Format-Table

    # List all Windows Packages:
    #Get-WindowsPackage -Online | Select-Object -Property ReleaseType, PackageName, PackageState, InstallTime | Sort-Object ReleaseType, PackageState, PackageName | Format-Table

    If (!$Revert) {
        Optimize-WindowsFeaturesList # Disable useless features and Enable features claimed as Optional on Windows, but actually, they are useful
    } Else {
        Optimize-WindowsFeaturesList -Revert
    }
}

Main
