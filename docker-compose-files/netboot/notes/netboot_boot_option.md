# netboot.xyz - boot options

UEFI

```bash
netboot.xyz.efi
```

legacy

```bash
netboot.xyz.kpxe
```

## netboot.xyz boot file types

|                               |                                                                      |
| ----------------------------- | -------------------------------------------------------------------- |
| netboot.xyz.kpxe              | Legacy DHCP boot image file, uses built-in iPXE NIC drivers          |
| netboot.xyz-undionly.kpxe     | Legacy DHCP boot image file, use if you have NIC issues              |
| netboot.xyz.efi               | UEFI boot image file, uses built-in UEFI NIC drivers                 |
| netboot.xyz-snp.efi           | UEFI w/ Simple Network Protocol, attempts to boot all net devices    |
| netboot.xyz-snponly.efi       | UEFI w/ Simple Network Protocol, only boots from device chained from |
| netboot.xyz-arm64.efi         | DHCP EFI boot image file, uses built-in iPXE NIC drivers             |
| netboot.xyz-arm64-snp.efi     | UEFI w/ Simple Network Protocol, attempts to boot all net devices    |
| netboot.xyz-arm64-snponly.efi | UEFI w/ Simple Network Protocol, only boots from device chained from |
| netboot.xyz-rpi4-snp.efi      | UEFI for Raspberry Pi 4, attempts to boot all net devices            |
