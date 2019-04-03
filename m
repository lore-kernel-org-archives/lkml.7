Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ADFC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DBB206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554280896;
	bh=hIwMYmrKIX1thB3CxCBg+TQADF4MzErTIndU0iEpOVI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QGIqvXjighWxSfb/a+No5FcU6610bwkI3MjZLVxTpWBGH5uIn/KcsQdEefZCRmLfq
	 GXbS2B7OyORENXDKIsIjr1Yvqs94qH+6hNucSZXJ3/H3xCUJZLJ8/YhPA8v7QdurUP
	 qzfj94mRlMFic7fXdc0k1/CZZ6VIX9tatvYHRioo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfDCIle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbfDCIld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:41:33 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB0FF206B7;
        Wed,  3 Apr 2019 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554280891;
        bh=hIwMYmrKIX1thB3CxCBg+TQADF4MzErTIndU0iEpOVI=;
        h=Date:From:To:Cc:Subject:From;
        b=Z4GFsW/jdsHlZ1QuIX+poda6Ar0f6HIqBz+x0UsQk5bn1Qd+vk47tUYwb8N6JT/t8
         gZAJsnizSRQ/9NQJg8Z6hVLfM6FpuMPIjNwE+MGGDnn58ev939xI1Kxxuq/6+Ku5Xa
         VYz6bgg5+CNbEEdAbyL+K4vjRRt6aOD4MRWm5p7g=
Date:   Wed, 3 Apr 2019 10:40:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.110
Message-ID: <20190403084054.GA22663@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.110 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/virtual/kvm/api.txt                   |   16 +
 Makefile                                            |    2=20
 arch/arm/mach-imx/cpuidle-imx6q.c                   |   27 --
 arch/powerpc/Kconfig                                |    7=20
 arch/powerpc/include/asm/asm-prototypes.h           |    6=20
 arch/powerpc/include/asm/barrier.h                  |   12 -
 arch/powerpc/include/asm/code-patching-asm.h        |   18 +
 arch/powerpc/include/asm/code-patching.h            |    2=20
 arch/powerpc/include/asm/feature-fixups.h           |   21 +
 arch/powerpc/include/asm/hvcall.h                   |    2=20
 arch/powerpc/include/asm/ppc-opcode.h               |    2=20
 arch/powerpc/include/asm/ppc_asm.h                  |   10=20
 arch/powerpc/include/asm/security_features.h        |    7=20
 arch/powerpc/include/asm/setup.h                    |   20 +
 arch/powerpc/include/asm/uaccess.h                  |   11 -
 arch/powerpc/kernel/Makefile                        |    3=20
 arch/powerpc/kernel/entry_32.S                      |   10=20
 arch/powerpc/kernel/entry_64.S                      |   69 ++++++
 arch/powerpc/kernel/exceptions-64e.S                |   27 ++
 arch/powerpc/kernel/head_booke.h                    |   12 +
 arch/powerpc/kernel/head_fsl_booke.S                |   15 +
 arch/powerpc/kernel/module.c                        |   10=20
 arch/powerpc/kernel/security.c                      |  215 +++++++++++++++=
