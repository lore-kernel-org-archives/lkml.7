Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64725C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058F1213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553417062;
	bh=FoyjvYNoN9iniJ7j5UF4gwiBdJNoNRooGbsUH/i+JlM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=W37fmXkqWkPmo8zUqVMtwxL9eMKKsVOf2uEDENl3AVw689UCy1ytPH+vcTd9b4KQt
	 Cl4RZ+XSkFwXMxrfUv7jcAD/hKk6ye3Z1te6EdbySCmdBnlVe4Lqz+bpm3IyNLFYhQ
	 vIiG9O+G5Aj2dYa3K4GLKPS4eNOm/w9VQJUjyXp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfCXIoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 04:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfCXIoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 04:44:19 -0400
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13AF9213F2;
        Sun, 24 Mar 2019 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553417057;
        bh=FoyjvYNoN9iniJ7j5UF4gwiBdJNoNRooGbsUH/i+JlM=;
        h=Date:From:To:Cc:Subject:From;
        b=WPLlKmy2/ELdPlH9XaD6D6lr0Idh1ttzdXFgmDXeUw4mYbkACZKgdmlwfFaeseMsu
         d+d3rvbXhF8habS4v8ZtxGL4SWWmVxy+1uArcEPJnBvE0a7U50lJK7vOD+JgP2ZcKY
         2wUsxjNZFm/Qb5w37c2yYUqzTQg4ahCTKWW7/C/0=
