Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF1BC10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9652821019
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553417041;
	bh=uKaLBULFwxEBerMpx4qGO7TGcNzf9IEj5GWzSKxtX5g=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=LMEZEZhDur4b8sOTwC9ahzcnijcreTldwxmQiM43fcvQYejcZ4pLOSlL9fkEtJdi1
	 usTbSfb6X955EHX2XeMrkFK/RP6CkM5TnsT1pRyLgURsoaJgvDSsX1hZTMJyxHz9fs
	 9e28eTXT9g+F1jdcXF8SYM7I/IG66E5HAC3Louf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfCXIoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 04:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfCXIn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 04:43:59 -0400
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C91121019;
        Sun, 24 Mar 2019 08:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553417037;
        bh=uKaLBULFwxEBerMpx4qGO7TGcNzf9IEj5GWzSKxtX5g=;
        h=Date:From:To:Cc:Subject:From;
        b=FHwJdYOJSMJF/tWsMNDK0KyFm5wLEhGhVy1ZKafRAgihYPpAxR1pV5qHeI6b3DqK8
         sRHiofaJ5wy+raJUKaT0D0mkRakGkolZepl6wCb1MX+28zvYSosHqPCRyrRJQF0Amu
         LJZsnM/yFZrWuTD2gL3Swo43mMQEHMw9TWUJGYJs=
