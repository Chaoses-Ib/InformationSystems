# File Systems
[Wikipedia](https://en.wikipedia.org/wiki/File_system)

A **file** is simply a linear array of bytes, each of which you can read or write. Each file has some kind of **low-level name**, usually a number of some kind; often, the user is not aware of this name. For historical reasons, the low-level name of a file is often referred to as its **inode number**.

A **directory**, like a file, also has a low-level name (i.e., an inode number), but its contents are quite specific: it contains a list of `(user-readable name, low-level name)` pairs. Each entry in a directory refers to either files or other directories. By placing directories within other directories, users are able to build an arbitrary **directory tree** (or **directory hierarchy**), under which all files and directories are stored.

The file system provides a convenient way to name all the files we are interested in. Names are important in systems as the first step to accessing any resource is being able to name it.[^three]

## Index nodes
One of the most important on-disk structures of a file system is the **inode**, which is the generic name that is used in many file systems to describe the structure that holds the metadata for a given file, such as its length, permissions, and the location of its constituent blocks. The name inode is short for index node, the historical name given to it in UNIX and possibly earlier systems, used because these nodes were originally arranged in an array, and the array indexed into when accessing a particular inode.[^three]

Pointers:
- Multi-level index

  Most files are small. This imbalanced design reflects such a reality; if most files are indeed small, it makes sense to optimize for this case.

  Examples: ext2, ext3, UNIX file system.
- Extends

  Examples: ext4.

## POSIX
[2.5 Standard I/O Streams](https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/functions/V2_chap02.html#tag_15_05)

Creating files:
```c
int fd = open("foo", O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR);
```

The older way of creating a file is to call `creat()`:
```c
int fd = creat("foo"); // option: add second flag to set permissions
```

Because `open()` can create a file, the usage of `creat()` has somewhat fallen out of favor; however, it does hold a special place in UNIX lore. Specifically, when Ken Thompson was asked what he would do differently if he were redesigning UNIX, he replied: “I’d spell creat with an e.”[^three]


[^three]: Operating Systems: Three Easy Pieces