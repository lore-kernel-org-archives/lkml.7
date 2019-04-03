Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FFC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E22A2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554280921;
	bh=vjPyFFPBpwORH8cNV3JXOe3TrUvL9jqLb5C61VWHbe8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=p4/Yt1ZG3qWbE7zgWkZ/FQCw2P+p59aEw6u/QlxSXhW0lNLLxVC/4BI1yzRXxLQMG
	 tUVzt5HdXruMKzvG6TfG4RRndB2xjrlKIZR7Np3DBlh1y/HN9l5iNrl6vfcpDOtaxZ
	 xE9E3wsBsaZ88Eh6zD07g/yDU3eiQINorl7TUInE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfDCIl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbfDCIlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:41:55 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBCD72147A;
        Wed,  3 Apr 2019 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554280913;
        bh=vjPyFFPBpwORH8cNV3JXOe3TrUvL9jqLb5C61VWHbe8=;
        h=Date:From:To:Cc:Subject:From;
        b=p4tJbT+mekRBU3teLlQDKczkb/+h/R9fvkZSKSEgnLWMUqeToCt6GdfLOgThpAySc
         GheOJAJ3ffj/XPk0BpZo3tR2AtjS9abhU9OMI2kcta2HzgQ8cV3PuCl+FqRsAwe4Tf
         lAOr/CV8O3pnnoh8477o21uMP9nIOnFrVXIZdnmg=
