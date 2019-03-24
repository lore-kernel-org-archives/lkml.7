Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A672C10F10
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D8421019
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553417180;
	bh=DHmuj2lWcKL3Hkg4o41PnYzBswZC9LlLt326/GVFtGE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bpCB4iUjd1kzLUg32zOhqMkpTznmEdlNEz0fNkCDca1FSc9z4SuN5CZrBUKA75Q7E
	 +4n5jeTIqIhMZlzlA1mzFTMaKPr8cTEKksKxs4BOf5FZrW9Hr9QJPNYQEVnQ6Cg3Yt
	 CSd6yEbHCdPd+n1gN2ORDhqqIEbT2XfmZ4h+DIkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfCXIqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 04:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfCXIqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 04:46:18 -0400
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8C9213F2;
        Sun, 24 Mar 2019 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553417170;
        bh=DHmuj2lWcKL3Hkg4o41PnYzBswZC9LlLt326/GVFtGE=;
        h=Date:From:To:Cc:Subject:From;
        b=2MCDOHxtEPOFAoHA6Vas3uqsyZO+mSwgEyMyINuSPpyMiGyjQzpKLe+q62Z1qZlI5
         rTgd5+K+rLmX4GaIRCa73p394R1pT+QAmafjpqI+XQIgA/nR+Jf225iYzu4+SXs4jV
         m4dS+TNUX2ckVfNu+w/Nui4HvZwncSdU4BDdhaTo=
Date:   Sun, 24 Mar 2019 09:46:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 5.0.4
Message-ID: <20190324084607.GA6407@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 5.0.4 kernel.

All users of the 5.0 kernel series must upgrade.

The updated 5.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-5.0.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/DMA-API.txt                                        |    8=20
 Documentation/arm64/silicon-errata.txt                           |    2=20
 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt |    4=20
 Documentation/process/stable-kernel-rules.rst                    |    3=20
 Makefile                                                         |    2=20
 arch/arm/crypto/crct10dif-ce-core.S                              |   14=20
 arch/arm/crypto/crct10dif-ce-glue.c                              |   23=20
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c                          |    8=20
 arch/arm64/crypto/aes-ce-ccm-core.S                              |    5=20
 arch/arm64/crypto/aes-ce-ccm-glue.c                              |    4=20
 arch/arm64/crypto/aes-neonbs-core.S                              |    8=20
 arch/arm64/crypto/crct10dif-ce-glue.c                            |   25 -
 arch/arm64/include/asm/hardirq.h                                 |   31 +
 arch/arm64/kernel/irq.c                                          |    3=20
 arch/arm64/kernel/kgdb.c                                         |   14=20
 arch/arm64/kernel/probes/kprobes.c                               |    6=20
 arch/arm64/kvm/sys_regs.c                                        |    2=20
 arch/arm64/mm/fault.c                                            |    9=20
 arch/m68k/Makefile                                               |    5=20
 arch/mips/include/asm/kvm_host.h                                 |    2=20
 arch/powerpc/include/asm/book3s/64/hugetlb.h                     |    8=20
 arch/powerpc/include/asm/kvm_host.h                              |    2=20
 arch/powerpc/include/asm/powernv.h                               |    2=20
 arch/powerpc/kernel/entry_32.S                                   |    9=20
 arch/powerpc/kernel/process.c                                    |    2=20
 arch/powerpc/kernel/ptrace.c                                     |   10=20
 arch/powerpc/kernel/smp.c                                        |   90 +--
 arch/powerpc/kernel/traps.c                                      |   12=20
 arch/powerpc/kvm/book3s_hv_rmhandlers.S                          |   26 -
 arch/powerpc/mm/slb.c                                            |    5=20
 arch/powerpc/platforms/83xx/suspend-asm.S                        |   34 +
 arch/powerpc/platforms/embedded6xx/wii.c                         |    4=20
 arch/powerpc/platforms/powernv/idle.c                            |   27 -
 arch/powerpc/platforms/powernv/opal-msglog.c                     |    2=20
 arch/powerpc/platforms/powernv/smp.c                             |   25 +
 arch/s390/include/asm/kvm_host.h                                 |    2=20
 arch/s390/kernel/setup.c                                         |   31 -
 arch/x86/crypto/aegis128-aesni-glue.c                            |   38 -
 arch/x86/crypto/aegis128l-aesni-glue.c                           |   38 -
 arch/x86/crypto/aegis256-aesni-glue.c                            |   38 -
 arch/x86/crypto/aesni-intel_glue.c                               |   13=20
 arch/x86/crypto/morus1280_glue.c                                 |   40 -
 arch/x86/crypto/morus640_glue.c                                  |   39 -
 arch/x86/events/intel/uncore.c                                   |    1=20
 arch/x86/events/intel/uncore.h                                   |   12=20
 arch/x86/events/intel/uncore_snb.c                               |    4=20
 arch/x86/include/asm/kvm_host.h                                  |    2=20
 arch/x86/kernel/ftrace.c                                         |   42 -
 arch/x86/kernel/kprobes/opt.c                                    |    5=20
 arch/x86/kernel/kvmclock.c                                       |    6=20
 arch/x86/kvm/mmu.c                                               |   39 -
 arch/x86/kvm/vmx/nested.c                                        |   43 +
 arch/x86/kvm/vmx/vmx.c                                           |   16=20
 arch/x86/kvm/x86.c                                               |    4=20
 arch/x86/kvm/x86.h                                               |    7=20
 arch/x86/xen/mmu_pv.c                                            |   13=20
 crypto/aead.c                                                    |    4=20
 crypto/aegis128.c                                                |   14=20
 crypto/aegis128l.c                                               |   14=20
 crypto/aegis256.c                                                |   14=20
 crypto/ahash.c                                                   |   42 +
 crypto/cfb.c                                                     |   14=20
 crypto/morus1280.c                                               |   13=20
 crypto/morus640.c                                                |   13=20
 crypto/ofb.c                                                     |   91 +--
 crypto/pcbc.c                                                    |   14=20
 crypto/shash.c                                                   |   18=20
 crypto/skcipher.c                                                |   27 -
 crypto/testmgr.c                                                 |   14=20
 crypto/testmgr.h                                                 |   53 ++
 drivers/acpi/device_sysfs.c                                      |    6=20
 drivers/acpi/nfit/core.c                                         |   84 +--
 drivers/base/power/wakeup.c                                      |    8=20
 drivers/char/ipmi/ipmi_si.h                                      |    4=20
 drivers/char/ipmi/ipmi_si_hardcode.c                             |  236 ++=
