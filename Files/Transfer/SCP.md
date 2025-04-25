# Secure Copy Protocol (SCP)
[Wikipedia](https://en.wikipedia.org/wiki/Secure_copy_protocol)

> According to OpenSSH developers in April 2019, SCP is outdated, inflexible and not readily fixed; they recommend the use of more modern protocols like SFTP and rsync for file transfer. As of OpenSSH version 9.0, `scp` client therefore uses SFTP for file transfers by default instead of the legacy SCP/RCP protocol.

## Directory
- How to `mkdir` automatically?
  - `-r dir` (not `-r dir/`)

  [PSCP: Upload an entire folder, Windows to Linux - Server Fault](https://serverfault.com/questions/295565/pscp-upload-an-entire-folder-windows-to-linux)

## Performance
Slow for a lot of small files.

- [`tar`](../Archives/tar.md)
  ```pwsh
  pscp -batch -pwfile $key -r dist/* ${target}:$targetPath
  ```
  ```pwsh
  # Create a tarball of the dist directory
  # tar -cvf target/dist.tar dist/*
  tar -cvf dist/dist.tar -z --exclude=dist.tar -C dist .
  if ($LASTEXITCODE -ne 0) {
      exit $LASTEXITCODE
  }

  # Transfer the tarball to the server
  # pscp -batch -pwfile $key target/dist.tar ${target}:$targetPath
  pscp -batch -pwfile $key dist/dist.tar ${target}:$targetPath
  if ($LASTEXITCODE -ne 0) {
      exit $LASTEXITCODE
  }

  # Extract the tarball on the server
  plink -batch -pwfile $key $target powershell -Command "tar -xvf $targetPath/dist.tar -C $targetPath; Remove-Item $targetPath/dist.tar"
  if ($LASTEXITCODE -ne 0) {
      exit $LASTEXITCODE
  }
  ```

[time - Why is scp so slow and how to make it faster? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/238152/why-is-scp-so-slow-and-how-to-make-it-faster)
