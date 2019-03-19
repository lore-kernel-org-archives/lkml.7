Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98374C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522A620685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552999655;
	bh=x/GrNlgPJO0WNA//hEnvTKTUyr6hDS+QwqC3470B7J8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xFAnmj6Xn+pm/b6PvImbwJwp7UKZBkTCyjCx0yy0Zv9BS8dvKz2V6MWF0gbjPPprk
	 jiUz8lRrEwg9qc8pPwyQVz/jFN5gRkPu2M/tfb5Eg4ElJCPpZboLBuDTwKk5yACsSy
	 RiD3Mg+9G6b7fPtpP3PgI6YH4dfwkhkd6qKOVUzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfCSMre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfCSMrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:47:33 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231F420685;
        Tue, 19 Mar 2019 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552999651;
        bh=x/GrNlgPJO0WNA//hEnvTKTUyr6hDS+QwqC3470B7J8=;
        h=Date:From:To:Cc:Subject:From;
        b=JcpMd/Pw80bbXZi5QoAsJgdIEeppwk2eNC42jFv9C7NsTfwQG+z9rxZVLUOBN3aSM
         TuE9rL7xUk1+4MSqaYIS+wqob9tpMBAcMydUQjDYwCeWd/Io5h4pOmw2jTgwXwGPHB
         yGPZxtYi200vSSd3sTrpzVD43g1JehaK02Id+LCY=
Date:   Tue, 19 Mar 2019 13:47:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 5.0.3
Message-ID: <20190319124729.GA1952@kroah.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 5.0.3 kernel.

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

 Makefile                                               |    2=20
 arch/x86/events/intel/core.c                           |    4=20
 arch/x86/events/perf_event.h                           |    4=20
 drivers/connector/cn_proc.c                            |   22 +++-
 drivers/gpu/drm/drm_atomic_helper.c                    |    9 +
 drivers/md/raid10.c                                    |    1=20
 drivers/net/dsa/mv88e6xxx/chip.c                       |   11 ++
 drivers/net/dsa/mv88e6xxx/chip.h                       |    3=20
 drivers/net/dsa/mv88e6xxx/port.c                       |   24 +++++
 drivers/net/dsa/mv88e6xxx/port.h                       |    4=20
 drivers/net/ethernet/hisilicon/hns3/hnae3.h            |    1=20
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c        |    6 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |    9 +
 drivers/net/ethernet/mellanox/mlx4/cmd.c               |    9 +
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c  |    6 -
 drivers/net/ethernet/microchip/lan743x_main.c          |   55 +++++++----
 drivers/net/ethernet/renesas/ravb_main.c               |    2=20
 drivers/net/ppp/pptp.c                                 |    1=20
 drivers/net/vxlan.c                                    |   14 ++
 fs/f2fs/file.c                                         |   12 +-
 net/core/gro_cells.c                                   |   22 +++-
 net/hsr/hsr_device.c                                   |   18 +--
 net/hsr/hsr_framereg.c                                 |   12 ++
 net/hsr/hsr_framereg.h                                 |    1=20
 net/ipv4/fou.c                                         |    4=20
 net/ipv4/route.c                                       |   13 +-
 net/ipv4/syncookies.c                                  |    7 +
 net/ipv4/tcp.c                                         |    5 +
 net/ipv4/tcp_input.c                                   |    8 +
 net/ipv4/tcp_ipv4.c                                    |    9 -
 net/ipv6/fou6.c                                        |    4=20
 net/ipv6/sit.c                                         |    5 -
 net/l2tp/l2tp_ip6.c                                    |    4=20
 net/rxrpc/conn_client.c                                |    4=20
 net/sched/cls_flower.c                                 |   43 ++++-----
 net/sctp/stream.c                                      |    2=20
 net/vmw_vsock/virtio_transport_common.c                |   22 +++-
 net/x25/af_x25.c                                       |    7 +
 sound/firewire/bebob/bebob.c                           |   14 ++
 sound/firewire/motu/amdtp-motu.c                       |    4=20
 sound/hda/hdac_i915.c                                  |    4=20
 sound/pci/hda/patch_conexant.c                         |    3=20
 sound/pci/hda/patch_realtek.c                          |   80 +++++++++++-=
