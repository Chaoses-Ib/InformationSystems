# Trash
[Wikipedia](https://en.wikipedia.org/wiki/Trash_(computing))

> In computing, the trash, also known by other names such as dustbin, wastebasket, and others, is a graphical user interface desktop metaphor for temporary storage for files set aside by the user for deletion, but not yet permanently erased. The concept and name is part of Mac operating systems, a similar implementation is called the Recycle Bin in Microsoft Windows, and other operating systems use other names.

## Libraries
Rust:
- [trash-rs: A Rust library for moving files to the Recycle Bin](https://github.com/Byron/trash-rs)
  - `delete()` can delete directory directly
  - Cannot empty trash directly
- [hymkor/trash-rs: Move file(s) to trash-box of Microsoft Windows](https://github.com/hymkor/trash-rs)

## Windows
`C:\$RECYCLE.BIN\`

[Windows Recycle Bin Forensics. The Recycle Bin | by thismanera | Medium](https://medium.com/@thismanera/windows-recycle-bin-forensics-a2998c9a4d3e)

Storage Sense -> Automatic User content cleanup (Windows 10):
- Off by default

Tools:
- [rifiuti2: Windows Recycle Bin analyser](https://github.com/abelcheung/rifiuti2)

  `rifiuti-vista.exe --live`

  - `Gone`: If a trashed file has been permanently deleted, or has been restored onto filesystem, then it is considered "gone".
    - From Windows 98 onwards, this info is kept in `INFO2` entries
    - Since Vista, only restored file retains the index entry. Permanently deleted trash file won't show up in output.

- [recycler: A tool to configure windows recycle bins](https://github.com/thsmi/recycler)

### Hidden trash
> 似乎是回收站损坏了，shell 视图只能看到 2023-04-26 以后的，582 个，但是看文件 2019-10 的都还在，1331 个
>
> 找了个取证工具，虽然能显示出来残留的文件，但是都显示已删除。~~感觉是回收站在实际删除文件前就在数据库里标记成了已删除，之后删除时出错，文件就一直残留着了~~

残留文件的体积只有 48~322 B，比原始大小小很多，是数据库信息本身，可能都是 restored file/folder；但是残留文件夹中文件的大小都是原始大小，rifiuti2 也不会显示这些残留文件夹。

> 破案了，是win会把所有从回收站还原的文件都留份元数据，永远不会删除🌚  
> 不过文件夹的机制似乎不太一样，我这里有几个残留的文件夹，里面都是实际数据，不是元数据

残留的文件夹以 `$R` 开头，但却没有相应的 `$I` 信息。永久删除文件时 `$I` 会被删除，可能是 Windows 先把 `$I` 删除了，在再删除文件夹时出错了。

[windows - Some files still remain in $RECYCLE.BIN - Super User](https://superuser.com/questions/1342463/some-files-still-remain-in-recycle-bin)
> The folders you are seeing are from other users. It is possible they were carried over from previous installs, and its possible you had profile issues, and they are old versions of your current profile.

[windows 7 - How do I fix my recycle bin that doesn't show the deleted items? - Super User](https://superuser.com/questions/145146/how-do-i-fix-my-recycle-bin-that-doesnt-show-the-deleted-items)