+++++---
 drivers/char/ipmi/ipmi_si_intf.c                                 |   28 -
 drivers/char/ipmi/ipmi_si_mem_io.c                               |    5=20
 drivers/char/ipmi/ipmi_si_platform.c                             |   29 -
 drivers/char/ipmi/ipmi_si_port_io.c                              |    5=20
 drivers/char/tpm/st33zp24/st33zp24.c                             |    2=20
 drivers/char/tpm/tpm-interface.c                                 |   11=20
 drivers/char/tpm/tpm_atmel.c                                     |    2=20
 drivers/char/tpm/tpm_crb.c                                       |   22=20
 drivers/char/tpm/tpm_i2c_atmel.c                                 |    6=20
 drivers/char/tpm/tpm_i2c_infineon.c                              |    2=20
 drivers/char/tpm/tpm_i2c_nuvoton.c                               |    2=20
 drivers/char/tpm/tpm_ibmvtpm.c                                   |    8=20
 drivers/char/tpm/tpm_infineon.c                                  |    2=20
 drivers/char/tpm/tpm_nsc.c                                       |    2=20
 drivers/char/tpm/tpm_tis_core.c                                  |    2=20
 drivers/char/tpm/tpm_vtpm_proxy.c                                |    3=20
 drivers/char/tpm/xen-tpmfront.c                                  |    2=20
 drivers/clk/clk-twl6040.c                                        |   53 ++
 drivers/clk/ingenic/cgu.c                                        |   10=20
 drivers/clk/ingenic/cgu.h                                        |    2=20
 drivers/clk/samsung/clk-exynos5-subcmu.c                         |   13=20
 drivers/clk/uniphier/clk-uniphier-cpugear.c                      |    2=20
 drivers/clocksource/Kconfig                                      |   10=20
 drivers/clocksource/arm_arch_timer.c                             |   55 ++
 drivers/clocksource/exynos_mct.c                                 |   23=20
 drivers/cpufreq/pxa2xx-cpufreq.c                                 |    4=20
 drivers/cpufreq/qcom-cpufreq-kryo.c                              |   20=20
 drivers/cpufreq/tegra124-cpufreq.c                               |    2=20
 drivers/cpuidle/governor.c                                       |    1=20
 drivers/crypto/caam/caamalg.c                                    |    1=20
 drivers/crypto/caam/caamhash.c                                   |   93 +--
 drivers/crypto/ccree/cc_buffer_mgr.c                             |    8=20
 drivers/crypto/ccree/cc_cipher.c                                 |    7=20
 drivers/crypto/rockchip/rk3288_crypto.c                          |    2=20
 drivers/crypto/rockchip/rk3288_crypto.h                          |    4=20
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c               |   39 +
 drivers/crypto/rockchip/rk3288_crypto_ahash.c                    |    2=20
 drivers/dma/sh/usb-dmac.c                                        |    2=20
 drivers/gpio/gpio-pca953x.c                                      |    3=20
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c                 |    8=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c                 |    6=20
 drivers/gpu/drm/drm_fb_helper.c                                  |    4=20
 drivers/gpu/drm/radeon/evergreen_cs.c                            |    1=20
 drivers/hwtracing/intel_th/gth.c                                 |    4=20
 drivers/hwtracing/stm/core.c                                     |   11=20
 drivers/i2c/busses/i2c-tegra.c                                   |    8=20
 drivers/iio/adc/exynos_adc.c                                     |   19=20
 drivers/infiniband/hw/hfi1/hfi.h                                 |    2=20
 drivers/infiniband/hw/hfi1/init.c                                |   14=20
 drivers/infiniband/sw/rdmavt/qp.c                                |   59 +-
 drivers/irqchip/irq-brcmstb-l2.c                                 |   10=20
 drivers/irqchip/irq-gic-v3-its.c                                 |    2=20
 drivers/md/bcache/extents.c                                      |   13=20
 drivers/md/bcache/request.c                                      |    7=20
 drivers/md/bcache/writeback.h                                    |    3=20
 drivers/md/dm-integrity.c                                        |    8=20
 drivers/md/raid10.c                                              |    2=20
 drivers/md/raid5.c                                               |    2=20
 drivers/media/dvb-frontends/lgdt330x.c                           |    2=20
 drivers/media/i2c/cx25840/cx25840-core.c                         |    3=20
 drivers/media/i2c/cx25840/cx25840-core.h                         |    1=20
 drivers/media/i2c/ov5640.c                                       |    2=20
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c               |    2=20
 drivers/media/platform/vimc/Makefile                             |    3=20
 drivers/media/platform/vimc/vimc-capture.c                       |   18=20
 drivers/media/platform/vimc/vimc-common.c                        |   35 -
 drivers/media/platform/vimc/vimc-common.h                        |   15=20
 drivers/media/platform/vimc/vimc-debayer.c                       |   26 -
 drivers/media/platform/vimc/vimc-scaler.c                        |   28 -
 drivers/media/platform/vimc/vimc-sensor.c                        |   56 --
 drivers/media/platform/vimc/vimc-streamer.c                      |  188 ++=
