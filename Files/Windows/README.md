# Windows
[Mount points, volumes, and physical drives, oh my! - The Old New Thing](https://devblogs.microsoft.com/oldnewthing/20201019-00/?p=104380)

[Naming Files, Paths, and Namespaces - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file)

Books:
- [File System Behavior in the Microsoft Windows Environment](https://download.microsoft.com/download/4/3/8/43889780-8d45-4b2e-9d3a-c696a890309f/file%20system%20behavior%20overview.pdf)

## Volumes
A **volume** is region of storage that is managed by a single file system.

- Volume GUID paths (unique volume names)

  `\\?\Volume{GUID}\`

  e.g. `\\?\Volume{26a21bda-a627-11d7-9931-806e6f6e6963}\`

  - The operating system assigns a volume GUID path to a volume when the volume is first installed and when the volume is formatted.
  - A volume can have more than one volume GUID path.
  - All volume and mounted folder functions that take a volume GUID path as an input parameter require the **trailing backslash** (except `CreateFile`).

    All volume and mounted folder functions that return a volume GUID path provide the trailing backslash.

- Labels
  
  A label is a user-friendly name that is assigned to a volume, usually by an end user, to make it easier to recognize.

  - Two different volumes can have the same label.

- Drive letters

  e.g. `C:\`

  - Drive letter assignments can change as volumes are added to and removed from the computer.
  - A volume can only be assigned with one drive letter?

  [Editing Drive Letter Assignments - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/fileio/editing-drive-letter-assignments)

A volume can have a label, a drive letter, both, or neither.

[Naming a Volume - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-volume)

## Volume mount points
- Volume GUID paths

- Drive letters

- Mounted folders

  A mounted folder is an association between a folder on one volume and another volume, so that the folder path can be used to access the volume.

  e.g. `C:\MountD\`

API:
- [`SetVolumeMountPointW()`](https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-setvolumemountpointw)
  - 需要管理员权限。
- [`GetVolumePathNamesForVolumeNameW`](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getvolumepathnamesforvolumenamew)
  - 不包括 DOS device names。

Tools:
- `mountvol`

  ```
  Creates, deletes, or lists a volume mount point.

  MOUNTVOL [drive:]path VolumeName
  MOUNTVOL [drive:]path /D
  MOUNTVOL [drive:]path /L
  MOUNTVOL [drive:]path /P
  MOUNTVOL /R
  MOUNTVOL /N
  MOUNTVOL /E
  MOUNTVOL drive: /S

      path        Specifies the existing NTFS directory where the mount
                  point will reside.
      VolumeName  Specifies the volume name that is the target of the mount
                  point.
      /D          Removes the volume mount point from the specified directory.
      /L          Lists the mounted volume name for the specified directory.
      /P          Removes the volume mount point from the specified directory,
                  dismounts the volume, and makes the volume not mountable.
                  You can make the volume mountable again by creating a volume
                  mount point.
      /R          Removes volume mount point directories and registry settings
                  for volumes that are no longer in the system.
      /N          Disables automatic mounting of new volumes.
      /E          Re-enables automatic mounting of new volumes.
      /S          Mount the EFI System Partition on the given drive.

  Possible values for VolumeName along with current mount points are:

      \\?\Volume{0285bf10-ba5f-11ed-a8b4-806e6f6e6963}\
          C:\

      \\?\Volume{0285bf0e-ba5f-11ed-a8b4-806e6f6e6963}\
          *** NO MOUNT POINTS ***
  ```
  - [MOUNTVOL "The parameter is incorrect." | Tom's Hardware Forum](https://forums.tomshardware.com/threads/mountvol-the-parameter-is-incorrect.3092457/)

- Disk Management

## DOS devices
Starting with Windows Vista, deleted files are immediately deleted permanently, and are not moved to the Recycle Bin. Prior to Windows Vista (in Windows XP, for example) files from substituted "disks" were moved to the Recycle Bin when deleted. A registry entry could be added to re-enable the Recycle Bin.

API:
- [`DefineDosDeviceW()`](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-definedosdevicew)
  - Drive letters mapped with the command are not available during system startup for services nor do they persist across a reboot.
  - 不需要管理员权限。

Tools:
- `subst` ([Wikipedia](https://en.wikipedia.org/wiki/SUBST))
  
  ```
  Associates a path with a drive letter.

  SUBST [drive1: [drive2:]path]
  SUBST drive1: /D

    drive1:        Specifies a virtual drive to which you want to assign a path.
    [drive2:]path  Specifies a physical drive and path you want to assign to
                  a virtual drive.
    /D             Deletes a substituted (virtual) drive.

  Type SUBST with no parameters to display a list of current virtual drives.
  ```

## Network drives
[You can't access this shared folder because your organization's security policies block unauthenticated guest access - Microsoft Q&A](https://learn.microsoft.com/en-us/answers/questions/59309/you-can-t-access-this-shared-folder-because-your-o)
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters\AllowInsecureGuestAuth`

[Make a network drive available over the internet? - Super User](https://superuser.com/questions/311658/make-a-network-drive-available-over-the-internet)
- 通过 `\\youraddress` 就可以直接访问？会弹出登录窗口吗？

[How can I access a shared folder from another network? - Windows - Spiceworks Community](https://community.spiceworks.com/t/how-can-i-access-a-shared-folder-from-another-network/583958)

### Logon sessions
网络驱动器会与映射时使用的用户 ID 关联，而开启 UAC 后的管理员和标准用户的 ID 不同，无法互相访问对方映射的网络驱动器。可以通过在 `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System` 中添加 `EnableLinkedConnections=1` 来同时允许管理员和标准用户使用。
- [Some Programs Cannot Access Network Locations When UAC Is Enabled | Microsoft Learn](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee844140(v=ws.10)?redirectedfrom=MSDN)
- [windows 7 - What does registry setting EnableLinkedConnections do on a technical level? - Server Fault](https://serverfault.com/questions/182758/what-does-registry-setting-enablelinkedconnections-do-on-a-technical-level)
- [winforms - C# OpenFileDialog is not showing Network location or mapped drive - Stack Overflow](https://stackoverflow.com/questions/25892483/c-sharp-openfiledialog-is-not-showing-network-location-or-mapped-drive)
- [c# - Mapped drives not visible on open dialog - Stack Overflow](https://stackoverflow.com/questions/32790495/mapped-drives-not-visible-on-open-dialog)

在记事本、Word 2016、Listary 中都能复现这个问题，不过有遇到相似问题的用户反馈至少 Word 里可以正常看到，可能是新版 Word 自动绕过了这个限制。  
这个问题会影响到强制将账户类型改为管理员，或者单独以管理员身份运行某个程序的用户。如果通过工具以管理员身份映射驱动器可能也会影响标准用户下运行的程序。网络共享不受这个问题的影响。

[Mapped drives are not available - Windows Client | Microsoft Learn](https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/mapped-drives-not-available-from-elevated-command)

## Links
- Junctions
  - [Can an NTFS junction point be followed over a network share? - Super User](https://superuser.com/a/1745062)

    Windows 新版（至少 21H2 19044.1889 以上）不再支持在网络驱动器中使用 junction。

    Hidden and system junctions will be filtered out, others will not, but cannot be accessed by other users?

    [Windows junction invalid on network share - Super User](https://superuser.com/questions/1062248/windows-junction-invalid-on-network-share)

## Unicode
### Case sensitivity
> Do not assume case sensitivity. For example, consider the names OSCAR, Oscar, and oscar to be the same, even though some file systems (such as a POSIX-compliant file system) may consider them as different. Note that NTFS supports POSIX semantics for case sensitivity but this is not the default behavior.

[→NTFS](../Systems/NTFS/README.md#case-sensitivity)

## Tunneling
> Windows 删除或者重命名文件的时候会先把文件元数据保留，如果一段时间内又创建同名文件了就会复用。比 Linux 慢的原因又找到一个。

[File System Tunneling in Windows - Senturean](https://www.senturean.com/posts/19_04_13_windows-file-system-tunneling/)
> Tunneling can handle the previous situation in the following way:
> 1. In case of deletion or rename operation, an entry is created in the tunnel cache.
> 2. Once an entry is inserted it going to stay in the cache for a period of time.
> 3. Every time when a file is created or renamed the cache is going to be checked and if a file can be found with the name of the newly created or renamed file then the values from the cache are going to be used.
>    
>    The values which can be stored in the cache and used later depend on the file system. For example, NTFS stores object ID and creation time of the file while FAT preserves the creation time only.
> 
> The simplest way to test and observe it in action is to delete a file and then create a new one with the same name in the same path. The new file is going to inherit the creation timestamp of the original file. This function can mess with versioning systems and it can also make it tricky to find files created in a specific timeframe.
> 
> Most of the time file system tunneling won’t really affect any investigations. The only situation I can think of is the case when an investigator has to collect files which were created by an attacker. In a situation like this, it will be hard to determine whether a file was generated during an incident or not. In a real-life scenario every file which was touched during that timeframe can be considered compromised. During any action at least one of the timestamps is going to be updated so regardless of the Creation date timestamp inheritance we can identify potentially interesting files.

## API
.NET:
- [AlphaFS: A .NET library providing more complete Win32 file system functionality to the .NET platform than the standard System.IO classes.](https://github.com/alphaleonis/AlphaFS/)

### [`GetFileAttributesW`](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getfileattributesw)
```rust
fn GetFileAttributesW(lpFileName) {
  let (file_name, containing_directory) = RtlDosPathNameToNtPathName_U(lpFileName);
  let obja = InitializeObjectAttributes(file_name, OBJ_CASE_INSENSITIVE, containing_directory);
  let basic_info = NtQueryAttributesFile(obja);
  basic_info.map_err(|e| if RtlIsDosDeviceName_U(lpFileName) {
    FILE_ATTRIBUTE_ARCHIVE
  } else {
    e
  })
}

fn NtQueryAttributesFile(ObjectAttributes, FileInformation) {
  IopUpdateOtherOperationCount();
  ObOpenObjectByName(ObjectAttributes)
}
```

> If you call `GetFileAttributes` for a network share, the function fails, and [GetLastError](https://learn.microsoft.com/en-us/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror) returns `ERROR_BAD_NETPATH`. You must specify a path to a subfolder on that share.

Doesn't support `http://`.

[windows - How to avoid network stalls in GetFileAttributes? - Stack Overflow](https://stackoverflow.com/questions/1142080/how-to-avoid-network-stalls-in-getfileattributes)
> The problem isn't GetFileAttributes really. It typically uses just one call to the underlying file system driver. It's that IO which is stalling.
>
> Still, the solution is probably easy. Call [CancelSynchronousIo()](http://msdn.microsoft.com/en-us/library/windows/desktop/aa363794%28v=vs.85%29.aspx) after one second (this obviously requires a second thread as your first is stuck inside GetFileAttributes).

## Tools
- [fsutil](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/fsutil)

### [Everything](https://www.voidtools.com/)
- [IbEverythingExt: Everything 拼音搜索、快速选择扩展](https://github.com/Chaoses-Ib/IbEverythingExt)

[everything 索引原理探讨 - V2EX](https://www.v2ex.com/t/1001347#reply33)