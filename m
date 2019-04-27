Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10891C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C897D2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556369033;
	bh=5Gaq7Zrx0Mty7EoYuDWu11IFFJjWO/KO7BpABPCOH8U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qArtkcDNaXW2pPTtXvwa5UEjIkZRKW+eirC2w3w02+Rh/5nfxiuma7y30OKpbN6hh
	 VQ4C9E/muz8XHyTlSDXZvP3iqCm/hRP/paZ3+GZccqXTV6EFntGixewTNnA+SGKmoM
	 xwBg82gF60zEZcsdH0ME4q9dqRXesasKT1QC7Ao4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfD0Mnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfD0Mnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:43:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3AE2087F;
        Sat, 27 Apr 2019 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556369030;
        bh=5Gaq7Zrx0Mty7EoYuDWu11IFFJjWO/KO7BpABPCOH8U=;
        h=Date:From:To:Cc:Subject:From;
        b=SmPwqmS5IKgT1zE8Ad/luSEMfQve2BjdrcbCsGTwC/ezYXig8MLzbRuok5RccsRFO
         uKQLKevmZoSqZ9PdwUfMrZFtqnW3HYf1hDwhoLj1P68zX7lzzuH0N/45ALFUv3ieP/
         VI3PyUiIaqOj1tGHG8TEdnVl3/kAcBeCTOYttixU=
Date:   Sat, 27 Apr 2019 14:43:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.114
Message-ID: <20190427124348.GA10661@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.114 kernel.

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

 Makefile                                             |    5=20
 arch/arm64/include/asm/futex.h                       |    2=20
 arch/x86/crypto/poly1305-avx2-x86_64.S               |   14=20
 arch/x86/crypto/poly1305-sse2-x86_64.S               |   22 -
 arch/x86/events/amd/core.c                           |   35 +
 arch/x86/events/intel/core.c                         |    2=20
 arch/x86/events/perf_event.h                         |   38 -
 arch/x86/kernel/cpu/bugs.c                           |    6=20
 arch/x86/kernel/kprobes/core.c                       |   26 +
 arch/x86/kernel/process.c                            |    6=20
 arch/x86/kvm/emulate.c                               |   21 -
 arch/x86/kvm/svm.c                                   |   22 -
 crypto/testmgr.h                                     |   44 ++
 drivers/char/tpm/tpm_i2c_atmel.c                     |    4=20
 drivers/crypto/amcc/crypto4xx_alg.c                  |    3=20
 drivers/crypto/amcc/crypto4xx_core.c                 |    9=20
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c             |    3=20
 drivers/iio/accel/kxcjk-1013.c                       |    2=20
 drivers/iio/adc/ad_sigma_delta.c                     |    1=20
 drivers/iio/adc/at91_adc.c                           |   28 -
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c |    7=20
 drivers/iio/dac/mcp4725.c                            |    1=20
 drivers/iio/gyro/bmg160_core.c                       |    6=20
 drivers/iio/gyro/mpu3050-core.c                      |    8=20
 drivers/iio/industrialio-buffer.c                    |    5=20
 drivers/iio/industrialio-core.c                      |    4=20
 drivers/mmc/host/sdhci-esdhc-imx.c                   |   12=20
 drivers/mmc/host/sdhci.c                             |   79 ++--
 drivers/mmc/host/sdhci.h                             |   11=20
 drivers/net/bonding/bond_main.c                      |    6=20
 drivers/net/ethernet/cavium/thunder/nicvf_main.c     |   22 +
 drivers/net/team/team.c                              |   26 +
 drivers/net/wireless/ralink/rt2x00/rt2x00.h          |    1=20
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c       |   10=20
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c     |   15=20
 drivers/scsi/libfc/fc_rport.c                        |    1=20
 drivers/scsi/scsi_lib.c                              |    6=20
 drivers/staging/comedi/drivers/ni_usb6501.c          |   10=20
 drivers/staging/comedi/drivers/vmk80xx.c             |    8=20
 drivers/staging/iio/adc/ad7192.c                     |    8=20
 drivers/staging/iio/meter/ade7854.c                  |    2=20
 drivers/vhost/vhost.c                                |    6=20
 fs/cifs/cifsglob.h                                   |    2=20
 fs/cifs/file.c                                       |   30 +
 fs/cifs/misc.c                                       |   25 +
 fs/cifs/smb2misc.c                                   |    6=20
 fs/direct-io.c                                       |   24 +
 fs/iomap.c                                           |   12=20
 fs/proc/task_mmu.c                                   |   18=20
 fs/userfaultfd.c                                     |    9=20
 fs/xfs/libxfs/xfs_attr.c                             |   20 -
 fs/xfs/libxfs/xfs_attr_leaf.c                        |    9=20
 fs/xfs/libxfs/xfs_attr_leaf.h                        |    3=20
 fs/xfs/libxfs/xfs_defer.c                            |   39 +-
 fs/xfs/libxfs/xfs_defer.h                            |    5=20
 include/linux/fs.h                                   |    1=20
 include/linux/kprobes.h                              |    1=20
 include/linux/sched/mm.h                             |   21 +
 include/net/inet_frag.h                              |   16=20
 include/net/ipv6.h                                   |   29 -
 include/net/ipv6_frag.h                              |  111 +++++
 kernel/kprobes.c                                     |    6=20
 kernel/locking/lockdep.c                             |    3=20
 kernel/sched/fair.c                                  |   25 +
 kernel/sysctl.c                                      |    3=20
 kernel/trace/ftrace.c                                |    6=20
 mm/mmap.c                                            |    7=20
 mm/percpu.c                                          |    8=20
 mm/vmstat.c                                          |    5=20
 net/atm/lec.c                                        |    6=20
 net/bridge/br_input.c                                |   23 -
 net/bridge/br_multicast.c                            |    4=20
 net/ieee802154/6lowpan/reassembly.c                  |    2=20
 net/ipv4/fou.c                                       |    4=20
 net/ipv4/inet_fragment.c                             |  293 +++++++++++++++
 net/ipv4/ip_fragment.c                               |  302 +--------------
 net/ipv4/route.c                                     |   16=20
 net/ipv4/tcp_input.c                                 |   10=20
 net/ipv6/netfilter/nf_conntrack_reasm.c              |  279 ++++----------
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c            |    3=20
 net/ipv6/reassembly.c                                |  364 ++++----------=