Date:   Sun, 24 Mar 2019 09:44:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.177
Message-ID: <20190324084415.GA6072@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.4.177 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arc/include/asm/bitops.h                              |    6 
 arch/arc/include/asm/uaccess.h                             |    8 
 arch/arc/kernel/head.S                                     |   10 
 arch/arm/Kconfig                                           |    1 
 arch/arm/boot/dts/exynos3250.dtsi                          |    3 
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi          |   25 
 arch/arm/boot/dts/exynos5420.dtsi                          |   10 
 arch/arm/include/asm/irq.h                                 |    1 
 arch/arm/kernel/irq.c                                      |   62 --
 arch/arm/kernel/smp.c                                      |    2 
 arch/arm/kvm/mmio.c                                        |   10 
 arch/arm/mach-omap2/display.c                              |    7 
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c                    |    8 
 arch/arm/plat-pxa/ssp.c                                    |    3 
 arch/arm64/crypto/aes-ce-ccm-core.S                        |    5 
 arch/arm64/kernel/head.S                                   |    3 
 arch/m68k/Makefile                                         |    5 
 arch/mips/configs/ath79_defconfig                          |    1 
 arch/mips/jazz/jazzdma.c                                   |    5 
 arch/mips/kernel/irq.c                                     |    4 
 arch/mips/kernel/process.c                                 |    7 
 arch/powerpc/include/asm/epapr_hcalls.h                    |   12 
 arch/powerpc/kernel/entry_32.S                             |    9 
 arch/powerpc/platforms/83xx/suspend-asm.S                  |   34 +
 arch/powerpc/platforms/embedded6xx/wii.c                   |    4 
 arch/powerpc/platforms/powernv/opal-msglog.c               |    2 
 arch/x86/include/asm/page_64_types.h                       |    4 
 arch/x86/include/asm/uaccess.h                             |    7 
 arch/x86/include/asm/uv/bios.h                             |    8 
 arch/x86/kernel/cpu/amd.c                                  |    8 
 arch/x86/kernel/kexec-bzimage64.c                          |    3 
 arch/x86/kvm/svm.c                                         |    8 
 arch/x86/kvm/vmx.c                                         |   17 
 arch/x86/kvm/x86.c                                         |    1 
 arch/x86/platform/uv/bios_uv.c                             |   23 
 arch/xtensa/configs/smp_lx200_defconfig                    |    1 
 arch/xtensa/kernel/head.S                                  |    5 
 arch/xtensa/kernel/smp.c                                   |   41 +
 arch/xtensa/kernel/time.c                                  |    2 
 crypto/ahash.c                                             |   14 
 crypto/pcbc.c                                              |   14 
 drivers/acpi/device_sysfs.c                                |    6 
 drivers/atm/he.c                                           |    2 
 drivers/base/power/wakeup.c                                |    8 
 drivers/char/applicom.c                                    |   35 -
 drivers/clk/ingenic/cgu.c                                  |   10 
 drivers/clocksource/exynos_mct.c                           |   23 
 drivers/cpufreq/cpufreq.c                                  |    6 
 drivers/cpufreq/cpufreq_governor.h                         |   10 
 drivers/cpufreq/intel_pstate.c                             |   14 
 drivers/cpufreq/pxa2xx-cpufreq.c                           |    4 
 drivers/cpufreq/tegra124-cpufreq.c                         |    2 
 drivers/crypto/caam/caamalg.c                              |    1 
 drivers/dma/at_xdmac.c                                     |   19 
 drivers/dma/dmatest.c                                      |   28 -
 drivers/dma/sh/usb-dmac.c                                  |    2 
 drivers/firmware/efi/runtime-wrappers.c                    |    7 
 drivers/firmware/iscsi_ibft.c                              |    1 
 drivers/gpio/gpio-vf610.c                                  |    5 
 drivers/gpu/drm/msm/msm_rd.c                               |    7 
 drivers/gpu/drm/radeon/evergreen_cs.c                      |    1 
 drivers/gpu/ipu-v3/ipu-common.c                            |    8 
 drivers/hwtracing/intel_th/gth.c                           |    4 
 drivers/hwtracing/stm/core.c                               |   11 
 drivers/i2c/busses/i2c-cadence.c                           |    9 
 drivers/i2c/busses/i2c-tegra.c                             |    2 
 drivers/infiniband/hw/qib/qib_ud.c                         |    1 
 drivers/infiniband/ulp/srp/ib_srp.c                        |   10 
 drivers/input/keyboard/matrix_keypad.c                     |    2 
 drivers/input/keyboard/st-keyscan.c                        |    4 
 drivers/input/mouse/elan_i2c_core.c                        |    1 
 drivers/input/tablet/wacom_serial4.c                       |    2 
 drivers/iommu/amd_iommu.c                                  |   15 
 drivers/irqchip/irq-mmp.c                                  |    6 
 drivers/isdn/hardware/avm/b1.c                             |    2 
 drivers/isdn/i4l/isdn_tty.c                                |    8 
 drivers/leds/leds-lp5523.c                                 |    4 
 drivers/md/raid10.c                                        |    3 
 drivers/md/raid5.c                                         |    2 
 drivers/media/usb/uvc/uvc_driver.c                         |   14 
 drivers/media/usb/uvc/uvc_video.c                          |    8 
 drivers/media/v4l2-core/videobuf2-v4l2.c                   |    1 
 drivers/mfd/ab8500-core.c                                  |    2 
 drivers/mfd/db8500-prcmu.c                                 |    4 
 drivers/mfd/mc13xxx-core.c                                 |    4 
 drivers/mfd/qcom_rpm.c                                     |    4 
 drivers/mfd/ti_am335x_tscadc.c                             |    5 
 drivers/mfd/twl-core.c                                     |    4 
 drivers/mfd/wm5110-tables.c                                |    2 
 drivers/mmc/host/mmc_spi.c                                 |    1 
 drivers/net/dsa/mv88e6xxx.c                                |    2 
 drivers/net/ethernet/altera/altera_msgdma.c                |    3 
 drivers/net/ethernet/altera/altera_tse_main.c              |    4 
 drivers/net/ethernet/atheros/atlx/atl2.c                   |    4 
 drivers/net/ethernet/broadcom/bcmsysport.c                 |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                  |    6 
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c          |    6 
 drivers/net/ethernet/hisilicon/hns_mdio.c                  |    2 
 drivers/net/ethernet/ibm/ibmveth.c                         |    2 
 drivers/net/ethernet/marvell/mv643xx_eth.c                 |    7 
 drivers/net/ethernet/marvell/sky2.c                        |   24 
 drivers/net/ethernet/mellanox/mlx4/cmd.c                   |    1 
 drivers/net/ethernet/mellanox/mlx4/en_rx.c                 |   23 
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c      |    6 
 drivers/net/ethernet/renesas/ravb_main.c                   |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c             |    4 
 drivers/net/ipvlan/ipvlan_main.c                           |    9 
 drivers/net/phy/mdio_bus.c                                 |    1 
 drivers/net/phy/micrel.c                                   |   14 
 drivers/net/ppp/pptp.c                                     |    1 
 drivers/net/team/team.c                                    |   27 -
 drivers/net/team/team_mode_loadbalance.c                   |   15 
 drivers/net/vxlan.c                                        |   13 
 drivers/net/wireless/mac80211_hwsim.c                      |    2 
 drivers/net/xen-netback/netback.c                          |   10 
 drivers/parport/parport_pc.c                               |    2 
 drivers/pinctrl/meson/pinctrl-meson8b.c                    |    2 
 drivers/platform/x86/Kconfig                               |    1 
 drivers/regulator/s2mpa01.c                                |   10 
 drivers/regulator/s2mps11.c                                |    6 
 drivers/s390/block/dasd_eckd.c                             |    8 
 drivers/s390/net/qeth_core_main.c                          |   15 
 drivers/s390/virtio/virtio_ccw.c                           |    4 
 drivers/scsi/csiostor/csio_attr.c                          |    2 
 drivers/scsi/isci/init.c                                   |   14 
 drivers/scsi/libfc/fc_lport.c                              |    6 
 drivers/scsi/libiscsi.c                                    |    6 
 drivers/scsi/libsas/sas_expander.c                         |    2 
 drivers/scsi/qla4xxx/ql4_os.c                              |    2 
 drivers/scsi/virtio_scsi.c                                 |    2 
 drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c        |    9 
 drivers/staging/lustre/lnet/lnet/config.c                  |   14 
 drivers/staging/lustre/lnet/selftest/conrpc.c              |    4 
 drivers/staging/lustre/lnet/selftest/console.c             |    6 
 drivers/staging/lustre/lustre/include/lustre_disk.h        |    1 
 drivers/staging/lustre/lustre/libcfs/debug.c               |    6 
 drivers/staging/lustre/lustre/libcfs/hash.c                |    3 
 drivers/staging/lustre/lustre/libcfs/workitem.c            |    4 
 drivers/staging/lustre/lustre/llite/dir.c                  |    2 
 drivers/staging/lustre/lustre/lov/lov_pool.c               |    3 
 drivers/staging/lustre/lustre/obdclass/obd_mount.c         |   10 
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c             |    1 
 drivers/staging/lustre/lustre/ptlrpc/sec_config.c          |    3 
 drivers/staging/rdma/hfi1/ud.c                             |    1 
 drivers/target/iscsi/iscsi_target.c                        |    4 
 drivers/thermal/int340x_thermal/processor_thermal_device.c |    2 
 drivers/tty/serial/8250/8250_pci.c                         |  141 ++++-
 drivers/tty/serial/fsl_lpuart.c                            |    2 
 drivers/usb/dwc3/gadget.c                                  |    1 
 drivers/usb/gadget/function/f_sourcesink.c                 |    2 
 drivers/usb/serial/cp210x.c                                |    1 
 drivers/usb/serial/ftdi_sio.c                              |    2 
 drivers/usb/serial/ftdi_sio_ids.h                          |    6 
 drivers/usb/serial/option.c                                |    2 
 fs/9p/cache.c                                              |    8 
 fs/9p/v9fs.h                                               |    2 
 fs/9p/v9fs_vfs.h                                           |   23 
 fs/9p/vfs_file.c                                           |    6 
 fs/9p/vfs_inode.c                                          |   25 
 fs/9p/vfs_inode_dotl.c                                     |   27 -
 fs/9p/vfs_super.c                                          |    4 
 fs/autofs4/expire.c                                        |    3 
 fs/autofs4/inode.c                                         |    4 
 fs/btrfs/extent_io.c                                       |    4 
 fs/btrfs/volumes.c                                         |    4 
 fs/ceph/snap.c                                             |    3 
 fs/cifs/file.c                                             |   12 
 fs/cifs/smb2pdu.h                                          |    4 
 fs/drop_caches.c                                           |    8 
 fs/ext2/super.c                                            |   39 -
 fs/ext4/resize.c                                           |    3 
 fs/hugetlbfs/inode.c                                       |   12 
 fs/jbd2/transaction.c                                      |   33 -
 fs/ncpfs/ioctl.c                                           |    4 
 fs/nfs/direct.c                                            |   15 
 fs/nfs/filelayout/filelayout.c                             |   17 
 fs/nfs/flexfilelayout/flexfilelayout.c                     |   25 
 fs/nfs/pagelist.c                                          |   12 
 fs/nfs/pnfs.c                                              |   24 
 fs/nfs/read.c                                              |    2 
 fs/nfs/super.c                                             |    5 
 fs/nfsd/nfs3proc.c                                         |   16 
 fs/nfsd/nfs3xdr.c                                          |    1 
 fs/nfsd/nfsctl.c                                           |    2 
 include/keys/user-type.h                                   |    2 
 include/linux/cpufreq.h                                    |   12 
 include/linux/device-mapper.h                              |    2 
 include/net/gro_cells.h                                    |   12 
 include/net/icmp.h                                         |    9 
 include/net/ip.h                                           |    2 
 include/net/phonet/pep.h                                   |    5 
 kernel/futex.c                                             |    7 
 kernel/locking/rtmutex.c                                   |   52 +-
 kernel/locking/rtmutex_common.h                            |    8 
 kernel/rcu/tree.c                                          |   20 
 kernel/sysctl.c                                            |   11 
 kernel/trace/trace.c                                       |    1 
 lib/assoc_array.c                                          |    8 
 mm/hugetlb.c                                               |   14 
 mm/memory_hotplug.c                                        |    6 
 mm/mempolicy.c                                             |    6 
 mm/migrate.c                                               |   11 
 mm/mmap.c                                                  |    7 
 mm/shmem.c                                                 |   12 
 mm/vmalloc.c                                               |    2 
 net/9p/client.c                                            |    2 
 net/batman-adv/soft-interface.c                            |    2 
 net/bridge/br_multicast.c                                  |    9 
 net/bridge/netfilter/ebtables.c                            |    4 
 net/ceph/messenger.c                                       |   12 
 net/core/net-sysfs.c                                       |    3 
 net/hsr/hsr_device.c                                       |   18 
 net/hsr/hsr_framereg.c                                     |   12 
 net/hsr/hsr_framereg.h                                     |    1 
 net/ipv4/cipso_ipv4.c                                      |   23 
 net/ipv4/icmp.c                                            |    7 
 net/ipv4/inet_connection_sock.c                            |    2 
 net/ipv4/ip_options.c                                      |   22 
 net/ipv4/ip_vti.c                                          |   50 +
 net/ipv4/netfilter/arp_tables.c                            |    2 
 net/ipv4/netfilter/ip_tables.c                             |    2 
 net/ipv4/route.c                                           |    4 
 net/ipv4/syncookies.c                                      |    7 
 net/ipv4/tcp_input.c                                       |    8 
 net/ipv4/udp.c                                             |    2 
 net/ipv4/udp_impl.h                                        |    2 
 net/ipv4/udplite.c                                         |    2 
 net/ipv6/ip6mr.c                                           |    8 
 net/ipv6/netfilter/ip6_tables.c                            |    2 
 net/ipv6/route.c                                           |    2 
 net/ipv6/sit.c                                             |    7 
 net/ipv6/udp.c                                             |    2 
 net/ipv6/udp_impl.h                                        |    2 
 net/ipv6/udplite.c                                         |    2 
 net/l2tp/l2tp_ip6.c                                        |    4 
 net/mac80211/cfg.c                                         |    4 
 net/mac80211/rx.c                                          |    4 
 net/netfilter/ipvs/ip_vs_ctl.c                             |   12 
 net/netfilter/nf_conntrack_proto_tcp.c                     |    4 
 net/netfilter/nfnetlink_acct.c                             |    3 
 net/netfilter/nfnetlink_log.c                              |    2 
 net/nfc/llcp_commands.c                                    |   20 
 net/nfc/llcp_core.c                                        |   24 
 net/packet/af_packet.c                                     |    2 
 net/phonet/pep.c                                           |   32 -
 net/socket.c                                               |   24 
 net/unix/af_unix.c                                         |   48 +
 net/unix/diag.c                                            |    3 
 net/wireless/reg.c                                         |    4 
 net/x25/af_x25.c                                           |   20 
 security/keys/key.c                                        |    4 
 security/keys/keyring.c                                    |    4 
 security/keys/proc.c                                       |   11 
 security/keys/request_key.c                                |    1 
 security/keys/request_key_auth.c                           |    2 
 security/lsm_audit.c                                       |   10 
 sound/core/compress_offload.c                              |    3 
 sound/firewire/bebob/bebob.c                               |   14 
 sound/soc/fsl/fsl_esai.c                                   |    7 
 sound/soc/fsl/imx-audmux.c                                 |   24 
 sound/soc/intel/boards/broadwell.c                         |    2 
 sound/soc/intel/boards/haswell.c                           |    2 
 sound/soc/soc-dapm.c                                       |   10 
 sound/soc/soc-topology.c                                   |    8 
 tools/arch/x86/include/asm/cpufeatures.h                   |  336 +++++++++++++
 tools/arch/x86/include/asm/disabled-features.h             |   65 ++
 tools/arch/x86/include/asm/required-features.h             |  106 ++++
 tools/arch/x86/lib/memcpy_64.S                             |  179 ++++++
 tools/arch/x86/lib/memset_64.S                             |  138 +++++
 tools/include/asm/alternative-asm.h                        |    9 
 tools/perf/MANIFEST                                        |    8 
 tools/perf/Makefile.perf                                   |   15 
 tools/perf/bench/mem-memcpy-x86-64-asm.S                   |    2 
 tools/perf/bench/mem-memset-x86-64-asm.S                   |    2 
 tools/perf/util/auxtrace.c                                 |    4 
 tools/perf/util/auxtrace.h                                 |    3 
 tools/perf/util/cpumap.c                                   |   11 
 tools/perf/util/include/asm/alternative-asm.h              |    9 
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c        |   37 +
 tools/perf/util/symbol-elf.c                               |    9 
 virt/kvm/arm/vgic.c                                        |    7 
 282 files changed, 2469 insertions(+), 803 deletions(-)

