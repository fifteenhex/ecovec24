PREFIX=ecovec24
TOOLCHAIN=sh4-buildroot-linux-gnu_sdk-buildroot.tar.gz
DLDIR=$(PWD)/dl
EXTERNALS=../br2external ../br2autosshkey
DEFCONFIG=../br2external/board/ecovec24/buildroot.config

.PHONY: buildroot \
	clean \
	clearstuff \
	shell \
	bootstrap

all: buildroot copy_outputs

bootstrap.stamp:
	git submodule init
	git submodule update
	touch bootstrap.stamp

./br2secretsauce/common.mk: bootstrap.stamp

include ./br2secretsauce/common.mk

linux_rebuild:
#	$(call update_git_package,linux,ecovec24)
	$(MAKE) -C buildroot/ $(BR2ARGS) linux-rebuild

clean:
	$(MAKE) -C buildroot $(BR2ARGS) clean

upload: buildroot
	scp buildroot/output/images/uImage tftp:/srv/tftp/ecovec.uImage
	scp buildroot/output/images/rootfs.squashfs tftp:/srv/tftp/ecovec.initrd

clearstuff:
	rm -rf buildroot/output/build/nodectrl-dev/ buildroot/dl/nodectrl/
	rm -rf buildroot/output/build/tlwbe_heartbeat-dev/ buildroot/dl/tlwbe_heartbeat/

shell:
	ssh-keygen -f "/home/daniel/.ssh/known_hosts" -R "ecovec24"
	ssh -i buildroot/output/sshkeys/sh4life sh4life@ecovec24

copy_outputs:
	cp buildroot/output/images/uImage $(OUTPUTS)/ecovec24-u-boot.img
	cp buildroot/output/images/rootfs.squashfs $(OUTPUTS)/ecovec24-rootfs.squashfs