++++-
 arch/powerpc/kernel/setup-common.c                  |    3=20
 arch/powerpc/kernel/vmlinux.lds.S                   |   19 +
 arch/powerpc/kvm/bookehv_interrupts.S               |    4=20
 arch/powerpc/kvm/e500_emulate.c                     |    7=20
 arch/powerpc/lib/code-patching.c                    |   16 +
 arch/powerpc/lib/feature-fixups.c                   |   93 ++++++++
 arch/powerpc/mm/tlb_low_64e.S                       |    7=20
 arch/powerpc/net/bpf_jit.h                          |   17 -
 arch/powerpc/net/bpf_jit32.h                        |    4=20
 arch/powerpc/net/bpf_jit64.h                        |   20 +
 arch/powerpc/net/bpf_jit_comp64.c                   |   12 -
 arch/powerpc/platforms/powernv/setup.c              |    7=20
 arch/powerpc/platforms/pseries/setup.c              |    7=20
 arch/x86/Kconfig                                    |    8=20
 arch/x86/include/asm/kvm_host.h                     |    1=20
 arch/x86/kvm/vmx.c                                  |   14 -
 arch/x86/kvm/x86.c                                  |   12 +
 drivers/gpio/gpio-adnp.c                            |    6=20
 drivers/gpio/gpio-exar.c                            |    2=20
 drivers/gpu/drm/vgem/vgem_drv.c                     |    6=20
 drivers/isdn/hardware/mISDN/hfcmulti.c              |    3=20
 drivers/net/dsa/qca8k.c                             |   18 -
 drivers/net/ethernet/8390/mac8390.c                 |   19 +
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c    |    5=20
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c  |   30 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c     |    5=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |   16 +
 drivers/net/tun.c                                   |   16 +
 drivers/net/vxlan.c                                 |    4=20
 drivers/phy/allwinner/phy-sun4i-usb.c               |    5=20
 drivers/s390/cio/vfio_ccw_drv.c                     |    8=20
 drivers/s390/scsi/zfcp_erp.c                        |   17 +
 drivers/s390/scsi/zfcp_ext.h                        |    2=20
 drivers/s390/scsi/zfcp_scsi.c                       |    4=20
 drivers/scsi/sd.c                                   |   22 +-
 drivers/staging/comedi/comedidev.h                  |    2=20
 drivers/staging/comedi/drivers.c                    |   33 ++-
 drivers/staging/comedi/drivers/ni_mio_common.c      |   10=20
 drivers/staging/vt6655/device_main.c                |   11 -
 drivers/tty/serial/atmel_serial.c                   |    4=20
 drivers/tty/serial/kgdboc.c                         |    4=20
 drivers/tty/serial/max310x.c                        |    2=20
 drivers/tty/serial/sh-sci.c                         |   12 -
 drivers/usb/class/cdc-acm.c                         |    4=20
 drivers/usb/common/common.c                         |    2=20
 drivers/usb/core/config.c                           |    9=20
 drivers/usb/gadget/function/f_hid.c                 |    6=20
 drivers/usb/host/xhci-rcar.c                        |    1=20
 drivers/usb/host/xhci-ring.c                        |    9=20
 drivers/usb/mtu3/Kconfig                            |    1=20
 drivers/usb/serial/cp210x.c                         |    1=20
 drivers/usb/serial/ftdi_sio.c                       |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                   |    4=20
 drivers/usb/serial/mos7720.c                        |    4=20
 drivers/usb/serial/option.c                         |   17 +
 drivers/video/fbdev/goldfishfb.c                    |    2=20
 fs/btrfs/raid56.c                                   |    3=20
 fs/btrfs/tree-log.c                                 |   24 ++
 fs/nfs/nfs4proc.c                                   |    3=20
 fs/ocfs2/refcounttree.c                             |   42 ++-
 fs/open.c                                           |    6=20
 fs/proc/proc_sysctl.c                               |    3=20
 include/net/sctp/checksum.h                         |    2=20
 include/net/sock.h                                  |    6=20
 kernel/cpu.c                                        |   20 +
 lib/rhashtable.c                                    |    8=20
 mm/migrate.c                                        |   11 -
 net/bluetooth/l2cap_core.c                          |   83 ++++---
 net/core/datagram.c                                 |    2=20
 net/core/net-sysfs.c                                |    6=20
 net/dccp/ipv6.c                                     |    4=20
 net/ipv6/tcp_ipv6.c                                 |    8=20
 net/netlink/genetlink.c                             |    3=20
 net/packet/af_packet.c                              |    4=20
 net/rose/rose_subr.c                                |   21 +
 scripts/mod/modpost.c                               |    2=20
 sound/core/oss/pcm_oss.c                            |   43 ++--
 sound/core/pcm_native.c                             |    9=20
 sound/core/rawmidi.c                                |    2=20
 sound/core/seq/oss/seq_oss_synth.c                  |    7=20
 sound/pci/hda/patch_realtek.c                       |   27 ++
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   20 -
 virt/kvm/kvm_main.c                                 |    3=20
 106 files changed, 1155 insertions(+), 320 deletions(-)

