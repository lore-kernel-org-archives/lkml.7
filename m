Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D817C10F10
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D3A21019
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553417142;
	bh=BD0FlE4KlxgLxkzAlwNZzaMl0AeVd54hWMPKbsXQO84=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XXN7Q523ugATG2Eziy03XMmYfOXHb0s0P/SBWJZro57ySVmaCYCq3U5y/h9hWphzz
	 V3sJ3RrFCo8YyAjFfJi9od66Pg+fXgya1IK60lLZdlkayNefW/nHHQsbZu5dvTfD18
	 aayRJka5cia14dsIcqXiORu41wFiVFCSGIl1noJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfCXIpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 04:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfCXIpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 04:45:39 -0400
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4156E213F2;
        Sun, 24 Mar 2019 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553417133;
        bh=BD0FlE4KlxgLxkzAlwNZzaMl0AeVd54hWMPKbsXQO84=;
        h=Date:From:To:Cc:Subject:From;
        b=wn0SxWjQkOkJDH7RLrYcyUyrQkKrDGF9KKRGIMR/I2yDJjZmUg/EmEjkvj31IsNVX
         oH7gCIaUY6TokTO/mFSycB2RhlEp7fwnt0Lr+r1o5jp6ZF9MehgVoY47UzeCwrmdk9
         YmqNfxZhd0UU7GKvIIqzSqnOh1HNAU+QPE0WVifY=
