<h1 align="center">File Organizer Script</h1>

The File Organizer Script is a bash script designed to organize files into specific directories based on their file extensions. It helps keep your files more organized and tidy by sorting them into categories such as images, documents, videos, scripts, and audios. 
In addition to organizing files, the File Organizer Script also ensures data safety by creating backups of your files. The script automatically backs up the user's home directory, including all its contents, to the directory /var/backup/.

<h2 align="center">Prerequisites</h2>
Make sure you have the following installed on your system:
- Bash (usually pre-installed on Linux and macOS)
- find command (usually available on most Unix-like systems)

<h2 align="center">Usage</h2>
- Download the script to your system.
- Make the script executable: chmod +x file_organizer.sh
- Run the script: ./file_organizer.sh

<h2 align="center">Supported File Extensions</h2>
The script organizes files with the following extensions:

<h3>File formats:</h3>
<h4>Images</h4>
jpg, png, gif, jpeg, bmp, tiff, webp, svg, ico, psd

<h4>Documents</h4>
pdf, json, csv, txt, doc, docx, xls, xlsx, ppt, pptx, odt, ods, odp, rtf, xml

<h4>Scripts</h4>
sh, py, c, cpp, java, js, php, pl, rb, swift, bash, ps1, bat, cmd

<h4>Audios</h4>
mp3, wav, ogg, flac, m4a, aac, wma, aiff, ape, alac, opus, mid, amr, ra

 <h4>Videos</h4>
mp4, avi, mkv, gif, wmv, m4v, m4p, mpg, mpeg, flv, nsv, mxf, viv

<h2 align="center">Script Execution</h2>
The script will organize files in the specified <user_direcotry>/file_structure directory. It will create sub-directories for each category (images, documents, videos, scripts, and audios) and move the respective files into these sub-directories based on their file extensions.

Please note that the script will not delete any files but only organize them. Any sub-directories that become empty after the organization will be removed.

<h2 align="center" style="color:red;">Important Note</h2>

Before running any file organization script, it is crucial to make a backup of your important files to avoid any data loss. The File Organizer Script takes this aspect into consideration by automatically backing up the user's home directory to /var/backup/.

<h2 align="center">
  License
</h2>

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

<h2 align="center">
  Author
</h2>

- [D0rDa4aN919](https://github.com/D0rDa4aN919)