Date:   Sun, 24 Mar 2019 09:43:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.137
Message-ID: <20190324084355.GA6003@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.137 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                              |    2=20
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c               |    8 +-
 arch/arm/plat-pxa/ssp.c                               |    3 -
 arch/arm64/kernel/head.S                              |    3 -
 arch/m68k/Makefile                                    |    5 +
 arch/mips/configs/ath79_defconfig                     |    1=20
 arch/mips/jazz/jazzdma.c                              |    5 +
 arch/powerpc/kernel/entry_32.S                        |    9 +++
 arch/powerpc/platforms/83xx/suspend-asm.S             |   34 +++++++++---
 arch/powerpc/platforms/embedded6xx/wii.c              |    4 +
 arch/powerpc/platforms/powernv/opal-msglog.c          |    2=20
 arch/x86/kernel/kexec-bzimage64.c                     |    3 +
 arch/x86/kvm/svm.c                                    |    8 ++
 arch/xtensa/configs/smp_lx200_defconfig               |    1=20
 arch/xtensa/kernel/head.S                             |    5 +
 arch/xtensa/kernel/smp.c                              |   41 +++++++++-----
 crypto/ahash.c                                        |   14 ++---
 crypto/pcbc.c                                         |   14 +----
 drivers/atm/he.c                                      |    2=20
 drivers/cpufreq/pxa2xx-cpufreq.c                      |    4 -
 drivers/dma/dmatest.c                                 |   28 ++++------
 drivers/firmware/iscsi_ibft.c                         |    1=20
 drivers/gpu/drm/msm/msm_rd.c                          |    7 ++
 drivers/gpu/drm/radeon/evergreen_cs.c                 |    1=20
 drivers/i2c/busses/i2c-cadence.c                      |    9 ++-
 drivers/input/keyboard/matrix_keypad.c                |    2=20
 drivers/input/keyboard/st-keyscan.c                   |    4 -
 drivers/input/tablet/wacom_serial4.c                  |    2=20
 drivers/iommu/amd_iommu.c                             |   15 +++--
 drivers/irqchip/irq-mmp.c                             |    6 +-
 drivers/isdn/hardware/avm/b1.c                        |    2=20
 drivers/isdn/i4l/isdn_tty.c                           |    6 +-
 drivers/leds/leds-lp5523.c                            |    4 +
 drivers/md/raid10.c                                   |    3 -
 drivers/md/raid5.c                                    |    2=20
 drivers/media/usb/uvc/uvc_driver.c                    |   14 +++--
 drivers/media/usb/uvc/uvc_video.c                     |    8 ++
 drivers/mfd/ab8500-core.c                             |    2=20
 drivers/mfd/db8500-prcmu.c                            |    4 -
 drivers/mfd/mc13xxx-core.c                            |    4 +
 drivers/mfd/ti_am335x_tscadc.c                        |    5 +
 drivers/mfd/twl-core.c                                |    4 -
 drivers/mfd/wm5110-tables.c                           |    2=20
 drivers/mmc/host/mmc_spi.c                            |    1=20
 drivers/net/ethernet/altera/altera_msgdma.c           |    3 -
 drivers/net/ethernet/altera/altera_tse_main.c         |    4 +
 drivers/net/ethernet/atheros/atlx/atl2.c              |    4 -
 drivers/net/ethernet/broadcom/bcmsysport.c            |    4 +
 drivers/net/ethernet/ibm/ibmveth.c                    |    2=20
 drivers/net/ethernet/marvell/mv643xx_eth.c            |    7 ++
 drivers/net/ethernet/marvell/sky2.c                   |   24 ++++++++
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    6 +-
 drivers/net/phy/mdio_bus.c                            |    1=20
 drivers/net/phy/micrel.c                              |   14 ++++-
 drivers/net/ppp/pptp.c                                |    1=20
 drivers/net/team/team.c                               |   27 +--------
 drivers/net/team/team_mode_loadbalance.c              |   15 +++++
 drivers/net/vxlan.c                                   |   10 +++
 drivers/parport/parport_pc.c                          |    2=20
 drivers/platform/x86/Kconfig                          |    1=20
 drivers/regulator/s2mpa01.c                           |   10 +--
 drivers/regulator/s2mps11.c                           |    6 +-
 drivers/s390/block/dasd_eckd.c                        |    8 ++
 drivers/s390/net/qeth_core_main.c                     |   15 ++---
 drivers/scsi/csiostor/csio_attr.c                     |    2=20
 drivers/scsi/isci/init.c                              |   14 ++---
 drivers/scsi/libfc/fc_lport.c                         |    6 +-
 drivers/scsi/libiscsi.c                               |    6 ++
 drivers/scsi/libsas/sas_expander.c                    |    2=20
 drivers/scsi/qla4xxx/ql4_os.c                         |    2=20
 drivers/scsi/virtio_scsi.c                            |    2=20
 drivers/target/iscsi/iscsi_target.c                   |    4 -
 drivers/tty/serial/fsl_lpuart.c                       |    2=20
 drivers/usb/dwc3/gadget.c                             |    1=20
 drivers/usb/gadget/function/f_sourcesink.c            |    2=20
 drivers/usb/serial/cp210x.c                           |    1=20
 fs/autofs4/expire.c                                   |    3 -
 fs/autofs4/inode.c                                    |    4 +
 fs/btrfs/extent_io.c                                  |    4 -
 fs/ceph/snap.c                                        |    3 -
 fs/cifs/file.c                                        |   12 ++--
 fs/cifs/smb2pdu.h                                     |    4 -
 fs/ext2/super.c                                       |   39 +++++++++-----
 fs/ext4/resize.c                                      |    3 -
 fs/hugetlbfs/inode.c                                  |   12 ++++
 fs/jbd2/transaction.c                                 |   17 ++++--
 fs/nfs/super.c                                        |    5 +
 fs/nfsd/nfs3proc.c                                    |   16 +++++
 fs/nfsd/nfs3xdr.c                                     |    1=20
 fs/nfsd/nfsctl.c                                      |    2=20
 include/keys/user-type.h                              |    2=20
 include/net/gro_cells.h                               |   12 +++-
 include/net/icmp.h                                    |    9 ++-
 include/net/ip.h                                      |    2=20
 kernel/sysctl.c                                       |   11 +++
 lib/assoc_array.c                                     |    8 +-
 mm/hugetlb.c                                          |   14 ++++-
 mm/memory_hotplug.c                                   |    3 -
 mm/mempolicy.c                                        |    6 +-
 mm/migrate.c                                          |   11 +++
 mm/mmap.c                                             |    7 +-
 mm/shmem.c                                            |   12 ++--
 mm/vmalloc.c                                          |    2=20
 net/9p/client.c                                       |    2=20
 net/batman-adv/soft-interface.c                       |    2=20
 net/ceph/messenger.c                                  |   12 ++--
 net/core/net-sysfs.c                                  |    3 +
 net/hsr/hsr_device.c                                  |   18 +++---
 net/hsr/hsr_framereg.c                                |   12 ++++
 net/hsr/hsr_framereg.h                                |    1=20
 net/ipv4/cipso_ipv4.c                                 |   23 ++++++--
 net/ipv4/icmp.c                                       |    7 +-
 net/ipv4/ip_options.c                                 |   22 ++++++-
 net/ipv4/ip_vti.c                                     |   50 +++++++++++++=