Date:   Sun, 24 Mar 2019 09:45:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.31
Message-ID: <20190324084531.GA6321@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.31 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.txt                     |    2=20
 Documentation/process/stable-kernel-rules.rst              |    3=20
 Makefile                                                   |    2=20
 arch/arc/Kconfig                                           |    8=20
 arch/arc/include/asm/arcregs.h                             |    8=20
 arch/arc/include/asm/entry-arcv2.h                         |   54 +++
 arch/arc/include/asm/uaccess.h                             |    8=20
 arch/arc/kernel/entry-arcv2.S                              |    4=20
 arch/arc/kernel/intc-arcv2.c                               |    2=20
 arch/arc/kernel/setup.c                                    |   26 +
 arch/arc/lib/memcpy-archs.S                                |   14=20
 arch/arc/plat-hsdk/Kconfig                                 |    1=20
 arch/arm/Kconfig                                           |    1=20
 arch/arm/boot/dts/armada-xp-db.dts                         |   46 +--
 arch/arm/boot/dts/armada-xp-gp.dts                         |   13=20
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts            |   85 +++--
 arch/arm/boot/dts/omap4-droid4-xt894.dts                   |   11=20
 arch/arm/boot/dts/tegra124-nyan.dtsi                       |   17 +
 arch/arm/crypto/crct10dif-ce-core.S                        |   14=20
 arch/arm/crypto/crct10dif-ce-glue.c                        |   23 -
 arch/arm/include/asm/irq.h                                 |    1=20
 arch/arm/include/asm/kvm_host.h                            |   10=20
 arch/arm/kernel/irq.c                                      |   62 ----
 arch/arm/kernel/smp.c                                      |    2=20
 arch/arm/kvm/coproc.c                                      |    4=20
 arch/arm/kvm/reset.c                                       |   24 +
 arch/arm/mach-omap2/cpuidle44xx.c                          |   16 -
 arch/arm/mach-omap2/display.c                              |    7=20
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c                    |    8=20
 arch/arm/mm/dma-mapping.c                                  |    2=20
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts            |    2=20
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts          |    2=20
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts |    2=20
 arch/arm64/crypto/aes-ce-ccm-core.S                        |    5=20
 arch/arm64/crypto/aes-ce-ccm-glue.c                        |    4=20
 arch/arm64/crypto/aes-neonbs-core.S                        |    8=20
 arch/arm64/crypto/crct10dif-ce-glue.c                      |   25 -
 arch/arm64/include/asm/hardirq.h                           |   31 ++
 arch/arm64/include/asm/kvm_host.h                          |   11=20
 arch/arm64/kernel/head.S                                   |    3=20
 arch/arm64/kernel/irq.c                                    |    3=20
 arch/arm64/kernel/kgdb.c                                   |   14=20
 arch/arm64/kernel/probes/kprobes.c                         |    6=20
 arch/arm64/kvm/hyp/switch.c                                |    5=20
 arch/arm64/kvm/hyp/sysreg-sr.c                             |    5=20
 arch/arm64/kvm/reset.c                                     |   50 +++
 arch/arm64/kvm/sys_regs.c                                  |   10=20
 arch/m68k/Makefile                                         |    5=20
 arch/mips/include/asm/kvm_host.h                           |    2=20
 arch/powerpc/include/asm/book3s/64/hugetlb.h               |    8=20
 arch/powerpc/include/asm/kvm_host.h                        |    2=20
 arch/powerpc/include/asm/powernv.h                         |    2=20
 arch/powerpc/kernel/entry_32.S                             |    9=20
 arch/powerpc/kernel/process.c                              |    2=20
 arch/powerpc/kernel/ptrace.c                               |   10=20
 arch/powerpc/kernel/traps.c                                |   12=20
 arch/powerpc/platforms/83xx/suspend-asm.S                  |   34 +-
 arch/powerpc/platforms/embedded6xx/wii.c                   |    4=20
 arch/powerpc/platforms/powernv/idle.c                      |   27 -
 arch/powerpc/platforms/powernv/opal-msglog.c               |    2=20
 arch/powerpc/platforms/powernv/smp.c                       |   25 +
 arch/s390/include/asm/kvm_host.h                           |    2=20
 arch/s390/kernel/setup.c                                   |   31 +-
 arch/x86/crypto/aegis128-aesni-glue.c                      |   38 +-
 arch/x86/crypto/aegis128l-aesni-glue.c                     |   38 +-
 arch/x86/crypto/aegis256-aesni-glue.c                      |   38 +-
 arch/x86/crypto/aesni-intel_glue.c                         |   13=20
 arch/x86/crypto/morus1280_glue.c                           |   40 +-
 arch/x86/crypto/morus640_glue.c                            |   39 +-
 arch/x86/events/intel/uncore.c                             |    1=20
 arch/x86/events/intel/uncore.h                             |   12=20
 arch/x86/events/intel/uncore_snb.c                         |    4=20
 arch/x86/include/asm/intel-family.h                        |    2=20
 arch/x86/include/asm/kvm_host.h                            |    2=20
 arch/x86/kernel/kprobes/opt.c                              |    5=20
 arch/x86/kvm/mmu.c                                         |   23 +
 arch/x86/kvm/vmx.c                                         |   41 ++
 arch/x86/kvm/x86.c                                         |    4=20
 arch/x86/kvm/x86.h                                         |    7=20
 arch/x86/xen/mmu_pv.c                                      |   13=20
 block/blk-mq.c                                             |   12=20
 crypto/aead.c                                              |    4=20
 crypto/aegis128.c                                          |   14=20
 crypto/aegis128l.c                                         |   14=20
 crypto/aegis256.c                                          |   14=20
 crypto/ahash.c                                             |   42 +-
 crypto/cfb.c                                               |   14=20
 crypto/morus1280.c                                         |   13=20
 crypto/morus640.c                                          |   13=20
 crypto/pcbc.c                                              |   14=20
 crypto/shash.c                                             |   18 -
 crypto/skcipher.c                                          |   27 +
 crypto/testmgr.c                                           |   14=20
 crypto/testmgr.h                                           |   25 +
 drivers/acpi/device_sysfs.c                                |    6=20
 drivers/acpi/nfit/core.c                                   |   43 +-
 drivers/auxdisplay/ht16k33.c                               |    2=20
 drivers/base/power/wakeup.c                                |    8=20
 drivers/block/floppy.c                                     |    2=20
 drivers/char/ipmi/ipmi_si_intf.c                           |    5=20
 drivers/char/ipmi/ipmi_si_mem_io.c                         |    5=20
 drivers/char/ipmi/ipmi_si_port_io.c                        |    5=20
 drivers/char/tpm/st33zp24/st33zp24.c                       |    2=20
 drivers/char/tpm/tpm-interface.c                           |   11=20
 drivers/char/tpm/tpm_atmel.c                               |    2=20
 drivers/char/tpm/tpm_crb.c                                 |   22 +
 drivers/char/tpm/tpm_i2c_atmel.c                           |    6=20
 drivers/char/tpm/tpm_i2c_infineon.c                        |    2=20
 drivers/char/tpm/tpm_i2c_nuvoton.c                         |    2=20
 drivers/char/tpm/tpm_ibmvtpm.c                             |    8=20
 drivers/char/tpm/tpm_infineon.c                            |    2=20
 drivers/char/tpm/tpm_nsc.c                                 |    2=20
 drivers/char/tpm/tpm_tis_core.c                            |    2=20
 drivers/char/tpm/tpm_vtpm_proxy.c                          |    3=20
 drivers/char/tpm/xen-tpmfront.c                            |    2=20
 drivers/clk/clk-twl6040.c                                  |   53 +++
 drivers/clk/ingenic/cgu.c                                  |   10=20
 drivers/clk/ingenic/cgu.h                                  |    2=20
 drivers/clk/samsung/clk-exynos5-subcmu.c                   |   13=20
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c                       |    4=20
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c                       |    2=20
 drivers/clk/uniphier/clk-uniphier-cpugear.c                |    2=20
 drivers/clocksource/Kconfig                                |   10=20
 drivers/clocksource/arm_arch_timer.c                       |   55 +++
 drivers/clocksource/exynos_mct.c                           |   23 -
 drivers/clocksource/timer-ti-dm.c                          |    4=20
 drivers/cpufreq/pxa2xx-cpufreq.c                           |    4=20
 drivers/cpufreq/qcom-cpufreq-kryo.c                        |   20 +
 drivers/cpufreq/tegra124-cpufreq.c                         |    2=20
 drivers/crypto/caam/caamalg.c                              |    1=20
 drivers/crypto/caam/caamhash.c                             |   93 +-----
 drivers/crypto/ccree/cc_buffer_mgr.c                       |    8=20
 drivers/crypto/ccree/cc_cipher.c                           |    7=20
 drivers/crypto/rockchip/rk3288_crypto.c                    |    2=20
 drivers/crypto/rockchip/rk3288_crypto.h                    |    4=20
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c         |   39 ++
 drivers/crypto/rockchip/rk3288_crypto_ahash.c              |    2=20
 drivers/dma/sh/usb-dmac.c                                  |    2=20
 drivers/gpio/gpio-pca953x.c                                |    3=20
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c           |    8=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c           |    6=20
 drivers/gpu/drm/drm_fb_helper.c                            |    4=20
 drivers/gpu/drm/i915/i915_gem.c                            |    3=20
 drivers/gpu/drm/imx/imx-ldb.c                              |   25 +
 drivers/gpu/drm/imx/ipuv3-plane.c                          |    4=20
 drivers/gpu/drm/radeon/evergreen_cs.c                      |    1=20
 drivers/gpu/ipu-v3/ipu-common.c                            |    8=20
 drivers/hwtracing/intel_th/gth.c                           |    4=20
 drivers/hwtracing/stm/core.c                               |   11=20
 drivers/i2c/busses/i2c-bcm2835.c                           |   12=20
 drivers/i2c/busses/i2c-cadence.c                           |    9=20
 drivers/i2c/busses/i2c-tegra.c                             |    2=20
 drivers/iio/adc/exynos_adc.c                               |    2=20
 drivers/infiniband/hw/hfi1/hfi.h                           |    2=20
 drivers/infiniband/hw/hfi1/init.c                          |   14=20
 drivers/input/keyboard/cap11xx.c                           |   35 --
 drivers/input/keyboard/matrix_keypad.c                     |    2=20
 drivers/input/keyboard/st-keyscan.c                        |    4=20
 drivers/input/misc/pwm-vibra.c                             |   19 -
 drivers/input/serio/ps2-gpio.c                             |    1=20
 drivers/irqchip/irq-brcmstb-l2.c                           |   10=20
 drivers/irqchip/irq-gic-v3-its.c                           |    2=20
 drivers/mailbox/bcm-flexrm-mailbox.c                       |    4=20
 drivers/md/bcache/request.c                                |    7=20
 drivers/md/bcache/writeback.h                              |    3=20
 drivers/md/dm-integrity.c                                  |    8=20
 drivers/md/raid10.c                                        |    2=20
 drivers/md/raid5.c                                         |    2=20
 drivers/media/common/videobuf2/videobuf2-v4l2.c            |    1=20
 drivers/media/dvb-frontends/lgdt330x.c                     |    2=20
 drivers/media/i2c/ov5640.c                                 |    2=20
 drivers/media/platform/vimc/Makefile                       |    3=20
 drivers/media/platform/vimc/vimc-capture.c                 |   18 -
 drivers/media/platform/vimc/vimc-common.c                  |   35 --
 drivers/media/platform/vimc/vimc-common.h                  |   15 -
 drivers/media/platform/vimc/vimc-debayer.c                 |   26 -
 drivers/media/platform/vimc/vimc-scaler.c                  |   28 -
 drivers/media/platform/vimc/vimc-sensor.c                  |   56 ---
 drivers/media/platform/vimc/vimc-streamer.c                |  188 ++++++++=
