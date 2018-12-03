A working kernel/buildroot environment for the ecovec24 

```setenv serverip 192.168.3.1; setenv ipaddr 192.168.3.16; tftpboot 0x89000000 ecovec.uImage; tftpboot 0x8a000000 ecovec.initrd; bootm 0x89000000```
