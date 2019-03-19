Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B18C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72A20685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552999497;
	bh=A3H1aQwMpD4pdzRgs4oGT8Kp6O0Qc5mD6ZExWOEgLCI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SM2A3jRI2QF/X6lMuzAvlvxDarsi+t3nYB0jlpldQ3QIblg63iMJPFyTKb6uxWXXV
	 CkZT2/sFvFtwUIVG2YBzdC8X+hBFsbtZIYHcdW99kM84xIrYhMZoor0Fbec0m6IDxM
	 SG1jE9jzDTHlM/mb2Wef6YmTX9XNPe2ie234yETI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCSMoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfCSMoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:44:55 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCC020685;
        Tue, 19 Mar 2019 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552999494;
        bh=A3H1aQwMpD4pdzRgs4oGT8Kp6O0Qc5mD6ZExWOEgLCI=;
        h=Date:From:To:Cc:Subject:From;
        b=zGv3Im1awX9h/l/cu9s13bJ0DMYr1z5qu9YuC5VLD+jMTfRM/eoHwYGf2wFvqyqeM
         LgKiZU0e/i2QpDtcMBR8ojOBL7JMWN4RJphQo0DSSKX5SL9FBN750jTTUiaMBoJ11I
         0dn6kSd5+hgHkl5Zu8lVdTy6IG+oczBTnW2LXNnQ=
Date:   Tue, 19 Mar 2019 13:44:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.164
Message-ID: <20190319124451.GA25177@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.164 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                              |    2=20
 arch/x86/events/perf_event.h                          |    4 -
 drivers/md/raid10.c                                   |    1=20
 drivers/mmc/host/tmio_mmc_pio.c                       |   11 ++--
 drivers/net/ethernet/mellanox/mlx4/cmd.c              |    9 +++
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    6 +-
 drivers/net/ethernet/renesas/ravb_main.c              |    2=20
 drivers/net/ipvlan/ipvlan_main.c                      |    9 +++
 drivers/net/phy/mdio_bus.c                            |    1=20
 drivers/net/ppp/pptp.c                                |    1=20
 drivers/net/vxlan.c                                   |   14 ++++-
 drivers/vhost/vsock.c                                 |    2=20
 include/acpi/acconfig.h                               |    2=20
 include/linux/of.h                                    |   20 ++++---
 include/net/gro_cells.h                               |   22 ++++++--
 net/hsr/hsr_device.c                                  |   18 +++---
 net/hsr/hsr_framereg.c                                |   12 ++++
 net/hsr/hsr_framereg.h                                |    1=20
 net/ipv4/inet_connection_sock.c                       |    2=20
 net/ipv4/route.c                                      |    4 +
 net/ipv4/syncookies.c                                 |    7 ++
 net/ipv4/tcp_input.c                                  |    8 ++-
 net/ipv6/route.c                                      |    2=20
 net/ipv6/sit.c                                        |    5 +
 net/l2tp/l2tp_ip6.c                                   |    4 -
 net/rxrpc/conn_client.c                               |    4 -
 net/unix/af_unix.c                                    |   48 ++++++++++---=
-----
 net/unix/diag.c                                       |    3 -
 net/x25/af_x25.c                                      |   20 +++++--
 security/keys/proc.c                                  |    8 ---
 security/lsm_audit.c                                  |   10 ++-
 sound/firewire/bebob/bebob.c                          |   14 ++++-
 32 files changed, 190 insertions(+), 86 deletions(-)

Al Viro (1):
      missing barriers in some of unix_sock ->addr and ->path accesses

Daniel Borkmann (1):
      ipvlan: disallow userns cap_net_admin to change global mode/flags

David Howells (1):
      rxrpc: Fix client call queueing, waiting for channel

Eric Biggers (1):
      KEYS: restrict /proc/keys by credentials at open time

Eric Dumazet (8):
      l2tp: fix infoleak in l2tp_ip6_recvmsg()
      net/hsr: fix possible crash in add_timer()
      net/x25: fix use-after-free in x25_device_event()
      net/x25: reset state in x25_connect()
      vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()
      net/x25: fix a race in x25_bind()
      gro_cells: make sure device is up in gro_cells_receive()
      tcp/dccp: remove reqsk_put() from inet_child_forget()

Erik Schmauss (1):
      ACPICA: Reference Counts: increase max to 0x4000 for large servers

Greg Kroah-Hartman (1):
      Linux 4.9.164

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

Peter Zijlstra (1):
      perf/x86: Fixup typo in stub functions

Sakari Ailus (1):
      of: Support const and non-const use for to_of_node()

Sergei Shtylyov (1):
      mmc: tmio_mmc_core: don't claim spurious interrupts

Stefano Brivio (1):
      vxlan: Fix GRO cells race condition between receive and link delete

Takashi Sakamoto (1):
      ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O agai=
nst Liquid Saffire 56

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


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyQ5EAACgkQONu9yGCS
aT4SbA//VAjEYPkMdHMtqDvnPAJADwib45Yow1Y17xwaeJR32DLdpyAvXAiXZmE6
351rPVRPewCw7538daBvO4GUSprgR3Ho2ctwZG+GzEcLSh7PoY+EEKUTBpp6qSOw
F8OczfCXSGF7HcILktXLN/pSlUcbXSqgfK/ZbXKrOBVNCxmYbjsOoomThL3nivb4
84A+vXFf9Cdm06Kuzn4/7SmQwU4xTer3NTiQcsYjN9XUEjkJagm/R/bNIjPoXjBe
wGXUnZApBsLxS2b0USQuQXbVpePb5LdpuznG3LlxlV3eOHqld5WhsfnPYfv4lj2O
Bs6cmh+W35WvCwD5qmLU8t/FddwrFcEQkMDKqdwpW0KzpxhWQSvD/kgq3SROUgZq
bw8ErE3rA9ZHusuwyCaqwWuQ0sAzC6xqeXTnLR5jf3RV+LAmx8j3+vKZMESwInfQ
5NjLqt4BhtScm6EGU5MS5LGt8SWc9bIJ3jHQXRnrLT6AeTtQL52MHuclrcF1QOuO
1Jsg8NHD9uUYFJhDvaYc1pusdbXC92EcrDqW2n5RnY3J120HyQ8bBfUUjq2gdD50
/TbCLLSMp+VXh/6pzFJO5xdKvaHRHXGO1WlOHxzdvopyTNbo7rIi3yrfYJLxv7ou
ylZPPZx/iihJ4VPRcVC3TREXMnvQkT5kcB/HGtjjYlMIcMdbPmY=
=L8OS
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