+++++
 drivers/media/platform/vimc/vimc-streamer.h                |   38 ++
 drivers/media/usb/uvc/uvc_video.c                          |    8=20
 drivers/mfd/sm501.c                                        |    3=20
 drivers/misc/cxl/guest.c                                   |    2=20
 drivers/misc/cxl/pci.c                                     |   39 ++
 drivers/misc/mei/bus.c                                     |   21 -
 drivers/misc/mei/hbm.c                                     |    7=20
 drivers/mmc/core/core.c                                    |    4=20
 drivers/mmc/host/sdhci-esdhc-imx.c                         |    1=20
 drivers/net/can/flexcan.c                                  |    2=20
 drivers/net/dsa/bcm_sf2.c                                  |   12=20
 drivers/net/ethernet/atheros/atlx/atl2.c                   |    4=20
 drivers/net/ethernet/broadcom/bcmsysport.c                 |    4=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                  |    4=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                  |    2=20
 drivers/net/ethernet/cavium/thunder/nic_main.c             |    2=20
 drivers/net/ethernet/cavium/thunder/nicvf_main.c           |   27 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c         |    2=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c              |    7=20
 drivers/net/ethernet/marvell/mv643xx_eth.c                 |    7=20
 drivers/net/ethernet/marvell/mvneta.c                      |    2=20
 drivers/net/ethernet/netronome/nfp/bpf/jit.c               |   17 -
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c                |   21 +
 drivers/net/ethernet/qlogic/qed/qed_iwarp.h                |    1=20
 drivers/net/usb/qmi_wwan.c                                 |    4=20
 drivers/net/wireless/mac80211_hwsim.c                      |    2=20
 drivers/net/wireless/marvell/libertas_tf/if_usb.c          |    2=20
 drivers/nvdimm/label.c                                     |   23 +
 drivers/nvdimm/namespace_devs.c                            |    4=20
 drivers/nvdimm/pfn_devs.c                                  |    4=20
 drivers/parport/parport_pc.c                               |    2=20
 drivers/pci/controller/dwc/pcie-designware-host.c          |    2=20
 drivers/pci/pcie/dpc.c                                     |   27 +
 drivers/pci/probe.c                                        |   36 +-
 drivers/pinctrl/meson/pinctrl-meson8b.c                    |    2=20
 drivers/power/supply/cpcap-charger.c                       |    1=20
 drivers/regulator/max77620-regulator.c                     |   10=20
 drivers/regulator/s2mpa01.c                                |   10=20
 drivers/regulator/s2mps11.c                                |    6=20
 drivers/s390/block/dasd_eckd.c                             |    8=20
 drivers/s390/virtio/virtio_ccw.c                           |    4=20
 drivers/scsi/aacraid/linit.c                               |   13=20
 drivers/scsi/libiscsi.c                                    |    6=20
 drivers/scsi/qla2xxx/qla_init.c                            |   17 -
 drivers/scsi/sd.c                                          |   59 +++-
 drivers/scsi/virtio_scsi.c                                 |    2=20
 drivers/soc/qcom/rpmh.c                                    |   34 +-
 drivers/spi/spi-pxa2xx.c                                   |    1=20
 drivers/spi/spi-ti-qspi.c                                  |    6=20
 drivers/staging/media/imx/imx-ic-prpencvf.c                |   26 +
 drivers/staging/media/imx/imx-media-csi.c                  |   42 +-
 drivers/target/iscsi/iscsi_target.c                        |    4=20
 drivers/tty/serial/8250/8250_of.c                          |    4=20
 drivers/tty/serial/8250/8250_pci.c                         |  141 ++++++++-
 drivers/tty/serial/xilinx_uartps.c                         |    8=20
 drivers/tty/vt/vt.c                                        |   15 -
 drivers/usb/chipidea/ci_hdrc_tegra.c                       |    1=20
 drivers/usb/typec/tps6598x.c                               |   26 +
 fs/9p/v9fs_vfs.h                                           |   23 +
 fs/9p/vfs_file.c                                           |    6=20
 fs/9p/vfs_inode.c                                          |   23 -
 fs/9p/vfs_inode_dotl.c                                     |   27 -
 fs/9p/vfs_super.c                                          |    4=20
 fs/btrfs/acl.c                                             |    9=20
 fs/btrfs/disk-io.c                                         |    8=20
 fs/btrfs/extent_io.c                                       |    4=20
 fs/btrfs/volumes.c                                         |    4=20
 fs/cifs/cifsglob.h                                         |   19 +
 fs/cifs/file.c                                             |   12=20
 fs/cifs/smb2misc.c                                         |   17 -
 fs/cifs/smb2ops.c                                          |   28 +
 fs/cifs/smb2transport.c                                    |   14=20
 fs/cifs/transport.c                                        |    6=20
 fs/devpts/inode.c                                          |    1=20
 fs/ext2/super.c                                            |   39 +-
 fs/ext4/ext4.h                                             |    3=20
 fs/ext4/ioctl.c                                            |  100 +++++-
 fs/ext4/resize.c                                           |    3=20
 fs/jbd2/transaction.c                                      |   33 +-
 fs/kernfs/mount.c                                          |    8=20
 fs/nfs/nfs4idmap.c                                         |   31 +-
 fs/nfs/nfs4proc.c                                          |   12=20
 fs/nfs/pagelist.c                                          |   29 +-
 fs/nfs/write.c                                             |   11=20
 fs/nfsd/nfs3proc.c                                         |   16 -
 fs/nfsd/nfs3xdr.c                                          |    1=20
 fs/nfsd/nfs4state.c                                        |    8=20
 fs/nfsd/nfsctl.c                                           |    2=20
 fs/overlayfs/copy_up.c                                     |   59 +++-
 fs/overlayfs/overlayfs.h                                   |    2=20
 fs/overlayfs/util.c                                        |   55 ++-
 fs/pipe.c                                                  |   14=20
 fs/splice.c                                                |    4=20
 include/asm-generic/vmlinux.lds.h                          |    2=20
 include/keys/request_key_auth-type.h                       |   36 ++
 include/kvm/arm_vgic.h                                     |    2=20
 include/linux/device-mapper.h                              |    2=20
 include/linux/hardirq.h                                    |    7=20
 include/linux/key-type.h                                   |   22 -
 include/linux/kvm_host.h                                   |    2=20
 include/linux/pipe_fs_i.h                                  |    1=20
 include/linux/property.h                                   |    2=20
 include/linux/skbuff.h                                     |    6=20
 include/net/phonet/pep.h                                   |    5=20
 init/main.c                                                |    3=20
 kernel/bpf/lpm_trie.c                                      |    1=20
 kernel/bpf/stackmap.c                                      |    8=20
 kernel/cgroup/cgroup.c                                     |    9=20
 kernel/rcu/tree.c                                          |   20 -
 kernel/sysctl.c                                            |   11=20
 kernel/trace/trace.c                                       |    1=20
 kernel/trace/trace_event_perf.c                            |   16 -
 kernel/trace/trace_events_hist.c                           |    5=20
 lib/assoc_array.c                                          |    8=20
 mm/gup.c                                                   |    3=20
 mm/memory-failure.c                                        |   14=20
 mm/memory.c                                                |    5=20
 mm/page_alloc.c                                            |    8=20
 mm/page_ext.c                                              |    4=20
 mm/shmem.c                                                 |   12=20
 mm/swap.c                                                  |   17 -
 mm/vmalloc.c                                               |    2=20
 net/9p/client.c                                            |    2=20
 net/core/filter.c                                          |   12=20
 net/ipv4/esp4.c                                            |    2=20
 net/ipv4/netfilter/ipt_CLUSTERIP.c                         |    2=20
 net/ipv6/esp6.c                                            |    2=20
 net/key/af_key.c                                           |   40 +-
 net/mac80211/agg-tx.c                                      |    4=20
 net/mac80211/util.c                                        |    6=20
 net/netfilter/ipvs/Kconfig                                 |    1=20
 net/netfilter/ipvs/ip_vs_core.c                            |   10=20
 net/netfilter/ipvs/ip_vs_ctl.c                             |   10=20
 net/netfilter/x_tables.c                                   |    2=20
 net/phonet/pep.c                                           |   32 +-
 net/sunrpc/svcsock.c                                       |   20 -
 net/sunrpc/xprtrdma/verbs.c                                |    3=20
 net/xfrm/xfrm_interface.c                                  |    4=20
 net/xfrm/xfrm_policy.c                                     |    4=20
 scripts/kallsyms.c                                         |    4=20
 security/keys/internal.h                                   |   13=20
 security/keys/keyctl.c                                     |    1=20
 security/keys/process_keys.c                               |    1=20
 security/keys/request_key.c                                |   72 ++--
 security/keys/request_key_auth.c                           |   16 -
 security/selinux/hooks.c                                   |    8=20
 sound/soc/codecs/pcm186x.c                                 |    8=20
 sound/soc/codecs/rt5682.c                                  |    2=20
 sound/soc/fsl/fsl_esai.c                                   |    7=20
 sound/soc/samsung/i2s.c                                    |   10=20
 sound/soc/sh/rcar/ssi.c                                    |    2=20
 sound/soc/soc-dapm.c                                       |   24 +
 sound/soc/soc-topology.c                                   |    8=20
 tools/perf/util/auxtrace.c                                 |    4=20
 tools/perf/util/auxtrace.h                                 |    3=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c        |   37 ++
 tools/perf/util/intel-pt.c                                 |    2=20
 tools/perf/util/symbol.c                                   |    2=20
 tools/testing/selftests/bpf/test_lpm_map.c                 |   10=20
 tools/testing/selftests/net/fib_tests.sh                   |    1=20
 virt/kvm/arm/arm.c                                         |   10=20
 virt/kvm/arm/mmu.c                                         |    2=20
 virt/kvm/arm/psci.c                                        |   36 +-
 virt/kvm/arm/vgic/vgic-init.c                              |   24 +
 virt/kvm/arm/vgic/vgic-its.c                               |    8=20
 virt/kvm/arm/vgic/vgic.c                                   |   10=20
 virt/kvm/kvm_main.c                                        |    7=20
 346 files changed, 3061 insertions(+), 1579 deletions(-)

