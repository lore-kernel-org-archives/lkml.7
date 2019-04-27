Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF7C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246402087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556369012;
	bh=rLM+PU+llhZ0yaacCGiQhQlQvt8hnAfQzCVsUlaSAV0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CelFHN6VLne+fKSHVlBecA2UES9aqEorjzt3RNH8kLyAEfHFKJCkAETf+QZ3aCGjP
	 aKm/un92TDh/jpPTW5wiCRy/2edrKKF3jXaI7jyMWQdRKAZMRSNDxHDAh23a8u1VCH
	 JlJETlwz8wL5yhhzfC3Jab6/YWpAlSh/HYzP1ZGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfD0Mnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0Mna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:43:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF052087F;
        Sat, 27 Apr 2019 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556369008;
        bh=rLM+PU+llhZ0yaacCGiQhQlQvt8hnAfQzCVsUlaSAV0=;
        h=Date:From:To:Cc:Subject:From;
        b=uvSSYXcDqtQVOm8Ucm+8USFTN2+UhByErfo0NaMAnhXdewpN15/ZfY58quARkXdF7
         /qRR4WdVaCysqB3X+EICUNhzgUX2diHmJuiBbvdagoegeVz0OGMfVv72DrWDiEeXNv
         yFsDuhH4AK507I5tO54W65rQjucF584xqTc9kpwA=
Date:   Sat, 27 Apr 2019 14:43:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.171
Message-ID: <20190427124326.GA9093@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.171 kernel.

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

 Makefile                                         |    5=20
 arch/arm64/include/asm/futex.h                   |    2=20
 arch/x86/crypto/poly1305-avx2-x86_64.S           |   14 +-
 arch/x86/crypto/poly1305-sse2-x86_64.S           |   22 ++-
 arch/x86/events/amd/core.c                       |   35 ++++-
 arch/x86/kernel/kprobes/core.c                   |   26 ++++
 arch/x86/kvm/emulate.c                           |   21 +--
 arch/x86/kvm/svm.c                               |   19 ++-
 crypto/testmgr.h                                 |   44 +++++++
 drivers/char/tpm/tpm_i2c_atmel.c                 |   10 +
 drivers/crypto/amcc/crypto4xx_alg.c              |    3=20
 drivers/crypto/amcc/crypto4xx_core.c             |    9 +
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c         |    3=20
 drivers/iio/accel/kxcjk-1013.c                   |    2=20
 drivers/iio/adc/ad_sigma_delta.c                 |    1=20
 drivers/iio/adc/at91_adc.c                       |   28 ++--
 drivers/iio/gyro/bmg160_core.c                   |    6=20
 drivers/mmc/host/sdhci.c                         |   40 ++----
 drivers/net/bonding/bond_main.c                  |    6=20
 drivers/net/team/team.c                          |   26 ++++
 drivers/net/wireless/ralink/rt2x00/rt2x00.h      |    1=20
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c   |   10 -
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c |   15 +-
 drivers/scsi/libfc/fc_rport.c                    |    1=20
 drivers/staging/comedi/drivers/ni_usb6501.c      |   10 -
 drivers/staging/comedi/drivers/vmk80xx.c         |    8 -
 drivers/staging/iio/adc/ad7192.c                 |    8 -
 drivers/vhost/vhost.c                            |    6=20
 fs/cifs/cifsglob.h                               |    2=20
 fs/cifs/file.c                                   |   30 ++++
 fs/cifs/misc.c                                   |   25 +++-
 fs/cifs/smb2misc.c                               |    6=20
 include/linux/kprobes.h                          |    1=20
 kernel/kprobes.c                                 |    6=20
 kernel/locking/lockdep.c                         |    3=20
 kernel/sched/fair.c                              |   25 ++++
 kernel/sysctl.c                                  |    3=20
 kernel/trace/ftrace.c                            |    6=20
 mm/percpu.c                                      |    8 -
 mm/vmstat.c                                      |    5=20
 net/atm/lec.c                                    |    6=20
 net/bridge/br_input.c                            |   23 ++-
 net/bridge/br_multicast.c                        |    4=20
 net/ipv4/fou.c                                   |    4=20
 net/ipv4/route.c                                 |   16 ++
 net/ipv4/tcp_input.c                             |   10 -
 net/mac80211/driver-ops.h                        |    3=20
 scripts/mod/file2alias.c                         |  141 +++++++-----------=
-----
 security/device_cgroup.c                         |    2=20
 sound/core/info.c                                |   12 +
 sound/core/init.c                                |   18 +-
 51 files changed, 471 insertions(+), 269 deletions(-)

Adrian Hunter (1):
      mmc: sdhci: Fix data command CRC error handling

Aurelien Aptel (1):
      CIFS: keep FileInfo handle live during oplock break

Christian Lamparter (1):
      crypto: crypto4xx - properly set IV after de- and encrypt

Dragos Bogdan (1):
      iio: ad_sigma_delta: select channel when reading register

Eric Biggers (1):
      crypto: x86/poly1305 - fix overflow during partial reduction

Eric Dumazet (2):
      tcp: tcp_grow_window() needs to respect tcp_space()
      ipv4: ensure rcu_read_lock() in ipv4_link_failure()

