Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A7BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5D020685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552999629;
	bh=RXySPvkwvqUc83m2BrRZ3gXDR97h58vT4Z6F0jgUn6w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=trglRTjoT8N2wHbBiKwYSGx3RFGJapBxMOXHs3xyEJ3YbLNBLBAH7R+744kQYmx/z
	 YfNwool6UnAkGJUIm4S7uB4GSLVl+GivfUcc/7LZ66kRwHcd1rDUQqhJNzkwkCA1VS
	 WZGIWxIKwbm+VaxkHShwXOc9mbJSvvMgIKx+Nvho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfCSMrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfCSMrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:47:08 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A86220685;
        Tue, 19 Mar 2019 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552999626;
        bh=RXySPvkwvqUc83m2BrRZ3gXDR97h58vT4Z6F0jgUn6w=;
        h=Date:From:To:Cc:Subject:From;
        b=VRHXkb8v9rypxIWfE1XiKipdAsGUaiimGbyFS7gXfqEaYGrE5siyV8ODG6Y7wuwjZ
         TyiAlEOSDh6vo/DsQsm4INy9XJGXUt1XAjY8c3zdGEDIqXka3NVvAKE9C1SdH83xZu
         X3m+3FdguNoE7KdS92X9ILB+tPr1vS6IUBPXneLk=
Date:   Tue, 19 Mar 2019 13:47:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.17
Message-ID: <20190319124704.GA468@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.17 kernel.

Note, this is the LAST release of the 4.20.y kernel.  It is now
end-of-life, please move to the 5.0.y kernel tree at this point in time.

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

 Makefile                                              |    2=20
 arch/x86/events/intel/core.c                          |    4=20
 arch/x86/events/perf_event.h                          |    4=20
 drivers/connector/cn_proc.c                           |   22 ++++
 drivers/gpu/drm/drm_atomic_helper.c                   |    9 ++
 drivers/md/raid10.c                                   |    1=20
 drivers/net/bonding/bond_main.c                       |   35 +++----
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c       |    3=20
 drivers/net/ethernet/mellanox/mlx4/cmd.c              |    9 ++
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    6 -
 drivers/net/ethernet/microchip/lan743x_main.c         |   55 +++++++-----
 drivers/net/ethernet/renesas/ravb_main.c              |    2=20
 drivers/net/ipvlan/ipvlan_main.c                      |    4=20
 drivers/net/phy/mdio_bus.c                            |    1=20
 drivers/net/ppp/pptp.c                                |    1=20
 drivers/net/team/team.c                               |    4=20
 drivers/net/vxlan.c                                   |   14 ++-
 drivers/vhost/vsock.c                                 |    2=20
 fs/f2fs/file.c                                        |   12 +-
 net/core/gro_cells.c                                  |   22 ++++
 net/hsr/hsr_device.c                                  |   18 ++--
 net/hsr/hsr_framereg.c                                |   12 ++
 net/hsr/hsr_framereg.h                                |    1=20
 net/ipv4/route.c                                      |   13 ++
 net/ipv4/syncookies.c                                 |    7 +
 net/ipv4/tcp.c                                        |    5 +
 net/ipv4/tcp_input.c                                  |    8 +
 net/ipv4/tcp_ipv4.c                                   |    9 --
 net/ipv4/tcp_output.c                                 |    1=20
 net/ipv6/route.c                                      |   32 +++++--
 net/ipv6/sit.c                                        |    5 -
 net/l2tp/l2tp_ip6.c                                   |    4=20
 net/rxrpc/conn_client.c                               |    4=20
 net/sched/cls_flower.c                                |   43 ++++-----
 net/sctp/stream.c                                     |    2=20
 net/smc/smc.h                                         |    6 -
 net/unix/af_unix.c                                    |   57 +++++++-----
 net/unix/diag.c                                       |    3=20
 net/x25/af_x25.c                                      |   20 +++-
 security/lsm_audit.c                                  |   10 +-
 sound/firewire/bebob/bebob.c                          |   14 ++-
 sound/firewire/motu/amdtp-motu.c                      |    4=20
 sound/hda/hdac_i915.c                                 |    4=20
 sound/pci/hda/patch_conexant.c                        |    3=20
 sound/pci/hda/patch_realtek.c                         |   80 ++++++++++++-=
-----
 45 files changed, 377 insertions(+), 200 deletions(-)

Al Viro (1):
      missing barriers in some of unix_sock ->addr and ->path accesses

Bryan Whitehead (2):
      lan743x: Fix RX Kernel Panic
      lan743x: Fix TX Stall Issue

Christoph Paasch (1):
      tcp: Don't access TCP_SKB_CB before initializing it

Daniel Borkmann (1):
      ipvlan: disallow userns cap_net_admin to change global mode/flags

David Howells (1):
      rxrpc: Fix client call queueing, waiting for channel

Eric Dumazet (8):
      gro_cells: make sure device is up in gro_cells_receive()
      l2tp: fix infoleak in l2tp_ip6_recvmsg()
      net/hsr: fix possible crash in add_timer()
      net/x25: fix use-after-free in x25_device_event()
      net/x25: reset state in x25_connect()
      vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()
      tcp: repaired skbs must init their tso_segs
      net/x25: fix a race in x25_bind()

