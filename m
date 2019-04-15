Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E2DC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36332087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353690;
	bh=ABEVtLe1k0Lm+qR9wBjax6SPgVeiuvHxV5lenbeuZUs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CuOtGzoMRFdWFqsPvClML3arOTfGuri7wzkhGg1O1hK7/hlFlqqjOP3OH/LfVHA8Z
	 GRiMc8OvGAMWiPW/dZz3agWlCs0tHp/ozKX2QnaqcfjfdbNbVhKIr5gWq1X9WPXRsC
	 r4yslSnFu08ff6xvGZEy6EISsxJhLs6s5/uJNcZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfDOSl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfDOSl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:41:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99D612087C;
        Mon, 15 Apr 2019 18:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353686;
        bh=ABEVtLe1k0Lm+qR9wBjax6SPgVeiuvHxV5lenbeuZUs=;
        h=Date:From:To:Cc:Subject:From;
        b=AZSUS1Mn4WzcQ2W25p2UHcBaiMZ6TOUAqFkDneOeRDEqt1bTzVg+et+/P0JG8xpqT
         mmm5Js/yJ9ignoCyQ5msckTFer1vlqRtJ0tLwaS1AChQNpW11vohNOHkAk3RqtQmSm
         m+7Ygiro8EfkmRebcy0wJISamT4w1jtGrQp7PEnE=
Date:   Mon, 15 Apr 2019 20:41:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 5.0.7
Message-ID: <20190415184123.GA20716@kroah.com>
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

I'm announcing the release of the 5.0.7 kernel.

(sorry I forgot to send these out last week, my fault, the kernels were
released, but the email did not get sent...)

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

 Documentation/arm/kernel_mode_neon.txt                      |    4=20
 Makefile                                                    |   69 +++++++=
----
 arch/arm/boot/dts/lpc32xx.dtsi                              |   18 +--
 arch/arm/boot/dts/meson8b.dtsi                              |    6 -
 arch/arm/include/asm/barrier.h                              |    2=20
 arch/arm/include/asm/processor.h                            |    6 -
 arch/arm/include/asm/v7m.h                                  |    2=20
 arch/arm/kernel/entry-header.S                              |    3=20
 arch/arm/kernel/entry-v7m.S                                 |    4=20
 arch/arm/kernel/machine_kexec.c                             |    5=20
 arch/arm/kernel/smp.c                                       |    4=20
 arch/arm/kernel/unwind.c                                    |   14 +-
 arch/arm/lib/Makefile                                       |    2=20
 arch/arm/lib/xor-neon.c                                     |    2=20
 arch/arm/mach-omap2/prm_common.c                            |    4=20
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c          |    5=20
 arch/arm/mm/copypage-v4mc.c                                 |    3=20
 arch/arm/mm/copypage-v4wb.c                                 |    3=20
 arch/arm/mm/copypage-v4wt.c                                 |    3=20
 arch/arm/mm/proc-v7m.S                                      |    3=20
 arch/h8300/Makefile                                         |    2=20
 arch/powerpc/include/asm/topology.h                         |    2=20
 arch/powerpc/kernel/entry_64.S                              |    7 +
 arch/powerpc/kernel/ptrace.c                                |    8 +
 arch/powerpc/mm/hugetlbpage-radix.c                         |    5=20
 arch/powerpc/mm/numa.c                                      |    9 -
 arch/powerpc/platforms/44x/Kconfig                          |    1=20
 arch/powerpc/platforms/powernv/pci-ioda-tce.c               |    1=20
 arch/powerpc/platforms/powernv/pci-ioda.c                   |    7 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c                |   19 +++
 arch/powerpc/xmon/ppc-dis.c                                 |    2=20
 arch/s390/kernel/perf_cpum_sf.c                             |    6 -
 arch/x86/boot/Makefile                                      |    2=20
 arch/x86/events/intel/bts.c                                 |    4=20
 arch/x86/events/intel/pt.c                                  |    5=20
 arch/x86/hyperv/hv_init.c                                   |    7 +
 arch/x86/include/asm/uaccess.h                              |   24 ++--
 arch/x86/kernel/kexec-bzimage64.c                           |    4=20
 arch/x86/kernel/vmlinux.lds.S                               |    2=20
 arch/x86/lib/usercopy_32.c                                  |    8 -
 arch/x86/platform/efi/quirks.c                              |    4=20
 arch/x86/realmode/rm/Makefile                               |    2=20
 block/bfq-iosched.c                                         |   22 ++-
 block/bfq-iosched.h                                         |    3=20
 block/bfq-wf2q.c                                            |    6 -
 drivers/acpi/acpi_video.c                                   |   20 ++-
 drivers/block/loop.c                                        |   21 ++-
 drivers/cdrom/cdrom.c                                       |    7 -
 drivers/char/hpet.c                                         |    2=20
 drivers/char/hw_random/virtio-rng.c                         |    2=20
 drivers/clk/clk-fractional-divider.c                        |    2=20
 drivers/clk/meson/meson-aoclk.c                             |   15 +-
 drivers/clk/rockchip/clk-rk3328.c                           |   12 +-
 drivers/clk/ti/clkctrl.c                                    |    2=20
 drivers/cpufreq/acpi-cpufreq.c                              |    4=20
 drivers/crypto/amcc/crypto4xx_trng.c                        |    4=20
 drivers/crypto/cavium/zip/zip_main.c                        |    6 -
 drivers/dma/imx-dma.c                                       |    2=20
 drivers/dma/qcom/hidma.c                                    |   19 +--
 drivers/dma/tegra20-apb-dma.c                               |    5=20
 drivers/firmware/efi/cper.c                                 |   13 +-
 drivers/firmware/efi/libstub/arm-stub.c                     |    5=20
 drivers/firmware/efi/libstub/efi-stub-helper.c              |   10 +
 drivers/firmware/efi/libstub/efistub.h                      |    1=20
 drivers/firmware/efi/libstub/fdt.c                          |    3=20
 drivers/firmware/efi/memattr.c                              |    2=20
 drivers/firmware/efi/runtime-wrappers.c                     |   48 ++++----
 drivers/gpio/gpio-omap.c                                    |   14 +-
 drivers/gpio/gpiolib-of.c                                   |    3=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |   60 +++++++=