Date:   Wed, 3 Apr 2019 10:41:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 5.0.6
Message-ID: <20190403084136.GA22806@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 5.0.6 kernel.

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

 Documentation/virtual/kvm/api.txt                    |   16 ++-
 Makefile                                             |    6 -
 arch/arm/mach-imx/cpuidle-imx6q.c                    |   27 +----
 arch/powerpc/include/asm/ppc-opcode.h                |    2=20
 arch/powerpc/kernel/exceptions-64e.S                 |    1=20
 arch/powerpc/lib/memcmp_64.S                         |   17 ++-
 arch/powerpc/net/bpf_jit.h                           |   17 ---
 arch/powerpc/net/bpf_jit32.h                         |    4=20
 arch/powerpc/net/bpf_jit64.h                         |   20 +++
 arch/powerpc/net/bpf_jit_comp64.c                    |   12 +-
 arch/powerpc/platforms/pseries/pseries_energy.c      |   27 +++--
 arch/powerpc/platforms/pseries/ras.c                 |    1=20
 arch/x86/Kconfig                                     |    8 -
 arch/x86/include/asm/kvm_host.h                      |    2=20
 arch/x86/kvm/vmx/vmx.c                               |   13 --
 arch/x86/kvm/vmx/vmx.h                               |    1=20
 arch/x86/kvm/x86.c                                   |   48 +++++++--
 block/blk-mq.c                                       |   13 ++
 drivers/acpi/cppc_acpi.c                             |    9 +
 drivers/block/zram/zram_drv.c                        |   32 +-----
 drivers/cpufreq/intel_pstate.c                       |    5=20
 drivers/cpufreq/scpi-cpufreq.c                       |    2=20
 drivers/gpio/gpio-adnp.c                             |    6 -
 drivers/gpio/gpio-exar.c                             |    2=20
 drivers/gpu/drm/i915/gvt/cmd_parser.c                |    2=20
 drivers/gpu/drm/i915/i915_drv.h                      |    3=20
 drivers/gpu/drm/i915/i915_reg.h                      |    2=20
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c          |   18 ++-
 drivers/gpu/drm/vgem/vgem_drv.c                      |    6 -
 drivers/gpu/drm/vkms/vkms_gem.c                      |    5=20
 drivers/iommu/io-pgtable-arm-v7s.c                   |   19 ++-
 drivers/isdn/hardware/mISDN/hfcmulti.c               |    3=20
 drivers/net/Kconfig                                  |    4=20
 drivers/net/dsa/mv88e6xxx/port.c                     |   24 +++-
 drivers/net/dsa/qca8k.c                              |   18 ---
 drivers/net/ethernet/8390/mac8390.c                  |   19 ++-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c     |    5=20
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c   |   30 ++---
 drivers/net/ethernet/realtek/r8169.c                 |    2=20
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c      |    5=20
 drivers/net/phy/meson-gxl.c                          |    6 +
 drivers/net/phy/phy_device.c                         |    2=20
 drivers/net/tun.c                                    |   16 ++-
 drivers/net/usb/aqc111.c                             |   15 ++
 drivers/net/usb/cdc_ether.c                          |    8 +
 drivers/net/vrf.c                                    |    1=20
 drivers/net/vxlan.c                                  |    4=20
 drivers/net/wireless/mediatek/mt76/mt76.h            |   13 ++
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c |   52 +++------
 drivers/net/wireless/mediatek/mt76/usb.c             |    1=20
 drivers/phy/allwinner/phy-sun4i-usb.c                |    5=20
 drivers/s390/cio/vfio_ccw_drv.c                      |    8 +
 drivers/s390/scsi/zfcp_erp.c                         |   17 +++
 drivers/s390/scsi/zfcp_ext.h                         |    2=20
 drivers/s390/scsi/zfcp_scsi.c                        |    4=20
 drivers/scsi/sd.c                                    |   22 +++-
 drivers/staging/comedi/comedidev.h                   |    2=20
 drivers/staging/comedi/drivers.c                     |   33 +++++-
 drivers/staging/comedi/drivers/ni_mio_common.c       |   10 +
 drivers/staging/erofs/dir.c                          |   45 ++++----
 drivers/staging/erofs/unzip_vle.c                    |   45 ++++++--
 drivers/staging/erofs/unzip_vle_lz4.c                |    7 -
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c           |    2=20
 drivers/staging/speakup/speakup_soft.c               |   16 ++-
 drivers/staging/speakup/spk_priv.h                   |    1=20
 drivers/staging/speakup/synth.c                      |    6 +
 drivers/staging/vt6655/device_main.c                 |   11 --
 drivers/tty/serial/atmel_serial.c                    |   52 +++++++--
 drivers/tty/serial/kgdboc.c                          |    4=20
 drivers/tty/serial/max310x.c                         |    2=20
 drivers/tty/serial/mvebu-uart.c                      |    3=20
 drivers/tty/serial/mxs-auart.c                       |    4=20
 drivers/tty/serial/qcom_geni_serial.c                |    2=20
 drivers/tty/serial/sh-sci.c                          |   12 --
 drivers/usb/class/cdc-acm.c                          |    4=20
 drivers/usb/common/common.c                          |    2=20
 drivers/usb/gadget/function/f_hid.c                  |    6 -
 drivers/usb/host/xhci-dbgcap.c                       |    5=20
 drivers/usb/host/xhci-hub.c                          |   19 ++-
 drivers/usb/host/xhci-rcar.c                         |    1=20
 drivers/usb/host/xhci-ring.c                         |    9 +
 drivers/usb/host/xhci.h                              |    8 +
 drivers/usb/mtu3/Kconfig                             |    1=20
 drivers/usb/serial/cp210x.c                          |    1=20
 drivers/usb/serial/ftdi_sio.c                        |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                    |    4=20
 drivers/usb/serial/mos7720.c                         |    4=20
 drivers/usb/serial/option.c                          |   17 ++-
 drivers/usb/typec/tcpm/tcpm.c                        |   27 ++++-
 drivers/usb/typec/tcpm/wcove.c                       |    9 +
 fs/btrfs/extent-tree.c                               |    2=20
 fs/btrfs/qgroup.c                                    |    4=20
 fs/btrfs/raid56.c                                    |    3=20
 fs/btrfs/tree-log.c                                  |   33 ++++--
 fs/btrfs/volumes.c                                   |    2=20
 fs/lockd/host.c                                      |    3=20
 fs/locks.c                                           |    5=20
 fs/nfs/nfs4proc.c                                    |    5=20
 fs/ocfs2/refcounttree.c                              |   42 ++++----
 fs/open.c                                            |    6 +
 fs/proc/proc_sysctl.c                                |    3=20
 include/linux/mii.h                                  |    2=20
 include/linux/page-isolation.h                       |   10 -
 include/linux/slab.h                                 |    2=20
 include/net/netfilter/nf_tables.h                    |    6 -
 include/net/sctp/checksum.h                          |    2=20
 include/net/sock.h                                   |    6 +
 kernel/bpf/verifier.c                                |    2=20
 kernel/cpu.c                                         |   20 +++
 kernel/trace/trace_dynevent.c                        |    2=20
 kernel/watchdog.c                                    |    6 -
 lib/rhashtable.c                                     |    8 +
 mm/debug.c                                           |    2=20
 mm/memory.c                                          |   11 +-
 mm/memory_hotplug.c                                  |   19 ++-
 mm/mempolicy.c                                       |   40 ++++++-
 mm/migrate.c                                         |   11 +-
 mm/page_alloc.c                                      |    2=20
 mm/page_isolation.c                                  |   51 ++++++---
 mm/slab.c                                            |    2=20
 mm/slab.h                                            |    3=20
 mm/slab_common.c                                     |    2=20
 mm/slub.c                                            |    5=20
 mm/sparse.c                                          |    2=20
 net/bluetooth/l2cap_core.c                           |   83 +++++++++------
 net/core/datagram.c                                  |    2=20
 net/core/net-sysfs.c                                 |    6 -
 net/dccp/ipv6.c                                      |    4=20
 net/ipv6/ila/ila_xlat.c                              |    1=20
 net/ipv6/route.c                                     |   18 +--
 net/ipv6/tcp_ipv6.c                                  |    8 -
 net/netfilter/nf_tables_api.c                        |   17 ++-
 net/netlink/genetlink.c                              |    3=20
 net/packet/af_packet.c                               |    4=20
 net/rose/rose_subr.c                                 |   21 ++--
 net/sctp/socket.c                                    |   12 +-
 net/tipc/net.c                                       |    5=20
 net/tipc/socket.c                                    |   20 ++-
 net/tipc/topsrv.c                                    |    1=20
 scripts/mod/modpost.c                                |    2=20
 sound/core/oss/pcm_oss.c                             |   43 ++++----
 sound/core/pcm_native.c                              |    9 +
 sound/core/rawmidi.c                                 |    2=20
 sound/core/seq/oss/seq_oss_synth.c                   |    7 -
 sound/pci/hda/patch_realtek.c                        |   99 ++++++++++++++=
