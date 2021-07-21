# Check-HiveNightmare

Simple PowerShell script to check if you currently have any volume shadows that are vulnerable to the Windows HiveNightmare vulnerability. Run from a non-elevated shell.

## Usage

`./Check-HiveNightmare.ps1 [-Dump ##]`

Running without any parameters will return a list of shadows with readable SAM hives and the last time that SAM, SYSTEM, and SECURITY were updated.

Running with the -Dump parameter will allow you to specify a shadow number to dump into the current directory.