+++++
 net/ipv6/ip6mr.c                                      |    8 +-
 net/ipv6/route.c                                      |    2=20
 net/ipv6/sit.c                                        |    7 +-
 net/l2tp/l2tp_ip6.c                                   |    4 -
 net/mac80211/cfg.c                                    |    4 +
 net/mac80211/rx.c                                     |    4 +
 net/netfilter/ipvs/ip_vs_ctl.c                        |   12 ++++
 net/netlink/af_netlink.c                              |   34 +++++++-----
 net/nfc/llcp_commands.c                               |   20 +++++++
 net/nfc/llcp_core.c                                   |   24 +++++++-
 net/packet/af_packet.c                                |    2=20
 net/unix/af_unix.c                                    |   48 ++++++++++---=
----
 net/unix/diag.c                                       |    3 -
 net/wireless/reg.c                                    |    4 -
 net/x25/af_x25.c                                      |   20 +++++--
 security/keys/key.c                                   |    4 -
 security/keys/keyring.c                               |    4 -
 security/keys/proc.c                                  |    3 -
 security/keys/request_key.c                           |    1=20
 security/keys/request_key_auth.c                      |    2=20
 security/lsm_audit.c                                  |   10 ++-
 sound/core/compress_offload.c                         |    3 -
 sound/firewire/bebob/bebob.c                          |   14 ++++-
 sound/soc/fsl/fsl_esai.c                              |    7 +-
 sound/soc/fsl/imx-audmux.c                            |   24 ++++----
 sound/soc/intel/broadwell.c                           |    2=20
 sound/soc/intel/haswell.c                             |    2=20
 tools/perf/util/cpumap.c                              |   11 +++
 tools/perf/util/symbol-elf.c                          |    9 ++-
 143 files changed, 836 insertions(+), 344 deletions(-)

Aditya Pakki (1):
      md: Fix failed allocation of md_register_thread

Al Viro (1):
      missing barriers in some of unix_sock ->addr and ->path accesses

Alban Bedel (1):
      MIPS: ath79: Enable OF serial ports in the default config

Alexey Khoroshilov (1):
      net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_pro=
be()

Alistair Strachan (1):
      media: uvcvideo: Fix 'type' check leading to overflow

Andy Shevchenko (1):
      dmaengine: dmatest: Abort test in case of mapping error

Anoob Soman (1):
      scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_t=
ask

Arad, Ronen (1):
      netlink: Trim skb to alloc size to avoid MSG_TRUNC

Arnd Bergmann (1):
      cpufreq: pxa2xx: remove incorrect __init annotation

Atsushi Nemoto (1):
      net: altera_tse: fix connect_local_phy error path

Balaji Pothunoori (1):
      mac80211: don't initiate TDLS connection if station is not associated=
 to AP

Bart Van Assche (1):
      scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock

Bob Copeland (1):
      mac80211: fix miscounting of ttl-dropped frames

Chaitanya Tata (1):
      cfg80211: extend range deviation for DMG

Charles Keepax (1):
      mfd: wm5110: Add missing ASRC rate register

Christophe Leroy (3):
      powerpc/32: Clear on-stack exception marker upon exception return
      powerpc/wii: properly disable use of BATs when requested.
      powerpc/83xx: Also save/restore SPRG4-7 during suspend

Colin Ian King (1):
      atm: he: fix sign-extension overflow on large shift

Cong Wang (1):
      team: avoid complex list operations in team_nl_cmd_options_set()

Dan Carpenter (3):
      mfd: ab8500-core: Return zero in get_register_interruptible()
      ALSA: compress: prevent potential divide by zero bugs
      usb: gadget: Potential NULL dereference on allocation error

Darrick J. Wong (2):
      tmpfs: fix link accounting when a tmpfile is linked in
      tmpfs: fix uninitialized return value in shmem_link

David Howells (1):
      assoc_array: Fix shortcut creation

Dmitry Torokhov (1):
      Input: matrix_keypad - use flush_delayed_work()

Eric Biggers (5):
      KEYS: allow reaching the keys quotas exactly
      KEYS: user: Align the payload buffer
      KEYS: always initialize keyring_index_key::desc_len
      crypto: ahash - fix another early termination in hash walk
      crypto: pcbc - remove bogus memcpy()s with src =3D=3D dest

