<#
.SYNOPSIS
Uploads publication assets to Cloudflare R2.

.DESCRIPTION
This script ensures the required AWS.Tools.S3 module is installed, loads environment variables
from .env (via Load-Env.ps1), and uploads the velopack directory and changelogs to the configured
Cloudflare R2 bucket.
#>

$ErrorActionPreference = "Stop"

Write-Host "Checking for AWS.Tools.S3 module..."
if (!(Get-Module -ListAvailable -Name AWS.Tools.S3)) {
    Write-Host "AWS.Tools.S3 module not found. Installing..."
    Install-Module -Name AWS.Tools.S3 -Force -AllowClobber -Scope CurrentUser
}
Import-Module AWS.Tools.S3

Write-Host "Loading environment variables from Load-Env.ps1..."
$loadEnvScript = Join-Path -Path $PSScriptRoot -ChildPath "Load-Env.ps1"
if (Test-Path $loadEnvScript) {
    . $loadEnvScript
} else {
    Write-Error "Load-Env.ps1 not found in $PSScriptRoot"
    exit 1
}

# Validate required variables
$requiredVars = @('R2_S3_ENDPOINT', 'R2_ACCESS_KEY_ID', 'R2_SECRET_ACCESS_KEY', 'R2_BUCKET')
foreach ($var in $requiredVars) {
    if ([string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($var))) {
        Write-Error "Required environment variable $var is not set. Check your .env file."
        exit 1
    }
}

# Create S3 Client configuration to disable automatic checksums (which R2 doesn't support)
$s3Config = New-Object Amazon.S3.AmazonS3Config
$s3Config.RequestChecksumCalculation = [Amazon.Runtime.RequestChecksumCalculation]::WHEN_REQUIRED
$s3Config.ResponseChecksumValidation = [Amazon.Runtime.ResponseChecksumValidation]::WHEN_REQUIRED

Write-Host "Preparing to upload files to Cloudflare R2..."
$s3Params = @{
    EndpointUrl = [Environment]::GetEnvironmentVariable('R2_S3_ENDPOINT')
    AccessKey   = [Environment]::GetEnvironmentVariable('R2_ACCESS_KEY_ID')
    SecretKey   = [Environment]::GetEnvironmentVariable('R2_SECRET_ACCESS_KEY')
    BucketName  = [Environment]::GetEnvironmentVariable('R2_BUCKET')
    Force       = $true # Force rewrite
    DisablePayloadSigning = $true
    ClientConfig = $s3Config
}

# Upload velopack directory
$velopackDir = Join-Path -Path $PSScriptRoot -ChildPath "velopack"
if (Test-Path $velopackDir) {
    Write-Host "Uploading $velopackDir to glowworm/velopack/ ..."
    Write-S3Object @s3Params -Folder $velopackDir -KeyPrefix "glowworm/velopack" -Recurse
} else {
    Write-Warning "Directory $velopackDir does not exist, skipping."
}

# Upload changelogs-preview.md
$changelogPreview = Join-Path -Path $PSScriptRoot -ChildPath "changelogs-preview.md"
if (Test-Path $changelogPreview) {
    Write-Host "Uploading changelogs-preview.md to glowworm/changelogs-preview.md ..."
    Write-S3Object @s3Params -File $changelogPreview -Key "glowworm/changelogs-preview.md"
} else {
    Write-Warning "File $changelogPreview does not exist, skipping."
}

# Upload changelogs-stable.md
$changelogStable = Join-Path -Path $PSScriptRoot -ChildPath "changelogs-stable.md"
if (Test-Path $changelogStable) {
    Write-Host "Uploading changelogs-stable.md to glowworm/changelogs-stable.md ..."
    Write-S3Object @s3Params -File $changelogStable -Key "glowworm/changelogs-stable.md"
} else {
    Write-Warning "File $changelogStable does not exist, skipping."
}

Write-Host "Upload completed successfully."
