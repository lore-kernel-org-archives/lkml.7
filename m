Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97DDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE9220685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552999570;
	bh=1Ie7boNcYF/q/mghxTBZFXEqM1lqwKtQDKG0ibV+Sxg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=djZ2wqIf/0G6v2gS7Lr3Uha7R05qxK3BAYGd0beHdjjXq84mjydad0iK75acbLcKL
	 Abn1bpJZ7g/5XFxzvNDJ8aSVjCdqxiyA4HhYL71N9SGGpsWDXXvs2KHT+UXB+MDpRT
	 eSTiSoQXhF0G9+b1gmrIpBodDK8Gnv7OOVNyUq/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfCSMqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfCSMqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:46:08 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A414020685;
        Tue, 19 Mar 2019 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552999567;
        bh=1Ie7boNcYF/q/mghxTBZFXEqM1lqwKtQDKG0ibV+Sxg=;
        h=Date:From:To:Cc:Subject:From;
        b=Ur7DDdtZ6m6Gu4DqpBNX3JX+QDS+4TJktt0B6dUD1iH933Jl63eN6YTiVHX4SZwXL
         M230ViXQn7imvTOytt32OFWiqJwhzfvX48lIst30UMQkYGhoN1n1EIUglJb2O2Hiys
         9LFO7JNDT77y5QLNIvOTb+wf+te0iC0dA1H6t/1A=
Date:   Tue, 19 Mar 2019 13:46:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.30
Message-ID: <20190319124604.GA21776@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.30 kernel.

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

 Makefile                                              |    2=20
 arch/x86/events/intel/core.c                          |    4=20
 arch/x86/events/perf_event.h                          |    4=20
 drivers/connector/cn_proc.c                           |   22 ++
 drivers/gpu/drm/drm_atomic_helper.c                   |    9 +
 drivers/md/raid10.c                                   |    1=20
 drivers/net/bonding/bond_main.c                       |   35 +---
 drivers/net/ethernet/intel/i40e/i40e_main.c           |   24 +--
 drivers/net/ethernet/mellanox/mlx4/cmd.c              |    9 +
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    6=20
 drivers/net/ethernet/microchip/lan743x_main.c         |   55 ++++---
 drivers/net/ethernet/renesas/ravb_main.c              |    2=20
 drivers/net/ipvlan/ipvlan_main.c                      |    4=20
 drivers/net/phy/mdio_bus.c                            |    1=20
 drivers/net/ppp/pptp.c                                |    1=20
 drivers/net/team/team.c                               |    4=20
 drivers/net/vxlan.c                                   |   14 +
 drivers/staging/erofs/internal.h                      |    1=20
 drivers/staging/erofs/utils.c                         |  139 ++++++++++++-=
-----
 drivers/vhost/vsock.c                                 |    2=20
 fs/f2fs/file.c                                        |   12 -
 net/core/gro_cells.c                                  |   22 ++
 net/hsr/hsr_device.c                                  |   18 +-
 net/hsr/hsr_framereg.c                                |   12 +
 net/hsr/hsr_framereg.h                                |    1=20
 net/ipv4/route.c                                      |   13 +
 net/ipv4/syncookies.c                                 |    7=20
 net/ipv4/tcp.c                                        |    5=20
 net/ipv4/tcp_input.c                                  |    8 -
 net/ipv4/tcp_ipv4.c                                   |    9 -
 net/ipv6/route.c                                      |   32 +++-
 net/ipv6/sit.c                                        |    5=20
 net/l2tp/l2tp_ip6.c                                   |    4=20
 net/rxrpc/conn_client.c                               |    4=20
 net/sched/cls_flower.c                                |   43 ++---
 net/sctp/stream.c                                     |    2=20
 net/smc/smc.h                                         |    6=20
 net/unix/af_unix.c                                    |   57 ++++---
 net/unix/diag.c                                       |    3=20
 net/x25/af_x25.c                                      |   20 +-
 security/lsm_audit.c                                  |   10 -
 sound/firewire/bebob/bebob.c                          |   14 +
 sound/firewire/motu/amdtp-motu.c                      |    4=20
 sound/hda/hdac_i915.c                                 |    4=20
 sound/pci/hda/patch_conexant.c                        |    3=20
 sound/pci/hda/patch_realtek.c                         |   80 ++++++----
 46 files changed, 487 insertions(+), 250 deletions(-)

Al Viro (1):
      missing barriers in some of unix_sock ->addr and ->path accesses

Bj=F6rn T=F6pel (1):
      i40e: report correct statistics when XDP is enabled

Bryan Whitehead (2):
      lan743x: Fix RX Kernel Panic
      lan743x: Fix TX Stall Issue

Christoph Paasch (1):
      tcp: Don't access TCP_SKB_CB before initializing it

Daniel Borkmann (1):
      ipvlan: disallow userns cap_net_admin to change global mode/flags

David Howells (1):
      rxrpc: Fix client call queueing, waiting for channel

Eric Dumazet (7):
      gro_cells: make sure device is up in gro_cells_receive()
      l2tp: fix infoleak in l2tp_ip6_recvmsg()
      net/hsr: fix possible crash in add_timer()
      net/x25: fix use-after-free in x25_device_event()
      net/x25: reset state in x25_connect()
      vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()
      net/x25: fix a race in x25_bind()

Gao Xiang (1):
      staging: erofs: fix race when the managed cache is enabled

George Wilkie (1):
      team: use operstate consistently for linkup

Greg Kroah-Hartman (1):
      Linux 4.19.30

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


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyQ5IwACgkQONu9yGCS
aT575A//WPp6HgB1ntTBY/kMvHYMZ3gYx7bn3AGoxAH0SQtrrKq6DE8e4Zm78tU8
AhzDgs4hkAZRy9HefDbXt4SNqyLtLx190W+y245nNV3GbMeIrIYC7TWGXPQhTSy/
EHl7sav/8YCFbFL3NBie7gfu5Xz6UiaB5qvYIz9egLciFseElrNDa74KtJsk0o1m
z3hKswg7Of/AWHfkHJxfe4bpDirSK1uYMq7YhTAdDIEJ+/faXNyMv4DiPg5iHmAh
VnhOgeZkIN5q52zmuNXRc/PnvK0fZTOfQy85kky6VaK1srvJQzFvocBuv+ygEVnB
TW9p7+xmDAt8BTof9Q6k4zXQ/klIpWxSDbovez55DAclboAfxtIWcFezCdS4aoZg
pnZ2QpsPR7UAt1QxxZI8HhS/ImUKYeC037bt4ASBh7phRJUYDSUJhlbfE+b4/Em+
tmM7HtC0PwVmXfKNGEYEGkmiBzf0AH9sdTRaJgoZ1kaVeiZlKDORlOmgEOIxg7c9
NWXzQ6Chkfk3Xa5NaKDsdLj7wk1Acg0VWNXPJQThEvbGxSw3qXAEBqsL2dD7eBbS
tbOBgnBPS+hhaKqfo8GyH3bgWR7ZjWmvy/guVn76Mmbq94WmAF3HIBt+B1S57mm2
7pMPVIiyNq6gw4Ftx70TKbg5qESQpq1e8Ro0kN3YiuIXKE5A1ao=
=4B3E
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
