Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$excludedDirs = @(".git", ".github", "scripts")
$errors = New-Object System.Collections.Generic.List[string]

function Add-Error {
    param([string]$Message)

    $errors.Add($Message)
}

function Get-Frontmatter {
    param([string]$Path)

    $lines = Get-Content -LiteralPath $Path
    if ($lines.Count -lt 3 -or $lines[0] -ne "---") {
        throw "Missing YAML frontmatter opening delimiter."
    }

    $closingIndex = -1
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -eq "---") {
            $closingIndex = $i
            break
        }
    }

    if ($closingIndex -lt 0) {
        throw "Missing YAML frontmatter closing delimiter."
    }

    return $lines[1..($closingIndex - 1)]
}

function Parse-Frontmatter {
    param([string[]]$Lines)

    $parsed = @{}
    foreach ($line in $Lines) {
        if ([string]::IsNullOrWhiteSpace($line)) {
            continue
        }

        if ($line -notmatch "^([A-Za-z0-9_-]+):\s*(.+)$") {
            throw "Unsupported frontmatter line: $line"
        }

        $parsed[$matches[1]] = $matches[2].Trim()
    }

    return $parsed
}

function Test-AgentsMetadata {
    param([string]$SkillDir)

    $agentFile = Join-Path $SkillDir "agents\openai.yaml"
    if (-not (Test-Path -LiteralPath $agentFile)) {
        Add-Error "Missing agents/openai.yaml in '$([IO.Path]::GetFileName($SkillDir))'."
        return
    }

    $content = Get-Content -Raw -LiteralPath $agentFile
    $requiredPatterns = @(
        "version:\s*1",
        "agent:",
        "display_name:",
        "short_description:",
        "default_prompt:"
    )

    foreach ($pattern in $requiredPatterns) {
        if ($content -notmatch $pattern) {
            Add-Error "Invalid agents/openai.yaml in '$([IO.Path]::GetFileName($SkillDir))': missing pattern '$pattern'."
        }
    }
}

$topLevelDirs = Get-ChildItem -LiteralPath $repoRoot -Directory | Where-Object {
    $excludedDirs -notcontains $_.Name
}

if ($topLevelDirs.Count -eq 0) {
    Add-Error "No top-level skill directories found."
}

foreach ($dir in $topLevelDirs) {
    $skillName = $dir.Name
    $skillFile = Join-Path $dir.FullName "SKILL.md"

    if (-not (Test-Path -LiteralPath $skillFile)) {
        Add-Error "Top-level directory '$skillName' is missing SKILL.md."
        continue
    }

    try {
        $frontmatterLines = Get-Frontmatter -Path $skillFile
        $frontmatter = Parse-Frontmatter -Lines $frontmatterLines
    } catch {
        Add-Error "Invalid frontmatter in '$skillName/SKILL.md': $($_.Exception.Message)"
        continue
    }

    $keys = @($frontmatter.Keys)
    $unexpectedKeys = @($keys | Where-Object { $_ -notin @("name", "description") })
    if ($unexpectedKeys.Count -gt 0) {
        Add-Error "'$skillName/SKILL.md' has unexpected frontmatter keys: $($unexpectedKeys -join ', ')."
    }

    if (-not $frontmatter.ContainsKey("name")) {
        Add-Error "'$skillName/SKILL.md' is missing the 'name' field."
    } elseif ($frontmatter["name"] -ne $skillName) {
        Add-Error "'$skillName/SKILL.md' has name '$($frontmatter["name"])' but folder name is '$skillName'."
    }

    if (-not $frontmatter.ContainsKey("description")) {
        Add-Error "'$skillName/SKILL.md' is missing the 'description' field."
    } else {
        $description = $frontmatter["description"]
        if ([string]::IsNullOrWhiteSpace($description)) {
            Add-Error "'$skillName/SKILL.md' has an empty description."
        }

        if ($description -notmatch "Use when") {
            Add-Error "'$skillName/SKILL.md' description should include explicit trigger text such as 'Use when ...'."
        }
    }

    Test-AgentsMetadata -SkillDir $dir.FullName
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Skill validation passed for $($topLevelDirs.Count) skill(s)."