Aditya Pakki (1):
      md: Fix failed allocation of md_register_thread

Adrian Hunter (5):
      perf intel-pt: Fix CYC timestamp calculation after OVF
      perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols
      perf auxtrace: Define auxtrace record alignment
      perf intel-pt: Fix overlap calculation for padding
      perf intel-pt: Fix divide by zero when TSC is not available

Al Viro (1):
      fix cgroup_do_mount() handling of failure exits

Alban Crequy (1):
      bpf, lpm: fix lookup bug in map_delete_elem

Alexander Shishkin (2):
      stm class: Prevent division by zero
      intel_th: Don't reference unassigned outputs

Alexander Shiyan (1):
      gpu: ipu-v3: Fix i.MX51 CSI control registers offset

Alexander Usyskin (2):
      mei: hbm: clean the feature flags on link reset
      mei: bus: move hw module get/put to probe/release

Alexei Starovoitov (1):
      bpf: fix lockdep false positive in stackmap

Alexey Khoroshilov (1):
      net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_pro=
be()

Anders Roxell (1):
      netfilter: ipt_CLUSTERIP: fix warning unused variable cn

Andre Przywara (1):
      clk: sunxi: A31: Fix wrong AHB gate number

Andrea Claudi (1):
      ipvs: fix dependency on nf_defrag_ipv6