+++--
 tools/objtool/Makefile                               |    7 -
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c  |   20 +--
 tools/perf/util/pmu.c                                |   10 +
 virt/kvm/kvm_main.c                                  |    3=20
 149 files changed, 1142 insertions(+), 597 deletions(-)

Aaro Koskinen (1):
      net: stmmac: fix memory corruption with large MTUs

Aditya Pakki (2):
      serial: max310x: Fix to avoid potential NULL pointer dereference
      serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference

Adrian Hunter (1):
      perf intel-pt: Fix TSC slip

Andrea Righi (1):
      btrfs: raid56: properly unmap parity page in finish_parity_scrub()

Arnd Bergmann (2):
      staging: olpc_dcon_xo_1: add missing 'const' qualifier
      usb: mtu3: fix EXTCON dependency

Axel Lin (1):
      gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

Bart Van Assche (1):
      scsi: sd: Fix a race between closing an sd device and sd I/O

Bernhard Rosenkraenzer (1):
      ALSA: hda/realtek - Fix speakers on Acer Predator Helios 500 Ryzen la=
ptops

Bjorn Helgaas (1):
      mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Bj=F8rn Mork (1):
      USB: serial: option: add Olicard 600

Catalin Marinas (1):
      NFS: Fix nfs4_lock_state refcounting in nfs4_alloc_{lock,unlock}data()

Chao Yu (1):
      staging: erofs: fix to handle error path of erofs_vmap()

Chen-Yu Tsai (1):
      phy: sun4i-usb: Support set_mode to USB_HOST for non-OTG PHYs

Chris Chiu (2):
      ALSA: hda/realtek - Add support for Acer Aspire E5-523G/ES1-432 heads=
et mic
      ALSA: hda/realtek: Enable headset mic of ASUS P5440FF with ALC256

