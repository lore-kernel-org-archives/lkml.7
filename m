Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4387C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BACB20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552200748;
	bh=Vvj1BelPZXpwxMIaH08yDeg16dm6QtGEUXdoNLUwdwA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1wfQlf76dTWGWyVRKlKDKiLDli45pRvopqkd0+knCpnU6jWRb1GAoYZ4GIrgtDrVa
	 jvVUeozQtE4MkYo3CXhMivgjica9THLqB8+XJ6DxBeYqQN9bsrngYiNz3kYd8MzJTC
	 /69ZGUhDOsPTppZFYP4uoul82/Fqzwv0DPWIBvgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCJGw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 01:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfCJGw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 01:52:26 -0500
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 933B020657;
        Sun, 10 Mar 2019 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552200745;
        bh=Vvj1BelPZXpwxMIaH08yDeg16dm6QtGEUXdoNLUwdwA=;
        h=Date:From:To:Cc:Subject:From;
        b=lhlP+NvMwZVweZjmWixB8gLLBPcBU8+nn8qPGI1MBjhdvJNxJ6Une7DycAejp9tla
         f+h6GYjKlVdHGDCROUWbhpZ7U773oM5jKlXN556N2816lPd148WCMr7MQID3eVuDFW
         Q4qJtXDPPP83qJzMz4DK0k+TMg88Oe48skaSp2K8=
Date:   Sun, 10 Mar 2019 07:52:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.15
Message-ID: <20190310065223.GA24945@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.15 kernel.

All users of the 4.20 kernel series must upgrade.

The updated 4.20.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.20.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                      |    2=20
 arch/mips/kernel/irq.c                        |    4=20
 arch/x86/boot/compressed/pgtable_64.c         |   19 +++-
 arch/x86/kernel/cpu/amd.c                     |    8 -
 arch/xtensa/kernel/process.c                  |    4=20
 drivers/android/binder.c                      |  106 ++++++++++++++++++---=
--
 drivers/base/dd.c                             |    2=20
 drivers/bluetooth/btrtl.c                     |   10 +-
 drivers/char/applicom.c                       |   35 +++++--
 drivers/cpufreq/cpufreq.c                     |    6 -
 drivers/cpufreq/intel_pstate.c                |   23 ++---
 drivers/gnss/sirf.c                           |   32 +++----
 drivers/net/dsa/mv88e6xxx/chip.c              |   27 ++++--
 drivers/net/dsa/mv88e6xxx/port.c              |   10 +-
 drivers/net/dsa/mv88e6xxx/port.h              |    1=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |    6 +
 drivers/net/ethernet/marvell/sky2.c           |   24 +++++
 drivers/net/ethernet/microchip/lan743x_main.c |   16 ++-
 drivers/net/ethernet/mscc/ocelot_board.c      |   14 ++-
 drivers/net/geneve.c                          |   11 +-
 drivers/net/hyperv/netvsc_drv.c               |   22 ++++
 drivers/net/phy/micrel.c                      |   13 ++
 drivers/net/phy/phylink.c                     |    4=20
 drivers/net/team/team_mode_loadbalance.c      |   15 +++
 drivers/net/tun.c                             |    4=20
 drivers/net/usb/qmi_wwan.c                    |   26 ++++-
 drivers/net/xen-netback/hash.c                |    2=20
 drivers/net/xen-netback/interface.c           |    7 +
 drivers/net/xen-netback/netback.c             |   10 +-
 drivers/scsi/scsi_lib.c                       |    1=20
 drivers/staging/android/ashmem.c              |   67 +++++++++------
 drivers/staging/android/ion/ion_system_heap.c |    2=20
 drivers/staging/comedi/drivers/ni_660x.c      |    1=20
 drivers/staging/erofs/inode.c                 |    8 -
 drivers/staging/erofs/internal.h              |   11 +-
 drivers/staging/erofs/unzip_vle.c             |  115 ++++++++++++++++-----=