+++++
 drivers/media/platform/vimc/vimc-streamer.h                      |   38 +
 drivers/media/usb/uvc/uvc_video.c                                |    8=20
 drivers/mfd/sm501.c                                              |    3=20
 drivers/misc/cxl/guest.c                                         |    2=20
 drivers/misc/cxl/pci.c                                           |   39 +
 drivers/misc/mei/bus.c                                           |   21=20
 drivers/misc/mei/hbm.c                                           |    7=20
 drivers/misc/vmw_balloon.c                                       |    5=20
 drivers/mmc/core/core.c                                          |    4=20
 drivers/mmc/host/renesas_sdhi_core.c                             |   11=20
 drivers/mmc/host/sdhci-esdhc-imx.c                               |    1=20
 drivers/net/dsa/lantiq_gswip.c                                   |   21=20
 drivers/net/wireless/marvell/libertas_tf/if_usb.c                |    2=20
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                 |    2=20
 drivers/nvdimm/label.c                                           |   23=20
 drivers/nvdimm/namespace_devs.c                                  |    4=20
 drivers/nvdimm/pfn_devs.c                                        |    4=20
 drivers/nvmem/core.c                                             |    4=20
 drivers/opp/core.c                                               |    2=20
 drivers/parport/parport_pc.c                                     |    2=20
 drivers/pci/controller/dwc/pcie-designware-host.c                |    2=20
 drivers/pci/controller/dwc/pcie-qcom.c                           |    2=20
 drivers/pci/controller/pci-aardvark.c                            |    2=20
 drivers/pci/controller/pci-mvebu.c                               |    2=20
 drivers/pci/hotplug/pciehp_hpc.c                                 |   17=20
 drivers/pci/pci-bridge-emul.c                                    |   86 ++-
 drivers/pci/pci-bridge-emul.h                                    |   13=20
 drivers/pci/pcie/dpc.c                                           |   27 +
 drivers/pci/probe.c                                              |   36 -
 drivers/power/supply/cpcap-charger.c                             |    1=20
 drivers/regulator/max77620-regulator.c                           |   10=20
 drivers/regulator/s2mpa01.c                                      |   10=20
 drivers/regulator/s2mps11.c                                      |    6=20
 drivers/s390/crypto/vfio_ap_drv.c                                |   44 +
 drivers/s390/crypto/vfio_ap_ops.c                                |    4=20
 drivers/s390/crypto/vfio_ap_private.h                            |    1=20
 drivers/s390/virtio/virtio_ccw.c                                 |    4=20
 drivers/scsi/aacraid/linit.c                                     |   13=20
 drivers/scsi/qla2xxx/qla_init.c                                  |   99 --=
