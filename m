Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDDE217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=inuits.eu header.i=@inuits.eu header.b="gyTyHUzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDKJUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:20:43 -0400
Received: from zimbra8.inuits.eu ([136.243.84.118]:47164 "EHLO
        zimbra8.inuits.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfDKJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:20:43 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2019 05:20:40 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra8.inuits.eu (Postfix) with ESMTP id BB2576097F;
        Thu, 11 Apr 2019 11:12:18 +0200 (CEST)
Received: from zimbra8.inuits.eu ([127.0.0.1])
        by localhost (zimbra8.inuits.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id s_x82r0czclh; Thu, 11 Apr 2019 11:12:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra8.inuits.eu (Postfix) with ESMTP id CFE5C60B20;
        Thu, 11 Apr 2019 11:12:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra8.inuits.eu CFE5C60B20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inuits.eu;
        s=FD9F633A-D6A0-11E7-8AD8-AAD64DD3D410; t=1554973937;
        bh=Qx0VzN8NzI2ipKA/yCoCXkY4D8NWMHXT42njaBT/biU=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=gyTyHUzQRY9fLYVPMGoKIjzZnHhR2BQuLyJw2ksf2u2FxEYIDq0GIXVBv0UmnvzgC
         4V2Gyc7TUPu09JF2D+EGYLV3++oS2o4GW70v9wMU9XMNsnLKZ9CY1drI+x2I3ITRiY
         uUFlKjwsoC63OrRyWd34ZCGLklouymvtYhEsR7mD550iOk9WSNgAZ5EqynBpq104+Z
         hQE0A2OZZg8DhMV7b/9XwCkSLFcStwIJZflGcVkvS16s9Xeg3N9XuL1rS35MpUbcer
         4bM7G+pp/Wt8Xesnp46kGvSFbbpfDrAVbWLKJIkFDp58l+fiSiOY4bUTalMIhs5gwF
         e6V+xtZNHctNQ==
X-Virus-Scanned: amavisd-new at mgmtprod.inuits.eu
Received: from zimbra8.inuits.eu ([127.0.0.1])
        by localhost (zimbra8.inuits.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M2pZQpWO4v0w; Thu, 11 Apr 2019 11:12:17 +0200 (CEST)
Received: from orval.atlantis.local (146-185-54-52.persgroep-ops.net [146.185.54.52])
        by zimbra8.inuits.eu (Postfix) with ESMTPSA id A1BD56097F;
        Thu, 11 Apr 2019 11:12:17 +0200 (CEST)
Message-ID: <0b6539fe5b2741b1327119236ea0e401d02003e6.camel@inuits.eu>
Subject: [GIT PULL] <global> global spelling corrections for v5.1.0-rc5
From:   Kenny Van de Maele <kenny.vandemaele@inuits.eu>
To:     torvalds@linux-foundation.org
Cc:     torvalds@osdl.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Apr 2019 11:12:19 +0200
Organization: Inuits
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_I hope I did this right... Apologies if I made a procedure mistake._

The following changes since commit
582549e3fbe137eb6ce9be591aca25c2222a36b4:

  Merge tag 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-04-10
09:39:04 -1000)

are available in the Git repository at:

  git://github.com/vdmkenny/linux-spelling-fix.git tags/common-
spelling-fixes-5.1.0-rc5

for you to fetch changes up to
6ee0055f3414a64133228e82004ea60d0e659d6d:

  fix common spelling mistakes (2019-04-11 10:22:24 +0200)

----------------------------------------------------------------
This PR contains a set of global spelling fixes of commonly miss-
spelled
words. Mostly documentation and comments were impacted, but a few lines
of code were affected as well.

----------------------------------------------------------------
Kenny Van de Maele (1):
      fix common spelling mistakes

 Documentation/ABI/testing/sysfs-fs-f2fs                   |  2 +-
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt |  2 +-
 Documentation/networking/ip-sysctl.txt                    |  2 +-
 arch/arc/plat-eznps/entry.S                               |  2 +-
 arch/arm/include/asm/xen/page-coherent.h                  |  2 +-
 arch/arm/kernel/entry-header.S                            |  2 +-
 arch/arm/mach-imx/mm-imx3.c                               |  2 +-
 arch/arm/mach-imx/suspend-imx6.S                          |  2 +-
 arch/arm/net/bpf_jit_32.c                                 |  2 +-
 arch/arm64/include/asm/xen/page-coherent.h                |  2 +-
 arch/c6x/kernel/asm-offsets.c                             |  2 +-
 arch/c6x/kernel/entry.S                                   |  2 +-
 arch/m68k/math-emu/fp_util.S                              |  2 +-
 arch/powerpc/include/asm/book3s/64/radix.h                |  2 +-
 arch/powerpc/kvm/book3s_xive.c                            |  4 ++--
 arch/powerpc/mm/hash_native_64.c                          |  2 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S              |  2 +-
 arch/x86/kernel/traps.c                                   |  2 +-
 drivers/acpi/video_detect.c                               |  2 +-
 drivers/bus/mvebu-mbus.c                                  |  2 +-
 drivers/clk/clk-hsdk-pll.c                                |  2 +-
 drivers/clk/ingenic/cgu.h                                 |  2 +-
 drivers/clk/meson/axg.c                                   |  2 +-
 drivers/clk/meson/g12a.c                                  |  2 +-
 drivers/clk/meson/gxbb.c                                  |  2 +-
 drivers/clk/rockchip/clk-cpu.c                            |  2 +-
 drivers/clk/samsung/clk-cpu.c                             |  2 +-
 drivers/crypto/cavium/cpt/cptpf_main.c                    |  8 ++++---
-
 drivers/crypto/cavium/cpt/cptvf_main.c                    |  4 ++--
 drivers/crypto/cavium/nitrox/nitrox_isr.c                 |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_isr.h                 |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_sriov.c               |  2 +-
 drivers/crypto/ux500/hash/hash_alg.h                      |  2 +-
 drivers/dma/qcom/bam_dma.c                                |  2 +-
 drivers/firmware/efi/efi.c                                |  2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c            |  2 +-
 drivers/firmware/efi/memmap.c                             |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                    |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                     |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                     |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                     |  4 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c   |  4 ++--
 drivers/gpu/drm/amd/display/dc/inc/compressor.h           |  2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c   |  2 +-
 drivers/gpu/drm/drm_plane_helper.c                        |  2 +-
 drivers/gpu/drm/drm_vblank.c                              |  4 ++--
 drivers/gpu/drm/i915/i915_irq.c                           |  2 +-
 drivers/gpu/drm/i915/i915_vma.c                           |  2 +-
 drivers/gpu/drm/i915/intel_atomic.c                       |  2 +-
 drivers/gpu/drm/i915/intel_pm.c                           |  2 +-
 drivers/gpu/drm/radeon/radeon_vm.c                        |  2 +-
 drivers/gpu/drm/radeon/uvd_v1_0.c                         |  4 ++--
 drivers/gpu/drm/tegra/hdmi.c                              |  2 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c                  |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                       |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                       |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                  |  2 +-
 drivers/hid/hid-appleir.c                                 |  2 +-
 drivers/hid/usbhid/hiddev.c                               | 24
+++++++++++-----------
 drivers/i2c/busses/i2c-cadence.c                          |  2 +-
 drivers/i2c/busses/i2c-cpm.c                              |  2 +-
 drivers/i2c/busses/i2c-designware-common.c                |  2 +-
 drivers/i2c/busses/i2c-viperboard.c                       |  2 +-
 drivers/infiniband/hw/hfi1/chip.c                         |  2 +-
 drivers/input/touchscreen/auo-pixcir-ts.c                 |  2 +-
 drivers/iommu/amd_iommu.c                                 |  2 +-
 drivers/irqchip/irq-bcm7120-l2.c                          |  2 +-
 drivers/isdn/i4l/isdn_net.c                               |  2 +-
 drivers/md/md-cluster.c                                   |  2 +-
 drivers/mfd/ab8500-core.c                                 |  2 +-
 drivers/mmc/host/meson-gx-mmc.c                           |  2 +-
 drivers/mtd/nand/raw/jz4740_nand.c                        |  2 +-
 drivers/mtd/sm_ftl.c                                      |  2 +-
 drivers/net/ethernet/amd/amd8111e.c                       |  2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c        |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c       |  6 +++---
 drivers/net/ethernet/marvell/pxa168_eth.c                 |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c               |  2 +-
 drivers/net/ethernet/tehuti/tehuti.c                      |  2 +-
 drivers/net/usb/rndis_host.c                              |  2 +-
 drivers/net/wireless/ath/ath.h                            |  2 +-
 drivers/net/wireless/ath/ath10k/core.h                    |  2 +-
 drivers/net/wireless/ath/wcn36xx/hal.h                    |  2 +-
 drivers/net/wireless/broadcom/b43/b43.h                   |  8 ++++---
-
 drivers/net/wireless/broadcom/b43/main.c                  |  4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c |  2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c  |  4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h    |  2 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c               |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c           |  2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c       |  2 +-
 drivers/nfc/pn533/pn533.c                                 |  2 +-
 drivers/nvme/host/core.c                                  |  2 +-
 drivers/nvme/host/fc.c                                    |  2 +-
 drivers/nvme/host/pci.c                                   |  2 +-
 drivers/pci/controller/pci-xgene-msi.c                    |  2 +-
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c              |  2 +-
 drivers/pinctrl/pinctrl-sx150x.c                          |  2 +-
 drivers/power/supply/ab8500_charger.c                     |  2 +-
 drivers/power/supply/ab8500_fg.c                          |  2 +-
 drivers/rtc/rtc-rk808.c                                   |  2 +-
 drivers/rtc/rtc-s35390a.c                                 |  2 +-
 drivers/scsi/aha152x.c                                    |  2 +-
 drivers/scsi/atp870u.c                                    |  2 +-
 drivers/scsi/csiostor/csio_scsi.c                         |  2 +-
 drivers/scsi/csiostor/csio_wr.c                           |  2 +-
 drivers/scsi/esas2r/esas2r_init.c                         |  2 +-
 drivers/scsi/isci/phy.h                                   |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                      |  2 +-
 drivers/scsi/pm8001/pm8001_hwi.c                          |  4 ++--
 drivers/scsi/pm8001/pm8001_init.c                         |  4 ++--
 drivers/scsi/pm8001/pm8001_sas.h                          |  2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                          |  4 ++--
 drivers/scsi/qla2xxx/qla_iocb.c                           |  4 ++--
 drivers/scsi/qla2xxx/qla_target.c                         |  2 +-
 drivers/scsi/snic/snic_scsi.c                             |  2 +-
 drivers/soc/dove/pmu.c                                    |  2 +-
 drivers/soc/fsl/qbman/qman_portal.c                       |  2 +-
 drivers/soc/ti/knav_qmss_queue.c                          |  2 +-
 drivers/spi/spi-bcm63xx.c                                 |  2 +-
 drivers/spi/spi-imx.c                                     |  2 +-
 drivers/staging/comedi/drivers/dt2811.c                   |  2 +-
 drivers/staging/rtl8723bs/include/hal_data.h              |  2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c               |  4 ++--
 drivers/tty/serial/men_z135_uart.c                        |  2 +-
 drivers/tty/serial/serial-tegra.c                         |  2 +-
 drivers/usb/dwc2/core.c                                   |  2 +-
 drivers/usb/dwc2/gadget.c                                 |  4 ++--
 drivers/usb/dwc2/hcd.c                                    |  4 ++--
 drivers/usb/gadget/udc/pch_udc.c                          |  2 +-
 drivers/usb/host/ehci-q.c                                 |  2 +-
 drivers/watchdog/max63xx_wdt.c                            |  2 +-
 fs/file_table.c                                           |  2 +-
 fs/gfs2/lock_dlm.c                                        |  2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c                    |  2 +-
 fs/nfs/nfs4xdr.c                                          |  2 +-
 fs/nfsd/nfs4proc.c                                        |  2 +-
 fs/pnode.c                                                |  2 +-
 fs/xfs/xfs_inode.c                                        |  2 +-
 fs/xfs/xfs_log.c                                          |  2 +-
 include/linux/ftrace.h                                    |  2 +-
 include/linux/hiddev.h                                    |  2 +-
 include/linux/ipv6.h                                      |  2 +-
 include/linux/mfd/da9063/registers.h                      |  2 +-
 include/linux/percpu-defs.h                               |  2 +-
 include/linux/ssb/ssb_regs.h                              |  2 +-
 include/linux/usb/quirks.h                                |  2 +-
 include/net/addrconf.h                                    |  4 ++--
 include/net/if_inet6.h                                    |  2 +-
 include/net/iw_handler.h                                  |  4 ++--
 include/net/ndisc.h                                       |  8 ++++---
-
 include/uapi/linux/android/binder.h                       |  2 +-
 include/uapi/linux/elf.h                                  |  2 +-
 include/uapi/linux/if_addr.h                              |  2 +-
 ipc/sem.c                                                 |  2 +-
 kernel/locking/osq_lock.c                                 |  2 +-
 kernel/sysctl_binary.c                                    |  2 +-
 lib/refcount.c                                            |  2 +-
 mm/page_ext.c                                             |  2 +-
 net/6lowpan/ndisc.c                                       |  4 ++--
 net/9p/trans_virtio.c                                     |  2 +-
 net/caif/caif_socket.c                                    |  2 +-
 net/ipv4/devinet.c                                        | 20
+++++++++---------
 net/ipv4/esp4.c                                           |  4 ++--
 net/ipv4/ipmr.c                                           |  2 +-
 net/ipv6/addrconf.c                                       | 94
++++++++++++++++++++++++++++++++++++++++++-----------------------------
-------------
 net/ipv6/esp6.c                                           |  4 ++--
 net/netfilter/nft_set_bitmap.c                            |  2 +-
 net/sunrpc/svcsock.c                                      |  2 +-
 samples/bpf/do_hbm_test.sh                                |  4 ++--
 sound/core/pcm_native.c                                   |  2 +-
 sound/soc/intel/haswell/sst-haswell-ipc.h                 |  2 +-
 tools/perf/util/parse-events.c                            |  2 +-
 tools/perf/util/s390-cpumsf.c                             |  2 +-
 tools/testing/selftests/kvm/lib/elf.c                     |  2 +-
 tools/testing/selftests/net/psock_tpacket.c               |  2 +-
 tools/testing/selftests/powerpc/vphn/test-vphn.c          |  2 +-
 181 files changed, 282 insertions(+), 282 deletions(-)