Aaro Koskinen (1):
      net: stmmac: fix memory corruption with large MTUs

Aditya Pakki (1):
      serial: max310x: Fix to avoid potential NULL pointer dereference

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

Bhadram Varka (1):
      stmmac: copy unicast mac address to MAC registers

Bjorn Helgaas (1):
      mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Bj=F8rn Mork (1):
      USB: serial: option: add Olicard 600

Chen-Yu Tsai (1):
      phy: sun4i-usb: Support set_mode to USB_HOST for non-OTG PHYs

Christian Lamparter (1):
      net: dsa: qca8k: remove leftover phy accessors

Christoffer Dall (1):
      video: fbdev: Set pixclock =3D 0 in goldfishfb

Christoph Paasch (1):
      net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Christophe Leroy (1):
      powerpc/fsl: Fix the flush of branch predictor.

Cornelia Huck (1):
      vfio: ccw: only free cp on final interrupt

Darrick J. Wong (1):
      ocfs2: fix inode bh swapping mixup in ocfs2_reflink_inodes_lock

Dean Nelson (2):
      thunderx: enable page recycling for non-XDP case
      thunderx: eliminate extra calls to put_page() for pages held for recy=
cling

Diana Craciun (16):
      powerpc/64: Disable the speculation barrier from the command line
      powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.
      powerpc/64: Make meltdown reporting Book3S 64 specific
      powerpc/fsl: Add barrier_nospec implementation for NXP PowerPC Book3E
      powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit platfo=
rms
      powerpc/fsl: Add infrastructure to fixup branch predictor flush
      powerpc/fsl: Add macro to flush the branch predictor
      powerpc/fsl: Fix spectre_v2 mitigations reporting
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

Eric Biggers (1):
      drm/vgem: fix use-after-free when drm_gem_handle_create() fails

Eric Dumazet (5):
      dccp: do not use ipv6 header for ipv4 flow
      net: rose: fix a possible stack overflow
      tcp: do not use ipv6 header for ipv4 flow
      tun: properly test for IFF_UP
      tun: add a missing rcu_read_unlock() in error path

Fabrizio Castro (1):
      usb: common: Consider only available nodes for dr_mode

Filipe Manana (1):
      Btrfs: fix incorrect file size after shrinking truncate and fsync

Finn Thain (1):
      mac8390: Fix mmio access size probe

Fredrik Noring (1):
      kbuild: modversions: Fix relative CRC byte order interpretation

George McCollister (1):
      USB: serial: ftdi_sio: add additional NovaTech products

Greg Kroah-Hartman (3):
      USB: serial: cp210x: add new device id
      Revert "USB: core: only clean up what we allocated"
      Linux 4.14.110

Gustavo A. R. Silva (2):
      ALSA: rawmidi: Fix potential Spectre v1 vulnerability
      ALSA: seq: oss: Fix Spectre v1 vulnerability

Herbert Xu (1):
      rhashtable: Still do rehash when we get EEXIST

Hoan Nguyen An (1):
      serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Ian Abbott (1):
      staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest

Josef Bacik (1):
      btrfs: remove WARN_ON in log_dir_items

Kailang Yang (2):
      ALSA: hda/realtek - Add support headset mode for DELL WYSE AIO
      ALSA: hda/realtek - Add support headset mode for New DELL WYSE NB

Kangjie Lu (2):
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

Mathias Nyman (1):
      xhci: Fix port resume done detection for SS ports with LPM enabled

