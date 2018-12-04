.PHONY: buildroot buildroot_config clean

BR2ARGS=BR2_DEFCONFIG=../br2external/board/ecovec24/buildroot.config BR2_EXTERNAL="../br2external ../br2autosshkey"

buildroot:
	$(MAKE) -C buildroot $(BR2ARGS)

buildroot_config:
	$(MAKE) -C buildroot $(BR2ARGS) menuconfig
	$(MAKE) -C buildroot $(BR2ARGS) savedefconfig

linux_config:
	$(MAKE) -C buildroot/ $(BR2ARGS) linux-menuconfig
	$(MAKE) -C buildroot/ $(BR2ARGS) linux-update-defconfig

clean:
	$(MAKE) -C buildroot $(BR2ARGS) clean

upload:
	scp buildroot/output/images/uImage espressobin2:/srv/tftp/ecovec.uImage
	scp buildroot/output/images/rootfs.squashfs espressobin2:/srv/tftp/ecovec.initrd