-----
 net/mac80211/driver-ops.h                            |    3=20
 net/openvswitch/conntrack.c                          |    1=20
 scripts/mod/file2alias.c                             |  141 ++-----
 security/device_cgroup.c                             |    2=20
 sound/core/info.c                                    |   12=20
 sound/core/init.c                                    |   18=20
 sound/pci/hda/patch_realtek.c                        |    6=20
 tools/include/linux/bitops.h                         |    7=20
 tools/include/linux/bits.h                           |   26 +
 tools/perf/check-headers.sh                          |    1=20
 91 files changed, 1400 insertions(+), 1114 deletions(-)

Adrian Hunter (3):
      mmc: sdhci: Fix data command CRC error handling
      mmc: sdhci: Rename SDHCI_ACMD12_ERR and SDHCI_INT_ACMD12ERR
      mmc: sdhci: Handle auto-command errors

Andi Kleen (1):
      x86/cpu/bugs: Use __initconst for 'const' init data

Andrea Arcangeli (1):
      coredump: fix race condition between mmget_not_zero()/get_task_mm() a=
nd core dumping

Arnaldo Carvalho de Melo (1):
      tools include: Adopt linux/bits.h

Aurelien Aptel (1):
      CIFS: keep FileInfo handle live during oplock break

Christian Lamparter (1):
      crypto: crypto4xx - properly set IV after de- and encrypt

Darrick J. Wong (3):
      iomap: report collisions between directio and buffered writes to user=
space
      xfs: add the ability to join a held buffer to a defer_ops
      xfs: hold xfs_buf locked between shortform->leaf conversion and the a=
ddition of an attribute

Dragos Bogdan (1):
      iio: ad_sigma_delta: select channel when reading register

Eric Biggers (1):
      crypto: x86/poly1305 - fix overflow during partial reduction

Eric Dumazet (3):
      tcp: tcp_grow_window() needs to respect tcp_space()
      ipv4: ensure rcu_read_lock() in ipv4_link_failure()
      ipv6: frags: fix a lockdep false positive

Fabrice Gasnier (1):
      iio: core: fix a possible circular locking dependency

Felix Fietkau (1):
      mac80211: do not call driver wake_tx_queue op during reconfig

Florian Westphal (1):
      ipv6: remove dependency of nf_defrag_ipv6 on ipv6 module

Georg Ottinger (1):
      iio: adc: at91: disable adc channel interrupt in timeout case

Greg Kroah-Hartman (2):
      Revert "locking/lockdep: Add debug_locks check in __lock_downgrade()"
      Linux 4.14.114

Gustavo A. R. Silva (1):
      net: atm: Fix potential Spectre v1 vulnerabilities

Gwendal Grignou (1):
      iio: cros_ec: Fix the maths for gyro scale calculation