--
 drivers/scsi/qla2xxx/qla_isr.c                                   |    2=20
 drivers/scsi/qla2xxx/qla_os.c                                    |    2=20
 drivers/scsi/sd.c                                                |   59 ++
 drivers/scsi/virtio_scsi.c                                       |    2=20
 drivers/soc/qcom/rpmh.c                                          |   34 -
 drivers/spi/spi-gpio.c                                           |    4=20
 drivers/spi/spi-omap2-mcspi.c                                    |    4=20
 drivers/spi/spi-pxa2xx.c                                         |    1=20
 drivers/spi/spi-ti-qspi.c                                        |    6=20
 drivers/staging/media/imx/imx-ic-prpencvf.c                      |   26 -
 drivers/staging/media/imx/imx-media-csi.c                        |   44 +
 drivers/target/iscsi/iscsi_target.c                              |    4=20
 drivers/tty/serial/8250/8250_of.c                                |    4=20
 drivers/tty/serial/8250/8250_pci.c                               |  141 ++=
+++
 drivers/tty/serial/xilinx_uartps.c                               |    8=20
 drivers/tty/vt/vt.c                                              |   15=20
 drivers/usb/chipidea/ci_hdrc_tegra.c                             |    1=20
 drivers/usb/typec/tps6598x.c                                     |   26 -
 fs/9p/v9fs_vfs.h                                                 |   23=20
 fs/9p/vfs_file.c                                                 |    6=20
 fs/9p/vfs_inode.c                                                |   23=20
 fs/9p/vfs_inode_dotl.c                                           |   27 -
 fs/9p/vfs_super.c                                                |    4=20
 fs/btrfs/acl.c                                                   |    9=20
 fs/btrfs/dev-replace.c                                           |    1=20
 fs/btrfs/disk-io.c                                               |    8=20
 fs/btrfs/extent_io.c                                             |    4=20
 fs/btrfs/ioctl.c                                                 |   21=20
 fs/btrfs/scrub.c                                                 |   24 -
 fs/btrfs/volumes.c                                               |    4=20
 fs/cifs/cifs_fs_sb.h                                             |    1=20
 fs/cifs/cifsfs.c                                                 |    1=20
 fs/cifs/cifsglob.h                                               |   20=20
 fs/cifs/cifssmb.c                                                |   17=20
 fs/cifs/connect.c                                                |   26 +
 fs/cifs/file.c                                                   |   12=20
 fs/cifs/inode.c                                                  |    2=20
 fs/cifs/smb2misc.c                                               |   17=20
 fs/cifs/smb2ops.c                                                |   28 +
 fs/cifs/smb2transport.c                                          |   14=20
 fs/cifs/transport.c                                              |    6=20
 fs/dax.c                                                         |   19=20
 fs/devpts/inode.c                                                |    1=20
 fs/ext2/super.c                                                  |   39 +
 fs/ext4/ext4.h                                                   |    3=20
 fs/ext4/ioctl.c                                                  |  100 ++=
+-
 fs/ext4/resize.c                                                 |    3=20
 fs/jbd2/transaction.c                                            |   33 -
 fs/kernfs/mount.c                                                |    8=20
 fs/nfs/nfs4proc.c                                                |   12=20
 fs/nfs/pagelist.c                                                |   29 -
 fs/nfsd/nfs3proc.c                                               |   16=20
 fs/nfsd/nfs3xdr.c                                                |    1=20
 fs/nfsd/nfs4state.c                                              |    8=20
 fs/nfsd/nfsctl.c                                                 |    2=20
 fs/overlayfs/copy_up.c                                           |   59 +-
 fs/overlayfs/overlayfs.h                                         |    2=20
 fs/overlayfs/util.c                                              |   55 +-
 fs/pipe.c                                                        |   14=20
 fs/splice.c                                                      |    4=20
 include/asm-generic/vmlinux.lds.h                                |    2=20
 include/linux/device-mapper.h                                    |    2=20
 include/linux/dma-mapping.h                                      |    8=20
 include/linux/hardirq.h                                          |    7=20
 include/linux/kvm_host.h                                         |    2=20
 include/linux/pipe_fs_i.h                                        |    1=20
 include/linux/property.h                                         |    2=20
 include/linux/swiotlb.h                                          |   11=20
 kernel/cgroup/cgroup.c                                           |    9=20
 kernel/dma/direct.c                                              |   11=20
 kernel/dma/mapping.c                                             |   14=20
 kernel/dma/swiotlb.c                                             |   14=20
 kernel/rcu/tree.c                                                |   19=20
 kernel/sysctl.c                                                  |   11=20
 kernel/trace/trace.c                                             |    1=20
 kernel/trace/trace_event_perf.c                                  |   16=20
 kernel/trace/trace_events_hist.c                                 |    5=20
 mm/memory-failure.c                                              |   14=20
 mm/memory.c                                                      |    5=20
 mm/vmalloc.c                                                     |    2=20
 net/9p/client.c                                                  |    2=20
 net/sunrpc/clnt.c                                                |  124 ++=