George Wilkie (1):
      team: use operstate consistently for linkup

Greg Kroah-Hartman (1):
      Linux 4.20.17

Guillaume Nault (1):
      tcp: handle inet_csk_reqsk_queue_add() failures

Jack Morgenstein (3):
      net/mlx4_core: Fix reset flow when in command polling mode
      net/mlx4_core: Fix locking in SRIOV mode when switching between event=
s and polling
      net/mlx4_core: Fix qp mtt size calculation

Jaegeuk Kim (1):
      f2fs: wait on atomic writes to count F2FS_CP_WB_DATA

Jaroslav Kysela (1):
      ALSA: hda - add more quirks for HP Z2 G4 and HP Z240

Jian Shen (1):
      net: hns3: add dma_rmb() for rx description

Jian-Hong Pan (2):
      ALSA: hda/realtek: Enable audio jacks of ASUS UX362FA with ALC294
      ALSA: hda/realtek: Enable headset MIC of Acer TravelMate X514-51T wit=
h ALC255

Kalash Nainwal (1):
      net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255

Li RongQing (1):
      connector: fix unsafe usage of ->real_parent

Mao Wenan (1):
      net: hsr: fix memory leak in hsr_dev_finalize()

Masaru Nagai (1):
      ravb: Decrease TxFIFO depth of Q3 and Q2 to one

Miaohe Lin (1):
      net: sit: fix UBSAN Undefined behaviour in check_6rd

Michal Soltys (1):
      bonding: fix PACKET_ORIGDEV regression

Nicholas Kazlauskas (1):
      drm: Block fb changes for async plane updates

Paolo Abeni (4):
      ipv4/route: fail early when inet dev is missing
      ipv6: route: purge exception on removal
      ipv6: route: enforce RCU protection in rt6_update_exception_stamp_rt()
      ipv6: route: enforce RCU protection in ip6_route_check_nh_onlink()

Peter Zijlstra (2):
      perf/x86: Fixup typo in stub functions
      perf/x86/intel: Fix memory corruption

Soheil Hassas Yeganeh (1):
      tcp: do not report TCP_CM_INQ of 0 for closed connections

Stefano Brivio (1):
      vxlan: Fix GRO cells race condition between receive and link delete

Takashi Iwai (2):
      ALSA: hda: Extend i915 component bind timeout
      ALSA: hda/realtek - Reduce click noise on Dell Precision 5820 headpho=
ne

Takashi Sakamoto (2):
      ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O agai=
nst Liquid Saffire 56
      ALSA: firewire-motu: fix construction of PCM frame for capture direct=
ion

Ursula Braun (1):
      net/smc: fix smc_poll in SMC_INIT state

Vlad Buslov (1):
      net: sched: flower: insert new filter to idr after setting its mask

Xiao Ni (1):
      It's wrong to add len to sector_nr in raid10 reshape twice

Xin Long (3):
      pptp: dst_release sk_dst_cache in pptp_sock_destruct
      route: set the deleted fnhe fnhe_daddr to 0 in ip_del_fnhe to fix a r=
ace
      sctp: remove sched init from sctp_stream_init

YueHaibing (1):
      mdio_bus: Fix use-after-free on device_register fails

Zha Bin (1):
      vhost/vsock: fix vhost vsock cid hashing inconsistent

kbuild test robot (1):
      perf/x86/intel: Make dev_attr_allow_tsx_force_abort static


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyQ5MgACgkQONu9yGCS
aT7MqRAAkrVbnOO53bAmmt3F82ieocOUM9/VUrC26mrAsudi7aVkdQ5laJVbIb8Y
BheteEG1qZtlfvhYAxkTn1EK8Gf3Pe8/mbgiH8+ukqr4PMh4i9EvsVR8a3dXSG9c
VH4Wo28l2j3GJGrRajqX+ddzNRwVvRk4oeEntbh0RmUy5OY9B/KjmSgWAkaBsjZq
fV29Us04rAY9p9cJJ/5womI8lQ5KrXhRHwtCfMd2ZrqBdvWW2UUZivORsp46ilkD
jpRGm5l0qvLLFz2DntCZIzt6JoIY1AgnMbXNxwuh93OR6/E+/b5C+P+Saj1/snff
D96NSFCZ19X7ZJ4QdhJXW29r5Cpkn5d5iCBHHeSxD8hKLGh6hKM0abJKgHP8x70/
XgQft6RM5xKAoIoVNpkqKZ7P2NcI6x9FWOo9zGvPwmraK9pu27ELFmsHfayBCCzi
YtTEJZ2kG0bkfJHZJBzCgv6FC1owlLDdMm1rmQRz4Ra4/KaNsNJUkJ34dfuQHOBk
eWVO1/4BegQkXCiLPsqgOulS8Rfm3903ZsB1tEZ/KWAYTmkA9dQfh1CTpTQhPeil
20APxRtkM8X2sOD4k+i7AwUSjrsDYJB+7IKN9574o85RZcG7sKSKZF71/pLyE6Ow
r88MCQ/za1OPeswsYhRrWtd5GyXkW0Lchfzh3+T0oH4pKbpbK/0=
=5dy4
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
