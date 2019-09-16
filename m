Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A96C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3ABE20830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbfIPPNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:13:53 -0400
Received: from 8bytes.org ([81.169.241.247]:54724 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbfIPPNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:13:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 73C0F1AD; Mon, 16 Sep 2019 17:13:50 +0200 (CEST)
Date:   Mon, 16 Sep 2019 17:13:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.4
Message-ID: <20190916151342.GA7444@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.4

for you to fetch changes up to e95adb9add75affb98570a518c902f50e5fcce1b:

  Merge branches 'arm/omap', 'arm/exynos', 'arm/smmu', 'arm/mediatek', 'arm/qcom', 'arm/renesas', 'x86/amd', 'x86/vt-d' and 'core' into next (2019-09-11 12:39:19 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.4:

Including:

	- Batched unmap support for the IOMMU-API

	- Support for unlocked command queueing in the ARM-SMMU driver

	- Rework the ATS support in the ARM-SMMU driver

	- More refactoring in the ARM-SMMU driver to support hardware
	  implemention specific quirks and errata

	- Bounce buffering DMA-API implementatation in the Intel VT-d driver
	  for untrusted devices (like Thunderbolt devices)

	- Fixes for runtime PM support in the OMAP iommu driver

	- MT8183 IOMMU support in the Mediatek IOMMU driver

	- Rework of the way the IOMMU core sets the default domain type for
	  groups. Changing the default domain type on x86 does not require two
	  kernel parameters anymore.

	- More smaller fixes and cleanups

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu/omap: Mark pm functions __maybe_unused

Chris Wilson (1):
      iommu/vt-d: Declare Broadwell igfx dmar support snafu

Eric Auger (1):
      iommu: Revisit iommu_insert_resv_region() implementation

Eric Dumazet (1):
      iommu/iova: Avoid false sharing on fq_timer_on

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Move IMTTBCR_SL0_TWOBIT_* to restore sort order

Gustavo A. R. Silva (1):
      iommu/qcom: Use struct_size() helper

Hai Nguyen Pham (1):
      iommu/ipmmu-vmsa: Disable cache snoop transactions on R-Car Gen3

Joerg Roedel (17):
      iommu/omap: Fix compilation warnings
      Merge branch 'for-joerg/batched-unmap' of git://git.kernel.org/.../will/linux into core
      iommu: Remember when default domain type was set on kernel command line
      iommu: Add helpers to set/get default domain type
      iommu: Use Functions to set default domain type in iommu_set_def_domain_type()
      iommu/amd: Request passthrough mode from IOMMU core
      iommu/vt-d: Request passthrough mode from IOMMU core
      x86/dma: Get rid of iommu_pass_through
      ia64: Get rid of iommu_pass_through
      iommu: Print default domain type on boot
      iommu: Set default domain type at runtime
      iommu: Disable passthrough mode when SME is active
      Documentation: Update Documentation for iommu.passthrough
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branch 'arm/smmu' into arm/mediatek
      iommu: Don't use sme_active() in generic code
      Merge branches 'arm/omap', 'arm/exynos', 'arm/smmu', 'arm/mediatek', 'arm/qcom', 'arm/renesas', 'x86/amd', 'x86/vt-d' and 'core' into next

Kai-Heng Feng (1):
      iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge systems

Kyung Min Park (1):
      iommu/vt-d: Add Scalable Mode fault information

Lu Baolu (5):
      swiotlb: Split size parameter to map/unmap APIs
      iommu/vt-d: Check whether device requires bounce buffer
      iommu/vt-d: Don't switch off swiotlb if bounce page is used
      iommu/vt-d: Add trace events for device dma map/unmap
      iommu/vt-d: Use bounce buffer for untrusted devices

Marek Szyprowski (1):
      iommu/exynos: Remove __init annotation from exynos_sysmmu_probe()

Nadav Amit (1):
      iommu/vt-d: Fix wrong analysis whether devices share the same bus

Qian Cai (1):
      iommu/amd: Silence warnings under memory pressure

Robin Murphy (18):
      iommu/arm-smmu: Mask TLBI address correctly
      iommu/qcom: Mask TLBI addresses correctly
      iommu/arm-smmu: Convert GR0 registers to bitfields
      iommu/arm-smmu: Convert GR1 registers to bitfields
      iommu/arm-smmu: Convert context bank registers to bitfields
      iommu/arm-smmu: Rework cb_base handling
      iommu/arm-smmu: Split arm_smmu_tlb_inv_range_nosync()
      iommu/arm-smmu: Get rid of weird "atomic" write
      iommu/arm-smmu: Abstract GR1 accesses
      iommu/arm-smmu: Abstract context bank accesses
      iommu/arm-smmu: Abstract GR0 accesses
      iommu/arm-smmu: Rename arm-smmu-regs.h
      iommu/arm-smmu: Add implementation infrastructure
      iommu/arm-smmu: Move Secure access quirk to implementation
      iommu/arm-smmu: Add configuration implementation hook
      iommu/arm-smmu: Add reset implementation hook
      iommu/arm-smmu: Add context init implementation hook
      iommu/arm-smmu: Ensure 64-bit I/O accessors are available on 32-bit CPU

Stephen Boyd (1):
      iommu: Remove dev_err() usage after platform_get_irq()

Suman Anna (7):
      iommu/omap: fix boot issue on remoteprocs with AMMU/Unicache
      iommu/omap: add pdata ops for omap_device_enable/idle
      iommu/omap: streamline enable/disable through runtime pm callbacks
      iommu/omap: add logic to save/restore locked TLBs
      iommu/omap: Add system suspend/resume support
      iommu/omap: introduce new API for runtime suspend/resume control
      iommu/omap: Use the correct type for SLAB_HWCACHE_ALIGN

Suthikulpanit, Suravee (1):
      iommu/amd: Re-factor guest virtual APIC (de-)activation code

Tero Kristo (2):
      iommu/omap: add support for late attachment of iommu devices
      iommu/omap: remove pm_runtime_irq_safe flag for OMAP IOMMUs

Tom Murphy (1):
      iommu: Remove wrong default domain comments

Will Deacon (29):
      iommu: Remove empty iommu_tlb_range_add() callback from iommu_ops
      iommu/io-pgtable-arm: Remove redundant call to io_pgtable_tlb_sync()
      iommu/io-pgtable: Rename iommu_gather_ops to iommu_flush_ops
      iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes
      iommu: Introduce iommu_iotlb_gather_add_page()
      iommu: Pass struct iommu_iotlb_gather to ->unmap() and ->iotlb_sync()
      iommu/io-pgtable: Introduce tlb_flush_walk() and tlb_flush_leaf()
      iommu/io-pgtable: Hook up ->tlb_flush_walk() and ->tlb_flush_leaf() in drivers
      iommu/io-pgtable-arm: Call ->tlb_flush_walk() and ->tlb_flush_leaf()
      iommu/io-pgtable: Replace ->tlb_add_flush() with ->tlb_add_page()
      iommu/io-pgtable: Remove unused ->tlb_sync() callback
      iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->unmap()
      iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->tlb_add_page()
      iommu/arm-smmu-v3: Separate s/w and h/w views of prod and cons indexes
      iommu/arm-smmu-v3: Drop unused 'q' argument from Q_OVF macro
      iommu/arm-smmu-v3: Move low-level queue fields out of arm_smmu_queue
      iommu/arm-smmu-v3: Operate directly on low-level queue where possible
      iommu/arm-smmu-v3: Reduce contention during command-queue insertion
      iommu/arm-smmu-v3: Defer TLB invalidation until ->iotlb_sync()
      iommu/arm-smmu: Make private implementation details static
      iommu/arm-smmu-v3: Document ordering guarantees of command insertion
      iommu/arm-smmu-v3: Disable detection of ATS and PRI
      iommu/arm-smmu-v3: Remove boolean bitfield for 'ats_enabled' flag
      iommu/arm-smmu-v3: Don't issue CMD_SYNC for zero-length invalidations
      iommu/arm-smmu-v3: Rework enabling/disabling of ATS for PCI masters
      iommu/arm-smmu-v3: Fix ATC invalidation ordering wrt main TLBs
      iommu/arm-smmu-v3: Avoid locking on invalidation path when not using ATS
      Revert "iommu/arm-smmu-v3: Disable detection of ATS and PRI"
      Merge branches 'for-joerg/arm-smmu/smmu-v2' and 'for-joerg/arm-smmu/smmu-v3' into for-joerg/arm-smmu/updates

Yong Wu (23):
      dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
      iommu/mediatek: Use a struct as the platform data
      memory: mtk-smi: Use a general config_port interface
      memory: mtk-smi: Use a struct for the platform data for smi-common
      iommu/mediatek: Fix iova_to_phys PA start for 4GB mode
      iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr helpers
      iommu/io-pgtable-arm-v7s: Use ias/oas to check the valid iova/pa
      iommu/io-pgtable-arm-v7s: Rename the quirk from MTK_4GB to MTK_EXT
      iommu/io-pgtable-arm-v7s: Extend to support PA[33:32] for MediaTek
      iommu/mediatek: Adjust the PA for the 4GB Mode
      iommu/mediatek: Add bclk can be supported optionally
      iommu/mediatek: Add larb-id remapped support
      iommu/mediatek: Refine protect memory definition
      iommu/mediatek: Move reset_axi into plat_data
      iommu/mediatek: Move vld_pa_rng into plat_data
      memory: mtk-smi: Add gals support
      iommu/mediatek: Add mt8183 IOMMU support
      iommu/mediatek: Add mmu1 support
      memory: mtk-smi: Invoke pm runtime_callback to enable clocks
      memory: mtk-smi: Add bus_sel for mt8183
      iommu/mediatek: Fix VLD_PA_RNG register backup when suspend
      memory: mtk-smi: Get rid of need_larbid
      iommu/mediatek: Clean up struct mtk_smi_iommu

YueHaibing (1):
      iommu/arm-smmu-v3: Fix build error without CONFIG_PCI_ATS

Yunsheng Lin (1):
      iommu/dma: Fix for dereferencing before null checking

 Documentation/admin-guide/kernel-parameters.txt    |   7 +-
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  30 +-
 .../memory-controllers/mediatek,smi-common.txt     |  12 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   4 +
 MAINTAINERS                                        |   3 +-
 arch/arm/mach-omap2/Makefile                       |   2 +
 arch/arm/mach-omap2/omap-iommu.c                   |  43 +
 arch/ia64/include/asm/iommu.h                      |   2 -
 arch/ia64/kernel/pci-dma.c                         |   2 -
 arch/x86/include/asm/iommu.h                       |   1 -
 arch/x86/kernel/pci-dma.c                          |  20 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |  24 +-
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/Makefile                             |   5 +-
 drivers/iommu/amd_iommu.c                          | 106 ++-
 drivers/iommu/amd_iommu.h                          |  14 +
 drivers/iommu/amd_iommu_init.c                     |   5 +-
 drivers/iommu/amd_iommu_quirks.c                   |  92 ++
 drivers/iommu/amd_iommu_types.h                    |   9 +
 drivers/iommu/arm-smmu-impl.c                      | 174 ++++
 drivers/iommu/arm-smmu-regs.h                      | 210 -----
 drivers/iommu/arm-smmu-v3.c                        | 980 ++++++++++++++++-----
 drivers/iommu/arm-smmu.c                           | 662 ++++++--------
 drivers/iommu/arm-smmu.h                           | 402 +++++++++
 drivers/iommu/dma-iommu.c                          |  13 +-
 drivers/iommu/dmar.c                               |  77 +-
 drivers/iommu/exynos-iommu.c                       |   9 +-
 drivers/iommu/intel-iommu.c                        | 359 +++++++-
 drivers/iommu/intel-trace.c                        |  14 +
 drivers/iommu/intel_irq_remapping.c                |   6 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 | 145 ++-
 drivers/iommu/io-pgtable-arm.c                     |  48 +-
 drivers/iommu/iommu.c                              | 217 +++--
 drivers/iommu/iova.c                               |   4 +-
 drivers/iommu/ipmmu-vmsa.c                         | 106 ++-
 drivers/iommu/msm_iommu.c                          |  43 +-
 drivers/iommu/mtk_iommu.c                          | 213 +++--
 drivers/iommu/mtk_iommu.h                          |  21 +-
 drivers/iommu/mtk_iommu_v1.c                       |   9 +-
 drivers/iommu/omap-iommu.c                         | 324 ++++++-
 drivers/iommu/omap-iommu.h                         |   9 +-
 drivers/iommu/qcom_iommu.c                         |  72 +-
 drivers/iommu/rockchip-iommu.c                     |   2 +-
 drivers/iommu/s390-iommu.c                         |   3 +-
 drivers/iommu/tegra-gart.c                         |  12 +-
 drivers/iommu/tegra-smmu.c                         |   2 +-
 drivers/iommu/virtio-iommu.c                       |   5 +-
 drivers/memory/mtk-smi.c                           | 268 ++++--
 drivers/vfio/vfio_iommu_type1.c                    |  27 +-
 drivers/xen/swiotlb-xen.c                          |   8 +-
 include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++
 include/linux/amd-iommu.h                          |  12 +
 include/linux/blk_types.h                          |   5 +-
 include/linux/intel-iommu.h                        |   2 +
 include/linux/io-pgtable.h                         |  66 +-
 include/linux/iommu.h                              | 108 ++-
 include/linux/omap-iommu.h                         |  15 +
 include/linux/platform_data/iommu-omap.h           |   4 +
 include/linux/swiotlb.h                            |   8 +-
 include/soc/mediatek/smi.h                         |   5 -
 include/trace/events/intel_iommu.h                 | 106 +++
 kernel/dma/direct.c                                |   2 +-
 kernel/dma/swiotlb.c                               |  34 +-
 63 files changed, 3851 insertions(+), 1472 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-iommu.c
 create mode 100644 drivers/iommu/amd_iommu.h
 create mode 100644 drivers/iommu/amd_iommu_quirks.c
 create mode 100644 drivers/iommu/arm-smmu-impl.c
 delete mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/arm-smmu.h
 create mode 100644 drivers/iommu/intel-trace.c
 create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h
 create mode 100644 include/trace/events/intel_iommu.h

Please pull.

Thanks,

	Joerg

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl1/pqYACgkQK/BELZcB
GuOBgw/+MhlK8Ops0CWM4ElVJRBZwnAbs8ZCDfYru4xm5jHchK1TtpMxQLX6mWxM
MB+RTudr+8uZX4kZ6vQLuoEJfeuP+p8wwG+3T5pYMAn7LDQqb748Np2kXru/dBxU
JGzZa7tQhlriiEFKaz+7rTKTbEeNH0coqCqrludFsxwmFMPRhrN5cQg9Ban0zMEJ
Xm4HN2coQOkdf4EX25P5Pt0DCE6iKupi7zuBsL4uEsUApir0L0e+dUsETRcwaEf+
UDgKDhP2brptsIILu3819bZpALqaYMtNezJVCTL8AwrRBGJphcMLc/dosaONVcgt
sGE6DxxNhVfmTx6MnYdATW/tEd6SdhJzRh2sxa3a06fSUfSyjZHWU0HAIPFDs5vW
JjlhfNYXlX3Y9sCUJ8LBIUggmG3+velGmUbUcqVLvLej7SPkLLmDvesw6iRwkpqR
NMLOFZ8hx3sADCGSUWCbHdff5uwNGdSNYp56IuGBBuiRvU9ee67WKVdqtBbCoXBI
YE4hRyIHvd/Q21OwyDPu1YhdE5wsEFTVMQSS6mN2GCf6k+0qpOz43jSd9leVgOmE
8QYigMB4JCWNU8/bNygG5y4s22KeRUrjZojGzV+1JRmpbeuI/UYLfmW8+eNnSdC5
bypvy2R1b4j4+dyrR4lyei+ci+VbkwxbBQLS4ueTNoRpfDHDDao=
=HOeV
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