Maxime Chevallier (1):
      packets: Always register packet sk in the same order

Michael Ellerman (11):
      powerpc: Use barrier_nospec in copy_from_user()
      powerpc/64: Use barrier_nospec in syscall entry
      powerpc64s: Show ori31 availability in spectre_v1 sysfs file not v2
      powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC
      powerpc/64: Call setup_barrier_nospec() from setup_arch()
      powerpc/asm: Add a patch_site macro & helpers for patching instructio=
ns
      powerpc/64s: Add new security feature flags for count cache flush
      powerpc/64s: Add support for software count cache flush
      powerpc/pseries: Query hypervisor for count cache flush settings
      powerpc/powernv: Query firmware for count cache flush settings
      powerpc/security: Fix spectre_v2 reporting

Michal Suchanek (4):
      powerpc/64s: Add support for ori barrier_nospec patching
      powerpc/64s: Patch barrier_nospec in modules
      powerpc/64s: Enable barrier_nospec based on firmware settings
      powerpc/64s: Enhance the information in cpu_show_spectre_v1()

Naveen N. Rao (1):
      powerpc: bpf: Fix generation of load/store DW instructions

Olga Kornievskaia (1):
      NFSv4.1 don't free interrupted slot on open

Paolo Abeni (1):
      net: datagram: fix unbounded loop in __skb_try_recv_datagram()

Radoslav Gerganov (1):
      USB: gadget: f_hid: fix deadlock in f_hidg_write()

Romain Izard (1):
      usb: cdc-acm: fix race during wakeup blocking TX traffic

Sean Christopherson (2):
      KVM: Reject device ioctls from processes other than the VM's creator
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

Thomas Gleixner (2):
      cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_C=
PU=3Dn
      x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=3Dy

Wentao Wang (1):
      Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/=
kgdboc

Xin Long (1):
      sctp: get sctphdr by offset in sctp_compute_cksum

Yasushi Asano (1):
      usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk

YueHaibing (3):
      genetlink: Fix a memory leak on error path
      net-sysfs: call dev_hold if kobject_init_and_add success
      fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Zhiqiang Liu (1):
      vxlan: Don't call gro_cells_destroy() before device is unregistered


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlykcZYACgkQONu9yGCS
aT4SnQ//QVuCn7rARPVz555/oEQB8svEevLsBTeas3ecrpS1dIOpVNVmYXAOEXf6
qFmAoVuZ2DXhBJOJftb9aWBeqhJb9Ani43DIceVeHOhSvce9pe00aM7Wx3e8UQe0
9zDePjrV6fcFh1vPIPYDyomJD3gOfgqhpVkFnypIMh9l4sJgJs6VrrF7G7l1+jSa
aE+LogT0RpWR8O7kLOsXdSY/o5HBK0reuKyhVhub/7QMK21GuBe3sNzey3wZdUdu
mzDc5QwOjhGuFdRFB7fiGdtzOU4DqZZDESqwBAytnS0y2FWuju1CZ8WvRxm5sRsA
Kfpg5RbywCDe9eJEbkgPDWs2hi6IFqOs8FLEbwY+cqqyhsXNdMPW2pNEGDLCS6pS
x3s9hUMmAFxZFtt0YSyxrCbjuNkqg5JKisG772B/CEF3xxaUjqp+V74MlANeNEpQ
UOb7CIMofa4b6ptCZyManHEDhgqVpwdgQgziy0PaTyUOl1zO0KxY7z+T98FWlENY
qoqM74Gv6bZB5LI5P6fpAVBcyDCRnx94yOyRMF8VnwbdhLJ9uy/aui5gXqji7uKp
3+qhJgG4zfTvnyzJj73G3/FympT10XN1zi8C4D38sRhtMtUfkVN29mXY/B4urgML
mYLz6jXuKrbJ2rWe1LKbQAnBZNAFckBPbNL5sUV0p1N8tyfFrcU=
=Szcn
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
