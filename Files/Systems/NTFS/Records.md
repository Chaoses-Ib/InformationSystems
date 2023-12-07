# File Records
A file on an NTFS volume is identified by a 64-bit value called a **file record number**:
```c
struct FileRecordNumber {
    uint64_t file_number: 48;
    uint16_t sequence_number: 16;
}
```
> - The file number corresponds to the position of the file’s file record in the MFT minus 1 (or to the position of the base file record minus 1 if the file has more than one file record).
> - The sequence number, which is incremented each time an MFT file record position is reused, enables NTFS to perform internal consistency checks.[^winter]

## Attributes
Instead of viewing a file as just a repository for textual or binary data, NTFS stores files as a collection of attribute/value pairs, one of which is the data it contains:
- [New Technologies File System (NTFS) - libyal/libfsntfs](https://github.com/libyal/libfsntfs/blob/main/documentation/New%20Technologies%20File%20System%20(NTFS).asciidoc#6-the-attributes)
- [\[MS-FSCC\]: NTFS Attribute Types | Microsoft Learn](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-fscc/a82e9105-2405-4e37-b2c3-28c773902d85)

> Each attribute in a file record is identified with its attribute type code and has a value and an optional name. Most attributes never have names, although the index-related attributes and the `$DATA` attribute often do.[^winter]

> If a file is small, all its attributes and their values (its data, for example) fit within the file record that describes the file. When the value of an attribute is stored in the MFT (either in the file’s main file record or an extension record located elsewhere within the MFT), the attribute is called a **resident attribute**. Several attributes are defined as always being resident so that NTFS can locate nonresident attributes. The standard information and index root attributes are always resident, for example.
> 
> Each attribute begins with a standard header containing information about the attribute—information that NTFS uses to manage the attributes in a generic way. The header, which is always resident, records whether the attribute’s value is resident or nonresident. For resident attributes, the header also contains the offset from the header to the attribute’s value and the length of the attribute’s value.
>
> Of course, many files and directories can’t be squeezed into a 1 KB or 4 KB, fixed-size MFT record. If a particular attribute’s value, such as a file’s data attribute, is too large to be contained in an MFT file record, NTFS allocates clusters for the attribute’s value outside the MFT. A contiguous group of clusters is called a run (or an extent). If the attribute’s value later grows (if a user appends data to the file, for example), NTFS allocates another run for the additional data. Attributes whose values are stored in runs (rather than within the MFT) are called **nonresident attributes**. The file system decides whether a particular attribute is resident or nonresident; the location of the data is transparent to the process accessing it.
>
> If a particular file has too many attributes to fit in the MFT record, a second MFT record is used to contain the additional attributes (or attribute 
headers for nonresident attributes). In this case, an attribute called the **attribute list** is added.

## File names
[New Technologies File System (NTFS) - libyal/libfsntfs](https://github.com/libyal/libfsntfs/blob/main/documentation/New%20Technologies%20File%20System%20(NTFS).asciidoc#64-the-file-name-attribute)

### Short names
> Since Windows 8.1, by default all the NTFS nonbootable volumes have short name generation disabled.[^winter]

### Hard links
> In case of a hard link the MFT entry will contain additional file name attributes with the parent file reference of each hard link.

Statistics:

Category | Count | Percent
--- | --- | ---
Files | 5057106 | 84%
Files with one hard link | 4822961 | 80% (95.4% in files)
Files with two or more hard links | 234145 | 4% (4.6% in files)
Directories | 955384 | 16%
Total | 6012490 | 100%

Maximum hard link count: 109


[^winter]: Windows Internals