+--
 net/sunrpc/svcsock.c                                             |   20=20
 security/selinux/hooks.c                                         |    8=20
 sound/soc/codecs/pcm186x.c                                       |    8=20
 sound/soc/fsl/fsl_esai.c                                         |    7=20
 tools/perf/util/auxtrace.c                                       |    4=20
 tools/perf/util/auxtrace.h                                       |    3=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c              |   37 +
 tools/perf/util/intel-pt.c                                       |    2=20
 tools/perf/util/symbol.c                                         |    2=20
 virt/kvm/arm/mmu.c                                               |    2=20
 virt/kvm/kvm_main.c                                              |    7=20
 278 files changed, 3048 insertions(+), 1608 deletions(-)

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

Alexander Shishkin (2):
      stm class: Prevent division by zero
      intel_th: Don't reference unassigned outputs

Alexander Usyskin (2):
      mei: hbm: clean the feature flags on link reset
      mei: bus: move hw module get/put to probe/release

Anand Jain (1):
      btrfs: scrub: fix circular locking dependency warning

Andy Shevchenko (2):
      ACPI / device_sysfs: Avoid OF modalias creation for removed device
      spi: pxa2xx: Setup maximum supported DMA transfer length

Aneesh Kumar K.V (1):
      powerpc/hugetlb: Don't do runtime allocation of 16G pages in LPAR con=
figuration

Anssi Hannula (1):
      serial: uartps: Fix stuck ISR if RX disabled with non-empty FIFO

Ard Biesheuvel (4):
      crypto: arm/crct10dif - revert to C code for short inputs
      crypto: arm64/crct10dif - revert to C code for short inputs
      crypto: arm64/aes-ccm - fix logical bug in AAD MAC handling
      crypto: arm64/aes-ccm - fix bugs in non-NEON fallback routine

Arnd Bergmann (1):
      cpufreq: pxa2xx: remove incorrect __init annotation

BOUGH CHEN (1):
      mmc: sdhci-esdhc-imx: fix HS400 timing issue

Bart Van Assche (1):
      scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock

Bartosz Golaszewski (1):
      nvmem: core: don't check the return value of notifier chain call

Ben Gardon (1):
      Revert "KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()"

Bjorn Andersson (1):
      PCI: qcom: Don't deassert reset GPIO during probe

Bjorn Helgaas (1):
      PCI/ASPM: Use LTR if already enabled by platform

Chen-Yu Tsai (1):
      media: sun6i: Fix CSI regmap's max_register

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

Cody P Schafer (1):
      media: cx25840: mark pad sig_types to fix cx231xx init

Coly Li (1):
      bcache: use (REQ_META|REQ_PRIO) to indicate bio for metadata

Corey Minyard (1):
      ipmi_si: Fix crash when using hard-coded device

Dan Carpenter (2):
      vmw_balloon: release lock on error in vmballoon_reset()
      btrfs: drop the lock on error in btrfs_dev_replace_cancel

Dan Robertson (1):
      btrfs: init csum_list before possible free

Dan Williams (6):
      nfit: Fix nfit_intel_shutdown_status() command submission
      acpi/nfit: Fix bus command validation
      nfit/ars: Attempt a short-ARS whenever the ARS state is idle at boot
      nfit/ars: Attempt short-ARS even in the no_init_ars case
      libnvdimm/label: Clear 'updating' flag after label-set update
      libnvdimm/pmem: Honor force_raw for legacy pmem regions

Daniel Axtens (1):
      bcache: never writeback a discard operation

Dave Martin (1):
      arm64: KVM: Fix architecturally invalid reset value for FPEXC32_EL2

