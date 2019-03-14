Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C91C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7C220811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552580845;
	bh=zF7FhFZ+W6TX+djisins63jyXsHisyuRp+eLy+TqlR4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HwIx/DksBOl8T0PU1opzCmTGzT9exjC8X/2bcPS3gVxKtjL8GF54QevJKjlTWybxz
	 9WaiEnCCXqwDNu4wHikUBgb/Q2dIjl/bdsEryfjGdZMmdjOLQn0191vMsBIX5aDXMa
	 /PNBudFIvCkgg5U1VfXTcLMOXFLuv+xPUpDaEUH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfCNQ1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfCNQ1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:27:22 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4757D20811;
        Thu, 14 Mar 2019 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552580840;
        bh=zF7FhFZ+W6TX+djisins63jyXsHisyuRp+eLy+TqlR4=;
        h=Date:From:To:Cc:Subject:From;
        b=xlFx4hJrR6ceNSzy0APr03vL3S/hS2Fovah+b7jLc8sVs/z8W3w+tmKm9Rmx/oZsQ
         uPSVk/5EFO7Uyq8Q+dJW579hGGisFlHbm0qUlrPm1ULyOTSftxJKrV/9fVYUxd5yyJ
         NA374wBc/S0BZosriIfrWTnkUdQ2lQL3DssUWQpA=