Andy Shevchenko (2):
      ACPI / device_sysfs: Avoid OF modalias creation for removed device
      spi: pxa2xx: Setup maximum supported DMA transfer length

Aneesh Kumar K.V (1):
      powerpc/hugetlb: Don't do runtime allocation of 16G pages in LPAR con=
figuration

Anoob Soman (1):
      scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_t=
ask

Anssi Hannula (1):
      serial: uartps: Fix stuck ISR if RX disabled with non-empty FIFO

Ard Biesheuvel (4):
      crypto: arm/crct10dif - revert to C code for short inputs
      crypto: arm64/crct10dif - revert to C code for short inputs
      crypto: arm64/aes-ccm - fix logical bug in AAD MAC handling
      crypto: arm64/aes-ccm - fix bugs in non-NEON fallback routine

Arnd Bergmann (2):
      phonet: fix building with clang
      cpufreq: pxa2xx: remove incorrect __init annotation

BOUGH CHEN (1):
      mmc: sdhci-esdhc-imx: fix HS400 timing issue

Bard liao (1):
      ASoC: topology: free created components in tplg load error

Bart Van Assche (1):
      scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock

Beniamino Galvani (1):
      qmi_wwan: apply SET_DTR quirk to Sierra WP7607

Benjamin Coddington (1):
      NFS: Don't use page_file_mapping after removing the page

Bill Kuzeja (1):
      scsi: qla2xxx: Fix panic from use after free in qla2x00_async_tm_cmd

Bjorn Helgaas (1):
      PCI/ASPM: Use LTR if already enabled by platform

Christoffer Dall (2):
      KVM: arm/arm64: Reset the VCPU without preemption and vcpu state load=
ed
      KVM: arm/arm64: vgic: Always initialize the group of private IRQs

Christophe Leroy (5):
      powerpc/32: Clear on-stack exception marker upon exception return
      powerpc/wii: properly disable use of BATs when requested.
      powerpc/83xx: Also save/restore SPRG4-7 during suspend
      powerpc/traps: fix recoverability of machine check handling on book3s=
/32
      powerpc/traps: Fix the message printed when stack overflows

Codrin Ciubotariu (2):
      ASoC: codecs: pcm186x: fix wrong usage of DECLARE_TLV_DB_SCALE()
      ASoC: codecs: pcm186x: Fix energysense SLEEP bit

Coly Li (1):
      bcache: use (REQ_META|REQ_PRIO) to indicate bio for metadata

Dan Carpenter (1):
      net: dsa: bcm_sf2: potential array overflow in bcm_sf2_sw_suspend()

Dan Williams (5):
      acpi/nfit: Fix bus command validation
      nfit/ars: Attempt a short-ARS whenever the ARS state is idle at boot
      nfit/ars: Attempt short-ARS even in the no_init_ars case
      libnvdimm/label: Clear 'updating' flag after label-set update
      libnvdimm/pmem: Honor force_raw for legacy pmem regions

Daniel Axtens (1):
      bcache: never writeback a discard operation

Darrick J. Wong (2):
      tmpfs: fix link accounting when a tmpfile is linked in
      tmpfs: fix uninitialized return value in shmem_link

Dave Martin (1):
      arm64: KVM: Fix architecturally invalid reset value for FPEXC32_EL2

David Howells (2):
      assoc_array: Fix shortcut creation
      keys: Fix dependency loop between construction record and auth key

Dexuan Cui (1):
      nfit: acpi_nfit_ctl(): Check out_obj->type in the right place

Dietmar Eggemann (1):
      ARM: 8824/1: fix a migrating irq bug when hotplug cpu

Dmitry Osipenko (1):
      usb: chipidea: tegra: Fix missed ci_hdrc_remove_device()

Dmitry Torokhov (3):
      Input: cap11xx - switch to using set_brightness_blocking()
      Input: ps2-gpio - flush TX work when closing port
      Input: matrix_keypad - use flush_delayed_work()

Dongdong Liu (1):
      PCI/DPC: Fix print AER status in DPC event handling

Doug Berger (1):
      irqchip/brcmstb-l2: Use _irqsave locking variants in non-interrupt co=
de

Enric Balletbo i Serra (1):
      arm64: dts: rockchip: fix graph_port warning on rk3399 bob kevin and =
excavator

Eric Biggers (14):
      crypto: cfb - add missing 'chunksize' property
      crypto: cfb - remove bogus memcpy() with src =3D=3D dest
      crypto: ahash - fix another early termination in hash walk
      crypto: aead - set CRYPTO_TFM_NEED_KEY if ->setkey() fails
      crypto: aegis - fix handling chunked inputs
      crypto: arm64/aes-neonbs - fix returning final keystream block
      crypto: hash - set CRYPTO_TFM_NEED_KEY if ->setkey() fails
      crypto: morus - fix handling chunked inputs
      crypto: pcbc - remove bogus memcpy()s with src =3D=3D dest
      crypto: skcipher - set CRYPTO_TFM_NEED_KEY if ->setkey() fails
      crypto: testmgr - skip crc32c context test for ahash algorithms
      crypto: x86/aegis - fix handling chunked inputs and MAY_SLEEP
      crypto: x86/aesni-gcm - fix crash on empty plaintext
      crypto: x86/morus - fix handling chunked inputs and MAY_SLEEP

Eugene Loh (1):
      kallsyms: Handle too long symbols in kallsyms.c

