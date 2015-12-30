# eyefi_spool_fix
Detects and parses out files from eye-fi spool directory that are broken

Notes: I noticed files were getting stuck in my %User Profile%\AppData\Local\Eye-Fi\spool\
 folders. They were a mix of JPG, tar.gz and ISO (mp4s)

Usage: 
- Move all files from each of the subdirectories to a new folder and clone this into that folder
- Run this in that folder:
       find . -type f -exec mv '{}' '{}'.tar.gz \;
- Clone the script (or download to that folder)
- Run the script

 All files will be moved to save, and .tar.gz will be moved to 'processed' folder
 You can delete the 'processed' folder if you're happy with the results.
 Files should retain all original filestamp dates, I did the best to ensure filenames were satisfactory
