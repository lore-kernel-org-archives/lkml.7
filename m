Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FF1C10F0D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE71D206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554280955;
	bh=icJq9+5G8yRQXWd0ocW9zB7jQ+SEtUCKfUqJoDOOAY8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ei0wwKIOQ4VqeKASslZAT0mb5f4ncHld/F/Kc5jfsZPV2jT5UvdWYDrxbF9RaVg1I
	 0pe9kPHwacxRbIJNowHrVCRPxMNo5kxeM3idvjf4LTFYgBvq2CvAPY6oPZkK7Rb6Fy
	 IiY1HAW1OYI3JdW7Rg+KDUQGmsbNtI+TvA9Vp66c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfDCIme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbfDCIls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:41:48 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B322147A;
        Wed,  3 Apr 2019 08:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554280906;
        bh=icJq9+5G8yRQXWd0ocW9zB7jQ+SEtUCKfUqJoDOOAY8=;
        h=Date:From:To:Cc:Subject:From;
        b=j31dEPPfYg9fw87HZaIGUS5Sd/pe07NP9lHNC6vtBZe0JwpJBbnEmxZDCCHTgyGLS
         zAT0tCwaNOJOpU52I6u703i+kJMaZzPsMsUaFOVj3RZIXfAsy4tFzIM8Z1VMddu4fB
         Tms7c6Myfrkw+bmY559jsrD8wxr1zTJVkWcq4wDk=
Date:   Wed, 3 Apr 2019 10:41:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.33
Message-ID: <20190403084116.GA22721@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.33 kernel.

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

 Documentation/virtual/kvm/api.txt                   |   16 -
 Makefile                                            |    6=20
 arch/arm/mach-imx/cpuidle-imx6q.c                   |   27 --
 arch/powerpc/include/asm/feature-fixups.h           |   12 +
 arch/powerpc/include/asm/ppc-opcode.h               |    2=20
 arch/powerpc/include/asm/ppc_asm.h                  |   10=20
 arch/powerpc/include/asm/setup.h                    |    7=20
 arch/powerpc/kernel/entry_64.S                      |    5=20
 arch/powerpc/kernel/exceptions-64e.S                |   27 ++
 arch/powerpc/kernel/head_booke.h                    |   12 +
 arch/powerpc/kernel/head_fsl_booke.S                |   15 +
 arch/powerpc/kernel/security.c                      |   49 ++--
 arch/powerpc/kernel/setup-common.c                  |    1=20
 arch/powerpc/kernel/vmlinux.lds.S                   |    8=20
 arch/powerpc/kvm/bookehv_interrupts.S               |    4=20
 arch/powerpc/kvm/e500_emulate.c                     |    7=20
 arch/powerpc/lib/feature-fixups.c                   |   23 +
 arch/powerpc/lib/memcmp_64.S                        |   17 +
 arch/powerpc/mm/tlb_low_64e.S                       |    7=20
 arch/powerpc/net/bpf_jit.h                          |   17 -
 arch/powerpc/net/bpf_jit32.h                        |    4=20
 arch/powerpc/net/bpf_jit64.h                        |   20 +
 arch/powerpc/net/bpf_jit_comp64.c                   |   12 -
 arch/powerpc/platforms/pseries/pseries_energy.c     |   27 +-
 arch/x86/Kconfig                                    |    8=20
 arch/x86/include/asm/kvm_host.h                     |    2=20
 arch/x86/kvm/vmx.c                                  |   14 -
 arch/x86/kvm/x86.c                                  |   48 +++-
 drivers/char/ipmi/ipmi_si.h                         |    4=20
 drivers/char/ipmi/ipmi_si_hardcode.c                |  236 ++++++++++++++-=