-----
 drivers/staging/erofs/unzip_vle.h             |    3=20
 drivers/staging/erofs/unzip_vle_lz4.c         |   19 +---
 drivers/staging/erofs/xattr.c                 |   65 +++++++++++---
 drivers/staging/wilc1000/linux_wlan.c         |    4=20
 drivers/usb/host/xhci-pci.c                   |    1=20
 drivers/usb/host/xhci-tegra.c                 |    4=20
 drivers/usb/serial/cp210x.c                   |   12 ++
 drivers/usb/serial/ftdi_sio.c                 |    2=20
 drivers/usb/serial/ftdi_sio_ids.h             |    6 +
 drivers/usb/serial/option.c                   |    2=20
 fs/aio.c                                      |   12 ++
 fs/exec.c                                     |    2=20
 include/linux/cpufreq.h                       |   12 --
 include/net/bluetooth/bluetooth.h             |    2=20
 include/net/icmp.h                            |    9 +-
 include/net/ip.h                              |    4=20
 include/net/sch_generic.h                     |   31 ++-----
 include/uapi/linux/android/binder.h           |   19 ++++
 kernel/bpf/verifier.c                         |    3=20
 kernel/trace/trace_events_filter.c            |    5 -
 net/bluetooth/af_bluetooth.c                  |   16 ++-
 net/bluetooth/l2cap_sock.c                    |    2=20
 net/bluetooth/rfcomm/sock.c                   |    2=20
 net/bluetooth/sco.c                           |    2=20
 net/core/gen_stats.c                          |    2=20
 net/core/net-sysfs.c                          |    3=20
 net/ipv4/cipso_ipv4.c                         |   20 +++-
 net/ipv4/fib_frontend.c                       |    4=20
 net/ipv4/icmp.c                               |    7 -
 net/ipv4/ip_input.c                           |    9 +-
 net/ipv4/ip_options.c                         |   22 +++-
 net/ipv4/netlink.c                            |   17 ++-
 net/ipv4/route.c                              |    2=20
 net/ipv6/ip6mr.c                              |    8 -
 net/ipv6/route.c                              |    7 +
 net/ipv6/sit.c                                |    1=20
 net/mpls/af_mpls.c                            |    3=20
 net/netlabel/netlabel_kapi.c                  |    3=20
 net/nfc/llcp_commands.c                       |   20 ++++
 net/nfc/llcp_core.c                           |   24 ++++-
 net/sched/act_ipt.c                           |    3=20
 net/sched/act_skbedit.c                       |    3=20
 net/sched/act_tunnel_key.c                    |    3=20
 net/sched/sch_generic.c                       |   13 +-
 net/sched/sch_netem.c                         |   10 +-
 net/sctp/socket.c                             |    1=20
 net/socket.c                                  |    1=20
 net/tipc/socket.c                             |    8 +
 tools/testing/selftests/firmware/fw_lib.sh    |    2=20
 85 files changed, 782 insertions(+), 321 deletions(-)

Ajay Singh (1):
      staging: wilc1000: fix to set correct value for 'vif_num'

Andrew Lunn (2):
      net: dsa: mv88e6xxx: Fix statistics on mv88e6161
      net: dsa: mv88e6xxx: Fix u64 statistics

Balaji Manoharan (1):
      usb: xhci: Fix for Enabling USB ROLE SWITCH QUIRK on INTEL_SUNRISEPOI=
NT_LP_XHCI

Bart Van Assche (1):
      aio: Fix locking in aio_poll()

Bryan Whitehead (1):
      lan743x: Fix TX Stall Issue

Daniel Borkmann (1):
      bpf: fix sanitation rewrite in case of non-pointers

Daniele Palmas (1):
      USB: serial: option: add Telit ME910 ECM composition

David Ahern (4):
      ipv4: Return error for RTA_VIA attribute
      ipv6: Return error for RTA_VIA attribute
      mpls: Return error for RTA_GATEWAY attribute
      ipv4: Pass original device to ip_rcv_finish_core

Davide Caratti (2):
      net/sched: act_ipt: fix refcount leak when replace fails
      net/sched: act_skbedit: fix refcount leak when replace fails

Eric Biggers (1):
      net: socket: set sock->sk to NULL after calling proto_ops::release()

Eric Dumazet (1):
      net: sched: put back q.qlen into a single location

Erik Hugne (1):
      tipc: fix RDM/DGRAM connect() regression

Gao Xiang (5):
      staging: erofs: fix mis-acted TAIL merging behavior
      staging: erofs: fix fast symlink w/o xattr when fs xattr is on
      staging: erofs: fix race of initializing xattrs of a inode at the sam=
e time
      staging: erofs: fix illegal address access under memory pressure
      staging: erofs: compressed_pages should not be accessed again after f=
reed

Geert Uytterhoeven (1):
      driver core: Postpone DMA tear-down until after devres release

Greg Kroah-Hartman (1):
      Linux 4.20.15

Gustavo A. R. Silva (2):
      staging: comedi: ni_660x: fix missing break in switch statement
      applicom: Fix potential Spectre v1 vulnerabilities

Haiyang Zhang (1):
      hv_netvsc: Fix IP header checksum for coalesced packets

Hangbin Liu (1):
      ipv4: Add ICMPv6 support when parse route ipproto

Heiner Kallweit (5):
      net: dsa: mv88e6xxx: add call to mv88e6xxx_ports_cmode_init to probe =
for new DSA framework
      net: dsa: mv88e6xxx: handle unknown duplex modes gracefully in mv88e6=
xxx_port_set_duplex
      net: dsa: mv8e6xxx: fix number of internal PHYs for 88E6x90 family
      net: phy: phylink: fix uninitialized variable in phylink_get_mac_state
      net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_por=
t_set_cmode

Ido Schimmel (2):
      ip6mr: Do not call __IP6_INC_STATS() from preemptible context
      team: Free BPF filter when unregistering netdev

Igor Druzhinin (2):
      xen-netback: don't populate the hash cache on XenBus disconnect
      xen-netback: fix occasional leak of grant ref mappings under memory p=