Felix Fietkau (1):
      mac80211: do not call driver wake_tx_queue op during reconfig

Georg Ottinger (1):
      iio: adc: at91: disable adc channel interrupt in timeout case

Greg Kroah-Hartman (2):
      Revert "locking/lockdep: Add debug_locks check in __lock_downgrade()"
      Linux 4.9.171

Gustavo A. R. Silva (1):
      net: atm: Fix potential Spectre v1 vulnerabilities

Hangbin Liu (1):
      team: set slave to promisc if team is already in promisc mode

Ian Abbott (4):
      staging: comedi: vmk80xx: Fix use of uninitialized semaphore
      staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
      staging: comedi: ni_usb6501: Fix use of uninitialized mutex
      staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Jann Horn (1):
      device_cgroup: fix RCU imbalance in error case

Jarkko Sakkinen (1):
      tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

Jason Wang (1):
      vhost: reject zero size iova range

Kim Phillips (1):
      perf/x86/amd: Add event map for AMD Family 17h

Konstantin Khlebnikov (1):
      mm/vmstat.c: fix /proc/vmstat format for CONFIG_DEBUG_TLBFLUSH=3Dy CO=
NFIG_SMP=3Dn

Linus Torvalds (1):
      i2c-hid: properly terminate i2c_hid_dmi_desc_override_table[] array

Lorenzo Bianconi (1):
      net: fou: do not use guehdr after iptunnel_pull_offloads in gue_udp_r=
ecv

Masahiro Yamada (2):
      modpost: file2alias: go back to simple devtable lookup
      modpost: file2alias: check prototype of handler

Masami Hiramatsu (3):
      x86/kprobes: Verify stack frame on kretprobe
      kprobes: Mark ftrace mcount handler functions nokprobe
      kprobes: Fix error check when reusing optimized probes

Matteo Croce (1):
      percpu: stop printing kernel addresses

Matthias Kaehlcke (1):
      Revert "kbuild: use -Oz instead of -Os when using clang"

Mike Looijmans (1):
      iio/gyro/bmg160: Use millidegrees for temperature scale

Mircea Caprioru (1):
      staging: iio: ad7192: Fix ad7193 channel address

Nathan Chancellor (1):
      arm64: futex: Restore oldval initialization to work around buggy comp=
ilers

Nikolay Aleksandrov (2):
      net: bridge: fix per-port af_packet sockets
      net: bridge: multicast: use rcu to access port list from br_multicast=
_start_querier

Phil Auld (1):
      sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup

Sabrina Dubroca (1):
      bonding: fix event handling for stacked bonds

Saurav Kashyap (1):
      Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"

Sean Christopherson (1):
      KVM: x86: Don't clear EFER during SMM transitions for 32-bit vCPU

Stephen Suryaputra (1):
      ipv4: recompile ip options in ipv4_link_failure

Suthikulpanit, Suravee (1):
      Revert "svm: Fix AVIC incomplete IPI emulation"

Takashi Iwai (2):
      ALSA: core: Fix card races between register and disconnect
      ALSA: info: Fix racy addition/deletion of nodes

Vijayakumar Durai (1):
      rt2x00: do not increment sequence number while re-transmitting

Will Deacon (1):
      kernel/sysctl.c: fix out-of-bounds access when setting file-max

he, bo (1):
      io: accel: kxcjk1013: restore the range after resume.


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlzETm4ACgkQONu9yGCS
aT4bCBAArO3ep7uZr+9UItovOoyzh6H94QbjwBZ5AASdwMlc6ieuvDIvUb7tPDZ6
/SwV8QhCAodJYipc/HgR2S5Pn750Q2WW0HZYF6jWQsb9OuIWjnt2kuzhB2mk23nP
CSZDS1v7azJ5I6wEs0vCHAok9VW2+kGvxsLw1gZmdhLn7Az+CGg8sguKmwSZkr0v
H5fHGkwJDNfaAP4uxjxIl63wZTjlXL477cfUP23TMI/7ttkte7qkEO5WP2H0eUgR
OFdtvA1SNU210IagPEf2V+ER4jhDkd1jYlNd5wcWpkck2KWs4DXw9phOzYmHYC26
FmT0ToJ8i9KhiVu8cktIVneMmpD8tBD1uFPdPYSCeQweB4JJCAT8ow5RQpg1PsLs
kPHNgJzOV3AeTZNSYieh6eIN/bBTw9x0HPoAcZNo41eX12XON/awRRkFSUtvUaz4
FIHG7JzT5aQfp0m3q7Ek/04v986TrXFINeBa263vPfw6PQzrvfBD54Oro/RzNoe7
mEWNqKTpJ8q/asVMDaYULECLQGSkBFNeWdrOjfanJvUaVsuwkNLueD5b5qfA+FWM
mzQKzqoY5065yUeRNquXcy8XteSas/uvhXsRdHsKEo/dYLTuZEBgNCh9isNvAEJR
sBi6bqZ8ad0YriTd3U54puLpNiiFEGX4qCskNjyKJ6ZkUpf9Dxo=
=CYjY
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
