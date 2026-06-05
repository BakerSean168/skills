param(
    [Parameter(Mandatory = $true)]
    [string]$SkillName,

    [Parameter(Mandatory = $true)]
    [string]$Description,

    [string]$DisplayName,
    [string]$ShortDescription,
    [string]$DefaultPrompt,
    [string]$OutputRoot,
    [switch]$IncludeReferences,
    [switch]$IncludeAssets,
    [switch]$IncludeScripts,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function To-KebabCase {
    param([string]$Value)

    $normalized = $Value.ToLowerInvariant() -replace "[^a-z0-9]+", "-" -replace "^-+", "" -replace "-+$", ""
    $normalized = $normalized -replace "-{2,}", "-"

    if ([string]::IsNullOrWhiteSpace($normalized)) {
        throw "Skill name '$Value' cannot be normalized to a valid kebab-case id."
    }

    return $normalized
}

function To-TitleCase {
    param([string]$Value)

    $segments = $Value -split "-"
    return ($segments | ForEach-Object {
        if ($_.Length -eq 0) { return $_ }
        return $_.Substring(0, 1).ToUpperInvariant() + $_.Substring(1)
    }) -join " "
}

function Render-Template {
    param(
        [string]$TemplatePath,
        [hashtable]$Values
    )

    $content = Get-Content -Raw -LiteralPath $TemplatePath
    foreach ($key in $Values.Keys) {
        $token = "{{" + $key + "}}"
        $content = $content.Replace($token, [string]$Values[$key])
    }

    return $content
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$skillRoot = Split-Path -Parent $scriptRoot
$repoRoot = Split-Path -Parent $skillRoot
$templateRoot = Join-Path $skillRoot "assets\templates"

$normalizedName = To-KebabCase -Value $SkillName
$resolvedOutputRoot = if ($OutputRoot) { $OutputRoot } else { $repoRoot }
$targetDir = Join-Path $resolvedOutputRoot $normalizedName

if ((Test-Path -LiteralPath $targetDir) -and -not $Force) {
    throw "Target skill folder already exists: $targetDir. Use -Force to overwrite files in place."
}

$title = To-TitleCase -Value $normalizedName
$resolvedDisplayName = if ($DisplayName) { $DisplayName } else { $title }
$resolvedShortDescription = if ($ShortDescription) { $ShortDescription } else { "Short summary for $resolvedDisplayName." }
$resolvedDefaultPrompt = if ($DefaultPrompt) { $DefaultPrompt } else { "Operate as $resolvedDisplayName and replace this prompt with the real stance." }

$templateValues = @{
    skill_name = $normalizedName
    title = $title
    description = $Description
    display_name = $resolvedDisplayName
    short_description = $resolvedShortDescription
    default_prompt = $resolvedDefaultPrompt
}

New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $targetDir "agents") -Force | Out-Null

$skillMd = Render-Template -TemplatePath (Join-Path $templateRoot "SKILL.md.tmpl") -Values $templateValues
$openaiYaml = Render-Template -TemplatePath (Join-Path $templateRoot "openai.yaml.tmpl") -Values $templateValues

Set-Content -LiteralPath (Join-Path $targetDir "SKILL.md") -Value $skillMd
Set-Content -LiteralPath (Join-Path $targetDir "agents\openai.yaml") -Value $openaiYaml

if ($IncludeReferences) {
    $referencesDir = Join-Path $targetDir "references"
    New-Item -ItemType Directory -Path $referencesDir -Force | Out-Null
    $referenceTemplate = Get-Content -Raw -LiteralPath (Join-Path $templateRoot "reference.md.tmpl")
    Set-Content -LiteralPath (Join-Path $referencesDir "reference.md") -Value $referenceTemplate
}

if ($IncludeAssets) {
    $assetsDir = Join-Path $targetDir "assets"
    New-Item -ItemType Directory -Path $assetsDir -Force | Out-Null
    $assetTemplate = Get-Content -Raw -LiteralPath (Join-Path $templateRoot "asset.txt.tmpl")
    Set-Content -LiteralPath (Join-Path $assetsDir "template.txt") -Value $assetTemplate
}

if ($IncludeScripts) {
    $scriptsDir = Join-Path $targetDir "scripts"
    New-Item -ItemType Directory -Path $scriptsDir -Force | Out-Null
    $scriptTemplate = Get-Content -Raw -LiteralPath (Join-Path $templateRoot "script.ps1.tmpl")
    Set-Content -LiteralPath (Join-Path $scriptsDir "helper.ps1") -Value $scriptTemplate
}

$createdPaths = @(
    Join-Path $targetDir "SKILL.md"
    Join-Path $targetDir "agents\openai.yaml"
)

if ($IncludeReferences) {
    $createdPaths += Join-Path $targetDir "references\reference.md"
}

if ($IncludeAssets) {
    $createdPaths += Join-Path $targetDir "assets\template.txt"
}

if ($IncludeScripts) {
    $createdPaths += Join-Path $targetDir "scripts\helper.ps1"
}

[pscustomobject]@{
    SkillName = $normalizedName
    TargetDir = $targetDir
    Created = $createdPaths
}