Aditya Pakki (1):
      md: Fix failed allocation of md_register_thread

Adrian Hunter (3):
      perf intel-pt: Fix CYC timestamp calculation after OVF
      perf auxtrace: Define auxtrace record alignment
      perf intel-pt: Fix overlap calculation for padding

Al Viro (1):
      missing barriers in some of unix_sock ->addr and ->path accesses

Alban Bedel (1):
      MIPS: ath79: Enable OF serial ports in the default config

Alexander Shishkin (2):
      stm class: Prevent division by zero
      intel_th: Don't reference unassigned outputs

Alexander Shiyan (1):
      gpu: ipu-v3: Fix i.MX51 CSI control registers offset

Alexey Khoroshilov (2):
      net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()
      net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_probe()

Alistair Strachan (1):
      media: uvcvideo: Fix 'type' check leading to overflow

Andreas Gruenbacher (1):
      sockfs: getxattr: Fail with -EOPNOTSUPP for invalid attribute names

Andrew Lunn (2):
      net: dsa: mv88e6xxx: Fix u64 statistics
      gpio: vf610: Mask all GPIO interrupts

Andy Lutomirski (1):
      x86/uaccess: Don't leak the AC flag into __put_user() value evaluation

Andy Shevchenko (2):
      dmaengine: dmatest: Abort test in case of mapping error
      ACPI / device_sysfs: Avoid OF modalias creation for removed device