+--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c       |   42 +++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |    1=20
 drivers/gpu/drm/amd/display/dc/core/dc.c                    |    3=20
 drivers/gpu/drm/amd/display/dc/core/dc_link.c               |    1=20
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c   |    7 -
 drivers/gpu/drm/drm_dp_mst_topology.c                       |    1=20
 drivers/gpu/drm/drm_fb_helper.c                             |    2=20
 drivers/gpu/drm/drm_mode_object.c                           |    1=20
 drivers/gpu/drm/drm_plane.c                                 |    3=20
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c                    |   36 +++---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c                   |    4=20
 drivers/gpu/drm/rcar-du/rcar_du_kms.c                       |    2=20
 drivers/gpu/drm/scheduler/sched_entity.c                    |   39 ++++--
 drivers/gpu/drm/vkms/vkms_crtc.c                            |   21 +--
 drivers/hid/intel-ish-hid/ipc/ipc.c                         |    9 +
 drivers/hid/intel-ish-hid/ishtp/bus.c                       |    4=20
 drivers/hwtracing/coresight/coresight-etm-perf.c            |    6 -
 drivers/hwtracing/coresight/coresight-etm4x.c               |    3=20
 drivers/i2c/busses/i2c-designware-core.h                    |    2=20
 drivers/i2c/busses/i2c-designware-master.c                  |    6 +
 drivers/i2c/busses/i2c-designware-pcidrv.c                  |    7 +
 drivers/i2c/busses/i2c-designware-platdrv.c                 |    3=20
 drivers/i2c/i2c-core-base.c                                 |    9 -
 drivers/i2c/i2c-core-of.c                                   |   14 ++
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                         |   10 -
 drivers/infiniband/hw/cxgb4/cm.c                            |    5=20
 drivers/infiniband/hw/mlx4/cm.c                             |    2=20
 drivers/input/misc/soc_button_array.c                       |    2=20
 drivers/iommu/intel-iommu.c                                 |    3=20
 drivers/iommu/io-pgtable-arm-v7s.c                          |    3=20
 drivers/leds/leds-lp55xx-common.c                           |    4=20
 drivers/md/bcache/sysfs.c                                   |   25 +++-
 drivers/md/bcache/sysfs.h                                   |   13 +-
 drivers/md/dm-thin.c                                        |   13 ++
 drivers/media/i2c/mt9m111.c                                 |    2=20
 drivers/media/i2c/ov7740.c                                  |    7 -
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c             |   40 +++---
 drivers/media/platform/mx2_emmaprp.c                        |    6 -
 drivers/media/platform/rcar-vin/rcar-core.c                 |    8 +
 drivers/media/platform/rockchip/rga/rga.c                   |    6 -
 drivers/media/platform/s5p-g2d/g2d.c                        |    6 -
 drivers/media/platform/s5p-jpeg/jpeg-core.c                 |   57 +++++--=