Dexuan Cui (1):
      nfit: acpi_nfit_ctl(): Check out_obj->type in the right place

Dmitry Osipenko (1):
      usb: chipidea: tegra: Fix missed ci_hdrc_remove_device()

Dongdong Liu (1):
      PCI/DPC: Fix print AER status in DPC event handling

Doug Berger (1):
      irqchip/brcmstb-l2: Use _irqsave locking variants in non-interrupt co=
de

Eric Biggers (15):
      crypto: cfb - add missing 'chunksize' property
      crypto: cfb - remove bogus memcpy() with src =3D=3D dest
      crypto: ofb - fix handling partial blocks and make thread-safe
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

Evan Quan (1):
      drm/amd/powerplay: correct power reading on fiji

Felipe Franciosi (1):
      scsi: virtio_scsi: don't send sc payload with tmfs

Felix Fietkau (1):
      mt76: fix corrupted software generated tx CCMP PN

Filipe Manana (4):
      Btrfs: setup a nofs context for memory allocation at btrfs_create_tre=
e()
      Btrfs: setup a nofs context for memory allocation at __btrfs_set_acl
      Btrfs: fix corruption reading shared and compressed extents after hol=
e punching
      Btrfs: fix deadlock between clone/dedupe and rename

Finn Thain (1):
      m68k: Add -ffreestanding to CFLAGS

Franck LENORMAND (1):
      crypto: caam - fix hash context DMA unmap size

French, Nicholas A (1):
      media: lgdt330x: fix lock status reporting

Gilad Ben-Yossef (2):
      crypto: ccree - unmap buffer before copying IV
      crypto: ccree - don't copy zero size ciphertext

Giridhar Malavali (1):
      scsi: qla2xxx: Avoid PCI IRQ affinity mapping when multiqueue is not =
supported

Greg Kroah-Hartman (2):
      stable-kernel-rules.rst: add link to networking patch queue
      Linux 5.0.4

Gustavo A. R. Silva (4):
      crypto: ccree - fix missing break in switch statement
      ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify
      mfd: sm501: Fix potential NULL pointer dereference
      drm/radeon/evergreen_cs: fix missing break in switch statement

Hadar Gat (1):
      crypto: ccree - fix free of unallocated mlli buffer

Halil Pasic (1):
      s390/virtio: handle find on invalid queue gracefully

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

J. Bruce Fields (3):
      security/selinux: fix SECURITY_LSM_NATIVE_LABELS on reused superblock
      nfsd: fix performance-limiting session calculation
      svcrpc: fix UDP on servers with lots of threads

Jan Kara (2):
      ext4: fix crash during online resizing
      ext2: Fix underflow in ext2_max_size()

Jan Stancek (1):
      mm/memory.c: do_fault: avoid usage of stale vm_area_struct

Jann Horn (2):
      tracing/perf: Use strndup_user() instead of buggy open-coded version
      splice: don't merge into linked buffers

Jarkko Sakkinen (2):
      tpm/tpm_crb: Avoid unaligned reads in crb_recv()
      tpm: Unify the send callback behaviour

Jay Dolan (2):
      serial: 8250_pci: Fix number of ports for ACCES serial cards
      serial: 8250_pci: Have ACCES cards that use the four port Pericom PI7=
C9X7954 chip use the pci_pericom_setup()

Jiong Wu (1):
      mmc:fix a bug when max_discard is 0

Joerg Roedel (3):
      dma: Introduce dma_max_mapping_size()
      swiotlb: Introduce swiotlb_max_mapping_size()
      swiotlb: Add is_swiotlb_active() function

Johan Hovold (2):
      net: dsa: lantiq_gswip: fix use-after-free on failed probe
      net: dsa: lantiq_gswip: fix OF child-node lookups

Johannes Thumshirn (1):
      btrfs: ensure that a DUP or RAID1 block group has exactly two stripes

Jordan Niethe (1):
      powerpc/powernv: Make opal log only readable by root

Josh Poimboeuf (1):
      x86/unwind/orc: Fix ORC unwind table alignment

Juergen Gross (1):
      xen: fix dom0 boot on huge systems

Julien Thierry (1):
      arm64: Fix HCR.TGE status for NMI contexts

Kan Liang (1):
      perf/x86/intel/uncore: Fix client IMC events return huge result

Krzysztof Kozlowski (5):
      iio: adc: exynos-adc: Fix NULL pointer exception on unbind
      iio: adc: exynos-adc: Use proper number of channels for Exynos4x12
      regulator: s2mps11: Fix steps for buck7, buck8 and LDO35
      clk: samsung: exynos5: Fix possible NULL pointer exception on platfor=