Eugeniy Paltsev (1):
      ARCv2: lib: memcpy: fix doing prefetchw outside of buffer

Evan Quan (1):
      drm/amd/powerplay: correct power reading on fiji

Felipe Franciosi (1):
      scsi: virtio_scsi: don't send sc payload with tmfs

Filipe Manana (3):
      Btrfs: setup a nofs context for memory allocation at btrfs_create_tre=
e()
      Btrfs: setup a nofs context for memory allocation at __btrfs_set_acl
      Btrfs: fix corruption reading shared and compressed extents after hol=
e punching

Finn Thain (1):
      m68k: Add -ffreestanding to CFLAGS

Florian Fainelli (2):
      net: systemport: Fix reception of BPDUs
      net: dsa: bcm_sf2: Do not assume DSA master supports WoL

Francesco Ruggeri (1):
      netfilter: compat: initialize all fields in xt_init

Franck LENORMAND (1):
      crypto: caam - fix hash context DMA unmap size

French, Nicholas A (1):
      media: lgdt330x: fix lock status reporting

Gabriel Fernandez (1):
      Input: st-keyscan - fix potential zalloc NULL dereference

Gilad Ben-Yossef (2):
      crypto: ccree - unmap buffer before copying IV
      crypto: ccree - don't copy zero size ciphertext

Greg Kroah-Hartman (2):
      stable-kernel-rules.rst: add link to networking patch queue
      Linux 4.19.31

Gustavo A. R. Silva (4):
      crypto: ccree - fix missing break in switch statement
      ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify
      mfd: sm501: Fix potential NULL pointer dereference
      drm/radeon/evergreen_cs: fix missing break in switch statement

Hadar Gat (1):
      crypto: ccree - fix free of unallocated mlli buffer

Halil Pasic (1):
      s390/virtio: handle find on invalid queue gracefully

Hans Verkuil (1):
      media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()

Harry Wentland (1):
      drm/amd/display: don't call dm_pp_ function from an fpu block

Heikki Krogerus (1):
      device property: Fix the length used in PROPERTY_ENTRY_STRING()

Himanshu Madhani (1):
      scsi: qla2xxx: Fix LUN discovery if loop id is not assigned yet by fi=
rmware

Horia Geant=C4=83 (1):
      crypto: caam - fix DMA mapping of stack memory

Hou Tao (1):
      9p: use inode->i_lock to protect i_size_write() under 32-bit

Huang Zijiang (1):
      net: hns: Fix object reference leaks in hns_dsaf_roce_reset()

Ilan Peer (1):
      mac80211: Fix Tx aggregation session tear down with ITXQs

J. Bruce Fields (3):
      security/selinux: fix SECURITY_LSM_NATIVE_LABELS on reused superblock
      nfsd: fix performance-limiting session calculation
      svcrpc: fix UDP on servers with lots of threads

James Morse (1):
      KVM: arm64: Forbid kprobing of the VHE world-switch code

Jan Kara (2):
      ext4: fix crash during online resizing
      ext2: Fix underflow in ext2_max_size()

Jan Stancek (1):
      mm/memory.c: do_fault: avoid usage of stale vm_area_struct

Jann Horn (3):
      mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs
      tracing/perf: Use strndup_user() instead of buggy open-coded version
      splice: don't merge into linked buffers

Jarkko Sakkinen (2):
      tpm/tpm_crb: Avoid unaligned reads in crb_recv()
      tpm: Unify the send callback behaviour

Jay Dolan (2):
      serial: 8250_pci: Fix number of ports for ACCES serial cards
      serial: 8250_pci: Have ACCES cards that use the four port Pericom PI7=
C9X7954 chip use the pci_pericom_setup()

Jeff Kirsher (1):
      ixgbe: fix older devices that do not support IXGBE_MRQC_L3L4TXSWEN

Jianchao Wang (1):
      blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue

Jiong Wang (2):
      nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K
      nfp: bpf: fix ALU32 high bits clearance bug

Jiong Wu (1):
      mmc:fix a bug when max_discard is 0

Johannes Berg (1):
      mac80211: call drv_ibss_join() on restart

Johannes Thumshirn (1):
      btrfs: ensure that a DUP or RAID1 block group has exactly two stripes

Jonathan Bakker (1):
      Input: pwm-vibra - prevent unbalanced regulator

Jordan Niethe (1):
      powerpc/powernv: Make opal log only readable by root

Josh Poimboeuf (1):
      x86/unwind/orc: Fix ORC unwind table alignment

Juergen Gross (1):
      xen: fix dom0 boot on huge systems

Julia Lawall (1):
      drm/imx: imx-ldb: add missing of_node_puts

Julien Thierry (2):
      KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock
      arm64: Fix HCR.TGE status for NMI contexts

Kan Liang (1):
      perf/x86/intel/uncore: Fix client IMC events return huge result

Krzysztof Kozlowski (4):
      iio: adc: exynos-adc: Fix NULL pointer exception on unbind
      regulator: s2mps11: Fix steps for buck7, buck8 and LDO35
      clk: samsung: exynos5: Fix possible NULL pointer exception on platfor=
m_device_alloc() failure
      clk: samsung: exynos5: Fix kfree() of const memory on setting driver_=
override

Kunihiko Hayashi (1):
      clk: uniphier: Fix update register for CPU-gear

Kuninori Morimoto (1):
      ASoC: rsnd: fixup rsnd_ssi_master_clk_start() user count check

Li RongQing (1):
      mac80211_hwsim: propagate genlmsg_reply return code

Loic Poulain (1):
      media: i2c: ov5640: Fix post-reset delay

Lubomir Rintel (2):
      libertas_tf: don't set URB_ZERO_PACKET on IN USB transfer
      serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart

Lucas A. M. Magalh=C3=A3es (1):
      media: vimc: Add vimc-streamer for stream control

Lucas Stach (1):
      PCI: dwc: skip MSI init if MSIs have been explicitly disabled

Mao Wenan (1):
      net: set static variable an initial value in atl2_probe()