Eric Dumazet (8):
      batman-adv: fix uninit-value in batadv_interface_tx()
      l2tp: fix infoleak in l2tp_ip6_recvmsg()
      net/x25: fix use-after-free in x25_device_event()
      net/x25: reset state in x25_connect()
      net/x25: fix a race in x25_bind()
      vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()
      net/hsr: fix possible crash in add_timer()
      gro_cells: make sure device is up in gro_cells_receive()

Felipe Franciosi (1):
      scsi: virtio_scsi: don't send sc payload with tmfs

Filipe Manana (1):
      Btrfs: fix corruption reading shared and compressed extents after hol=
e punching

Finn Thain (1):
      m68k: Add -ffreestanding to CFLAGS

Florian Fainelli (1):
      net: systemport: Fix reception of BPDUs

Gabriel Fernandez (1):
      Input: st-keyscan - fix potential zalloc NULL dereference

Greg Kroah-Hartman (1):
      Linux 3.18.137

Gustavo A. R. Silva (3):
      iscsi_ibft: Fix missing break in switch statement
      ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify
      drm/radeon/evergreen_cs: fix missing break in switch statement

Hangbin Liu (1):
      sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()

Ian Kent (1):
      autofs: fix error return in autofs_fill_super()

Ido Schimmel (2):
      team: Free BPF filter when unregistering netdev
      ip6mr: Do not call __IP6_INC_STATS() from preemptible context

Ilya Dryomov (1):
      libceph: handle an empty authorize reply

Ivan Mironov (1):
      USB: serial: cp210x: add ID for Ingenico 3070

Jack Morgenstein (1):
      net/mlx4_core: Fix qp mtt size calculation

Jan Kara (2):
      ext4: fix crash during online resizing
      ext2: Fix underflow in ext2_max_size()

Jann Horn (1):
      mm: enforce min addr even if capable() in expand_downwards()

Jason Gerecke (1):
      Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Jia-Ju Bai (1):
      isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

Jiri Olsa (1):
      perf symbols: Filter out hidden symbols from labels

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attac=
hed

Jonathan Neusch=E4fer (1):
      mmc: spi: Fix card detection during probe

Jordan Niethe (1):
      powerpc/powernv: Make opal log only readable by root

Julian Wiedmann (1):
      s390/qeth: fix use-after-free in error path

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

Kristian H. Kristensen (1):
      drm/msm: Unblock writer if reader closes file

Krzysztof Kozlowski (1):
      regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

Logan Gunthorpe (1):
      scsi: isci: initialize shost fully before calling scsi_add_host()

Lubomir Rintel (1):
      irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Mao Wenan (2):
      net: hsr: fix memory leak in hsr_dev_finalize()
      net: set static variable an initial value in atl2_probe()

Max Filippov (4):
      xtensa: SMP: fix secondary CPU initialization
      xtensa: smp_lx200_defconfig: fix vectors clash
      xtensa: SMP: mark each possible CPU as present
      xtensa: SMP: limit number of possible CPUs by NR_CPUS

Miaohe Lin (1):
      net: sit: fix UBSAN Undefined behaviour in check_6rd

Michal Hocko (1):
      mm, memory_hotplug: is_mem_section_removable do not pass the end of a=
 zone

Mike Kravetz (1):
      hugetlbfs: fix races and page leaks during migration

Ming Lu (1):
      scsi: libfc: free skb when receiving invalid flogi resp

Nathan Chancellor (3):
      mfd: twl-core: Fix section annotations on {,un}protect_pm_master
      mfd: db8500-prcmu: Fix some section annotations
      isdn: avm: Fix string plus integer warning from Clang

Nazarov Sergey (2):
      net: Add __icmp_send helper.
      net: avoid use IPCB in cipso_v4_error

NeilBrown (1):
      nfsd: fix memory corruption caused by readdir

Pan Bian (1):
      autofs: drop dentry reference only when it is never used

Paul Moore (1):
      netlabel: fix out-of-bounds memory accesses

Pavel Shilovsky (1):
      CIFS: Fix read after write for files with read caching

Peng Hao (1):
      ARM: pxa: ssp: unneeded to free devm_ allocated data

QiaoChong (1):
      parport_pc: fix find_superio io compare code, should use equal test.

Rajasingh Thavamani (1):
      net: phy: Micrel KSZ8061: link failure after cable connect