-----
 drivers/char/ipmi/ipmi_si_intf.c                    |   22 +
 drivers/char/ipmi/ipmi_si_platform.c                |   30 ++
 drivers/gpio/gpio-adnp.c                            |    6=20
 drivers/gpio/gpio-exar.c                            |    2=20
 drivers/gpu/drm/i915/gvt/cmd_parser.c               |    2=20
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c         |   18 +
 drivers/gpu/drm/vgem/vgem_drv.c                     |    6=20
 drivers/gpu/drm/vkms/vkms_gem.c                     |    5=20
 drivers/iommu/io-pgtable-arm-v7s.c                  |   19 +
 drivers/isdn/hardware/mISDN/hfcmulti.c              |    3=20
 drivers/net/Kconfig                                 |    4=20
 drivers/net/dsa/qca8k.c                             |   18 -
 drivers/net/ethernet/8390/mac8390.c                 |   19 +
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c    |    5=20
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c  |   30 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c     |    5=20
 drivers/net/phy/meson-gxl.c                         |    6=20
 drivers/net/tun.c                                   |   16 +
 drivers/net/vrf.c                                   |    1=20
 drivers/net/vxlan.c                                 |    4=20
 drivers/phy/allwinner/phy-sun4i-usb.c               |    5=20
 drivers/platform/x86/intel_cht_int33fe.c            |   27 +-
 drivers/s390/cio/vfio_ccw_drv.c                     |    8=20
 drivers/s390/scsi/zfcp_erp.c                        |   17 +
 drivers/s390/scsi/zfcp_ext.h                        |    2=20
 drivers/s390/scsi/zfcp_scsi.c                       |    4=20
 drivers/scsi/sd.c                                   |   22 +
 drivers/staging/comedi/comedidev.h                  |    2=20
 drivers/staging/comedi/drivers.c                    |   33 ++
 drivers/staging/comedi/drivers/ni_mio_common.c      |   10=20
 drivers/staging/erofs/dir.c                         |   45 ++-
 drivers/staging/erofs/unzip_vle.c                   |   46 ++-
 drivers/staging/erofs/unzip_vle_lz4.c               |    7=20
 drivers/staging/speakup/speakup_soft.c              |   16 -
 drivers/staging/speakup/spk_priv.h                  |    1=20
 drivers/staging/speakup/synth.c                     |    6=20
 drivers/staging/vt6655/device_main.c                |   11=20
 drivers/tty/serial/atmel_serial.c                   |    4=20
 drivers/tty/serial/kgdboc.c                         |    4=20
 drivers/tty/serial/max310x.c                        |    2=20
 drivers/tty/serial/mvebu-uart.c                     |    3=20
 drivers/tty/serial/mxs-auart.c                      |    4=20
 drivers/tty/serial/qcom_geni_serial.c               |    2=20
 drivers/tty/serial/sh-sci.c                         |   12 -
 drivers/usb/class/cdc-acm.c                         |    4=20
 drivers/usb/common/common.c                         |    2=20
 drivers/usb/gadget/function/f_hid.c                 |    6=20
 drivers/usb/host/xhci-dbgcap.c                      |    5=20
 drivers/usb/host/xhci-hub.c                         |   19 +
 drivers/usb/host/xhci-rcar.c                        |    1=20
 drivers/usb/host/xhci-ring.c                        |    9=20
 drivers/usb/host/xhci.h                             |    8=20
 drivers/usb/mtu3/Kconfig                            |    1=20
 drivers/usb/serial/cp210x.c                         |    1=20
 drivers/usb/serial/ftdi_sio.c                       |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                   |    4=20
 drivers/usb/serial/mos7720.c                        |    4=20
 drivers/usb/serial/option.c                         |   17 +
 drivers/usb/typec/class.c                           |   38 +--
 fs/btrfs/extent-tree.c                              |    2=20
 fs/btrfs/raid56.c                                   |    3=20
 fs/btrfs/tree-log.c                                 |   33 +-
 fs/btrfs/volumes.c                                  |    2=20
 fs/lockd/host.c                                     |    3=20
 fs/nfs/nfs4proc.c                                   |    3=20
 fs/ocfs2/refcounttree.c                             |   42 ++-
 fs/open.c                                           |    6=20
 fs/proc/proc_sysctl.c                               |    3=20
 include/linux/device.h                              |   24 ++
 include/linux/slab.h                                |    2=20
 include/net/sctp/checksum.h                         |    2=20
 include/net/sock.h                                  |    6=20
 kernel/bpf/verifier.c                               |    2=20
 kernel/cpu.c                                        |   20 +
 kernel/watchdog.c                                   |    6=20
 lib/rhashtable.c                                    |    8=20
 mm/mempolicy.c                                      |   40 ++-
 mm/migrate.c                                        |   11=20
 mm/slab.c                                           |    2=20
 mm/slab.h                                           |    3=20
 mm/slab_common.c                                    |    2=20
 mm/slub.c                                           |    5=20
 net/bluetooth/l2cap_core.c                          |   83 ++++---
 net/core/datagram.c                                 |    2=20
 net/core/net-sysfs.c                                |    6=20
 net/dccp/ipv6.c                                     |    4=20
 net/ipv6/ila/ila_xlat.c                             |    1=20
 net/ipv6/route.c                                    |   18 -
 net/ipv6/tcp_ipv6.c                                 |    8=20
 net/netlink/genetlink.c                             |    3=20
 net/packet/af_packet.c                              |    4=20
 net/rose/rose_subr.c                                |   21 +
 net/sched/act_mirred.c                              |    3=20
 net/sctp/socket.c                                   |   12 -
 net/tipc/net.c                                      |    5=20
 net/tipc/socket.c                                   |   20 +
 net/tipc/topsrv.c                                   |    1=20
 scripts/mod/modpost.c                               |    2=20
 sound/core/oss/pcm_oss.c                            |   43 +--
 sound/core/pcm_native.c                             |    9=20
 sound/core/rawmidi.c                                |    2=20
 sound/core/seq/oss/seq_oss_synth.c                  |    7=20
 sound/pci/hda/patch_realtek.c                       |   79 ++++++
 tools/objtool/Makefile                              |    7=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   20 -
 tools/perf/util/pmu.c                               |   10=20
 virt/kvm/kvm_main.c                                 |    3=20
 137 files changed, 1322 insertions(+), 563 deletions(-)

