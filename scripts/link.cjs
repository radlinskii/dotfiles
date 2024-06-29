const { exec } = require("child_process");
const fs = require("fs");
const path = require("path");

// Function to create symbolic links recursively
function createSymbolicLink(source, target) {
    const sourcePath = path.resolve(source);
    const targetPath = path.resolve(target);

    // Check if source is a directory
    if (fs.lstatSync(sourcePath).isDirectory()) {
        // Create target directory if it doesn't exist
        if (!fs.existsSync(targetPath)) {
            fs.mkdirSync(targetPath, { recursive: true });
        }

        // Iterate over items in the directory
        fs.readdirSync(sourcePath).forEach((item) => {
            const sourceItem = path.join(sourcePath, item);
            const targetItem = path.join(targetPath, item);
            createSymbolicLink(sourceItem, targetItem);
        });
    } else {
        // Remove existing file or link
        if (fs.existsSync(targetPath)) {
            fs.unlinkSync(targetPath);
        }

        // Create symbolic link for file
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
}
