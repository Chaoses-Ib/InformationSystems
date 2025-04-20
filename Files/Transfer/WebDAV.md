# WebDAV
[Wikipedia](https://en.wikipedia.org/wiki/WebDAV), [MDN](https://developer.mozilla.org/en-US/docs/Glossary/WebDAV)

WebDAV (Web Distributed Authoring and Versioning)

[WebDAV: the Awesome File Sharing Method No One Is Using - simonsafar.com](https://simonsafar.com/2022/webdav/)

Only used for file management practically?

[WebDAV - ArchWiki](https://wiki.archlinux.org/title/WebDAV)

[fstanis/awesome-webdav: A curated list of awesome apps that support WebDAV and tools related to it.](https://github.com/fstanis/awesome-webdav)

[WebDav 对 Windows 设备是不是不太友好？ - V2EX](https://v2ex.com/t/598070)

## Servers
- Nginx
  - [Module `ngx_http_dav_module`](https://nginx.org/en/docs/http/ngx_http_dav_module.html)

    > The module processes HTTP and WebDAV methods PUT, DELETE, MKCOL, COPY, and MOVE. WebDAV clients that require additional WebDAV methods to operate will not work with this module.
  - [nginx-dav-ext-module: nginx WebDAV PROPFIND,OPTIONS,LOCK,UNLOCK support](https://github.com/arut/nginx-dav-ext-module) (discontinued)
    - [AUR (en) - nginx-mainline-mod-dav-ext](https://aur.archlinux.org/packages/nginx-mainline-mod-dav-ext)
    - Windows
      - [Making on Windows - Issue #2](https://github.com/arut/nginx-dav-ext-module/issues/2)
      - [build for windows libxslt not found - Issue #70](https://github.com/arut/nginx-dav-ext-module/issues/70)
    - [Please stop using this Crappy old repo - Issue #74](https://github.com/arut/nginx-dav-ext-module/issues/74)
  - [dotwee/nginx-webdav-nononsense - Docker Image | Docker Hub](https://hub.docker.com/r/dotwee/nginx-webdav-nononsense)

  [#2580 (Full native WebDAV support) -- nginx](https://trac.nginx.org/nginx/ticket/2580)
  > WebDAV support is one feature where Nginx falls behind Apache. Not only does the native module only implement 5 methods, even the supplementary nginx-dav-ext module fails to implement the important method `PROPPATCH`, required for the native Windows WebDAV client to function.

  [nginx webdav could not open collection - Stack Overflow](https://stackoverflow.com/questions/24666457/nginx-webdav-could-not-open-collection)

  [【nginx、webdav】使用Nginx搭建WebDav文件共享服务 - 吾星喵乐分享](https://blog.starmeow.cn/detail/48aedb8880cab8c45637abc7493ecddd/)

- Apache: [`mod_dav`](https://httpd.apache.org/docs/2.4/mod/mod_dav.html)
- IIS: [WebDAV <webdav>](https://learn.microsoft.com/en-us/iis/configuration/system.webserver/webdav/)

Rust:
- [webdav-handler-rs: webdav handler library for hyper, warp, actix-web or anything that can interface using the 'http' crate.](https://github.com/miquels/webdav-handler-rs) (discontinued)
  - [webdav-server-rs: webdav server in rust](https://github.com/miquels/webdav-server-rs)
  - [dav-server-rs: Rust WebDAV server library. A fork of the webdav-handler crate.](https://github.com/messense/dav-server-rs)
    - [Add OpenDAL based filesystems - Issue #20](https://github.com/messense/dav-server-rs/issues/20)
    - [davoxide: A simple WebDAV server with a basic web UI, authentication, and permissions](https://github.com/akrantz01/davoxide)
- [dufs: A file server that supports static serving, uploading, searching, accessing control, webdav...](https://github.com/sigoden/dufs)
  - 3.56 MiB
  - `scoop install dufs`
  - Download folder as zip file
  - Search files
  - Resumable/partial uploads/downloads
  - Easy to use with curl
  - Web UI
    - Download, Move, Delete, View/Edit
    - Not minified
    - `send_index()`
      - `<template id="index-data">__INDEX_DATA__</template>` Base64
      - `?json`
  - [Auth](https://github.com/sigoden/dufs/blob/8a92a0cf1a1f2cd2341cb118e811d5f12177a8c3/src/server.rs#L182-L186C49): Basic auth
    - [Support Authentication via Token - Issue #522](https://github.com/sigoden/dufs/issues/522)
  - Use hyper directly with in-house router
  - No `lib.rs`
- [hyperdav-server: Basic WebDAV server as a hyper server handler.](https://github.com/tylerwhall/hyperdav-server)

Go:
- [hacdias/webdav: A simple and standalone WebDAV server.](https://github.com/hacdias/webdav)
- SFTPGo
- [sangunsun/webdavSmump: a webdav server of multi user multi path。一个实现了多用户访问的webdav服务端，每个用户可以指定访问不同的文件夹。](https://github.com/sangunsun/webdavSmump)

  > 已知webdav缺点：
  > 1. 客户端挂载问题：实测在linux下和在macos下，把webdav挂载成盘后，不管是命令行还是GUI拷贝文件都存在缓存问题，数据不能及时到达服务端。客户端提示文件拷贝完成，服务端看到文件大小还是0，即使umount掉盘数据还是不能及时到达服务器造成数据丢失。使用手机端的各种文件管理器、raidrive未发现丢失数据情况，同样一块远程共享，同时用webdav和smb共享，linux和macos下挂盘后拷贝数据，smb可把数据实时传给服务器，webdav就不行
  > 2. 延迟问题：实测把同样的服务端目录通过smb和webdav共享出来，用同一个客户端的两种协议访问，在文件夹内文件较多(nnn以上)时，smb反应较快，而webdav则有一到几秒的延迟时间才能显示文件列表。
  > 3. 在线播放问题(使用FE文件游览器)：和问题2一样的环境，在线播放nnnM的视频文件，smb基本能秒出，webdav则需要几秒的缓存时间。

PHP:
- [karadav: Lightweight NextCloud compatible WebDAV server](https://github.com/kd2org/karadav)
- [flysystem-webdav: \[READ ONLY\] WebDAV adapter for Flysystem](https://github.com/thephpleague/flysystem-webdav)

Perl:
- [webdavcgi: WebDAV CGI brings your file service to the Web. Homepage:](https://github.com/DanRohde/webdavcgi)
  - [Requirements](https://danrohde.github.io/webdavcgi/doc.html)

Test: https://webdav.filestash.app

[WebDAV management / control panel? : r/selfhosted](https://www.reddit.com/r/selfhosted/comments/nvch09/webdav_management_control_panel/)

## Clients
[WebDAV Client Small Files Performance Testing](https://gist.github.com/joshtrichards/e245aa5cd402b8c0c485a3945ba3ce77)

- Windows

Rust:
- [rustydav: Implementation of webdav requests in rust](https://github.com/andreinbio/rustydav)
  - [remotefs-rs-webdav: remotefs-rs implementation for WebDAV](https://github.com/remotefs-rs/remotefs-rs-webdav)
- [reqwest\_dav: An async webdav client for rust with tokio and reqwest](https://github.com/niuhuan/reqwest_dav)
- OpenDAL: [Webdav](https://opendal.apache.org/docs/rust/opendal/services/struct.Webdav.html)

JS:
- [webdav-client: WebDAV client written in Typescript for NodeJS and the browser](https://github.com/perry-mitchell/webdav-client)
  - [daview: Proxy a WebDAV instance with a nicer UI and custom authentication](https://github.com/tale/daview)
- [webdav-js: A simple WebDAV client written in JS for use as a bookmarklet, or integration into a web server.](https://github.com/dom111/webdav-js)
  - Download, Copy, Rename, Move, Delete
  - Upload: No progress, just spin
- [Filestash --- Self-hosted client for your data](https://www.filestash.app/) (paid)
- IT Hit: [AJAX Browser - Web-based WebDAV Client](https://www.webdavsystem.com/ajaxfilebrowser) (paid)
  - [AJAX File Browser Demo](http://www.ajaxbrowser.com/)

  > Web-based WebDAV Client, open documents directly from server, pause resume uploads, automatically restore broken uploads, folders upload, upload over 2Gb

  [Running the WebDAV Samples](https://www.webdavsystem.com/server/server_examples/running_webdav_samples/)
- NextCloud
  - [nextcloud-webdav-filepicker: 📂 File picker to interact with Nextcloud files](https://github.com/julien-nc/nextcloud-webdav-filepicker)
  - [nextcloud-link: Javascript/Typescript client that communicates with Nextcloud's WebDAV and OCS APIs](https://github.com/tentwentyfour/nextcloud-link)
- Extensions
  - [File Management - WebDav](https://chromewebstore.google.com/detail/file-management-webdav/famepaffkmmhdefbapbadnniioekdppm)

[WebDAV Javascript库 - Mryqu's Notes](https://mryqu.github.io/post/webdav_javascript%E5%BA%93/)

[Browser based WebDAV client? - Stack Overflow](https://stackoverflow.com/questions/2006900/browser-based-webdav-client)

[Accessing WebDAV Server](https://www.webdavsystem.com/server/access/)