Marc Kleine-Budde (1):
      can: flexcan: FLEXCAN_IFLAG_MB: add () around macro argument

Marc Zyngier (2):
      arm/arm64: KVM: Allow a VCPU to fully reset itself
      arm/arm64: KVM: Don't panic on failure to properly reset system regis=
ters

Mark Cave-Ayland (1):
      powerpc: Fix 32-bit KVM-PR lockup and host crash with MacOS guest

Mark Walton (1):
      gpio: pca953x: Fix dereference of irq data in shutdown

Mark Zhang (1):
      regulator: max77620: Initialize values for DT properties

Martin Blumenstingl (1):
      pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins

Martin K. Petersen (1):
      scsi: sd: Optimal I/O size should be a multiple of physical block size

Martin Schwidefsky (2):
      s390/setup: fix early warning messages
      s390/setup: fix boot crash for machine without EDAT-1

Martin Willi (1):
      esp: Skip TX bytes accounting when sending from a request socket

Masami Hiramatsu (1):
      x86/kprobes: Prohibit probing on optprobe template code

Michael Chan (2):
      bnxt_en: Fix typo in firmware message timeout logic.
      bnxt_en: Wait longer for the firmware message response to complete.

Michael Ellerman (1):
      powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning

Michael J. Ruhl (1):
      IB/hfi1: Close race condition on user context disable and close

Michal Hocko (1):
      mm: handle lru_add_drain_all for UP properly

Michal Kalderon (2):
      qed: Fix iWARP buffer size provided for syn packet processing.
      qed: Fix iWARP syn packet mac address validation.

Miguel Ojeda (1):
      auxdisplay: ht16k33: fix potential user-after-free on module unload

Mikulas Patocka (1):
      dm integrity: limit the rate of error messages

NeilBrown (2):
      dm: fix to_sector() for 32bit
      nfsd: fix memory corruption caused by readdir

Nicolas Morey-Chaisemartin (1):
      xprtrdma: Make sure Send CQ is allocated on an existing compvec

Nicolas Pitre (1):
      vt: perform safe console erase in the right order

Nikolaus Voss (1):
      usb: typec: tps6598x: handle block writes separately with plain-I2C a=
dapters

Noralf Tr=C3=B8nnes (1):
      drm/fb-helper: generic: Fix drm_fbdev_client_restore()

Oliver O'Halloran (1):
      libnvdimm: Fix altmap reservation size calculation

Pankaj Gupta (1):
      crypto: caam - fixed handling of sg list

Paul Cercueil (2):
      clk: ingenic: Fix round_rate misbehaving with non-integer dividers
      clk: ingenic: Fix doc of ingenic_cgu_div_info

Paul Kocialkowski (2):
      i2c: bcm2835: Clear current buffer pointers and counts after a transf=
er
      clk: sunxi-ng: v3s: Fix TCON reset de-assert bit

Paul Mackerras (1):
      powerpc/powernv: Don't reprogram SLW image on every KVM guest entry/e=
xit

Pavel Machek (1):
      cpcap-charger: generate events for userspace

Pavel Shilovsky (3):
      CIFS: Do not reset lease state to NONE on lease break
      CIFS: Do not skip SMB2 message IDs on send failures
      CIFS: Fix read after write for files with read caching

Pawe=C5=82 Chmiel (1):
      Input: pwm-vibra - stop regulator after disabling pwm, not before

Philipp Zabel (1):
      drm/imx: ignore plane updates on disabled crtcs

Phuong Nguyen (1):
      dmaengine: usb-dmac: Make DMAC system sleep callbacks explicit

Pierre-Louis Bossart (1):
      ASoC: dapm: fix out-of-bounds accesses to DAPM lookup tables

Qian Cai (1):
      Revert "mm: use early_pfn_to_nid in page_ext_init"

QiaoChong (1):
      parport_pc: fix find_superio io compare code, should use equal test.

Rajneesh Bhardwaj (1):
      x86/CPU: Add Icelake model number

Rayagonda Kokatanur (1):
      mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue

Robin Murphy (1):
      ARM: 8835/1: dma-mapping: Clear DMA ops on teardown

Roman Penyaev (1):
      mm/vmalloc: fix size check for remap_vmalloc_range_partial()

Russell King (2):
      ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug
      net: marvell: mvneta: fix DMA debug warning

S.j. Wang (1):
      ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

Sagar Biradar (1):
      scsi: aacraid: Fix performance issue on logical drives

Sakari Ailus (1):
      media: uvcvideo: Avoid NULL pointer dereference at the end of streami=
ng

Samuel Holland (1):
      clocksource/drivers/arch_timer: Workaround for Allwinner A64 timer in=
stability

Sean Christopherson (6):
      KVM: Call kvm_arch_memslots_updated() before updating memslots
      KVM: x86/mmu: Detect MMIO generation wrap in any address space
      KVM: x86/mmu: Do not cache MMIO accesses while memslots are in flux
      KVM: nVMX: Sign extend displacements of VMX instr's mem operands
      KVM: nVMX: Apply addr size mask to effective address for VMX instruct=
ions
      KVM: nVMX: Ignore limit checks on VMX instructions using flat segments

Sean Tranchetti (1):
      af_key: unconditionally clone on broadcast

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the hold bit setting

Shuming Fan (1):
      ASoC: rt5682: Correct the setting while select ASRC clk for AD/DA fil=
ter

Sowjanya Komatineni (1):
      i2c: tegra: fix maximum transfer size

Stefan Haberland (1):
      s390/dasd: fix using offset into zero size array error

Stephen Boyd (1):
      soc: qcom: rpmh: Avoid accessing freed memory from batch API

Steve Longerbeam (4):
      gpu: ipu-v3: Fix CSI offsets for imx53
      media: imx: prpencvf: Stop upstream before disabling IDMA channel
      media: imx: csi: Disable CSI immediately after last EOF
      media: imx: csi: Stop upstream before disabling IDMA channel

Stuart Menefy (3):
      regulator: s2mpa01: Fix step values for some LDOs
      clocksource/drivers/exynos_mct: Move one-shot check from tick clear t=
