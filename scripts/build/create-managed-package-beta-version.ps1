# There are 2 versions of sfdx-project.json - 1 for the unlocked package and 1 for the managed package
# This script handles switching to the managed package's version of the file, and creating a beta of the managed package

# Create a beta of the managed package version (no `--codecoverage` flag)
cp -R ./force-app/ ./managed/package/
cd ./managed/
$gitBranch = (git branch --show-current)
$gitCommit = (git rev-parse HEAD)
npx sfdx force:package:version:create --json --package "Related-Products" --codecoverage --installationkeybypass --wait 30 --branch $gitBranch --tag $gitCommit
if ($LASTEXITCODE -ne 0) {
    throw "Error creating package version for managed package"
}
Remove-Item -Path "./package" -Force -Recurse
cd ../
