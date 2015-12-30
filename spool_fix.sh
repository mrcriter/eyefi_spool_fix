#!/bin/bash
#Author: mrcriter
#Name: eyefi_spool_fix
#Date: 2015-12-30
#Version: 1.0
#Notes: I noticed files were getting stuck in my %User Profile%\AppData\Local\Eye-Fi\spool\delivery\<mac address>
# folders. They were a mix of JPG, tar.gz and ISO (mp4s)
#Usage: move all files from each of the subdirectories to a new folder and clone this into that folder
# Run the script. All files will be moved to save, and .tar.gz will be moved to 'processed' folder
# You can delete the 'processed' folder if you're happy with the results.
# Files should retain all original filestamp dates, I did the best to ensure filenames were satisfactory

mkdir saved
mkdir processed
for i in *.tar.gz; do
	echo working on $i
	var1=`file $i | awk  '{print $2}'`
	case "$var1" in
		"JPEG")	echo "Found a JPEG!"
			year=`file $i | awk -F'datetime=' '{print $2}' | awk -F':' '{print $1}'`
			month=`file $i | awk -F'datetime=' '{print $2}' | awk -F':' '{print $2}'`
			dayhour=`file $i | awk -F'datetime=' '{print $2}' | awk -F':' '{print $3}' | sed 's/ /_/'`
			minute=`file $i | awk -F'datetime=' '{print $2}' | awk -F':' '{print $4}'`
			second=`file $i | awk -F'datetime=' '{print $2}' | awk -F':' '{print $5}' | awk -F',' '{print $1}'`
			mv $i ./saved/IMG_$year$month$dayhour$minute$second.jpg
			#mv $i ./processed/$i
                        echo "$i saved to IMG_$year$month$dayhour$minute$second.jpg" >> find_jpeg.log
			;;
		"ISO")	echo "Found a MP4!"
			name=`date -r $i +'%Y%M%d_%H%M%S'`
			mv $i ./saved/MOV_$name.mp4
			#mv $i ./processed/$i
			echo "$i saved to MOV_$name.mp4" >> find_jpeg.log
		;;
		"POSIX") echo "Found posix!"
			tar -xvf $i -C ./saved
			mv $i ./processed/$i
                        echo "$i extracted" >> find_jpeg.log
		;;
		*) 	echo "Error, unknown file"
			echo "$i - unknown file type $var1" >> error.log
		;;
	esac
done