Anoob Soman (1):
      scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_task

Ard Biesheuvel (1):
      crypto: arm64/aes-ccm - fix logical bug in AAD MAC handling

Arnaldo Carvalho de Melo (1):
      perf bench: Copy kernel files needed to build mem{cpy,set} x86_64 benchmarks

Arnd Bergmann (2):
      phonet: fix building with clang
      cpufreq: pxa2xx: remove incorrect __init annotation

Atsushi Nemoto (1):
      net: altera_tse: fix connect_local_phy error path

Balaji Pothunoori (1):
      mac80211: don't initiate TDLS connection if station is not associated to AP

Bard liao (1):
      ASoC: topology: free created components in tplg load error

Bart Van Assche (2):
      RDMA/srp: Rework SCSI device reset handling
      scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock

Bob Copeland (1):
      mac80211: fix miscounting of ttl-dropped frames

Brian Welty (1):
      IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM

Chaitanya Tata (1):
      cfg80211: extend range deviation for DMG

Charles Keepax (1):
      mfd: wm5110: Add missing ASRC rate register

Christoffer Dall (1):
      KVM: arm/arm64: Fix MMIO emulation data handling

Christophe Leroy (3):
      powerpc/32: Clear on-stack exception marker upon exception return
      powerpc/wii: properly disable use of BATs when requested.
      powerpc/83xx: Also save/restore SPRG4-7 during suspend