Ralph Campbell (1):
      numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNOD=
ES

Rander Wang (1):
      ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Roman Penyaev (1):
      mm/vmalloc: fix size check for remap_vmalloc_range_partial()

Ronnie Sahlberg (1):
      cifs: fix computation for MAX_SMB2_HDR_SIZE

S.j. Wang (1):
      ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

Sakari Ailus (1):
      media: uvcvideo: Avoid NULL pointer dereference at the end of streami=
ng

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the hold bit setting

Silvio Cesare (1):
      ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Sinan Kaya (1):
      platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Stefan Haberland (1):
      s390/dasd: fix using offset into zero size array error

Stephane Eranian (1):
      perf tools: Handle TOPOLOGY headers with no CPU

Stuart Menefy (1):
      regulator: s2mpa01: Fix step values for some LDOs

Su Yanjun (1):
      vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Suravee Suthikulpanit (1):
      iommu/amd: Fix IOMMU page flush when detach device from a domain

Takashi Sakamoto (1):
      ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O agai=
nst Liquid Saffire 56

Thomas Bogendoerfer (1):
      MIPS: jazz: fix 64bit build

Thomas Falcon (1):
      ibmveth: Do not process frames after calling napi_reschedule

Tomonori Sakita (2):
      serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampli=
ng
      net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case

Varun Prakash (1):
      scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Vignesh R (1):
      mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd =
cells

Vitaly Kuznetsov (1):
      KVM: nSVM: clear events pending from svm_complete_interrupts() when e=
xiting to L1

Vladimir Murzin (1):
      arm64: Relax GIC version check during early boot

Xiao Ni (1):
      It's wrong to add len to sector_nr in raid10 reshape twice

Xin Long (1):
      pptp: dst_release sk_dst_cache in pptp_sock_destruct

Yan, Zheng (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

Yao Liu (1):
      nfs: Fix NULL pointer dereference of dev_name

Yihao Wu (1):
      nfsd: fix wrong check in write_v4_end_grace()

YueHaibing (4):
      scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param
      net-sysfs: Fix mem leak in netdev_register_kobject
      net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails
      mdio_bus: Fix use-after-free on device_register fails

Zeng Tao (1):
      usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

Zev Weiss (1):
      kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_c=
onv

ZhangXiaoxu (1):
      ipvs: Fix signed integer overflow when setsockopt timeout

zhangyi (F) (1):
      jbd2: clear dirty flag when revoking a buffer from an older transacti=
on

zhengbin (1):
      9p/net: fix memory leak in p9_client_create


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyXQ0gACgkQONu9yGCS
aT7K9Q//WxEiLpJXB7VK2zGw4P8W+q94dQkjN0EEiEx8ROylStUw/u0xn4I8lMXH
VkwvxmyjyXVyxjkIFndTW6+T5mbMqV0w87pwVRD0LKuITNI+Wo1BXMWPAqBSPTNn
yFXWGBYQ0Ry5pzxHhiNbCTQHG5Rz5Ap6AW//WaHn6xA5VpRApHFmZug+eoacSBvb
ibjmEBm7mfxDt7OUpoYZ2OTU8PI64yVinwekKRGjIqXKxK4GDxZazbiNGcAmfMRp
1Awims+3aDU2/gPYjpxr+rR7+xUq4LRADjKjbk4MLSn31232LeShj2yPzLe5ckFW
dBP/8wJdrXxmNzMngrz36fHu8jHKHa7cTlbQccmGH4+mbtx0YgAn1urVtBsl5aAM
I6cbj0CDqLpIsyh3RLP0JLEVY7eBMTuZ5JtnWzNmCQ90BkGWfbJGoQ85valyeoen
E+9SZWtPfIAvdFr9SWFmcQrWNaV6xt1nO7f5qMLtRwsiOlyxH+sRAiYhb1pkI+Fa
YJp3nfAguNtGz6dXDK77I6AzENw8jLtLGklOMW8833QzPPJyaJdjFqoKjfeHlNtM
GsXl1VMGeF+LMRvXTf8HRT6DwkoqjCIeUJGJRVw7R47zffP2uhXpUpDkJ+nP0eAv
ezQwS4il6ICYtUvqC/ZDIlWaB7lntcs+Hfc8BRNAPj7ko4mmiHE=
=AD9q
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