--
 drivers/media/platform/sh_veu.c                             |    4=20
 drivers/mmc/host/omap.c                                     |    2=20
 drivers/net/dsa/mv88e6xxx/chip.c                            |    8 +
 drivers/net/dsa/mv88e6xxx/port.c                            |    2=20
 drivers/net/ethernet/cisco/enic/enic_main.c                 |    6 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c      |   36 +++---
 drivers/net/ethernet/intel/e1000e/netdev.c                  |   21 +--
 drivers/net/ethernet/intel/ice/ice_switch.c                 |   15 ++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c             |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c        |    3=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c           |   17 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c              |    4=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c           |    6 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c            |    2=20
 drivers/net/phy/phy-c45.c                                   |   10 +
 drivers/net/phy/phy_device.c                                |   13 +-
 drivers/net/veth.c                                          |    3=20
 drivers/net/wireless/ath/ath10k/ce.c                        |   26 ++--
 drivers/net/wireless/ath/ath10k/ce.h                        |    2=20
 drivers/net/wireless/ath/ath10k/debugfs_sta.c               |    7 -
 drivers/net/wireless/ath/ath10k/htt_rx.c                    |   12 +-
 drivers/net/wireless/ath/ath10k/wmi.h                       |    2=20
 drivers/net/wireless/ath/wil6210/cfg80211.c                 |   14 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c   |    2=20
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                 |   20 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                |   11 +
 drivers/net/wireless/marvell/mwifiex/cfg80211.c             |   10 +
 drivers/net/wireless/mediatek/mt76/eeprom.c                 |   24 ++--
 drivers/net/wireless/mediatek/mt76/usb.c                    |   11 -
 drivers/net/wireless/mediatek/mt7601u/eeprom.h              |    2=20
 drivers/net/wireless/ti/wlcore/main.c                       |    7 -
 drivers/nvme/host/fc.c                                      |    5=20
 drivers/nvme/target/core.c                                  |   20 +--
 drivers/pci/controller/pcie-mediatek.c                      |    5=20
 drivers/pci/hotplug/pciehp_hpc.c                            |    2=20
 drivers/pci/pcie/pme.c                                      |   22 ++-
 drivers/perf/arm_spe_pmu.c                                  |    6 -
 drivers/pinctrl/meson/pinctrl-meson.c                       |   22 ++-
 drivers/pinctrl/meson/pinctrl-meson8b.c                     |    6 -
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c                       |   32 +++--
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c                       |   11 +
 drivers/platform/mellanox/mlxreg-hotplug.c                  |    5=20
 drivers/platform/x86/ideapad-laptop.c                       |    2=20
 drivers/platform/x86/intel-hid.c                            |    7 -
 drivers/platform/x86/intel_pmc_core.c                       |    3=20
 drivers/platform/x86/intel_pmc_core.h                       |    2=20
 drivers/regulator/act8865-regulator.c                       |    5=20
 drivers/regulator/core.c                                    |    2=20
 drivers/regulator/mcp16502.c                                |    1=20
 drivers/s390/net/ism_drv.c                                  |   12 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                           |    2=20
 drivers/scsi/fcoe/fcoe.c                                    |    2=20
 drivers/scsi/fcoe/fcoe_ctlr.c                               |    7 -
 drivers/scsi/fcoe/fcoe_transport.c                          |    2=20
 drivers/scsi/hisi_sas/hisi_sas_main.c                       |   13 ++
 drivers/scsi/megaraid/megaraid_sas_base.c                   |    1=20
 drivers/scsi/qedf/qedf_main.c                               |    2=20
 drivers/scsi/scsi_scan.c                                    |    6 -
 drivers/soc/qcom/qcom_gsbi.c                                |    7 -
 drivers/soc/tegra/fuse/fuse-tegra.c                         |   12 +-
 drivers/staging/iio/addac/adt7316.c                         |   18 +--
 drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c |    6 -
 drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c |    6 -
 drivers/staging/mt7621-spi/spi-mt7621.c                     |    7 +
 drivers/tty/serial/8250/8250_pxa.c                          |    4=20
 drivers/tty/tty_buffer.c                                    |    2=20
 drivers/usb/chipidea/core.c                                 |    9 +
 drivers/usb/dwc3/gadget.c                                   |    2=20
 drivers/usb/gadget/function/f_fs.c                          |    1=20
 drivers/video/backlight/pwm_bl.c                            |    2=20
 drivers/video/fbdev/core/fbmem.c                            |    3=20
 drivers/xen/gntdev-dmabuf.c                                 |   12 +-
 drivers/xen/gntdev-dmabuf.h                                 |    2=20
 drivers/xen/gntdev.c                                        |    2=20
 fs/btrfs/extent-tree.c                                      |   71 +++++++=