m_device_alloc() failure
      clk: samsung: exynos5: Fix kfree() of const memory on setting driver_=
override

Kunihiko Hayashi (1):
      clk: uniphier: Fix update register for CPU-gear

Loic Poulain (1):
      media: i2c: ov5640: Fix post-reset delay

Lubomir Rintel (2):
      libertas_tf: don't set URB_ZERO_PACKET on IN USB transfer
      serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart

Lucas A. M. Magalh=C3=A3es (1):
      media: vimc: Add vimc-streamer for stream control

Lucas Stach (1):
      PCI: dwc: skip MSI init if MSIs have been explicitly disabled

Mark Cave-Ayland (1):
      powerpc: Fix 32-bit KVM-PR lockup and host crash with MacOS guest

Mark Walton (1):
      gpio: pca953x: Fix dereference of irq data in shutdown

Mark Zhang (1):
      regulator: max77620: Initialize values for DT properties

Martin K. Petersen (1):
      scsi: sd: Optimal I/O size should be a multiple of physical block size

Martin Schwidefsky (2):
      s390/setup: fix early warning messages
      s390/setup: fix boot crash for machine without EDAT-1

Masami Hiramatsu (1):
      x86/kprobes: Prohibit probing on optprobe template code

Matthew Wilcox (1):
      dax: Flush partial PMDs correctly

Michael Ellerman (2):
      powerpc/kvm: Save and restore host AMR/IAMR/UAMOR
      powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning

Michael J. Ruhl (2):
      IB/hfi1: Close race condition on user context disable and close
      IB/rdmavt: Fix concurrency panics in QP post_send and modify to error

Mika Westerberg (1):
      PCI: pciehp: Disable Data Link Layer State Changed event on suspend

Mike Marciniszyn (1):
      IB/rdmavt: Fix loopback send with invalidate ordering

Mikulas Patocka (1):
      dm integrity: limit the rate of error messages

NeilBrown (2):
      dm: fix to_sector() for 32bit
      nfsd: fix memory corruption caused by readdir

Nicholas Piggin (3):
      powerpc/64s/hash: Fix assert_slb_presence() use of the slbfee. instru=
ction
      powerpc/smp: Fix NMI IPI timeout
      powerpc/smp: Fix NMI IPI xmon timeout

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

Paul Mackerras (1):
      powerpc/powernv: Don't reprogram SLW image on every KVM guest entry/e=
xit

Pavel Machek (1):
      cpcap-charger: generate events for userspace

Pavel Shilovsky (4):
      CIFS: Fix leaking locked VFS cache pages in writeback retry
      CIFS: Do not reset lease state to NONE on lease break
      CIFS: Do not skip SMB2 message IDs on send failures
      CIFS: Fix read after write for files with read caching

Pavel Tatashin (1):
      x86/kvmclock: set offset for kvm unstable clock

Phuong Nguyen (1):
      dmaengine: usb-dmac: Make DMAC system sleep callbacks explicit

Pierre Morel (1):
      s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem

QiaoChong (1):
      parport_pc: fix find_superio io compare code, should use equal test.

Quinn Tran (1):
      scsi: qla2xxx: Use complete switch scan for RSCN events

Rafael J. Wysocki (1):
      cpuidle: governor: Add new governors to cpuidle_governors again

Roman Penyaev (1):
      mm/vmalloc: fix size check for remap_vmalloc_range_partial()

Russell King (1):
      spi: spi-gpio: fix SPI_CS_HIGH capability

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

Sean Christopherson (9):
      KVM: Call kvm_arch_memslots_updated() before updating memslots
      KVM: VMX: Compare only a single byte for VMCS' "launched" in vCPU-run
      KVM: VMX: Zero out *all* general purpose registers after VM-Exit
      KVM: x86/mmu: Detect MMIO generation wrap in any address space
      KVM: x86/mmu: Do not cache MMIO accesses while memslots are in flux
      KVM: nVMX: Sign extend displacements of VMX instr's mem operands
      KVM: nVMX: Apply addr size mask to effective address for VMX instruct=
ions
      KVM: nVMX: Ignore limit checks on VMX instructions using flat segments
      KVM: nVMX: Check a single byte for VMCS "launched" in nested early ch=
ecks

Sowjanya Komatineni (2):
      i2c: tegra: fix maximum transfer size
      i2c: tegra: update maximum transfer size

Stephen Boyd (1):
      soc: qcom: rpmh: Avoid accessing freed memory from batch API

Steve French (1):
      smb3: make default i/o size for smb3 mounts larger