Codrin Ciubotariu (1):
      dmaengine: at_xdmac: Fix wrongfull report of a channel as in use

Colin Ian King (1):
      atm: he: fix sign-extension overflow on large shift

Cong Wang (1):
      team: avoid complex list operations in team_nl_cmd_options_set()

Dan Carpenter (4):
      mfd: ab8500-core: Return zero in get_register_interruptible()
      ALSA: compress: prevent potential divide by zero bugs
      thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
      usb: gadget: Potential NULL dereference on allocation error

Daniel Borkmann (1):
      ipvlan: disallow userns cap_net_admin to change global mode/flags

Daniele Palmas (1):
      USB: serial: option: add Telit ME910 ECM composition

Darrick J. Wong (2):
      tmpfs: fix link accounting when a tmpfile is linked in
      tmpfs: fix uninitialized return value in shmem_link

David Howells (1):
      assoc_array: Fix shortcut creation

Dietmar Eggemann (1):
      ARM: 8824/1: fix a migrating irq bug when hotplug cpu

Dmitry Eremin (1):
      staging: lustre: fix buffer overflow of string buffer

Dmitry Torokhov (1):
      Input: matrix_keypad - use flush_delayed_work()

Eric Biggers (6):
      KEYS: allow reaching the keys quotas exactly
      KEYS: user: Align the payload buffer
      KEYS: always initialize keyring_index_key::desc_len
      KEYS: restrict /proc/keys by credentials at open time
      crypto: ahash - fix another early termination in hash walk
      crypto: pcbc - remove bogus memcpy()s with src == dest

