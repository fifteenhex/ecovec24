.PHONY: buildroot buildroot_config buildroot_defconfig clean clearstuff shell

BR2ARGS=BR2_DEFCONFIG=../br2external/board/ecovec24/buildroot.config BR2_EXTERNAL="../br2external ../br2autosshkey"

buildroot:
	$(MAKE) -C buildroot $(BR2ARGS)

buildroot_config:
	$(MAKE) -C buildroot $(BR2ARGS) menuconfig
	$(MAKE) -C buildroot $(BR2ARGS) savedefconfig

buildroot_defconfig:
	$(MAKE) -C buildroot $(BR2ARGS) defconfig

linux_config:
	$(MAKE) -C buildroot/ $(BR2ARGS) linux-menuconfig
	$(MAKE) -C buildroot/ $(BR2ARGS) linux-update-defconfig

clean:
	$(MAKE) -C buildroot $(BR2ARGS) clean

upload: buildroot
	scp buildroot/output/images/uImage tftp:/srv/tftp/ecovec.uImage
	scp buildroot/output/images/rootfs.squashfs tftp:/srv/tftp/ecovec.initrd

clearstuff:
	rm -rf buildroot/output/build/nodectrl-dev/ buildroot/dl/nodectrl/
	rm -rf buildroot/output/build/tlwbe_heartbeat-dev/ buildroot/dl/tlwbe_heartbeat/

shell:
	ssh -i buildroot/output/sshkeys/sh4life sh4life@ecovec24