-----
 43 files changed, 350 insertions(+), 144 deletions(-)

Adalbert Laz=C4=83r (1):
      vsock/virtio: fix kernel panic from virtio_transport_reset_no_sock

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Set correct interface mode for CPU/DSA ports

Bryan Whitehead (2):
      lan743x: Fix RX Kernel Panic
      lan743x: Fix TX Stall Issue

Christoph Paasch (1):
      tcp: Don't access TCP_SKB_CB before initializing it

David Howells (1):
      rxrpc: Fix client call queueing, waiting for channel

Eric Dumazet (7):
      fou, fou6: avoid uninit-value in gue_err() and gue6_err()
      gro_cells: make sure device is up in gro_cells_receive()
      l2tp: fix infoleak in l2tp_ip6_recvmsg()
      net/hsr: fix possible crash in add_timer()
      net/x25: fix use-after-free in x25_device_event()
      net/x25: reset state in x25_connect()
      vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()

Greg Kroah-Hartman (1):
      Linux 5.0.3

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

Li RongQing (1):
      connector: fix unsafe usage of ->real_parent

Mao Wenan (1):
      net: hsr: fix memory leak in hsr_dev_finalize()

Masaru Nagai (1):
      ravb: Decrease TxFIFO depth of Q3 and Q2 to one

Miaohe Lin (1):
      net: sit: fix UBSAN Undefined behaviour in check_6rd

Nicholas Kazlauskas (1):
      drm: Block fb changes for async plane updates

Paolo Abeni (1):
      ipv4/route: fail early when inet dev is missing

Peter Zijlstra (2):
      perf/x86: Fixup typo in stub functions
      perf/x86/intel: Fix memory corruption

Shiju Jose (1):
      net: hns3: fix to stop multiple HNS reset due to the AER changes

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

Vlad Buslov (1):
      net: sched: flower: insert new filter to idr after setting its mask

Xiao Ni (1):
      It's wrong to add len to sector_nr in raid10 reshape twice

Xin Long (3):
      pptp: dst_release sk_dst_cache in pptp_sock_destruct
      route: set the deleted fnhe fnhe_daddr to 0 in ip_del_fnhe to fix a r=
ace
      sctp: remove sched init from sctp_stream_init

kbuild test robot (1):
      perf/x86/intel: Make dev_attr_allow_tsx_force_abort static


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyQ5OAACgkQONu9yGCS
aT6+vg//QJzmtBHMlamW5fEGS7qFzYStcx28fQjb8KFnncpBm+a5ch7IvvTk8RUU
4/+jdI5MIvzigNmGmnwSMhpSPCExQURrILOAINLucaLAFEamTLQvZl7SNH4p+rlQ
mjFLbEoy8WfExkKZQ7uocNs7Sp2DiSaXZgRwB/aViTXnyLRHTIXY/jaD39dLAKBX
7OC5cF4ezAqPo47mU2Jmzi7werfe79vgzZHA8e88ASt9eqgMkEdAu1Vyg3FyNdMY
e/5Sq75W2X7pINdWZhT5KK+eN2V3Zm4k6zbZRPbMupII4jgSxMv0rrX6izc2Ps8k
/BD9CWy8LWKg0oLCetF3EN6R5S6RY0ZqJeeGIfAUiEf+nEhujPiVYL7gAx6N5TMC
xxnLw7k9DB+vUGwj0PYwZN9JG81+ew0EUqn57f9fryAjdnO4y2X4+Ew+q0Ccqao6
xpebCTyRukrH/ymI4Y7pIetzzz+w3kBfaK0fyfRd8w4WHwosMrjd1Y+EhglB9WuB
8ZKr0MXuh3HCZxwFKlrnuFivaRDOgV2K4PiWLGitubqpt6CT78S2arifHByjwz36
NdSYt19qclUgBeIHTwRRvd1pL5bGqvANccNgG489tAo9SmNnnFXMrSL4xZJwknEL
wgLhlkU4QZloS4gpLc4jJxBDdn4FF75SvshFrNL3xni1G5PHY8U=
=z+zR
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
