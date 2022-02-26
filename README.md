![status-badge](https://woodpecker.thingy.jp/api/badges/fifteenhex/ecovec24/status.svg)

A working kernel/buildroot environment for the ecovec24 

```setenv serverip 192.168.3.1; setenv ipaddr 192.168.3.16; tftpboot 0x89000000 ecovec.uImage; tftpboot 0x8a000000 ecovec.initrd; bootm 0x89000000```

# Notes

- The rootfs is a squashfs in ram via phram. This allows to have the flexibility of an initramfs without unpacking the whole thing and wasting memory.
  Or at least that was the idea. Sticking a squashfs into ram isn't working anymore :(.


# Partial boot log

```
## Booting kernel from Legacy Image at 89000000 ...
   Image Name:   Linux-5.12.0-rc7
   Image Type:   SuperH Linux Kernel Image (gzip compressed)
   Data Size:    3106884 Bytes =  3 MB
   Load Address: 88001000
   Entry Point:  88002000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 5.12.0-rc7 (daniel@shiro) (sh4-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.02-715-g5e3799213236) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #17 Sat Apr 17 1
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000000
... LOADER_TYPE       - 00000000
... INITRD_START      - 00000000
... INITRD_SIZE       - 00000000
Memory limited to 248MB
Booting machvec: R0P7724 (EcoVec)
initrd disabled
Zone ranges:
  Normal   [mem 0x0000000008000000-0x00000000177fffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000008000000-0x00000000177fffff]
Initmem setup node 0 [mem 0x0000000008000000-0x00000000177fffff]
Built 1 zonelists, mobility grouping on.  Total pages: 62930
Kernel command line: console=tty0, console=ttySC0,115200 phram.phram=rootfs,0x8a000000,32Mi root=/dev/mmcblk0 rootwait mem=248M memchunk.vpu=8m memchunk.veu0=4m
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
Sorting __ex_table...
mem auto-init: stack:off, heap alloc:off, heap free:off
PVR=10300b00 CVR=7144040d PRR=00002200
I-cache : n_ways=4 n_sets=256 way_incr=8192
I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
D-cache : n_ways=4 n_sets=256 way_incr=8192
D-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
S-cache : n_ways=4 n_sets=2048 way_incr=65536
S-cache : entry_mask=0x0000ffe0 alias_mask=0x0000f000 n_aliases=16
Memory: 246316K/253952K available (3666K kernel code, 279K rwdata, 984K rodata, 124K init, 90K bss, 7632K reserved, 0K cma-reserved)
virtual kernel memory layout:
    fixmap  : 0xdffd7000 - 0xdffff000   ( 160 kB)
    vmalloc : 0xc0000000 - 0xdffd5000   ( 511 MB)
    lowmem  : 0x88000000 - 0x97800000   ( 248 MB) (cached)
            : 0xa0000000 - 0xc0000000   ( 512 MB) (uncached)
      .init : 0x884d4000 - 0x884f3000   ( 124 kB)
      .data : 0x88396a08 - 0x884d3858   (1267 kB)
      .text : 0x88001000 - 0x88396a08   (3670 kB)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS: 8, nr_irqs: 8, preallocated irqs: 0
intc: Registered controller 'sh7724' with 83 IRQs
random: get_random_bytes called from start_kernel+0x2ba/0x634 with crng_init=0
Console: colour dummy device 80x25
printk: console [tty0] enabled
 sh-cmt-32.0: ch0: used for clock events
 sh-cmt-32.0: ch0: used for periodic clock events
 sh-cmt-32.0: ch0: used as clock source
clocksource: sh-cmt-32.0: mask: 0xffffffffffffffff max_cycles: 0x1ef4687b1, max_idle_ns: 902748573917236 ns
 sh-tmu.0: ch0: used for clock events
 sh-tmu.0: ch0: used for periodic clock events
 sh-tmu.0: ch1: used as clock source
clocksource: sh-tmu.0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 183481014613 ns
sched_clock: 32 bits at 250 Hz, resolution 4000000ns, wraps every 8589934590000000ns
Calibrating delay loop (skipped)... 499.99 BogoMIPS PRESET (lpj=999999)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
CPU: SH7724
Performance Events: sh4a support registered
```
