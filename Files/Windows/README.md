# Windows
[Mount points, volumes, and physical drives, oh my! - The Old New Thing](https://devblogs.microsoft.com/oldnewthing/20201019-00/?p=104380)

[Naming Files, Paths, and Namespaces - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file)

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

## API
.NET:
- [AlphaFS: A .NET library providing more complete Win32 file system functionality to the .NET platform than the standard System.IO classes.](https://github.com/alphaleonis/AlphaFS/)

## Tools
- [fsutil](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/fsutil)

### [Everything](https://www.voidtools.com/)
- [IbEverythingExt: Everything 拼音搜索、快速选择扩展](https://github.com/Chaoses-Ib/IbEverythingExt)

[everything 索引原理探讨 - V2EX](https://www.v2ex.com/t/1001347#reply33)