Eric Dumazet (10):
      batman-adv: fix uninit-value in batadv_interface_tx()
      udplite: call proper backlog handlers
      l2tp: fix infoleak in l2tp_ip6_recvmsg()
      net/x25: fix use-after-free in x25_device_event()
      net/x25: reset state in x25_connect()
      net/x25: fix a race in x25_bind()
      vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()
      net/hsr: fix possible crash in add_timer()
      gro_cells: make sure device is up in gro_cells_receive()
      tcp/dccp: remove reqsk_put() from inet_child_forget()

Eugeniy Paltsev (2):
      ARCv2: Enable unaligned access in early ASM code
      ARC: fix __ffs return value to avoid build warnings

Felipe Franciosi (1):
      scsi: virtio_scsi: don't send sc payload with tmfs

Filipe Manana (1):
      Btrfs: fix corruption reading shared and compressed extents after hole punching

Finn Thain (1):
      m68k: Add -ffreestanding to CFLAGS

Florian Fainelli (1):
      net: systemport: Fix reception of BPDUs

Gabriel Fernandez (1):
      Input: st-keyscan - fix potential zalloc NULL dereference

Greg Kroah-Hartman (3):
      ncpfs: fix build warning of strncpy
      isdn: isdn_tty: fix build warning of strncpy
      Linux 4.4.177

Guillaume Nault (1):
      tcp: handle inet_csk_reqsk_queue_add() failures

Gustavo A. R. Silva (4):
      applicom: Fix potential Spectre v1 vulnerabilities
      iscsi_ibft: Fix missing break in switch statement
      ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify
      drm/radeon/evergreen_cs: fix missing break in switch statement

Halil Pasic (1):
      s390/virtio: handle find on invalid queue gracefully

Hangbin Liu (2):
      sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()
      Revert "bridge: do not add port to router list when receives query with source 0.0.0.0"

Hans Verkuil (1):
      media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()

Hou Tao (1):
      9p: use inode->i_lock to protect i_size_write() under 32-bit

Ian Kent (1):
      autofs: fix error return in autofs_fill_super()

Ido Schimmel (2):
      team: Free BPF filter when unregistering netdev
      ip6mr: Do not call __IP6_INC_STATS() from preemptible context

Igor Druzhinin (1):
      xen-netback: fix occasional leak of grant ref mappings under memory pressure

Ilya Dryomov (1):
      libceph: handle an empty authorize reply

Ivan Mironov (1):
      USB: serial: cp210x: add ID for Ingenico 3070

Jack Morgenstein (2):
      net/mlx4_core: Fix reset flow when in command polling mode
      net/mlx4_core: Fix qp mtt size calculation

Jan Kara (3):
      fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
      ext4: fix crash during online resizing
      ext2: Fix underflow in ext2_max_size()

Jann Horn (1):
      mm: enforce min addr even if capable() in expand_downwards()

Jason Gerecke (1):
      Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Jay Dolan (2):
      serial: 8250_pci: Fix number of ports for ACCES serial cards
      serial: 8250_pci: Have ACCES cards that use the four port Pericom PI7C9X7954 chip use the pci_pericom_setup()

Jia-Ju Bai (1):
      isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

Jiaxun Yang (1):
      x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Jiri Olsa (1):
      perf symbols: Filter out hidden symbols from labels

Johannes Thumshirn (1):
      btrfs: ensure that a DUP or RAID1 block group has exactly two stripes

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached

Jonathan Marek (1):
      mfd: qcom_rpm: write fw_version to CTRL_REG

Jonathan Neuschäfer (1):
      mmc: spi: Fix card detection during probe

Jordan Niethe (1):
      powerpc/powernv: Make opal log only readable by root

Jozsef Kadlecsik (1):
      netfilter: nf_conntrack_tcp: Fix stack out of bounds when parsing TCP options

Julian Wiedmann (1):
      s390/qeth: fix use-after-free in error path