ressure

Ivan Mironov (1):
      USB: serial: cp210x: add ID for Ingenico 3070

Jiaxun Yang (1):
      x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Jiri Benc (1):
      geneve: correctly handle ipv6.disable module parameter

Johan Hovold (1):
      gnss: sirf: fix premature wakeup interrupt enable

Kai-Heng Feng (2):
      sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79
      Bluetooth: btrtl: Restore old logic to assume firmware is already loa=
ded

Karoly Pados (1):
      USB: serial: cp210x: fix GPIO in autosuspend

Kavya Sree Kotagiri (1):
      net: mscc: Enable all ports in QSGMII

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Do not read legacy ROM on EFI system

Kristian Evensen (1):
      qmi_wwan: Add support for Quectel EG12/EM12

Liu Xiang (1):
      MIPS: irq: Allocate accurate order pages for irq stack

Luis Chamberlain (1):
      selftests: firmware: fix verify_reqs() return value

Mans Rullgard (1):
      USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485

Mao Wenan (1):
      net: sit: fix memory leak in sit_init_net()

Martin Wilck (1):
      scsi: core: reset host byte in DID_NEXUS_FAILURE case

Matthias Kaehlcke (1):
      Bluetooth: Fix locking in bt_accept_enqueue() for BH context

Max Filippov (1):
      xtensa: fix get_wchan

Maxime Chevallier (1):
      net: dsa: mv88e6xxx: power serdes on/off for 10G interfaces on 6390X

Michael Chan (1):
      bnxt_en: Drop oversize TX packets to prevent errors.

Nazarov Sergey (2):
      net: Add __icmp_send helper.
      net: avoid use IPCB in cipso_v4_error

Paul Moore (1):
      netlabel: fix out-of-bounds memory accesses

Pavel Tikhomirov (1):
      tracing: Fix event filters and triggers to handle negative numbers

Qing Xia (1):
      staging: android: ion: fix sys heap pool's gfp_flags

Rajasingh Thavamani (1):
      net: phy: Micrel KSZ8061: link failure after cable connect

Sheng Lan (1):
      net: netem: fix skb length BUG_ON in __skb_to_sgvec

Sheng Yong (1):
      staging: erofs: fix memleak of inode's shared xattr array

Tetsuo Handa (2):
      staging: android: ashmem: Don't call fallocate() with ashmem_mutex he=
ld.
      staging: android: ashmem: Avoid range_alloc() allocation with ashmem_=
mutex held.

Thierry Reding (1):
      xhci: tegra: Prevent error pointer dereference

Timur Celik (2):
      tun: fix blocking read
      tun: remove unnecessary memory barrier

Todd Kjos (1):
      binder: create node flag to request sender's security context

Tung Nguyen (1):
      tipc: fix race condition causing hung sendto

Viresh Kumar (1):
      cpufreq: Use struct kobj_attribute instead of struct global_attr

Vlad Buslov (1):
      net: sched: act_tunnel_key: fix NULL pointer dereference during init

Xin Long (1):
      sctp: call iov_iter_revert() after sending ABORT

YueHaibing (3):
      net-sysfs: Fix mem leak in netdev_register_kobject
      net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails
      exec: Fix mem leak in kernel_read_file


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyEtCYACgkQONu9yGCS
aT44MRAAvAmAqKei1YWzeYdRycO5w4mhJ6jIMf4i1fmSf1mBjYA+ozuw6l80bMb7
xppyAsKlESB60gGXrOJqIr+Emm6gKfkH4bJcLPADAYzBI2uUA6gCCaUiL0wIjsxs
SMrF+6CLhJ3gZX5gLPaoQI/hxwo4Dx6o5kBBAAk0YmAKht+OhT1XPO0DRE6yfI4J
jEEbw7l5BVmyP9gsjcvtNHimwEaqgY1/MjdQBo6Xh/7ws9HxIvsBzvcjz2NZvbQS
Sjjxyr3IZUQ8QXT64da83XbD6/ukz3/Pu3ycyhM4t5h5yTGX5Ew+s2oHlUrMgTn2
vxURvz3xtj3ztThpxt+vFLUgon3YvIg76LCJ+Ur9O3hhITl0NUmEoQufEV+yd9Su
lcvLxNDspIIbajn1KscwDFO7y+RUqqrOZaViM13mxsnn5L5HkhYBw5I45BR6RtkK
rKkWZQ5QklJYgzRp7A2IOfZg0jpQgvjSoi7vy8pTlbheiKblfrl4pOZSZDQdxxzi
FNC0D4HNt/DFk2BCUP1hZJU8c4TqTYkOCtmku8AW9FcrM64j6w2RDm0XmPSC9pZT
W7XLx1OuQEyroV6/wTgc5qsFExMfY/ISiu0V9P4Cej59Fo/fSM4d3e8DUZJzHPwX
ei4GAqYp/ueoDCLjfkEzkWV5BxLU3BymniBv/2PWWT6M8R2u1M8=
=zktv
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
