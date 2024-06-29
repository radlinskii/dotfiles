const { exec } = require("child_process");
const fs = require("fs");
const path = require("path");

function createFileSymLink(targetPath, sourcePath) {
    // Remove existing file or link
    if (fs.existsSync(targetPath)) {
        fs.unlinkSync(targetPath);
    }

    // Command to create symbolic link for file on Windows
    const command = `cmd /c mklink "${targetPath}" "${sourcePath}"`;

    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error: ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`Stderr: ${stderr}`);
            return;
        }
        console.log(`Created: ${stdout}`);
    });
}

function processDirectory(targetPath, sourcePath) {
    // Delete target if it exists
    if (fs.existsSync(targetPath)) {
        fs.rmSync(targetPath, { recursive: true, force: true });
    }

    // Create empty target directory
    fs.mkdirSync(targetPath, { recursive: true });

    // Iterate over items in the directory
    fs.readdirSync(sourcePath).forEach((item) => {
        const sourceItem = path.join(sourcePath, item);
        const targetItem = path.join(targetPath, item);
        createSymLink(sourceItem, targetItem);
    });
}

// Function to create symbolic links recursively
function createSymLink(source, target) {
    const sourcePath = path.resolve(source);
    const targetPath = path.resolve(target);

    // Check if source is a directory
    if (fs.lstatSync(sourcePath).isDirectory()) {
        processDirectory(targetPath, sourcePath);
    } else {
        createFileSymLink(targetPath, sourcePath);
    }
}

module.exports = { createSymLink };