Christian Lamparter (1):
      net: dsa: qca8k: remove leftover phy accessors

Christoph Paasch (1):
      net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Christophe Leroy (1):
      powerpc/fsl: Fix the flush of branch predictor.

Claudiu Manoil (1):
      net: mii: Fix PAUSE cap advertisement from linkmode_adv_to_lcl_adv_t(=
) helper

Cornelia Huck (1):
      vfio: ccw: only free cp on final interrupt

Darrick J. Wong (1):
      ocfs2: fix inode bh swapping mixup in ocfs2_reflink_inodes_lock

David Sterba (1):
      btrfs: don't report readahead errors and don't update statistics

Dean Nelson (2):
      thunderx: enable page recycling for non-XDP case
      thunderx: eliminate extra calls to put_page() for pages held for recy=
cling

Dmitry Bezrukov (1):
      net: usb: aqc111: Extend HWID table by QNAP device

Dmitry Bogdanov (1):
      net: aquantia: fix rx checksum offload for UDP/TCP over IPv6

Eric Biggers (2):
      drm/vgem: fix use-after-free when drm_gem_handle_create() fails
      drm/vkms: fix use-after-free when drm_gem_handle_create() fails

Eric Dumazet (5):
      dccp: do not use ipv6 header for ipv4 flow
      net: rose: fix a possible stack overflow
      tcp: do not use ipv6 header for ipv4 flow
      tun: properly test for IFF_UP
      tun: add a missing rcu_read_unlock() in error path

Erik Hugne (2):
      tipc: allow service ranges to be connect()'ed on RDM/DGRAM
      tipc: fix cancellation of topology subscriptions

Fabrizio Castro (1):
      usb: common: Consider only available nodes for dr_mode

Filipe Manana (2):
      Btrfs: fix incorrect file size after shrinking truncate and fsync
      Btrfs: fix assertion failure on fsync with NO_HOLES enabled

Finn Thain (1):
      mac8390: Fix mmio access size probe

Frank Rowand (1):
      tracing: initialize variable in create_dyn_event()

Fredrik Noring (1):
      kbuild: modversions: Fix relative CRC byte order interpretation

Gao Xiang (2):
      staging: erofs: fix error handling when failed to read compresssed da=
ta
      staging: erofs: keep corrupted fs from crashing kernel in erofs_readd=
ir()

Gautham R. Shenoy (1):
      powerpc/pseries/energy: Use OF accessor functions to read ibm,drc-ind=
exes

George McCollister (1):
      USB: serial: ftdi_sio: add additional NovaTech products

Greg Kroah-Hartman (2):
      USB: serial: cp210x: add new device id
      Linux 5.0.6

Gustavo A. R. Silva (3):
      ALSA: rawmidi: Fix potential Spectre v1 vulnerability
      ALSA: seq: oss: Fix Spectre v1 vulnerability
      usb: typec: Fix unchecked return value

Hans de Goede (1):
      usb: typec: tcpm: Try PD-2.0 if sink does not respond to 3.0 source-c=
aps

Heiner Kallweit (3):
      net: dsa: mv88e6xxx: fix few issues in mv88e6390x_port_set_cmode
      net: phy: don't clear BMCR in genphy_soft_reset
      r8169: fix cable re-plugging issue

Herbert Xu (2):
      rhashtable: Still do rehash when we get EEXIST
      ila: Fix rhashtable walker list corruption

Hoan Nguyen An (1):
      serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Ian Abbott (1):
      staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest

Jan Kara (1):
      mm/memory.c: fix modifying of page protection by insert_pfn()

Jaroslav Kysela (1):
      ALSA: hda/realtek: merge alc_fixup_headset_jack to alc295_fixup_chrom=
ebook

Jeff Layton (1):
      locks: wake any locks blocked on request before deadlock check

Jens Axboe (1):
      blk-mq: fix sbitmap ws_active for shared tags

Jerome Brunet (1):
      net: phy: meson-gxl: fix interrupt support

Jian-Hong Pan (4):
      ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286
      ALSA: hda/realtek: Enable headset MIC of Acer Aspire Z24-890 with ALC=