o ISR
      clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown

Sylwester Nawrocki (1):
      ASoC: samsung: Prevent clk_get_rate() calls in atomic context

Thadeu Lima de Souza Cascardo (1):
      selftests: fib_tests: sleep after changing carrier. again.

Thierry Reding (1):
      ARM: tegra: Restore DT ABI on Tegra124 Chromebooks

Thomas Petazzoni (1):
      ARM: dts: armada-xp: fix Armada XP boards NAND description

Tobias Brunner (1):
      xfrm: Fix inbound traffic via XFRM interfaces across network namespac=
es

Tom Zanussi (1):
      tracing: Use strncpy instead of memcpy for string keys in hist trigge=
rs

Tony Lindgren (3):
      clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
      ARM: dts: Configure clock parent for pwm vibra
      clk: clk-twl6040: Fix imprecise external abort for pdmclk

Trond Myklebust (4):
      NFS: Fix I/O request leakages
      NFS: Fix an I/O request leakage in nfs_do_recoalesce
      NFS: Don't recoalesce on error in nfs_pageio_complete_mirror()
      NFSv4.1: Reinitialise sequence results before retransmitting a request

Tvrtko Ursulin (1):
      drm/i915: Relax mmap VMA check

Vadim Lomovtsev (2):
      net: thunderx: make CFG_DONE message to run through generic send-ack =
sequence
      net: thunderx: add nicvf_send_msg_to_pf result check for set_rx_mode_=
task

Vaibhav Jain (1):
      cxl: Wrap iterations over afu slices inside 'afu_list_lock'

Varad Gautam (1):
      fs/devpts: always delete dcache dentry-s in dput()

Vignesh R (1):
      spi: ti-qspi: Fix mmap read when more than one CS in use

Vineet Gupta (3):
      ARC: uacces: remove lp_start, lp_end from clobber list
      ARCv2: support manual regfile save on interrupts
      ARCv2: don't assume core 0x54 has dual issue

Viresh Kumar (2):
      cpufreq: kryo: Release OPP tables on module removal
      PM / wakeup: Rework wakeup source timer cancellation

Vivek Goyal (2):
      ovl: During copy up, first copy up data and then xattrs
      ovl: Do not lose security.capability xattr over metadata file copy-up

Vladimir Murzin (1):
      arm64: Relax GIC version check during early boot

Wei Yang (1):
      libnvdimm, pfn: Fix over-trim in trim_pfn_device()

Will Deacon (1):
      arm64: debug: Ensure debug handlers check triggering exception level

Willem de Bruijn (2):
      bpf: only adjust gso_size on bytestream protocols
      bpf: only test gso type on gso packets

Xin Long (1):
      selinux: add the missing walk_size + len check in selinux_sctp_bind_c=
onnect

Yang Yingliang (1):
      ipmi_si: fix use-after-free of resource->name

Yangtao Li (1):
      cpufreq: tegra124: add missing of_node_put()

Yihao Wu (1):
      nfsd: fix wrong check in write_v4_end_grace()

Yizhuo (1):
      ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be=
 uninitialized

Yu Zhao (1):
      mm/gup: fix gup_pmd_range() for dax

Yufen Yu (1):
      floppy: check_events callback should not return a negative number

Zenghui Yu (1):
      irqchip/gic-v3-its: Avoid parsing _indirect_ twice for Device table

Zev Weiss (1):
      kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_c=
onv

Zhang Zhijie (2):
      crypto: rockchip - fix scatterlist nents error
      crypto: rockchip - update new iv to device in multiple operations

Zhang, Jun (1):
      rcu: Do RCU GP kthread self-wakeup from softirq and interrupt

Zhi Jin (1):
      stm class: Fix an endless loop in channel allocation

yangerkun (4):
      ext4: fix check of inode in swap_inode_boot_loader
      ext4: cleanup pagecache before swap i_data
      ext4: update quota information while swapping boot loader inode
      ext4: add mask of ext4 flags to swap

zhangyi (F) (3):
      tracing: Do not free iter->trace in fail path of tracing_open_pipe()
      jbd2: clear dirty flag when revoking a buffer from an older transacti=
on
      jbd2: fix compile warning when using JBUFFER_TRACE

zhengbin (1):
      9p/net: fix memory leak in p9_client_create

zhongjiang (1):
      mm: hwpoison: fix thp split handing in soft_offline_in_use_page()


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyXQ6sACgkQONu9yGCS
aT6RSRAAjSAt4LydfzSMPCJRAwWuI1nT6PBCWI75NB5iZEkCss4uoCv4DlJCaLwV
aTxIYF/JCSqyk1E3E/Uo75FsyvXQdCqpO2acYDgw7E7uMeTM1+gF3lID54q3FINq
noNLqqgMuWof24lXmJClOsZ9dTvMI7rknwp6EJgWCNOhULYBaFcZ+IOd33Hcb58x
LTU0n5I9r/0g4iIcsPHngPhUlwxvAt6PS50MibZ7rV+3mcC1fMawTYW3kfZHlcMU
l0dbWsYkFIZb5HRjR1H3IcLllTTg8HjuGk7OP7BNZTb7xeju3wTpUsCWRE7vs3zY
W5Btwen3FLZ4Br6sQVyFexzdUvSX5YFUXasBZe8sn9FjPpXI908LMR+utko7YHq0
hqCOmwQwXlfSNXgNML34B20fowgLQWe5unVdD2ffIJxq4v3XK1DEpzjh+GB6ST5q
chOySh0RybdYZUR4Yj6KnONv8EHpLbCpbYkqpFUAOL5uEZMNZjjoTPVlw0cJHxHP
mI9FSI64xLNH3L77ZkFZIc1XcYlfZVTTjHVVJWCp+JFnn698OM+v/EPzoUhY95hq
m2mhae+1gWfpC0VZEXxFyIUlOlsVyCYabwPdxQ/UVpJE7Ip/0hSuagAhI8HUDPbv
1TAi5ovdr5uAiroxV8veRF3xVOpaq8/lSX2Cpn6SCCC8npOfucg=
=xQc6
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
