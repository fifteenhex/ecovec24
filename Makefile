DLDIR=$(PWD)/dl

BR2ARGS=BR2_DEFCONFIG=../br2external/board/ecovec24/buildroot.config \
	BR2_EXTERNAL="../br2external ../br2autosshkey" \
	BR2_DL_DIR=$(DLDIR)

.PHONY: dldir \
	buildroot \
	buildroot_config \
	buildroot_defconfig \
	clean \
	clearstuff \
	shell \
	bootstrap

all: buildroot

bootstrap:
	git submodule init
	git submodule update

dldir:
	mkdir -p $(DLDIR)

buildroot_dl: dldir
	- git -C $(DLDIR)/linux/git checkout master
	- git -C $(DLDIR)/linux/git branch -D ecovec24
	- git -C $(DLDIR)/linux/git fetch --all
	- rm $(DLDIR)/linux/*.tar.gz

	$(MAKE) -C buildroot $(BR2ARGS) defconfig
	$(MAKE) -C buildroot $(BR2ARGS) source

	ls -l $(DLDIR)/linux/

buildroot: dldir
	$(MAKE) -C buildroot $(BR2ARGS)

buildroot_config:
	$(MAKE) -C buildroot $(BR2ARGS) menuconfig
	$(MAKE) -C buildroot $(BR2ARGS) savedefconfig

buildroot_defconfig:
	$(MAKE) -C buildroot $(BR2ARGS) defconfig

linux_config:
	$(MAKE) -C buildroot/ $(BR2ARGS) linux-menuconfig
	$(MAKE) -C buildroot/ $(BR2ARGS) linux-update-defconfig

define update_git_package
        @echo updating git package $(1)
        git -C dl/$(1)/git clean -fd
        git -C dl/$(1)/git fetch --force --all --tags
        git -C dl/$(1)/git checkout master
        - git -C dl/$(1)/git branch -D $(2)
        git -C dl/$(1)/git checkout -b $(2)
        git -C dl/$(1)/git reset --hard origin/$(2)
        rm -f dl/$(1)/$(1)-$(2).tar.gz
endef

linux_rebuild:
	$(call update_git_package,linux,ecovec24)
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