286
      ALSA: hda/realtek: Enable ASUS X441MB and X705FD headset MIC with ALC=
256
      ALSA: hda/realtek: Enable headset MIC of ASUS X430UN and X512DK with =
ALC256

Jonas Karlman (1):
      drm/rockchip: vop: reset scale mode when win is disabled

Josef Bacik (1):
      btrfs: remove WARN_ON in log_dir_items

Kailang Yang (3):
      ALSA: hda/realtek - Fixed Headset Mic JD not stable
      ALSA: hda/realtek - Add support headset mode for DELL WYSE AIO
      ALSA: hda/realtek - Add support headset mode for New DELL WYSE NB

Kan Liang (1):
      perf pmu: Fix parser error for uncore event alias

Kangjie Lu (3):
      tty: mxs-auart: fix a potential NULL pointer dereference
      tty: atmel_serial: fix a potential NULL pointer dereference
      gpio: exar: add a check for the return value of ida_simple_get fails

Kohji Okuno (1):
      ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected t=
ime

Kristian Evensen (1):
      USB: serial: option: add support for Quectel EM12

Lars Persson (1):
      mm/migrate.c: add missing flush_dcache_page for non-mapped page migra=
te

Lin Yi (1):
      USB: serial: mos7720: fix mos_parport refcount imbalance on error path

Mahesh Salgaonkar (1):
      powerpc/pseries/mce: Fix misleading print for TLB mutlihit

Malcolm Priestley (2):
      staging: vt6655: Remove vif check from vnt_interrupt
      staging: vt6655: Fix interrupt race condition on device start up.

Manasi Navare (1):
      drm/i915/icl: Fix the TRANS_DDI_FUNC_CTL2 bitfield macro

Mans Rullgard (1):
      USB: serial: option: set driver_info for SIM5218 and compatibles

Marcel Holtmann (2):
      Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt
      Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Martin K. Petersen (1):
      scsi: sd: Quiesce warning if device does not report optimal I/O size

Mathias Nyman (3):
      xhci: Fix port resume done detection for SS ports with LPM enabled
      usb: xhci: dbc: Don't free all memory with spinlock held
      xhci: Don't let USB3 ports stuck in polling state prevent suspend

Matteo Croce (1):
      gtp: change NET_UDP_TUNNEL dependency to select

Maxime Chevallier (1):
      packets: Always register packet sk in the same order

Michael Ellerman (1):
      powerpc/64: Fix memcmp reading past the end of src/dest

Minchan Kim (1):
      drivers/block/zram/zram_drv.c: fix idle/writeback string compare

Nathan Chancellor (1):
      tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_s=
etup

Naveen N. Rao (1):
      powerpc: bpf: Fix generation of load/store DW instructions

NeilBrown (1):
      NFS: fix mount/umount race in nlmclnt.

Nicolas Boichat (2):
      mm: add support for kmem caches in DMA32 zone
      iommu/io-pgtable-arm-v7s: request DMA32 memory, and improve debugging

Nikolay Borisov (2):
      btrfs: Fix bound checking in qgroup_trace_new_subtree_blocks
      btrfs: Avoid possible qgroup_rsv_size overflow in btrfs_calculate_ino=
de_block_rsv_size

Olga Kornievskaia (1):
      NFSv4.1 don't free interrupted slot on open

Oscar Salvador (1):
      mm/debug.c: fix __dump_page when mapping->host is not set

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fix set double-free in abort path

Paolo Abeni (1):
      net: datagram: fix unbounded loop in __skb_try_recv_datagram()

Qian Cai (3):
      mm/hotplug: fix offline undo_isolate_page_range()
      mm/memory_hotplug.c: fix notification in offline error path
      mm/page_isolation.c: fix a wrong flag in set_migratetype_isolate()

Radoslav Gerganov (1):
      USB: gadget: f_hid: fix deadlock in f_hidg_write()

Razvan Stefanescu (2):
      tty/serial: atmel: Add is_half_duplex helper
      tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

Rolf Eike Beer (1):
      objtool: Query pkg-config for libelf location

Romain Izard (1):
      usb: cdc-acm: fix race during wakeup blocking TX traffic

Sabrina Dubroca (1):
      vrf: prevent adding upper devices