Date:   Thu, 14 Mar 2019 09:27:19 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.29
Message-ID: <20190314162719.GA20520@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.29 kernel.

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

 Makefile                                               |    2=20
 arch/arm/boot/dts/exynos3250.dtsi                      |    3=20
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi        |   13=20
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi          |    2=20
 arch/arm/boot/dts/imx6sx.dtsi                          |    2=20
 arch/arm/boot/dts/meson.dtsi                           |    2=20
 arch/arm/boot/dts/meson8b-odroidc1.dts                 |    4=20
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts              |    3=20
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi         |    2=20
 arch/arm/boot/dts/omap3-n950-n9.dtsi                   |   42=20
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts              |    2=20
 arch/arm/plat-pxa/ssp.c                                |    3=20
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts         |    2=20
 arch/arm64/boot/dts/qcom/msm8996.dtsi                  |    2=20
 arch/arm64/boot/dts/renesas/r8a7796.dtsi               |    3=20
 arch/arm64/boot/dts/renesas/r8a77965.dtsi              |    3=20
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      |    1=20
 arch/arm64/kernel/probes/kprobes.c                     |    6=20
 arch/mips/boot/dts/ingenic/ci20.dts                    |    8=20
 arch/mips/kernel/process.c                             |    7=20
 arch/riscv/include/asm/processor.h                     |    2=20
 arch/riscv/kernel/setup.c                              |    2=20
 arch/riscv/mm/init.c                                   |    3=20
 arch/x86/boot/compressed/head_64.S                     |    8=20
 arch/x86/boot/compressed/pgtable.h                     |    2=20
 arch/x86/events/core.c                                 |   13=20
 arch/x86/events/intel/core.c                           |  154 ++-
 arch/x86/events/perf_event.h                           |   17=20
 arch/x86/include/asm/cpufeatures.h                     |    1=20
 arch/x86/include/asm/msr-index.h                       |    6=20
 arch/x86/include/asm/page_64_types.h                   |    4=20
 arch/x86/kernel/cpu/microcode/amd.c                    |    2=20
 arch/x86/kernel/kexec-bzimage64.c                      |    3=20
 arch/x86/pci/fixup.c                                   |   16=20
 arch/xtensa/configs/smp_lx200_defconfig                |    1=20
 arch/xtensa/kernel/head.S                              |    5=20
 arch/xtensa/kernel/smp.c                               |   41=20
 arch/xtensa/kernel/time.c                              |    2=20
 block/blk-iolatency.c                                  |   52 +
 drivers/base/dd.c                                      |    2=20
 drivers/clk/qcom/gcc-sdm845.c                          |   14=20
 drivers/clk/ti/divider.c                               |   11=20
 drivers/dma/at_xdmac.c                                 |   19=20
 drivers/dma/dmatest.c                                  |   28=20
 drivers/firmware/iscsi_ibft.c                          |    1=20
 drivers/gpio/gpio-vf610.c                              |    5=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c                 |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c              |   59 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                 |    5=20
 drivers/gpu/drm/radeon/ci_dpm.c                        |    5=20
 drivers/gpu/drm/radeon/si_dpm.c                        |    5=20
 drivers/gpu/drm/sun4i/sun4i_tcon.c                     |    2=20
 drivers/i2c/busses/i2c-omap.c                          |   13=20
 drivers/infiniband/hw/hfi1/ud.c                        |    1=20
 drivers/infiniband/hw/qib/qib_ud.c                     |    1=20
 drivers/infiniband/ulp/ipoib/ipoib.h                   |    1=20
 drivers/infiniband/ulp/ipoib/ipoib_cm.c                |    3=20
 drivers/input/mouse/elan_i2c_core.c                    |    1=20
 drivers/input/tablet/wacom_serial4.c                   |    2=20
 drivers/iommu/amd_iommu.c                              |   19=20
 drivers/irqchip/irq-gic-v3-its.c                       |   69 +
 drivers/irqchip/irq-mmp.c                              |    6=20
 drivers/media/usb/uvc/uvc_driver.c                     |   14=20
 drivers/net/ethernet/altera/altera_msgdma.c            |    3=20
 drivers/net/ethernet/cadence/macb.h                    |    3=20
 drivers/net/ethernet/cadence/macb_main.c               |   28=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c          |    5=20
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c       |   16=20
 drivers/net/ethernet/hisilicon/hns_mdio.c              |    2=20
 drivers/net/ethernet/qlogic/qed/qed_dev.c              |    8=20
 drivers/net/ethernet/qlogic/qed/qed_l2.c               |   17=20
 drivers/net/ethernet/qlogic/qed/qed_l2.h               |    3=20
 drivers/net/ethernet/qlogic/qed/qed_ll2.c              |   20=20
 drivers/net/ethernet/qlogic/qed/qed_sp.h               |    1=20
 drivers/net/ethernet/qlogic/qed/qed_spq.c              |   15=20
 drivers/net/ethernet/qlogic/qed/qed_sriov.c            |   10=20
 drivers/net/ethernet/qlogic/qed/qed_vf.c               |   10=20
 drivers/net/ethernet/qlogic/qede/qede.h                |    3=20
 drivers/net/ethernet/qlogic/qede/qede_fp.c             |   13=20
 drivers/net/ethernet/qlogic/qede/qede_main.c           |    3=20
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c         |    4=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   14=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c      |   17=20
 drivers/net/wireless/ath/ath9k/init.c                  |    6=20
 drivers/net/wireless/ti/wlcore/sdio.c                  |   15=20
 drivers/nvme/host/core.c                               |    8=20
 drivers/nvme/host/nvme.h                               |    1=20
 drivers/nvme/host/pci.c                                |   30=20
 drivers/pinctrl/pinctrl-mcp23s08.c                     |    7=20
 drivers/platform/x86/Kconfig                           |    2=20
 drivers/s390/net/qeth_core.h                           |    1=20
 drivers/s390/net/qeth_core_main.c                      |   21=20
 drivers/s390/net/qeth_l2_main.c                        |    2=20
 drivers/s390/net/qeth_l3_main.c                        |    1=20
 drivers/scsi/53c700.c                                  |    2=20
 drivers/scsi/aacraid/commsup.c                         |    5=20
 drivers/scsi/bnx2fc/bnx2fc_io.c                        |    4=20
 drivers/scsi/libfc/fc_lport.c                          |    6=20
 drivers/scsi/libfc/fc_rport.c                          |    1=20
 drivers/scsi/scsi_debug.c                              |   41=20
 drivers/soc/fsl/qbman/qman.c                           |    9=20
 drivers/staging/erofs/inode.c                          |    8=20
 drivers/staging/erofs/internal.h                       |   16=20
 drivers/staging/erofs/namei.c                          |  189 ++--
 drivers/staging/erofs/xattr.c                          |  165 ++-
 drivers/usb/phy/Kconfig                                |    2=20
 fs/autofs/expire.c                                     |    3=20
 fs/autofs/inode.c                                      |    4=20
 fs/buffer.c                                            |   19=20
 fs/cifs/smb2pdu.c                                      |   16=20
 fs/cifs/smb2pdu.h                                      |    4=20
 fs/drop_caches.c                                       |    8=20
 fs/gfs2/glock.c                                        |    2=20
 fs/iomap.c                                             |   37=20
 fs/nfs/super.c                                         |    5=20
 fs/proc/generic.c                                      |    4=20
 fs/proc/internal.h                                     |    1=20
 fs/proc/proc_net.c                                     |   20=20
 include/drm/drm_cache.h                                |   18=20
 include/linux/irqchip/arm-gic-v3.h                     |    2=20
 include/linux/stmmac.h                                 |    1=20
 kernel/bpf/hashtab.c                                   |    4=20
 kernel/bpf/percpu_freelist.c                           |   41=20
 kernel/bpf/percpu_freelist.h                           |    4=20
 kernel/bpf/syscall.c                                   |   12=20
 kernel/events/core.c                                   |   14=20
 kernel/relay.c                                         |    4=20
 kernel/trace/bpf_trace.c                               |   14=20
 lib/test_kmod.c                                        |    2=20
 mm/memory_hotplug.c                                    |   29=20
 net/batman-adv/bat_v_elp.c                             |    3=20
 net/bridge/netfilter/ebtables.c                        |    9=20
 net/core/filter.c                                      |    2=20
 net/ipv4/ip_vti.c                                      |   50 +
 net/netfilter/ipvs/ip_vs_ctl.c                         |   12=20
 net/netfilter/nf_conntrack_core.c                      |   16=20
 net/netfilter/xt_TEE.c                                 |   76 +
 net/vmw_vsock/virtio_transport.c                       |   29=20
 security/apparmor/domain.c                             |    5=20
 tools/bpf/bpftool/map.c                                |   16=20
 tools/bpf/bpftool/prog.c                               |    5=20
 tools/perf/builtin-script.c                            |    9=20
 tools/perf/builtin-trace.c                             |   25=20
 tools/perf/util/cpumap.c                               |   11=20
 tools/perf/util/symbol-elf.c                           |    9=20
 tools/testing/selftests/bpf/bpf_util.h                 |   30=20
 tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh |   13=20
 tools/testing/selftests/net/Makefile                   |    2=20
 tools/testing/selftests/netfilter/Makefile             |    2=20
 tools/testing/selftests/netfilter/config               |    2=20
 tools/testing/selftests/netfilter/nft_nat.sh           |  762 ++++++++++++=