-----
 fs/btrfs/qgroup.c                                           |   28 ++--
 fs/buffer.c                                                 |    7 +
 fs/cifs/cifs_dfs_ref.c                                      |    4=20
 fs/cifs/connect.c                                           |    5=20
 fs/cifs/file.c                                              |   14 ++
 fs/cifs/smb1ops.c                                           |    2=20
 fs/cifs/smb2pdu.c                                           |   10 +
 fs/ext4/extents.c                                           |   17 +-
 fs/ext4/indirect.c                                          |   47 +++----
 fs/f2fs/extent_cache.c                                      |    2=20
 fs/f2fs/f2fs.h                                              |    1=20
 fs/f2fs/inline.c                                            |    8 +
 fs/f2fs/super.c                                             |   17 +-
 fs/f2fs/sysfs.c                                             |   12 +-
 fs/f2fs/trace.c                                             |   20 ++-
 fs/f2fs/xattr.c                                             |   13 +-
 fs/file.c                                                   |    1=20
 fs/jbd2/commit.c                                            |    6 -
 fs/jbd2/journal.c                                           |   52 ++++----
 fs/ocfs2/cluster/nodemanager.c                              |   14 +-
 fs/read_write.c                                             |    6 +
 include/linux/atalk.h                                       |   18 ++-
 include/linux/cgroup-defs.h                                 |    2=20
 include/linux/cgroup.h                                      |    2=20
 include/linux/clk-provider.h                                |    3=20
 include/linux/efi.h                                         |   26 ++--
 include/linux/f2fs_fs.h                                     |   13 +-
 include/linux/filter.h                                      |    4=20
 include/linux/i2c.h                                         |    1=20
 include/linux/irqdesc.h                                     |    1=20
 include/linux/kasan-checks.h                                |    2=20
 include/linux/perf_event.h                                  |    2=20
 include/linux/relay.h                                       |    2=20
 include/linux/ring_buffer.h                                 |    2=20
 include/linux/sched.h                                       |    4=20
 include/linux/sched/topology.h                              |    8 -
 include/net/netfilter/br_netfilter.h                        |    1=20
 include/scsi/libfcoe.h                                      |    4=20
 kernel/audit.h                                              |    4=20
 kernel/audit_tree.c                                         |   19 +--
 kernel/auditsc.c                                            |   12 +-
 kernel/cgroup/cgroup.c                                      |   15 +-
 kernel/cgroup/pids.c                                        |    4=20
 kernel/cgroup/rstat.c                                       |   10 +
 kernel/cpu.c                                                |    9 +
 kernel/events/ring_buffer.c                                 |    2=20
 kernel/exit.c                                               |    1=20
 kernel/irq/chip.c                                           |   12 +-
 kernel/irq/internals.h                                      |    8 +
 kernel/irq/irqdesc.c                                        |    7 +
 kernel/rcu/update.c                                         |    2=20
 kernel/resource.c                                           |    4=20
 kernel/sched/core.c                                         |    9 -
 kernel/sched/debug.c                                        |    4=20
 kernel/sched/sched.h                                        |    6 -
 kernel/sched/topology.c                                     |    2=20
 kernel/sysctl.c                                             |    3=20
 kernel/trace/ring_buffer.c                                  |    5=20
 kernel/trace/trace.c                                        |    6 -
 kernel/trace/trace_kdb.c                                    |    6 -
 lib/bsearch.c                                               |    2=20
 lib/raid6/Makefile                                          |    2=20
 mm/cma.c                                                    |    4=20
 mm/kasan/common.c                                           |    2=20
 mm/memcontrol.c                                             |   19 ++-
 mm/mempolicy.c                                              |    2=20
 mm/oom_kill.c                                               |    3=20
 mm/page_alloc.c                                             |    2=20
 mm/page_ext.c                                               |    1=20
 mm/page_poison.c                                            |    4=20
 mm/slab.c                                                   |   17 +-
 mm/sparse.c                                                 |    2=20
 mm/swapfile.c                                               |   51 ++++----
 mm/vmalloc.c                                                |    6 -
 net/bridge/br_netfilter_hooks.c                             |    5=20
 net/netfilter/nf_conntrack_core.c                           |   14 +-
 net/netfilter/nf_conntrack_proto_tcp.c                      |   50 ++++++--
 net/netfilter/nf_tables_core.c                              |   14 +-
 net/netfilter/xt_physdev.c                                  |    9 +
 net/xdp/xsk.c                                               |    5=20
 security/apparmor/policy_unpack.c                           |    1=20
 security/selinux/hooks.c                                    |    9 +
 sound/core/pcm_native.c                                     |    8 +
 sound/firewire/dice/dice.c                                  |   12 +-
 sound/soc/fsl/fsl-asoc-card.c                               |    1=20
 sound/soc/fsl/imx-sgtl5000.c                                |    1=20
 sound/soc/generic/simple-card-utils.c                       |   14 +-
 sound/soc/qcom/common.c                                     |   10 +
 tools/build/Makefile.feature                                |    2=20
 tools/build/feature/test-all.c                              |   10 -
 tools/build/feature/test-reallocarray.c                     |    2=20
 tools/lib/bpf/Makefile                                      |    3=20
 tools/lib/lockdep/run_tests.sh                              |    6 -
 tools/lib/traceevent/event-parse.c                          |    2=20
 tools/perf/Makefile.config                                  |    5=20
 tools/perf/Makefile.perf                                    |    2=20
 tools/perf/builtin-c2c.c                                    |    8 +
 tools/perf/builtin-script.c                                 |   10 +
 tools/perf/builtin-trace.c                                  |    6 -
 tools/perf/tests/evsel-tp-sched.c                           |    6 -
 tools/perf/trace/beauty/msg_flags.c                         |    2=20
 tools/perf/trace/beauty/waitid_options.c                    |    2=20
 tools/perf/util/annotate.c                                  |    4=20
 tools/perf/util/s390-cpumsf.c                               |    5=20
 tools/perf/util/scripting-engines/trace-event-python.c      |   15 +-
 tools/perf/util/sort.c                                      |   10 +
 tools/perf/util/srcline.c                                   |    2=20
 tools/testing/selftests/bpf/Makefile                        |    3=20
 tools/testing/selftests/bpf/test_map_in_map.c               |    4=20
 tools/testing/selftests/bpf/test_maps.c                     |   27 ++--
 tools/testing/selftests/bpf/test_verifier.c                 |    9 +
 tools/testing/selftests/ir/ir_loopback.c                    |    4=20
 tools/testing/selftests/seccomp/seccomp_bpf.c               |    6 +
 300 files changed, 1765 insertions(+), 925 deletions(-)

Aaro Koskinen (1):
      mmc: omap: fix the maximum timeout setting

Akinobu Mita (2):
      media: ov7740: fix runtime pm initialization
      media: mt9m111: set initial frame size other than 0x0

Alagu Sankar (1):
      ath10k: don't report unset rssi values to mac80211

Alexei Avshalom Lazar (1):
      wil6210: check null pointer in _wil_cfg80211_merge_extra_ies

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda: Fix locked_vm counting for memory used by IOMMU=
 tables

Alexey Khoroshilov (1):
      soc: qcom: gsbi: Fix error handling in gsbi_probe()

Anders Roxell (2):
      efi: Fix build error due to enum collision between efi.h and ima.h
      dmaengine: imx-dma: fix warning comparison of distinct pointer types

Andi Kleen (1):
      perf script: Handle missing fields with -F +..

Andrea Parri (1):
      sched/core: Use READ_ONCE()/WRITE_ONCE() in move_queued_task()/task_r=
q_lock()

Andrea Righi (1):
      kprobes: Prohibit probing on bsearch()

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Add lockdep classes to fix false positive splat

Aneesh Kumar K.V (1):
      powerpc/hugetlb: Handle mmap_min_addr correctly in get_unmapped_area =
