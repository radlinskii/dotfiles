# Function to create symbolic link
function Create-SymbolicLink {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )

    if (Test-Path $destinationPath) {
        Write-Host "Destination path '$destinationPath' already exists. Skipping."
        return
    }

    if (Test-Path $sourcePath -PathType Container) {
        cmd /c mklink /d "$destinationPath" "$sourcePath"
    } else {
        cmd /c mklink "$destinationPath" "$sourcePath"
    }
}

# Function to create symbolic links for all items in a directory
function Create-SymbolicLinksForDirectory {
    param (
        [string]$sourceDir,
        [string]$destDir
    )

    # Ensure destination directory exists
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir
    }

    # Get all items in the source directory
    $items = Get-ChildItem -Path $sourceDir -Recurse

    foreach ($item in $items) {
        # Determine relative path from the source directory
        $relativePath = $item.FullName.Substring($sourceDir.Length)

        # Define source and destination paths
        $sourcePath = $item.FullName
        $destinationPath = Join-Path -Path $destDir -ChildPath $relativePath

        # Create directory for destination path if needed
        $destParentDir = Split-Path -Path $destinationPath -Parent
        if (-not (Test-Path $destParentDir)) {
            New-Item -ItemType Directory -Path $destParentDir -Force
        }

        # Create symbolic link
        Create-SymbolicLink -sourcePath $sourcePath -destinationPath $destinationPath
    }
}

# Define source and destination directories
$sourceDirectory = "C:\Users\irad\Projects\dotfiles\nvim"
$destinationDirectory = "C:\Users\irad\AppData\Local\nvim2"

# Call the function to create symbolic links
Create-SymbolicLinksForDirectory -sourceDir $sourceDirectory -destDir $destinationDirectory

