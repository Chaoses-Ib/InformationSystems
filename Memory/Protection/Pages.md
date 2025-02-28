# Pages
## Linux
[mprotect(2) - Linux manual page](https://man7.org/linux/man-pages/man2/mprotect.2.html)

## Windows
[Memory Protection Constants (WinNT.h) - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/Memory/memory-protection-constants)

[PAGE\_PROTECTION\_FLAGS | P/Invoke](https://www.pinvoke.dev/memory/page_protection_flags)

[NtQueryVirtualMemory function (ntifs.h) - Windows drivers | Microsoft Learn](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/nf-ntifs-ntqueryvirtualmemory)

### `WriteProcessMemory()`
Different from `NtWriteVirtualMemory()`, `WriteProcessMemory()` will temply make the readonly pages writable if they are *executable*.

Windows XP SP1:
```rust
fn WriteProcessMemory() {
  if NtProtectVirtualMemory(..., PAGE_READWRITE, &mut OldProtect) {
    if OldProtect.is_writable() {
      NtProtectVirtualMemory(..., OldProtect);
      NtWriteVirtualMemory(...);
      NtFlushInstructionCache(...);
      true
    } else {
      if matches!(OldProtect, PAGE_NOACCESS | PAGE_READONLY) {
        NtProtectVirtualMemory(..., OldProtect);
        BaseSetLastNTError(STATUS_ACCESS_VIOLATION);
        false
      } else {
        // The previous protection must have been code and the caller
        // is trying to set a breakpoint or edit the code. Do the write
        // and then restore the previous protection.
        NtWriteVirtualMemory(...);
        NtProtectVirtualMemory(..., OldProtect);
        NtFlushInstructionCache(...);
        true
      }
    }
  } else {
    false
  }
}
```

Windows 11 24H2 (26100.3321):
```rust
fn WriteProcessMemory() {
  // ARM64?
  RtlOpenCrossProcessEmulatorWorkConnection(...);

  let flush = || {
    if RtlWow64PopCrossProcessWorkFromFreeList() {
      if RtlWow64PushCrossProcessWorkOntoWorkList() {
        RtlWow64PushCrossProcessWorkOntoFreeList();
      }
    } else {
      RtlWow64RequestCrossProcessHeavyFlush();
    }
  };

  if NtQueryVirtualMemory(&mut info) {
    let mut oldProtect = info.protect;
    let mut protect = false;
    // PAGE_READWRITE | PAGE_WRITECOPY | PAGE_EXECUTE_READWRITE | PAGE_EXECUTE_WRITECOPY
    if !oldProtect.is_writable()
    {
      // PAGE_EXECUTE | PAGE_EXECUTE_READ
      if !oldProtect.is_executable() {
        BaseSetLastNTError(STATUS_ACCESS_VIOLATION);
        return false;
      }

      let new_protect = match info.type {
        MEM_PRIVATE => PAGE_EXECUTE_READWRITE | PAGE_ENCLAVE_UNVALIDATED | PAGE_TARGETS_NO_UPDATE, // 0x60000040
        MEM_MAPPED => {
          BaseSetLastNTError(STATUS_ACCESS_VIOLATION);
          return false;
        },
        MEM_IMAGE => PAGE_EXECUTE_WRITECOPY | PAGE_ENCLAVE_UNVALIDATED | PAGE_TARGETS_NO_UPDATE, // 0x60000080
      };

      flush();
      NtProtectVirtualMemory(
        new_protect | oldProtect & 0xFFFFFFCF,
        &mut OldProtect);
      flush();

      protect = true;
    }

    NtWriteVirtualMemory();
    flush();

    if protect {
      flush();
      NtProtectVirtualMemory(OldProtect);
      flush();
    }
  }
}
```

[It's Morphin' Time: Self-Modifying Code Sections with WriteProcessMemory for EDR Evasion | by Thiago Peixoto | Medium](https://revflash.medium.com/its-morphin-time-self-modifying-code-sections-with-writeprocessmemory-for-edr-evasion-9bf9e7b7dced)