callback

Ard Biesheuvel (2):
      efi/memattr: Don't bail on zero VA if it equals the region's PA
      efi/arm/arm64: Allow SetVirtualAddressMap() to be omitted

Arnaldo Carvalho de Melo (7):
      perf beauty msg_flags: Add missing %s lost when adding prefix suppres=
sion logic
      tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio
      tools build: Add test-reallocarray.c to test-all.c to fix the build
      perf beauty waitid options: Fix up prefix showing logic
      perf trace: Check if the 'fd' is negative when mapping it to pathname
      perf coresight: Do not test for libopencsd by default
      perf trace: Fixup etcsnoop example

Arnd Bergmann (3):
      enic: fix build warning without CONFIG_CPUMASK_OFFSTACK
      kasan: fix kasan_check_read/write definitions
      appletalk: Fix compile regression

Aurelien Aptel (1):
      CIFS: fix POSIX lock leak and invalid ptr deref

Aurelien Jarno (1):
      vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset =3D=
=3D -1

Axel Lin (2):
      regulator: mcp16502: Include linux/gpio/consumer.h to fix build error
      regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting

Bart Van Assche (1):
      lockdep/lib/tests: Fix run_tests.sh

Bas Nieuwenhuizen (1):
      drm/sched: Fix entities with 0 rqs.

Ben Dooks (1):
      dmaengine: tegra: avoid overflow of byte tracking

Benjamin Block (1):
      scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c

Bj=C3=B6rn T=C3=B6pel (1):
      xsk: fix to reject invalid flags in xsk_bind

Breno Leitao (2):
      bpf: test_maps: fix possible out of bound access warning
      powerpc/ptrace: Mitigate potential Spectre v1

Brian Norris (1):
      mwifiex: don't advertise IBSS features without FW support

Buland Singh (1):
      hpet: Fix missing '=3D' character in the __setup() code of hpet_mmap_=
enable

Carlos Maiolino (1):
      fs: fix guard_bio_eod to check for real EOD errors

Chao Yu (4):
      f2fs: fix to adapt small inline xattr space in __find_inline_xattr()
      f2fs: fix to avoid deadlock in f2fs_read_inline_dir()
      f2fs: fix to check inline_xattr_size boundary correctly
      f2fs: fix to initialize variable to avoid UBSAN/smatch warning

Chen-Yu Tsai (1):
      backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial state

Chieh-Min Wang (1):
      netfilter: conntrack: fix cloned unconfirmed skb->_nfct race in __nf_=
conntrack_confirm

Chris Wilson (1):
      drm: Reorder set_property_atomic to avoid returning with an active ww=
_ctx

Christian Brauner (1):
      sysctl: handle overflow for file-max

Coly Li (5):
      bcache: fix input overflow to cache set sysfs file io_error_halflife
      bcache: fix input overflow to sequential_cutoff
      bcache: fix potential div-zero error of writeback_rate_i_term_inverse
      bcache: improve sysfs_strtoul_clamp()
      bcache: fix potential div-zero error of writeback_rate_p_term_inverse

Daniel Jordan (1):
      mm, swap: bounds check swap_info array accesses to avoid NULL derefs

Daniel Vetter (1):
      drm/nouveau: Stop using drm_crtc_force_disable

Dave Hansen (1):
      mm/resource: Return real error codes from walk failures

David Tolnay (1):
      hwrng: virtio - Avoid repeated init of completion

Dongli Zhang (1):
      loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()

Douglas Anderson (1):
      tracing: kdb: Fix ftdump to not sleep

Eric Biggers (1):
      crypto: cavium/zip - fix collision with generic cra_driver_name

Eric Whitney (1):
      ext4: fix bigalloc cluster freeing when hole punching under load

Erwan Velu (1):
      cpufreq: acpi-cpufreq: Report if CPU doesn't support boost technologi=
es

Ezequiel Garcia (7):
      media: sh_veu: Correct return type for mem2mem buffer helpers
      media: s5p-jpeg: Correct return type for mem2mem buffer helpers
      media: rockchip/rga: Correct return type for mem2mem buffer helpers
      media: s5p-g2d: Correct return type for mem2mem buffer helpers
      media: mx2_emmaprp: Correct return type for mem2mem buffer helpers
      media: mtk-jpeg: Correct return type for mem2mem buffer helpers
      media: rockchip/vpu: Correct return type for mem2mem buffer helpers

Florian Fainelli (3):
      veth: Fix -Wformat-truncation
      e1000e: Fix -Wformat-truncation warnings
      mlxsw: spectrum: Avoid -Wformat-truncation warnings

Florian Westphal (2):
      netfilter: conntrack: tcp: only close if RST matches exact sequence
      netfilter: physdev: relax br_netfilter dependency

George Rimar (1):
      x86/build: Specify elf_i386 linker emulation explicitly for i386 obje=
cts

Greg Kroah-Hartman (1):
      Linux 5.0.7

Guenter Roeck (1):
      cdrom: Fix race condition in cdrom_sysctl_register

Hans de Goede (5):
      i2c: designware: Do not allow i2c_dw_xfer() calls while suspended
      ACPI / video: Refactor and fix dmi_is_desktop()
      brcmfmac: Use firmware_request_nowarn for the clm_blob
      Input: soc_button_array - fix mapping of the 5th GPIO in a PNP0C40 de=
vice
      ACPI / video: Extend chassis-type detection with a "Lunch Box" check