Jun-Ru Chang (1):
      MIPS: Remove function size check in get_frame_info()

Kai-Heng Feng (1):
      sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79

Kairui Song (1):
      x86/kexec: Don't setup EFI info if EFI runtime is not enabled

Kal Conley (1):
      net/packet: fix 4gb buffer limit due to overflow check

Kalash Nainwal (1):
      net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255

Kangjie Lu (2):
      mfd: mc13xxx: Fix a missing check of a register-read failure
      leds: lp5523: fix a missing check of return value of lp55xx_read

Ken-ichirou MATSUZAWA (1):
      netfilter: nfnetlink_log: just returns error for unknown command

Kristian H. Kristensen (1):
      drm/msm: Unblock writer if reader closes file

Krzysztof Kozlowski (2):
      ARM: dts: exynos: Do not ignore real-world fuse values for thermal zone 0 on Exynos5420
      regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

Li RongQing (1):
      mac80211_hwsim: propagate genlmsg_reply return code

Liu Xiang (1):
      MIPS: irq: Allocate accurate order pages for irq stack

Logan Gunthorpe (1):
      scsi: isci: initialize shost fully before calling scsi_add_host()

Lubomir Rintel (1):
      irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Mans Rullgard (1):
      USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485

Mao Wenan (2):
      net: hsr: fix memory leak in hsr_dev_finalize()
      net: set static variable an initial value in atl2_probe()

Marc Zyngier (1):
      arm/arm64: KVM: Feed initialized memory to MMIO accesses

Marek Szyprowski (1):
      ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU

Martin Blumenstingl (1):
      pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins

Masaru Nagai (1):
      ravb: Decrease TxFIFO depth of Q3 and Q2 to one

Max Filippov (5):
      xtensa: SMP: fix ccount_timer_shutdown
      xtensa: SMP: fix secondary CPU initialization
      xtensa: smp_lx200_defconfig: fix vectors clash
      xtensa: SMP: mark each possible CPU as present
      xtensa: SMP: limit number of possible CPUs by NR_CPUS

Miaohe Lin (1):
      net: sit: fix UBSAN Undefined behaviour in check_6rd

Michael Chan (1):
      bnxt_en: Drop oversize TX packets to prevent errors.

Michal Hocko (1):
      mm, memory_hotplug: is_mem_section_removable do not pass the end of a zone

Mike Kravetz (1):
      hugetlbfs: fix races and page leaks during migration

Mikhail Zaslonko (1):
      mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone

Ming Lu (1):
      scsi: libfc: free skb when receiving invalid flogi resp

Nathan Chancellor (3):
      mfd: twl-core: Fix section annotations on {,un}protect_pm_master
      mfd: db8500-prcmu: Fix some section annotations
      isdn: avm: Fix string plus integer warning from Clang

Nazarov Sergey (2):
      net: Add __icmp_send helper.
      net: avoid use IPCB in cipso_v4_error

NeilBrown (2):
      dm: fix to_sector() for 32bit
      nfsd: fix memory corruption caused by readdir

Pablo Neira Ayuso (1):
      netfilter: x_tables: enforce nul-terminated table name from getsockopt GET_ENTRIES

Pan Bian (1):
      autofs: drop dentry reference only when it is never used

Pankaj Gupta (1):
      crypto: caam - fixed handling of sg list

Paul Cercueil (1):
      clk: ingenic: Fix round_rate misbehaving with non-integer dividers

Paul Moore (1):
      netlabel: fix out-of-bounds memory accesses

Pavel Shilovsky (1):
      CIFS: Fix read after write for files with read caching

Peng Hao (1):
      ARM: pxa: ssp: unneeded to free devm_ allocated data

Peng Tao (1):
      NFS41: pop some layoutget errors to application

Peter Zijlstra (1):
      futex,rt_mutex: Restructure rt_mutex_finish_proxy_lock()

Phil Turnbull (1):
      netfilter: nfnetlink_acct: validate NFACCT_FILTER parameters

Phuong Nguyen (1):
      dmaengine: usb-dmac: Make DMAC system sleep callbacks explicit

Qian Cai (1):
      x86_64: increase stack size for KASAN_EXTRA

QiaoChong (1):
      parport_pc: fix find_superio io compare code, should use equal test.

Rajasingh Thavamani (1):
      net: phy: Micrel KSZ8061: link failure after cable connect

Ralph Campbell (1):
      numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNODES

Rander Wang (1):
      ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Roman Penyaev (1):
      mm/vmalloc: fix size check for remap_vmalloc_range_partial()