+++++
 tools/testing/selftests/proc/.gitignore                |    1=20
 tools/testing/selftests/proc/Makefile                  |    1=20
 tools/testing/selftests/proc/setns-dcache.c            |  129 ++
 tools/testing/selftests/timers/Makefile                |    2=20
 155 files changed, 2350 insertions(+), 611 deletions(-)

Aaro Koskinen (1):
      ARM: OMAP: dts: N950/N9: fix onenand timings

Alex Deucher (2):
      drm/amdgpu: Add missing power attribute to APU check
      drm/radeon: check if device is root before getting pci speed caps

Alexander Shishkin (1):
      x86/PCI: Fixup RTIT_BAR of Intel Denverton Trace Hub

Alexandre Ghiti (1):
      riscv: Adjust mmap base address at a third of task size

Alexei Starovoitov (2):
      bpf: fix lockdep false positive in percpu_freelist
      bpf: fix potential deadlock in bpf_prog_register

Alexey Dobriyan (1):
      proc: fix /proc/net/* after setns(2)

Alexey Khoroshilov (1):
      net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()

Alistair Strachan (2):
      media: uvcvideo: Fix 'type' check leading to overflow
      arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"

Anders Roxell (1):
      usb: phy: fix link errors

Andi Kleen (1):
      perf script: Fix crash with printing mixed trace point and other even=
ts

Andreas Gruenbacher (1):
      gfs2: Fix missed wakeups in find_insert_glock

Andrew Lunn (1):
      gpio: vf610: Mask all GPIO interrupts

Andy Shevchenko (1):
      dmaengine: dmatest: Abort test in case of mapping error

Anson Huang (1):
      ARM: dts: imx6sx: correct backward compatible of gpt

Ard Biesheuvel (1):
      drm: disable uncached DMA optimization for ARM and arm64

Arnaldo Carvalho de Melo (1):
      perf trace: Support multiple "vfs_getname" probes

Brian Welty (1):
      IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM

Carlo Caione (1):
      arm: dts: meson: Fix IRQ trigger type for macirq

Chris Wilson (1):
      drm/amdgpu: Transfer fences to dmabuf importer

Christoph Hellwig (1):
      iomap: fix a use after free in iomap_dio_rw

Codrin Ciubotariu (1):
      dmaengine: at_xdmac: Fix wrongfull report of a channel as in use

Colin Ian King (1):
      selftests: cpu-hotplug: fix case where CPUs offline > CPUs present

Dan Carpenter (4):
      clk: ti: Fix error handling in ti_clk_parse_divider_data()
      scsi: bnx2fc: Fix error handling in probe()
      scsi: 53c700: pass correct "dev" to dma_alloc_attrs()
      lib/test_kmod.c: potential double free in error handling

Daniel F. Dickinson (1):
      ath9k: Avoid OF no-EEPROM quirks without qca,no-eeprom

Douglas Gilbert (1):
      scsi: scsi_debug: fix write_same with virtual_gb problem

Fathi Boudra (2):
      selftests: net: use LDLIBS instead of LDFLAGS
      selftests: timers: use LDLIBS instead of LDFLAGS

Felix Fietkau (1):
      batman-adv: release station info tidstats

Feras Daoud (1):
      IB/ipoib: Fix for use-after-free in ipoib_cm_tx_start

Florian Westphal (2):
      netfilter: ebtables: compat: un-break 32bit setsockopt when no rules =
are present
      selftests: netfilter: add simple masq/redirect test cases

Gao Xiang (5):
      staging: erofs: add error handling for xattr submodule
      staging: erofs: fix fast symlink w/o xattr when fs xattr is on
      staging: erofs: fix memleak of inode's shared xattr array
      staging: erofs: fix race of initializing xattrs of a inode at the sam=
e time
      staging: erofs: keep corrupted fs from crashing kernel in erofs_namei=
()

Geert Uytterhoeven (3):
      arm64: dts: renesas: r8a7796: Enable DMA for SCIF2
      arm64: dts: renesas: r8a77965: Enable DMA for SCIF2
      driver core: Postpone DMA tear-down until after devres release

Greg Kroah-Hartman (2):
      relay: check return of create_buf_file() properly
      Linux 4.19.29

Guo Ren (1):
      riscv: fixup max_low_pfn with PFN_DOWN.

Gustavo A. R. Silva (2):
      iscsi_ibft: Fix missing break in switch statement
      scsi: aacraid: Fix missing break in switch statement

Harini Katakam (1):
      net: macb: Apply RXUBR workaround only to versions with errata

Heyi Guo (1):
      irqchip/gic-v4: Fix occasional VLPI drop

Ian Kent (1):
      autofs: fix error return in autofs_fill_super()

James Morse (1):
      arm64: kprobe: Always blacklist the KVM world-switch code

Jan Kara (1):
      fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()

Jan Kiszka (2):
      arm64: dts: zcu100-revC: Give wifi some time after power-on
      arm64: dts: hikey: Give wifi some time after power-on

Jason Gerecke (1):
      Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Jason Kridner (1):
      pinctrl: mcp23s08: spi: Fix regmap allocation for mcp23s18

Jernej Skrabec (1):
      ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2

Jerry Snitselaar (2):
      iommu/amd: Call free_iova_fast with pfn in map_sg
      iommu/amd: Unmap all mapped pages in error path of map_sg

Jiri Olsa (2):
      bpftool: Fix prog dump by tag
      perf symbols: Filter out hidden symbols from labels

John Johansen (1):
      apparmor: Fix aa_label_build() error handling for failed merges

Jose Abreu (3):
      net: stmmac: Fallback to Platform Data clock in Watchdog conversion
      net: stmmac: Send TSO packets always from Queue 0
      net: stmmac: Disable EEE mode earlier in XMIT callback

Julian Wiedmann (3):
      s390/qeth: release cmd buffer in error paths
      s390/qeth: fix use-after-free in error path
      s390/qeth: cancel close_dev work before removing a card

Jun-Ru Chang (1):
      MIPS: Remove function size check in get_frame_info()

Kairui Song (1):
      x86/kexec: Don't setup EFI info if EFI runtime is not enabled

Keith Busch (3):
      nvme: lock NS list changes while handling command effects
      nvme-pci: fix rapid add remove sequence
      nvme-pci: add missing unlock for reset error

Liu Bo (1):
      blk-iolatency: fix IO hang due to negative inflight counter

Lubomir Rintel (1):
      irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Madalin Bucur (1):
      soc: fsl: qbman: avoid race in clearing QMan interrupt

Manish Chopra (6):
      qed: Fix bug in tx promiscuous mode settings
      qed: Fix LACP pdu drops for VFs
      qed: Fix VF probe failure while FLR
      qed: Fix system crash in ll2 xmit
      qed: Fix stack out of bounds bug
      qed: Fix EQ full firmware assert.

Marc Zyngier (1):
      irqchip/gic-v3-its: Gracefully fail on LPI exhaustion

Marek Szyprowski (3):
      ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid=
 X2/U3
      ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU
      ARM: dts: exynos: Fix max voltage for buck8 regulator on Odroid XU3/X=
U4

Martin Blumenstingl (2):
      ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO active-l=
ow
      ARM: dts: meson8m2: mxiii-plus: mark the SD card detection GPIO activ=
e-low

Martin KaFai Lau (1):
      bpf: Fix syscall's stackmap lookup potential deadlock

Martynas Pumputis (2):
      bpf, selftests: fix handling of sparse CPU allocations
      netfilter: nf_nat: skip nat clash resolution for same-origin entries

Max Filippov (5):
      xtensa: SMP: fix ccount_timer_shutdown
      xtensa: SMP: fix secondary CPU initialization
      xtensa: smp_lx200_defconfig: fix vectors clash
      xtensa: SMP: mark each possible CPU as present
      xtensa: SMP: limit number of possible CPUs by NR_CPUS

Michal Hocko (2):
      mm, memory_hotplug: is_mem_section_removable do not pass the end of a=
 zone
      mm, memory_hotplug: fix off-by-one in is_pageblock_removable

Mikhail Zaslonko (1):
      mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone

Ming Lu (1):
      scsi: libfc: free skb when receiving invalid flogi resp

Naresh Kamboju (1):
      selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET

Pan Bian (1):
      autofs: drop dentry reference only when it is never used

Paolo Abeni (1):
      bpftool: fix percpu maps updating

Paul Kocialkowski (1):
      drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init

Peng Hao (1):
      ARM: pxa: ssp: unneeded to free devm_ allocated data

Peter Zijlstra (Intel) (4):
      perf/x86/intel: Make cpuc allocations consistent
      perf/x86/intel: Generalize dynamic constraint creation
      x86: Add TSX Force Abort CPUID/MSR
      perf/x86/intel: Implement support for TSX Force Abort

Philip Yang (1):
      drm/amdgpu: use spin_lock_irqsave to protect vm_manager.pasid_idr

Piotr Jaroszynski (1):
      iomap: get/put the page in iomap_page_create/release()

Qian Cai (1):
      x86_64: increase stack size for KASAN_EXTRA

Ronnie Sahlberg (2):
      cifs: fix computation for MAX_SMB2_HDR_SIZE
      cifs: allow calling SMB2_xxx_free(NULL)

Ross Lagerwall (1):
      Revert "scsi: libfc: Add WARN_ON() when deleting rports"

Sinan Kaya (2):
      platform/x86: Fix unmet dependency warning for ACPI_CMPC
      platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Srinivas Kandagatla (1):
      arm64: dts: add msm8996 compatible to gicv3

Stefano Garzarella (2):
      vsock/virtio: fix kernel panic after device hot-unplug
      vsock/virtio: reset connected sockets on device removal

Stephane Eranian (2):
      perf core: Fix perf_proc_update_handler() bug
      perf tools: Handle TOPOLOGY headers with no CPU

Su Yanjun (1):
      vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Sudarsana Reddy Kalluru (2):
      qed: Consider TX tcs while deriving the max num_queues for PF.
      qede: Fix system crash on configuring channels.

Suravee Suthikulpanit (1):
      iommu/amd: Fix IOMMU page flush when detach device from a domain

Taehee Yoo (2):
      netfilter: xt_TEE: fix wrong interface selection
      netfilter: xt_TEE: add missing code to get interface index in checken=
try.

Taniya Das (1):
      clk: qcom: gcc: Use active only source for CPUSS clocks

Tetsuo Handa (1):
      fs: ratelimit __find_get_block_slow() failure message.

Thomas Lendacky (1):
      x86/microcode/amd: Don't falsely trick the late loading mechanism

Tomonori Sakita (1):
      net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case

Tony Jones (1):
      perf script: Fix crash when processing recorded stat data

Tony Lindgren (2):
      ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
      i2c: omap: Use noirq system sleep pm ops to idle device for suspend

Ulf Hansson (1):
      wlcore: sdio: Fixup power on/off sequence

Vincent Batts (1):
      Input: elan_i2c - add id for touchpad found in Lenovo s21e-20

Wei Huang (1):
      x86/boot/compressed/64: Set EFER.LME=3D1 in 32-bit trampoline before =
returning to long mode

Yafang Shao (1):
      bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()

Yao Liu (1):
      nfs: Fix NULL pointer dereference of dev_name

Yonglong Liu (3):
      net: hns: Fix for missing of_node_put() after of_parse_phandle()
      net: hns: Restart autoneg need return failed when autoneg off
      net: hns: Fix wrong read accesses via Clause 45 MDIO protocol

Zenghui Yu (1):
      irqchip/gic-v3-its: Fix ITT_entry_size accessor

ZhangXiaoxu (1):
      ipvs: Fix signed integer overflow when setsockopt timeout

Zhou Yanjie (1):
      DTS: CI20: Fix bugs in ci20's device tree.


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyKgOcACgkQONu9yGCS
aT4+jw//ZbYUw2cdBZfE5ecqHHSVugWqPyiQm+vKrePlZER33xfyMXiGNyDpgw2J
vpJXLx0ZyHhiM4zjxtA2+nfwgQkKO3wrnhevVCdwkBjQeUngpK1Yf7EntanFi79M
vDqKW3t9FiIKHFCCbu8viLKmMqKyrsGxU0XsttS1/rkwV4GK4S5eF/j7+0E1300a
5f15mayOkjiJ1K3pp5GxQA0QzHQoRmn60FMYEy40ZXvcQTy8ViPoc2kGqo0+MoVe
461C+faIg5vLB9dVkBg7zpGEVSCHr5Uxkx+0Dlc1vdR612VOpjMz/l0xSefnvuGp
/Tu8g3TLvw3XMmQkJiA5HJO9biXHJDIu0zSR4+5iIw490hcfN3LVkoh6+FiO7R4B
Z7AxP8CI/Yv+W6GcO9CIs5soHoRHMX4jlJCcJOLZ+rj2uz+QP+koPa1P30Z8ihJY
4PZIA8bm/sDGrh49LvIq1SsQLs3fLNLXX78M8r7hYMlsBZXEq5f1Qj9WE+mhiJbB
MSn5NQv4nNAU5p6+gyxuW5ccDkAiShmI0yMFTdw7IgrZHRg/6e/LLfdU3tjBt5wU
54v+/318EOb5CjILa3swjuIi1dFPJhjW9K1f2LOsMAxVncGmOpRXWyiUue33gp/L
6fy18WVqYjnhn3hPl1Cug4G09pP7jGM9dqamLAstP+i5pkyhjUM=
=fl92
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