Steve Longerbeam (4):
      media: imx: prpencvf: Stop upstream before disabling IDMA channel
      media: imx-csi: Input connections to CSI should be optional
      media: imx: csi: Disable CSI immediately after last EOF
      media: imx: csi: Stop upstream before disabling IDMA channel

Steven Rostedt (VMware) (1):
      x86/ftrace: Fix warning and considate ftrace_jmp_replace() and ftrace=
_call_replace()

Stuart Menefy (3):
      regulator: s2mpa01: Fix step values for some LDOs
      clocksource/drivers/exynos_mct: Move one-shot check from tick clear t=
o ISR
      clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown

Takeshi Saito (1):
      mmc: renesas_sdhi: Fix card initialization failure in high speed mode

Tang Junhui (1):
      bcache: treat stale && dirty keys as bad keys

Thomas Petazzoni (2):
      PCI: pci-bridge-emul: Create per-bridge copy of register behavior
      PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags

Tom Zanussi (1):
      tracing: Use strncpy instead of memcpy for string keys in hist trigge=
rs

Tony Lindgren (1):
      clk: clk-twl6040: Fix imprecise external abort for pdmclk

Trond Myklebust (7):
      NFS: Fix I/O request leakages
      NFS: Fix an I/O request leakage in nfs_do_recoalesce
      NFS: Don't recoalesce on error in nfs_pageio_complete_mirror()
      NFSv4.1: Reinitialise sequence results before retransmitting a request
      SUNRPC: Prevent thundering herd when the socket is not connected
      SUNRPC: Fix up RPC back channel transmission
      SUNRPC: Respect RPC call timeouts when retrying transmission

Vaibhav Jain (1):
      cxl: Wrap iterations over afu slices inside 'afu_list_lock'

Varad Gautam (1):
      fs/devpts: always delete dcache dentry-s in dput()

Vignesh R (2):
      spi: ti-qspi: Fix mmap read when more than one CS in use
      spi: omap2-mcspi: Fix DMA and FIFO event trigger size mismatch

Viresh Kumar (3):
      cpufreq: kryo: Release OPP tables on module removal
      PM / wakeup: Rework wakeup source timer cancellation
      PM / OPP: Update performance state when freq =3D=3D old_freq

Vivek Goyal (2):
      ovl: During copy up, first copy up data and then xattrs
      ovl: Do not lose security.capability xattr over metadata file copy-up

Wei Yang (1):
      libnvdimm, pfn: Fix over-trim in trim_pfn_device()

Will Deacon (2):
      arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug sign=
als
      arm64: debug: Ensure debug handlers check triggering exception level

Xin Long (1):
      selinux: add the missing walk_size + len check in selinux_sctp_bind_c=
onnect

Yang Yingliang (1):
      ipmi_si: fix use-after-free of resource->name

Yangtao Li (1):
      cpufreq: tegra124: add missing of_node_put()

Yihao Wu (1):
      nfsd: fix wrong check in write_v4_end_grace()

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


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyXQ88ACgkQONu9yGCS
aT5WKxAAy63EBERnlr47qYCeOdS952n4kOUT7uhyyd9O124TCTPYx5+buJlYXUdL
Yeyw2mFvBBCe4aw16wMwNOb+OjwVif3UXokUuaNkm0OWmqcSujcP2tJMqe991IoV
Tyw/T/zlaYwApgROjWuUDmShDxmS5pFGOH0PhJdYa0/LOyYk+SHshBR15RFpD8X2
IrRZtkqTjLTKeYlMZrqPEzJW3BMEGoDNSsJkeX99T4XRLRn0W1VMrnU9lv1/5H7G
5v5ELDWzJgL3bIZ3+B5T8iOv9La8wa+gqzsUbV9lLuvs9Mds5b5DgdScRH8sPtYi
1kIXRpSpJKm+a4z1MHQjSZgYPnIeJFU23i0eXBDajNERBbDLLeIs0zt3veJ9cp2y
OL31/qWzjXBanusMnzO3r/ieXeGOuP4+Q1xbLi6YjYU29GMY4UkCiONrwwYNJLGs
+8SyMxBneAJuDYQHSU0TykkHe2HuX2mencgIF5hfIiIGdsUcjLjMKFW2kCVzFnu3
22Opj17fQm4qhOEpOfbopDhb6KjVrpjk/GcUi+c2Ki6e1tQIQ+o0qg0ngyPgCsJn
vI5isrENk5LnH2qK9fA0KcwNgnb5xUclKnYxgQxL8poKkYg7J7DbAa9RNQxQunxx
L/rbHPUPbdt7On54k5j7F+ay9AUfDum3OLb6crm7EO4ppwtizyU=
=VYPr
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