Samuel Thibault (1):
      staging: speakup_soft: Fix alternate speech with other synths

Sean Christopherson (3):
      KVM: Reject device ioctls from processes other than the VM's creator
      KVM: x86: Emulate MSR_IA32_ARCH_CAPABILITIES on AMD hosts
      KVM: x86: update %rip after emulating IO

Srinivas Pandruvada (2):
      ACPI / CPPC: Fix guaranteed performance handling
      cpufreq: intel_pstate: Also use CPPC nominal_perf for base_frequency

Stanislaw Gruszka (1):
      mt76x02u: use usb_bulk_msg to upload firmware

Steffen Maier (2):
      scsi: zfcp: fix rport unblock if deleted SCSI devices on Scsi_Host
      scsi: zfcp: fix scsi_eh host reset with port_forced ERP for non-NPIV =
FCP devices

Takashi Iwai (2):
      ALSA: pcm: Fix possible OOB access in PCM oss plugins
      ALSA: pcm: Don't suspend stream in unrecoverable PCM state

Tetsuo Handa (1):
      fs/open.c: allow opening only regular files during execve()

Thomas Gleixner (3):
      watchdog: Respect watchdog cpumask on CPU hotplug
      cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_C=
PU=3Dn
      x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=3Dy

Ville Syrj=E4l=E4 (1):
      drm/i915: Mark AML 0x87CA as ULX

Vincent Stehl=E9 (1):
      cpufreq: scpi: Fix use after free

Wentao Wang (1):
      Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/=
kgdboc

Xin Long (4):
      ipv6: make ip6_create_rt_rcu return ip6_null_entry instead of NULL
      sctp: get sctphdr by offset in sctp_compute_cksum
      sctp: use memdup_user instead of vmemdup_user
      tipc: change to check tipc_own_id to return in tipc_net_stop

Xu Yu (1):
      bpf: do not restore dst_reg when cur_state is freed

Yang Shi (1):
      mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specif=
ied

Yasushi Asano (1):
      usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk

YueHaibing (3):
      genetlink: Fix a memory leak on error path
      net-sysfs: call dev_hold if kobject_init_and_add success
      fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Zhenyu Wang (1):
      drm/i915/gvt: Fix MI_FLUSH_DW parsing with correct index check

Zhiqiang Liu (1):
      vxlan: Don't call gro_cells_destroy() before device is unregistered


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlykcb8ACgkQONu9yGCS
aT6cXg//TB5djetWdt5nclA0f9mO0YG6NWxbRcZ7MDng7D4KA8OAmH1VMGG6Cyul
3QEAhg12OQGSXJfMGGGu5xft+q9iSNhq8JrMOfjqT/uo6HthHfPyJ3Eb+fpj8GJG
C5UNDuH3w+Z96IxiTehLzpVbw7yehRUqg31DbziOl18JAPd0ALnS5+wUyHxJp5/V
twMHYmqbzYiyew8Ul5PGz79dCMjFTu6PbIV3LnYMoxv/jVs46Y6ErHmq1spQnCVW
AapXEU4/IVLjRa9ZEVw0gVlyaTF7hanja6JNIdWMkS/m2PIdj9tjBpuic7egL+IO
12X0Ki2o9jb4s39U0EcEM+XWn68TGIckThcmGItciqf/1uSXRsxwU22DDuQxbpqP
Uh3PueFWCdt/977lV7LZhI787yj/gaqEztaAaItZmjX23cls5rm+TuXtjheWSpBY
huMFWvRrdrrplF2M81CnFMEpc1skmgYkj9/Q60vkqE8/fvMq/WM0n51GDYW3f2oD
H1EtLSzvGMlkvB8k2FlLeTE8d6rKRmIzmOLE8EpT9gFUMGz1S36Az/2DZyGfm/ZQ
F+KiBZ1/a3a2Alo+S4+fevKwYS8wbUlFdeAbSzjLNgDEaFDisR8P+ljYXuiWahne
Hhp9DcjxG3u/03/2aK/DH+BB3GUQ9Ba/ykqIcrxeqria2BnhLjQ=
=WHi1
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
