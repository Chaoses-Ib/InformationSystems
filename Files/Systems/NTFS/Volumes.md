# Volumes
## Master File Table
> The MFT is the heart of the NTFS volume structure. The MFT is implemented as an array of file records.
> 
> The size of each file record can be 1 KB or 4 KB, as defined at volume-format time, and depends on the type of the underlying physical medium:
> - new physical disks that have 4 KB native sectors size and tiered disks generally use 4 KB file records,
> - while older disks that have 512 bytes sectors size use 1 KB file records.
> 
> The size of each MFT entry does not depend on the clusters size and can be overridden at volume-format time through the `Format /l` command.
> 
> Logically, the MFT contains one record for each file on the volume, including a record for the MFT itself. In addition to the MFT, each NTFS volume includes a set of metadata files containing the information that is used to implement the file system structure. Each of these NTFS metadata files has a name that begins with a dollar sign (`$`) and is hidden. For example, the file name of the MFT is `$MFT`. The rest of the files on an NTFS volume are normal user files and directories.
>
> Usually, each MFT record corresponds to a different file. If a file has a large number of attributes or becomes highly fragmented, however, more than one record might be needed for a single file. In such cases, the first MFT record, which stores the locations of the others, is called the **base file record**.[^winter]

## Mounting
> To mount the volume, NTFS looks in the **volume boot record (VBR)** (located at LCN 0), which contains a data structure called the **boot parameter block (BPB)**, to find the physical disk address of the MFT. The MFT’s file record is the first entry in the table; the second file record points to a file located in the middle of the disk called the MFT mirror (file name `$MFTMirr`) that contains a copy of the first four rows of the MFT. This partial copy of the MFT is used to locate metadata files if part of the MFT file can’t be read for some reason.
>
> Once NTFS finds the file record for the MFT, it obtains the VCN-to-LCN mapping information in the file record’s data attribute and stores it into memory. Each run has a VCN-to-LCN mapping and a run length because that’s all the information necessary to locate the LCN for any VCN. NTFS then processes the MFT records for several more metadata files and opens the files. Next, NTFS performs its file system recovery operation, and finally, it opens its remaining metadata files. The volume is now ready for user access.[^winter]

File records at position less than 16 are guaranteed to be fixed.


[^winter]: Windows Internals