He Kuang (1):
      perf report: Don't shadow inlined symbol with different addr range

Heiner Kallweit (1):
      net: phy: consider latched link-down status in polling mode

Hidetoshi Seto (1):
      sched/debug: Initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK

Hong Liu (1):
      HID: intel-ish-hid: avoid binding wrong ishtp_cl_device

Honghui Zhang (1):
      PCI: mediatek: Fix memory mapped IO range size computation

H=C3=A5kon Bugge (1):
      IB/mlx4: Increase the timeout for CM cache

Jacob Keller (1):
      ice: fix ice_remove_rule_internal vsi_list handling

James Smart (1):
      nvme-fc: fix numa_node when dev is null

Jason Cai (Xiang Feng) (1):
      dm thin: add sanity checks to thin-pool and external snapshot creation

Jason Yan (1):
      scsi: megaraid_sas: return error when create DMA pool failed

Jeremy Fertic (1):
      staging: iio: adt7316: fix dac_bits assignment

Jerome Brunet (1):
      clk: meson: clean-up clock registration

Jia Guo (1):
      ocfs2: fix a panic problem caused by o2cb_ctl

Jim Broadus (1):
      i2c: Allow recovery of the initial IRQ by an I2C client device.

Jiri Olsa (1):
      perf c2c: Fix c2c report for empty numa node

Johannes Berg (1):
      iwlwifi: mvm: fix RFH config command with >=3D10 CPUs

John Garry (1):
      scsi: hisi_sas: Set PHY linkrate when disconnected

John Johansen (1):
      apparmor: fix double free when unpack of secmark rules fails

John Stultz (1):
      usb: f_fs: Avoid crash due to out-of-scope stack ptr access

Josef Bacik (2):
      btrfs: save drop_progress if we drop refs at all
      btrfs: don't enospc all tickets on flush failure

Julia Lawall (2):
      crypto: crypto4xx - add missing of_node_put after of_device_is_availa=
ble
      drm: rcar-du: add missing of_node_put

J=C3=A9r=C3=B4me de Bretagne (1):
      platform/x86: intel-hid: Missing power button release on some Dell mo=
dels

Kai-Heng Feng (1):
      e1000e: Exclude device from suspend direct complete optimization

Kairui Song (2):
      x86/hyperv: Fix kernel panic when kexec on HyperV
      x86/kexec: Fill in acpi_rsdp_addr from the first kernel

Katsuhiro Suzuki (2):
      clk: fractional-divider: check parent rate only if flag is set
      clk: rockchip: fix frac settings of GPLL clock for rk3328

Konstantin Khlebnikov (1):
      e1000e: fix cyclic resets at link up with active tx

Kuninori Morimoto (1):
      ASoC: simple-card-utils: check "reg" property on asoc_simple_card_get=
_dai_id()

Li RongQing (1):
      netfilter: nf_tables: check the result of dereferencing base_chain->s=
tats

Linus Torvalds (1):
      iio: adc: fix warning in Qualcomm PM8xxx HK/XOADC driver

Lorenzo Bianconi (1):
      mt76: usb: do not run mt76u_queues_deinit twice

Louis Taylor (1):
      cifs: use correct format characters

Lu Baolu (1):
      iommu/vt-d: Disable ATS support on untrusted devices

Lubomir Rintel (1):
      serial: 8250_pxa: honor the port number from devicetree

Luc Van Oostenryck (2):
      include/linux/relay.h: fix percpu annotation in struct rchan
      sched/topology: Fix percpu data types in struct sd_data & struct s_da=
ta

Manfred Schlaegl (2):
      fbdev: fbmem: fix memory access if logo is bigger than the screen
      tty: increase the default flip buffer limit to 2*640K

Marek Beh=C3=BAn (1):
      net: dsa: mv88e6xxx: Default CMODE to 1000BaseX only on 6390X

Marek Vasut (2):
      gpio: of: Apply regulator-gpio quirk only to enable-gpios
      ARM: shmobile: Fix R-Car Gen2 regulator quirk

Martin Blumenstingl (2):
      ARM: dts: meson8b: fix the Ethernet data line signals in eth_rgmii_pi=
ns
      pinctrl: meson: meson8b: add the eth_rxd2 and eth_rxd3 pins

Masahiro Yamada (5):
      h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-
      kbuild: invoke syncconfig if include/config/auto.conf.cmd is missing
      kbuild: make -r/-R effective in top Makefile for old Make versions
      kbuild: add workaround for Debian make-kpkg
      kbuild: skip sub-make for in-tree build with GNU Make 4.x

Masami Hiramatsu (1):
      kprobes: Prohibit probing on RCU debug routine

Mathias Fr=C3=B6hlich (1):
      drm/amd/display: Fix reference counting for struct dc_sink.

Mathieu Malaterre (1):
      ARM: dts: lpc32xx: Remove leading 0x and 0s from bindings notation

Mathieu Poirier (1):
      perf/aux: Make perf_event accessible to setup_aux()

Michael Ellerman (1):
      powerpc/44x: Force PCI on for CURRITUCK

Michal Kazior (1):
      leds: lp55xx: fix null deref on firmware load failure

Mika Westerberg (1):
      PCI: pciehp: Assign ctrl->slot_ctrl before writing it to hardware

Mike Rapoport (1):
      docs/core-api/mm: fix user memory accessors formatting

Namjae Jeon (1):
      cifs: Accept validate negotiate if server return NT_STATUS_NOT_SUPPOR=
TED

