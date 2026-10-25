# Downloads the SlimefunCore jar this plugin compiles against into the local
# file repository under libs/ and verifies its SHA-512 against Modrinth's hash.
$ErrorActionPreference = 'Stop'
$Version = '2880'
$Url = "https://cdn.modrinth.com/data/Fz9hstnG/versions/8BPkEd8e/SlimefunCore4-$Version.jar"
$Sha512 = '2a17547ad2a81320c60b22697800313b71f8623976a2975be5d7fe9e6989ba1c5cd82dec580f2277b70f5ab09e2a025dcd3fe5f3aad6567fb49e58704f954f7f'
$Dir = Join-Path (Split-Path -Parent $PSScriptRoot) "libs/dev/slimefuncore/SlimefunCore4/$Version"
$Jar = Join-Path $Dir "SlimefunCore4-$Version.jar"
New-Item -ItemType Directory -Force $Dir | Out-Null
if ((Test-Path $Jar) -and ((Get-FileHash -Algorithm SHA512 $Jar).Hash.ToLower() -eq $Sha512)) {
    Write-Host "SlimefunCore4-$Version.jar already present and verified."
    exit 0
}
Write-Host "Downloading $Url"
Invoke-WebRequest -Uri $Url -OutFile $Jar
$Actual = (Get-FileHash -Algorithm SHA512 $Jar).Hash.ToLower()
if ($Actual -ne $Sha512) {
    Remove-Item $Jar
    throw "SHA-512 mismatch for SlimefunCore4-$Version.jar: got $Actual"
}
Write-Host "Verified SlimefunCore4-$Version.jar"