Aaro Koskinen (1):
      net: stmmac: fix memory corruption with large MTUs

Aditya Pakki (2):
      serial: max310x: Fix to avoid potential NULL pointer dereference
      serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference

Adrian Hunter (1):
      perf intel-pt: Fix TSC slip

Andrea Righi (1):
      btrfs: raid56: properly unmap parity page in finish_parity_scrub()

Arnd Bergmann (1):
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

Corey Minyard (1):
      ipmi_si: Fix crash when using hard-coded device

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

Diana Craciun (10):
      powerpc/fsl: Add infrastructure to fixup branch predictor flush
      powerpc/fsl: Add macro to flush the branch predictor
      powerpc/fsl: Emulate SPRN_BUCSR register
      powerpc/fsl: Add nospectre_v2 command line argument
      powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)
      powerpc/fsl: Flush the branch predictor at each kernel entry (32 bit)
      powerpc/fsl: Flush branch predictor when entering KVM
      powerpc/fsl: Enable runtime patching if nospectre_v2 boot arg is used
      powerpc/fsl: Update Spectre v2 reporting
      powerpc/fsl: Fixed warning: orphan section `__btb_flush_fixup'

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
      Linux 4.19.33

Gustavo A. R. Silva (2):
      ALSA: rawmidi: Fix potential Spectre v1 vulnerability
      ALSA: seq: oss: Fix Spectre v1 vulnerability

Heikki Krogerus (6):
      drivers: base: Helpers for adding device connection descriptions
      platform: x86: intel_cht_int33fe: Register all connections at once
      platform: x86: intel_cht_int33fe: Add connection for the DP alt mode
      platform: x86: intel_cht_int33fe: Add connections for the USB Type-C =
port
      usb: typec: class: Don't use port parent for getting mux handles
      platform: x86: intel_cht_int33fe: Remove the old connections for the =
muxes

Herbert Xu (2):
      rhashtable: Still do rehash when we get EEXIST
      ila: Fix rhashtable walker list corruption

Hoan Nguyen An (1):
      serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Ian Abbott (1):
      staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest

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

John Hurley (1):
      net: sched: fix cleanup NULL pointer exception in act_mirr

Jonas Karlman (1):
      drm/rockchip: vop: reset scale mode when win is disabled

Josef Bacik (1):
      btrfs: remove WARN_ON in log_dir_items

Kailang Yang (2):
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

Malcolm Priestley (2):
      staging: vt6655: Remove vif check from vnt_interrupt
      staging: vt6655: Fix interrupt race condition on device start up.

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

Michael Ellerman (2):
      powerpc/security: Fix spectre_v2 reporting
      powerpc/64: Fix memcmp reading past the end of src/dest

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

Nikolay Borisov (1):
      btrfs: Avoid possible qgroup_rsv_size overflow in btrfs_calculate_ino=
de_block_rsv_size

Olga Kornievskaia (1):
      NFSv4.1 don't free interrupted slot on open

Paolo Abeni (1):
      net: datagram: fix unbounded loop in __skb_try_recv_datagram()

Radoslav Gerganov (1):
      USB: gadget: f_hid: fix deadlock in f_hidg_write()

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
      KVM: x86: update %rip after emulating IO
      KVM: x86: Emulate MSR_IA32_ARCH_CAPABILITIES on AMD hosts

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


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlykcawACgkQONu9yGCS
aT58bg/+PLP6eOYXSqoJkGo19QhdMf/zdtfO3SZ2sH8+VZnA5UdeduJeSQ7OGsqP
Jnlz56GXSGw9cphj37R9oUJg1T+hZTqcAFUlG/dLHQzSjmWQOU3NOUoAp3vntETc
wjn9Yc/BewNEIJSNkYgqVC7HOCoRG3t3ByuR2kW5xIpGtIp+VATqAfWTgeW0ZRJb
I9bYv8E3dDdtR/XdJaeMDb7/UscLMF6OOjjY2abCcqbsPSD6S61ezYuNVXc+BZjy
h5RJLgZoxxbL6bQamplT4jFO5VKo2WGm+2GtW6ieEzNeXYSK5Ur/HzSPT6jraWYz
w7zQb9WXJiFdC1d1uZdQh/W54X4TQjy+exiEm7QvcRMo+4BJaIno1ztsfh6ZMq+X
S/mP7AQPDkxd+lkeMJRtSBsbg8RfsMAopfKdIgWg7JUjijUHcsYlrAVvP68mo1jo
CFAavRR6v7NcXkIsTrUNW5seOlurd3O5dW/Qubume0RXwC7zbFRR6OPclW5HAqeE
glXhZ/HvJ4DymndmO2MdzRQ5riYHWlA4+QUfEdzEDiW0hOMBJ1tp40PJiuLTRKer
ycDZbj3SWAjjr9+g+Dq4VJxBTGbMO0ZJm+fAAlio2oze884q9gxeOBJYHGSJ6Cpo
EhrBz6lRhZwavxBzH4Z3tsjHEIcPNGp6tyU1EzHabX9eSNvnMnQ=
=epzX
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