Nathan Chancellor (4):
      net: stmmac: Avoid sometimes uninitialized Clang warnings
      powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc
      ARM: 8833/1: Ensure that NEON code always compiles with Clang
      net: stmmac: Avoid one more sometimes uninitialized Clang warning

Nathan Fontenot (1):
      powerpc/pseries: Perform full re-add of CPU for topology update post-=
migration

Nicholas Kazlauskas (4):
      drm/amd/display: Clear stream->mode_changed after commit
      drm/amd/display: Don't re-program planes for DPMS changes
      drm/amd/display: Disconnect mpcc when changing tg
      drm/amd/display: Enable vblank interrupt during CRC capture

Nicolai Stange (1):
      powerpc/64s: Clear on-stack exception marker upon exception return

Nicolas Boichat (1):
      iommu/io-pgtable-arm-v7s: Only kmemleak_ignore L2 tables

Niklas Cassel (1):
      regulator: core: Take lock before applying system load

Oleg Nesterov (1):
      cgroup/pids: turn cgroup_subsys->free() into cgroup_subsys->release()=
 to fix the accounting

Oleksandr Andrushchenko (1):
      xen/gntdev: Do not destroy context while dma-bufs are in use

Ondrej Mosnacek (1):
      selinux: do not override context on context mounts

Paolo Valente (2):
      block, bfq: fix in-service-queue check for queue merging
      block, bfq: fix queue removal from weights tree

Paul Kocialkowski (2):
      usb: chipidea: Grab the (legacy) USB PHY by phandle first
      drm: Auto-set allow_fb_modifiers when given modifiers at plane init

Pawe? Chmiel (1):
      media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Peng Fan (1):
      mm/cma.c: cma_declare_contiguous: correct err handling

Peter Wu (1):
      drm/fb-helper: fix leaks in error path of drm_fb_helper_fbdev_setup

Qian Cai (4):
      mm/sparse: fix a bad comparison
      mm/page_ext.c: fix an imbalance with kmemleak
      mm/slab.c: kmemleak no scan alien caches
      page_poison: play nicely with KASAN

Qu Wenruo (1):
      btrfs: qgroup: Make qgroup async transaction commit more aggressive

Rafael J. Wysocki (1):
      PCI/PME: Fix hotplug/sysfs remove deadlock in pcie_pme_remove()

Rafael =C3=81vila de Esp=C3=ADndola (1):
      x86/build: Mark per-CPU symbols as absolute explicitly for LLD

Rajneesh Bhardwaj (1):
      platform/x86: intel_pmc_core: Fix PCH IP sts reading

Raju Rangoju (1):
      iw_cxgb4: fix srqidx leak during connection abort

Rakesh Pillai (1):
      ath10k: fix shadow register implementation for WCN3990

Ranjani Sridharan (1):
      ALSA: PCM: check if ops are defined before suspending PCM

Richard Guy Briggs (1):
      audit: hand taken context to audit_kill_trees for syscall logging

Roger Quadros (1):
      usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded

Ross Lagerwall (1):
      efi: cper: Fix possible out-of-bounds access

Russell King (3):
      gpio: gpio-omap: fix level interrupt idling
      net: marvell: mvpp2: fix stuck in-band SGMII negotiation
      ARM: avoid Cortex-A9 livelock on tight dmb loops

Sahitya Tummala (1):
      f2fs: do not use mutex lock in atomic context

Sai Prakash Ranjan (1):
      coresight: etm4x: Add support to enable ETMv4.2

Sara Sharon (1):
      iwlwifi: pcie: fix emergency path

Sebastian Andrzej Siewior (1):
      ARM: 8840/1: use a raw_spinlock_t in unwind

Sebastian Ott (1):
      s390/ism: ignore some errors during deregistration

Sedat Dilek (1):
      scsi: fcoe: make use of fip_mode enum complete

Shayenne Moura (2):
      drm/vkms: Bugfix racing hrtimer vblank handle
      drm/vkms: Bugfix extra vblank frame

Sheng Yong (1):
      f2fs: UBSAN: set boolean value iostat_enable correctly

Shiju Jose (1):
      net: hns3: fix setting of the hns reset_type for rdma hw errors

Shuah Khan (1):
      selftests: ir: fix warning: "%s" directive output may be truncated =
=E2=80=99 directive output may be truncated

Shunyong Yang (2):
      dmaengine: qcom_hidma: assign channel cookie correctly
      dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*

Shuriyc Chu (1):
      fs/file.c: initialize init_files.resize_wait

Song Hongyan (1):
      HID: intel-ish: ipc: handle PIMR before ish_wakeup also clear PISR bu=
sy_clear bit

Stanislav Fomichev (3):
      libbpf: force fixdep compilation at the start of the build
      selftests/bpf: skip verifier tests for unsupported program types
      selftests/bpf: suppress readelf stderr when probing for BTF support

Stanislaw Gruszka (1):
      mt7601u: bump supported EEPROM version

Stefan Agner (1):
      ARM: 8845/1: use unified assembler in c files

Stefan Roese (1):
      staging: spi: mt7621: Add return code check on device_reset()

Stephen Boyd (1):
      drm/msm/dpu: Convert to a chained irq chip

Steve Longerbeam (1):
      media: rcar-vin: Allow independent VIN link enablement

Surabhi Vishnoi (1):
      ath10k: Fix the wrong updation of BW in tx_stats debugfs entry