Ronnie Sahlberg (1):
      cifs: fix computation for MAX_SMB2_HDR_SIZE

S.j. Wang (1):
      ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

Saeed Mahameed (1):
      net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames

Sakari Ailus (1):
      media: uvcvideo: Avoid NULL pointer dereference at the end of streaming

Sasha Levin (2):
      Revert "x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls"
      fs/9p: use fscache mutex rather than spinlock

Sean Christopherson (2):
      KVM: nVMX: Sign extend displacements of VMX instr's mem operands
      KVM: nVMX: Ignore limit checks on VMX instructions using flat segments

Seth Forshee (1):
      powerpc: Always initialize input array when calling epapr_hypercall()

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the hold bit setting

Silvio Cesare (2):
      ASoC: dapm: change snprintf to scnprintf for possible overflow
      ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Sinan Kaya (1):
      platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Sowjanya Komatineni (1):
      i2c: tegra: fix maximum transfer size

Stefan Haberland (1):
      s390/dasd: fix using offset into zero size array error

Stefano Brivio (1):
      vxlan: Fix GRO cells race condition between receive and link delete

Stephane Eranian (1):
      perf tools: Handle TOPOLOGY headers with no CPU

Steve Longerbeam (1):
      gpu: ipu-v3: Fix CSI offsets for imx53

Stuart Menefy (3):
      regulator: s2mpa01: Fix step values for some LDOs
      clocksource/drivers/exynos_mct: Move one-shot check from tick clear to ISR
      clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown

Su Yanjun (1):
      vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Suravee Suthikulpanit (1):
      iommu/amd: Fix IOMMU page flush when detach device from a domain

Takashi Sakamoto (1):
      ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O against Liquid Saffire 56

Thomas Bogendoerfer (1):
      MIPS: jazz: fix 64bit build

Thomas Falcon (1):
      ibmveth: Do not process frames after calling napi_reschedule

Tomonori Sakita (2):
      serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling
      net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case

Trond Myklebust (2):
      NFS: Fix an I/O request leakage in nfs_do_recoalesce
      NFS: Don't recoalesce on error in nfs_pageio_complete_mirror()

Varun Prakash (1):
      scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Vignesh R (1):
      mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells

Vincent Batts (1):
      Input: elan_i2c - add id for touchpad found in Lenovo s21e-20

Vineet Gupta (1):
      ARC: uacces: remove lp_start, lp_end from clobber list

Viresh Kumar (2):
      cpufreq: Use struct kobj_attribute instead of struct global_attr
      PM / wakeup: Rework wakeup source timer cancellation

Vitaly Kuznetsov (1):
      KVM: nSVM: clear events pending from svm_complete_interrupts() when exiting to L1

Vladimir Murzin (1):
      arm64: Relax GIC version check during early boot

Wanpeng Li (1):
      KVM: X86: Fix residual mmio emulation request to userspace

Xiao Ni (1):
      It's wrong to add len to sector_nr in raid10 reshape twice

Xin Long (2):
      pptp: dst_release sk_dst_cache in pptp_sock_destruct
      route: set the deleted fnhe fnhe_daddr to 0 in ip_del_fnhe to fix a race

Yan, Zheng (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

Yangtao Li (1):
      cpufreq: tegra124: add missing of_node_put()

Yao Liu (1):
      nfs: Fix NULL pointer dereference of dev_name

Yihao Wu (1):
      nfsd: fix wrong check in write_v4_end_grace()

Yizhuo (1):
      ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized

Yonglong Liu (2):
      net: hns: Fix use after free identified by SLUB debug
      net: hns: Fix wrong read accesses via Clause 45 MDIO protocol

YueHaibing (4):
      scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param
      net-sysfs: Fix mem leak in netdev_register_kobject
      net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails
      mdio_bus: Fix use-after-free on device_register fails

Zeng Tao (1):
      usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

Zev Weiss (1):
      kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_conv

Zhang, Jun (1):
      rcu: Do RCU GP kthread self-wakeup from softirq and interrupt

ZhangXiaoxu (1):
      ipvs: Fix signed integer overflow when setsockopt timeout

Zhi Jin (1):
      stm class: Fix an endless loop in channel allocation

zhangyi (F) (3):
      tracing: Do not free iter->trace in fail path of tracing_open_pipe()
      jbd2: clear dirty flag when revoking a buffer from an older transaction
      jbd2: fix compile warning when using JBUFFER_TRACE

zhengbin (1):
      9p/net: fix memory leak in p9_client_create

