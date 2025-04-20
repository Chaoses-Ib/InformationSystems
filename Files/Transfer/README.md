# File Transfer
[Wikipedia](https://en.wikipedia.org/wiki/File_transfer)

To say a protocol is a file transfer protocol, it should at least support directory transfer.

[Which file access is the best : Webdav or FTP? - Stack Overflow](https://stackoverflow.com/questions/11216884/which-file-access-is-the-best-webdav-or-ftp)
> WebDAV has the following advantages over FTP:
> 1. By working via one TCP connection it's easier to configure it to bypass firewalls, NATs and proxies. In FTP the data channel can cause problems with proper NAT setup.
> 2. Again due to one TCP connection, which can be persistent, WebDAV would be a bit faster than FTP when transferring many small files - no need to make a data connection for each file.
> 3. GZIP compression is a standard for HTTP but not for FTP (yes, MODE Z is offered in FTP, but it's not defined in any standard).
> 4. HTTP has wide choice of authentication methods which are not defined in FTP. Eg. NTLM and Kerberos authentication is common in HTTP and in FTP it's hard to get proper support for them unless you write both client and server sides of FTP.
> 5. WebDAV supports partial transfers and in FTP partial uploads are not possible (ie. you can't overwrite a block in the middle of the file).
> 
> There's one more thing to consider (depending on whether you control the server) - SFTP (SSH File Transfer Protocol, not related to FTP in any way). SFTP is more feature-rich than WebDAV and SFTP is a protocol to access remote file systems, while WebDAV was designed with abstraction in mind (WebDAV was for "documents", while SFTP is for files and directories). SFTP has all benefits mentioned above for WebDAV and is more popular among both admins and developers.

[How to copy files from one machine to another using ssh - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/106480/how-to-copy-files-from-one-machine-to-another-using-ssh)

[帮忙推荐一款轻量开源文件管理服务 - V2EX](https://www.v2ex.com/t/1125578)

## Tools
Go:
- [filebrowser: 📂 Web File Browser](https://github.com/filebrowser/filebrowser)
  - 16.7 MiB
- [SFTPGo: Full-featured and highly configurable SFTP, HTTP/S, FTP/S and WebDAV server - S3, Google Cloud Storage, Azure Blob](https://github.com/drakkan/sftpgo)
  - 14.8 MiB
  - [Web UIs](https://docs.sftpgo.com/latest/web-interfaces/)