Takashi Iwai (1):
      ASoC: qcom: Fix of-node refcount unbalance in qcom_snd_parse_of()

Takashi Sakamoto (1):
      ALSA: dice: add support for Solid State Logic Duende Classic/Mini

Takeshi Kihara (2):
      pinctrl: sh-pfc: r8a77990: Fix MOD_SEL bit numbering
      pinctrl: sh-pfc: r8a77995: Fix MOD_SEL bit numbering

Tariq Toukan (1):
      net/mlx5e: Fix access to non-existing receive queue

Tejun Heo (1):
      cgroup, rstat: Don't flush subtree root unless necessary

Tetsuo Handa (2):
      mm,oom: don't kill global init via memory.oom.group
      memcg: killed threads should not invoke memcg OOM killer

Theodore Ts'o (1):
      jbd2: fix race when writing superblock

Thierry Reding (2):
      i2c: of: Try to find an I2C adapter matching the parent
      gpio: of: Restrict enable-gpio quirk to regulator-gpio

Thomas Gleixner (1):
      genirq: Avoid summation loops for /proc/stat

Thomas Richter (2):
      perf test: Fix failure of 'evsel-tp-sched' test on s390
      perf report: Add s390 diagnosic sampling descriptor size

Timo Alho (1):
      soc/tegra: fuse: Fix illegal free of IO base address

Tonghao Zhang (2):
      net/mlx5: Avoid panic when setting vport rate
      net/mlx5: Avoid panic when setting vport mac, getting vport config

Tony Jones (3):
      tools lib traceevent: Fix buffer overflow in arg_eval
      perf script python: Use PyBytes for attr in trace-event-python
      perf script python: Add trace_context extension module to sys.modules

Tony Lindgren (1):
      clk: ti: clkctrl: Fix clkdm_name regression for TI_CLK_CLKCTRL_COMPAT

Tycho Andersen (1):
      selftests: skip seccomp get_metadata test if not real root

Uladzislau Rezki (Sony) (1):
      mm/vmalloc.c: fix kernel BUG at mm/vmalloc.c:512!

Vadim Pasternak (1):
      platform/mellanox: mlxreg-hotplug: Fix KASAN warning

Valdis Kletnieks (1):
      bpf: fix missing prototype warnings

Valentin Schneider (1):
      cpu/hotplug: Mute hotplug lockdep during init

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Vladimir Murzin (1):
      ARM: 8830/1: NOMMU: Toggle only bits in EXC_RETURN we are really care=
 of

Vlastimil Babka (1):
      mm, mempolicy: fix uninit memory access

Wei Li (1):
      perf annotate: Fix getting source line failure

Wen Yang (2):
      mt76: fix a leaked reference by adding a missing of_node_put
      SoC: imx-sgtl5000: add missing put_device()

Xiang Chen (1):
      scsi: hisi_sas: Fix a timeout race of driver internal and SMP IO

Xingyu Chen (1):
      pinctrl: meson: fix G12A ao pull registers base address

Yang Fan (1):
      platform/x86: ideapad-laptop: Fix no_hw_rfkill_list for Lenovo RESCUE=
R R720-15IKBN

Yao Liu (1):
      cifs: Fix NULL pointer dereference of devname

Yonghong Song (1):
      tools/bpf: selftests: add map lookup to test_map_in_map bpf prog

Yufen Yu (1):
      nvme-loop: init nvmet_ctrl fatal_err_work when allocate

Zumeng Chen (1):
      wlcore: Fix memory leak in case wl12xx_fetch_firmware failure

luojiajun (1):
      jbd2: fix invalid descriptor block checksum

wen yang (1):
      ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

zhangyi (F) (1):
      ext4: cleanup bh release code in ext4_ind_remove_space()

zhengliang (1):
      f2fs: fix to data block override node segment by mistake


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly00FMACgkQONu9yGCS
aT68QRAAuONNOdD3P115HBlAhdQaazNiwUT6k048Y3jDl0uybqTQY9UN0Gs47KIs
mhdXVM4ClRCVarX1bpZjz55YKuua0t08OKgbS9B8KZP1r3sP4QBHOwM6+pZ0/sGA
K0D30SbLQhjrSNDHj1cekzS8uTJEpdE34XfklJ3umXy+aG2InUCvWz/GhYLxC56z
orJ51F+PCu7N3k2daGp8SX9XTVGqF5IZuzb6LMukvhBhn0+jhwKuPjoWLNNP1n1p
IUgYuYWEN2gr9OPqerWY6kQyAyJQZ2bN/gMLjZROusnLRAshExoGllJXd9e29Itm
jNJSI5mD3b3M+vfgiYJ194EcS5p2QhnLaEvdMPanb8488umIa2lxjTo8UW3kKBTq
Itcnrmin8rfSWAyFVcbuI4XLkQmvFjsX8aynPO+UjxMw/mE2mIzIsvKwvSnBqypi
GOajyq2cPOZWK3lli1iEFv7QtGnu4kFb0kwDufdWtZT1DvYWhRsLV3N4k+q43cxz
Qn8YgtGyWhZhF8Jv//ztbueBZb3sg1GSKGYXTYVZiucSD7CKhUaz5a3T3+zX3065
1DI/JyGdGimKqHizxEFKoWpKm35LQ93rarjAChqxtJSZa4sFfnxgNHZk7LUMKnvZ
OPkFCPdv4zFEOkoW8BfLiMnTKwzz1sDRhK4mGnYLqy7oqpsc7ow=
=ss4Y
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
