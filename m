Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790D22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552999528;
	bh=XrujEbovMqbGs068VRjJnH+7HiH3ic1/wmRXcq4nBCY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=YWf9r+FhshjLuZjj5jOR2QE7eDd5Sgf6/l+7y8UuDWCJ3POZ4ClPiw4BdlFIp8yzm
	 /2I/B5HkmQ/uHJDcIA6R8nQpSjPy+99+zdFIbbwnOztOlRfkEg/pEuMfX+IcIKlgPe
	 OSVXycxMXtNBlxxnABbCXvmmeMq+RT/p3GgYcsmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCSMp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfCSMp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:45:26 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E6982147C;
        Tue, 19 Mar 2019 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552999525;
        bh=XrujEbovMqbGs068VRjJnH+7HiH3ic1/wmRXcq4nBCY=;
        h=Date:From:To:Cc:Subject:From;
        b=z/OcgVFKQB0wzeggJmU3ZrFOkXjLtQgaoHOkhi88GeGjefzzR6My71GPekG6TSk+l
         8YVb4JggfFA3bRdxXWPJstBKm+5T2kVRPWMHusirKKRtqZL1VR72++MV1tIsnckHRx
         5aZq2LH5XJhu7NxHniTIPyOHOSmawlqeMc7oR8K4=
Date:   Tue, 19 Mar 2019 13:45:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.107
Message-ID: <20190319124521.GA9730@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.107 kernel.

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

 Makefile                                              |    2=20
 arch/x86/events/intel/core.c                          |    4 -
 arch/x86/events/perf_event.h                          |    4 -
 drivers/md/raid10.c                                   |    1=20
 drivers/net/bonding/bond_main.c                       |   35 ++++-------
 drivers/net/ethernet/mellanox/mlx4/cmd.c              |    9 ++
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    6 -
 drivers/net/ethernet/renesas/ravb_main.c              |    2=20
 drivers/net/ipvlan/ipvlan_main.c                      |    9 ++
 drivers/net/phy/mdio_bus.c                            |    1=20
 drivers/net/ppp/pptp.c                                |    1=20
 drivers/net/vxlan.c                                   |   14 ++++
 drivers/vhost/vsock.c                                 |    2=20
 include/acpi/acconfig.h                               |    2=20
 net/core/gro_cells.c                                  |   22 +++++-
 net/hsr/hsr_device.c                                  |   18 ++---
 net/hsr/hsr_framereg.c                                |   12 +++
 net/hsr/hsr_framereg.h                                |    1=20
 net/ipv4/route.c                                      |   13 ++--
 net/ipv4/syncookies.c                                 |    7 +-
 net/ipv4/tcp_input.c                                  |    8 ++
 net/ipv4/tcp_ipv4.c                                   |    9 --
 net/ipv6/route.c                                      |    2=20
 net/ipv6/sit.c                                        |    5 -
 net/l2tp/l2tp_ip6.c                                   |    4 -
 net/rxrpc/conn_client.c                               |    4 -
 net/unix/af_unix.c                                    |   57 ++++++++++---=
-----
 net/unix/diag.c                                       |    3=20
 net/x25/af_x25.c                                      |   20 ++++--
 security/lsm_audit.c                                  |   10 +--
 sound/firewire/bebob/bebob.c                          |   14 ++++
 sound/firewire/motu/amdtp-motu.c                      |    4 -
 tools/perf/arch/x86/util/unwind-libunwind.c           |    2=20
 33 files changed, 198 insertions(+), 109 deletions(-)

Al Viro (1):
      missing barriers in some of unix_sock ->addr and ->path accesses

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

Erik Schmauss (1):
      ACPICA: Reference Counts: increase max to 0x4000 for large servers

Greg Kroah-Hartman (1):
      Linux 4.14.107

Guillaume Nault (1):
      tcp: handle inet_csk_reqsk_queue_add() failures

Jack Morgenstein (3):
      net/mlx4_core: Fix reset flow when in command polling mode
      net/mlx4_core: Fix locking in SRIOV mode when switching between event=
s and polling
      net/mlx4_core: Fix qp mtt size calculation

Kalash Nainwal (1):
      net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255

Mao Wenan (1):
      net: hsr: fix memory leak in hsr_dev_finalize()

Masaru Nagai (1):
      ravb: Decrease TxFIFO depth of Q3 and Q2 to one

Miaohe Lin (1):
      net: sit: fix UBSAN Undefined behaviour in check_6rd

Michal Soltys (1):
      bonding: fix PACKET_ORIGDEV regression

Paolo Abeni (1):
      ipv4/route: fail early when inet dev is missing

Peter Zijlstra (2):
      perf/x86: Fixup typo in stub functions
      perf/x86/intel: Fix memory corruption

Stefano Brivio (1):
      vxlan: Fix GRO cells race condition between receive and link delete

Takashi Sakamoto (2):
      ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O agai=
nst Liquid Saffire 56
      ALSA: firewire-motu: fix construction of PCM frame for capture direct=
ion

Wang Nan (1):
      perf tools: Fix compile error with libunwind x86

Xiao Ni (1):
      It's wrong to add len to sector_nr in raid10 reshape twice

Xin Long (2):
      pptp: dst_release sk_dst_cache in pptp_sock_destruct
      route: set the deleted fnhe fnhe_daddr to 0 in ip_del_fnhe to fix a r=
ace

YueHaibing (1):
      mdio_bus: Fix use-after-free on device_register fails

Zha Bin (1):
      vhost/vsock: fix vhost vsock cid hashing inconsistent

kbuild test robot (1):
      perf/x86/intel: Make dev_attr_allow_tsx_force_abort static


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyQ5GEACgkQONu9yGCS
aT5PLg/9GtWyz1i18vTj/VSokEc+RPysWulIalWeZSKLN93oEOs0yqkCBRjtZrZs
DUILQPBjgxuRUtmtrcR3IUpVe7jZQ1g3XlvLzK+g7S0yj78rYs7zBbNSd5EDGvQg
Ff1xkY1XSnW2b5IK5B6CA0Blbr2kQ6hSDsAXxxO1SKEkeTv6svpTRQlRDUtGYd9x
EOo5GPxV19XSRpEJuu/idWITg7TGOP6EvBnQyUhTcirA+Tj1F4xKQTs2hAUOZjMV
lu/mPmJ/AWIOy/JKE31XJxdl82p6mSiLMTrUfwnwGoT3Z4RPHnGG6MZQm/QUOyEG
Y0LeqPfQ9VhDDb0+AEHTkzLEGctBkUD9nREInnSWiOiUKqpVlBaENwamwogXrGzU
WXik1gqVSK3+cLOChkSEPbMGqPSw/CxAb99I37OtCWHGHqv4/yt/OSzIa9YkEu8t
pL3zSOv/xQg8WwhDs+S2l5z86HHXewHUV3SOodUrE8Nf4b2qcTDYg5k7CmdAHbAS
fhyrlhHU6clzAxW+/s7NPIWtXrY4TvMXpWnyWomyK/DiMnolUFs559PzDNZhJfRa
zMu7+g5EnEIoln5h+YuNQbuXlhLHWsIYr72wYhHHZGesGgNmfJ6gll8TZTmVbTnA
u2stzjSjyCKOFe8suePm6dL91UPvIvPqd/yki8UMZd/snZc+Y7M=
=T65i
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
