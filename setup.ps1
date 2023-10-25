$env:all_proxy="socks5://127.0.0.1:10808"

function CommandIsExisted(
    [string] [Parameter(Mandatory = $true)] $command
){
    if (Get-Command $command -ErrorAction SilentlyContinue) {
        return $true
    } else {
        return $false
    }
}

function Get-LatestGitHubReleaseVersion {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Owner,
        [Parameter(Mandatory = $true)]
        [string]$Repo
    )

    $apiUrl = "https://api.github.com/repos/$Owner/$Repo/releases/latest"
    $response = Invoke-RestMethod -Uri $apiUrl
    $latestVersion = $response.tag_name
    return $latestVersion
}

Function Install-ModuleIfNotInstalled(
    [string] [Parameter(Mandatory = $true)] $moduleName,
    [string] $minimalVersion
){
    $Installedmodules = Get-InstalledModule
    if ($Installedmodules.name -contains $moduleName)
    {
        "$moduleName is installed "
    }

    else {
        "$moduleName is not installed"
        # $optionalArgs = New-Object -TypeName Hashtable
        if ($null -ne $minimalVersion) {
            # $optionalArgs['RequiredVersion'] = $minimalVersion
            # Install-Module -Name $moduleName @optionalArgs -AllowPrerelease -Scope CurrentUser -Repository PSGallery -Force -Verbose
            Install-Module -Name $moduleName -RequiredVersion $minimalVersion -AllowPrerelease -Scope CurrentUser -Repository PSGallery -Force -Verbose
        }
        else {
            Install-Module -Name $moduleName -AllowPrerelease -Scope CurrentUser -Repository PSGallery -Force -Verbose
        }
    }
}

# Install Modules
#
# Install-Module -Name Terminal-Icons -Repository PSGallery -Force
# Install-Module -Name QRCodeGenerator -Repository PSGallery -Force
# Install-Module -Name z -Repository PSGallery -Force
# Install-Module -Name  PSReadLine -AllowPrerelease -Scope CurrentUser -Repository PSGallery -Force
# Install-ModuleIfNotInstalled 'CosmosDB' '2.1.3.528'

Install-ModuleIfNotInstalled 'Terminal-Icons'
Install-ModuleIfNotInstalled 'QRCodeGenerator'
Install-ModuleIfNotInstalled 'z'
Install-ModuleIfNotInstalled 'PSReadLine'




#If the file does not exist, create it.
if (!(Test-Path -Path $PROFILE -PathType Leaf)) {
    try {
        # Detect Version of Powershell & Create Profile directories if they do not exist.
        if ($PSVersionTable.PSEdition -eq "Core" ) { 
            if (!(Test-Path -Path ($env:userprofile + "\Documents\Powershell"))) {
                New-Item -Path ($env:userprofile + "\Documents\Powershell") -ItemType "directory"
            }
        }
        elseif ($PSVersionTable.PSEdition -eq "Desktop") {
            if (!(Test-Path -Path ($env:userprofile + "\Documents\WindowsPowerShell"))) {
                New-Item -Path ($env:userprofile + "\Documents\WindowsPowerShell") -ItemType "directory"
            }
        }

        # Invoke-RestMethod https://github.com/ChrisTitusTech/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -o $PROFILE
        Invoke-RestMethod https://github.com/lgf4591/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -o $PROFILE
        Write-Host "The profile @ [$PROFILE] has been created."
    }
    catch {
        throw $_.Exception.Message
    }
}
# If the file already exists, show the message and do nothing.
else {
        Get-Item -Path $PROFILE | Move-Item -Destination oldprofile.ps1 -Force
        # Invoke-RestMethod https://github.com/ChrisTitusTech/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -OutFile $PROFILE
        Invoke-RestMethod https://github.com/lgf4591/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -o $PROFILE
        Write-Host "The profile @ [$PROFILE] has been created and old profile removed."
}
& $profile



# Choco install
#
if (CommandIsExisted "choco") {
    Write-Host "chocolatey has been installed!!!"
    # choco upgrade chocolatey -y
    Start-Process powershell -Verb runAs -ArgumentList "choco upgrade chocolatey"
} else {
    Write-Host "install chocolatey now!!!"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}


# Scoop install
#
if (CommandIsExisted "scoop") {
    Write-Host "oh-my-posh has been installed!!!"
    scoop update
} else {
    Write-Host "install scoop now!!!"
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
    irm get.scoop.sh | iex # or Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}


# zoxide install
#
if (CommandIsExisted "zoxide") {
    Write-Host "zoxide has been installed!!!"
    winget upgrade ajeetdsouza.zoxide -s winget
} else {
    Write-Host "install zoxide now!!!"
    winget install ajeetdsouza.zoxide
}



# oh-my-posh Install : https://ohmyposh.dev/docs/installation/windows
#
if (CommandIsExisted "oh-my-posh") {
    Write-Host "oh-my-posh has been installed!!!"
    winget upgrade JanDeDobbeleer.OhMyPosh -s winget
    # scoop update oh-my-posh
    # Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
} else {
    Write-Host "install oh-my-posh now!!!"
    winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
    # winget install JanDeDobbeleer.OhMyPosh -s winget
    # scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
    # Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

    # oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/cobalt2.omp.json | Invoke-Expression
    # oh-my-posh init pwsh --config 'C:\Users\lgf\AppData\Local\Programs\oh-my-posh\themes\kushal.omp.json' | Invoke-Expression
    # oh-my-posh init pwsh --config "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\kushal.omp.json" | Invoke-Expression
    Invoke-RestMethod https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/cobalt2.omp.json -OutFile "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\cobalt2.omp.json"
    Invoke-RestMethod https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/kushal.omp.json -OutFile "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\kushal.omp.json"
}


# starship Install : https://starship.rs/zh-cn/guide/
#
if (CommandIsExisted "starship") {
    Write-Host "oh-my-posh has been installed!!!"
    winget upgrade Starship.Starship -s winget
    # scoop update oh-my-posh
    # Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
} else {
    # cargo install starship --locked
    # choco install starship
    # conda install -c conda-forge starship
    # scoop install starship
    winget install --id Starship.Starship
}



# Font Install
# Get all installed font families

function InstallFont(
    [string] [Parameter(Mandatory = $true)] $fontName
){
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families
    $fontFamilies_map = [ordered]@{CascadiaCode="CaskaydiaCove NF"; Hack="Hack Nerd Font"}

    # Check if CaskaydiaCove NF is installed
    if ($fontFamilies -notcontains $fontFamilies_map[$fontName]) {
        
        # Download and install CaskaydiaCove NF
        $owner = "ryanoasis"
        $repo = "nerd-fonts"
        $latestVersion = Get-LatestGitHubReleaseVersion -Owner $owner -Repo $repo
        Write-Host "Latest release version of $repo is: $latestVersion"
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile("https://github.com/$Owner/$Repo/releases/download/$latestVersion/$fontName.zip", ".\$fontName.zip")

        Expand-Archive -Path ".\$fontName.zip" -DestinationPath ".\$fontName" -Force
        $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
        Get-ChildItem -Path ".\$fontName" -Recurse -Filter "*.ttf" | ForEach-Object {
            If (-not(Test-Path "$env:SystemRoot\Fonts\$($_.Name)")) {        
                # Install font
                $destination.CopyHere($_.FullName, 0x10)
            }
        }

        # Clean up
        Remove-Item -Path ".\$fontName" -Recurse -Force
        Remove-Item -Path ".\$fontName.zip" -Force
    }
}

InstallFont "Hack"
InstallFont "CascadiaCode"

$env:unsetproxy=""