Hangbin Liu (1):
      team: set slave to promisc if team is already in promisc mode

Hui Wang (1):
      ALSA: hda/realtek - add two more pin configuration sets to quirk table

Ian Abbott (4):
      staging: comedi: vmk80xx: Fix use of uninitialized semaphore
      staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
      staging: comedi: ni_usb6501: Fix use of uninitialized mutex
      staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Jaesoo Lee (1):
      scsi: core: set result when the command cannot be dispatched

Jann Horn (1):
      device_cgroup: fix RCU imbalance in error case

Jarkko Sakkinen (1):
      tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

Jason Wang (1):
      vhost: reject zero size iova range

Jean-Francois Dagenais (1):
      iio: dac: mcp4725: add missing powerdown bits in store eeprom

Kan Liang (1):
      perf/x86: Fix incorrect PEBS_REGS

Kim Phillips (1):
      perf/x86/amd: Add event map for AMD Family 17h

Konstantin Khlebnikov (1):
      mm/vmstat.c: fix /proc/vmstat format for CONFIG_DEBUG_TLBFLUSH=3Dy CO=
NFIG_SMP=3Dn

Lars-Peter Clausen (1):
      iio: Fix scan mask selection

Leonard Pollak (1):
      Staging: iio: meter: fixed typo

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

Matteo Croce (3):
      net: thunderx: raise XDP MTU to 1508
      net: thunderx: don't allow jumbo frames with XDP
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

Peter Oskolkov (3):
      net: IP defrag: encapsulate rbtree defrag code into callable functions
      net: IP6 defrag: use rbtrees for IPv6 defrag
      net: IP6 defrag: use rbtrees in nf_conntrack_reasm.c

Phil Auld (1):
      sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup

Sabrina Dubroca (1):
      bonding: fix event handling for stacked bonds

Saurav Kashyap (1):
      Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"

Sean Christopherson (1):
      KVM: x86: Don't clear EFER during SMM transitions for 32-bit vCPU

Sergey Larin (1):
      iio: gyro: mpu3050: fix chip ID reading

Stephen Suryaputra (1):
      ipv4: recompile ip options in ipv4_link_failure

Suthikulpanit, Suravee (1):
      Revert "svm: Fix AVIC incomplete IPI emulation"

Takashi Iwai (2):
      ALSA: core: Fix card races between register and disconnect
      ALSA: info: Fix racy addition/deletion of nodes

Thomas Gleixner (1):
      x86/speculation: Prevent deadlock on ssb_state::lock

Vijayakumar Durai (1):
      rt2x00: do not increment sequence number while re-transmitting

Vitaly Kuznetsov (1):
      KVM: x86: svm: make sure NMI is injected after nmi_singlestep

Will Deacon (1):
      kernel/sysctl.c: fix out-of-bounds access when setting file-max

he, bo (1):
      io: accel: kxcjk1013: restore the range after resume.


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlzEToQACgkQONu9yGCS
aT7oYxAAhFiL8cZFoZhHe6kzy8c6CDmPPznVuUOrK2dhsNPim9VR+HzKgMQId5kQ
e7uXzlHcrda1nqY79kocQ8yqlRqEoNXgvghNehuUby59Lk03FszCfxiN99Radfpw
M58dCrHMEjfG8psxZ63zxEKalWtHDrBFMFsG/LRhDzNgmwedh7WAn9pB+8x2xCvg
XTc3kAQWBqCg1JYhG8JKFTYV6G1X0/nlotf/jfxrQsBUCoSCMS1Xh1detV5Ugzph
CYuBN/b6/xqNruJwxNNy7NpJxJ5vig3asraJ8XMww/IcVhOs6U7HB32fk/9caeSg
Q9Buk1WzeT3yS640qZBb1ztrqIACkvRbclrWnV7HvI4u8RPYonkoI8JR/GGN1l0T
VOHptyZ04slyaykkXyeedyt1GvfK/dBjFuA5g2UrvUvw4WLxVXLIDDPPllTlL/DN
JSVFuUxEdUp+mGxSShAEHE/3QRsSAy6w2V69J7mjkEJXzUw3KsbcuDWDSbWFrO4B
BqgmMPVdj3bdEGPN1CEbNQxrx0/yVXe59EC6FzFBTXK/5gE8SuD8F2ABDBA5ogIr
F2mOL07hNfX5jBif6bqmkPveh+tthDxYk2KroF6enFQaLlvdNzPrgcYOEnFjtwtA
5d8j+ulbV2WqKCYzZMek+R3Td2o3PnTCvcNqmbYfT2diMHDm44U=
=awaC
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
