Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7094FC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E22208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556369065;
	bh=UI/53TZ/lmvDHQ7LcMyzYj2pRK/b+AWnvAecH7hKMJk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RckSlMoliSZDsKkiYgkDMVI6hDx6pDHDu9UCWWoX5bsEsiZDUkvoMeJ7O/sKoHMeq
	 80YLOH5KnktcTMNFGMvo1Or84HWuIxePSokiaXtbuhflfxDjrKyafil8x8ZFhDfna7
	 +lqOymtqRQheHK+M1DhEBVbBTMt2NVaTgC88G7ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfD0MoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfD0MoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:44:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B83208CB;
        Sat, 27 Apr 2019 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556369062;
        bh=UI/53TZ/lmvDHQ7LcMyzYj2pRK/b+AWnvAecH7hKMJk=;
        h=Date:From:To:Cc:Subject:From;
        b=j8DcJagORpcf7jC01Rb1kO3v0h/OHZFSSwJUp6qgjFhZ0ElmAPjDasyK0Doeulbnf
         Px6u1iFO2QPvbIpiWAKqZAdiTI7lBGd2RqcmlDoqdXak9JtY4dCc0V7cMAnK4vPCdb
         m5nuc8tZQOgNzHONkNC9GK7LFr1gaC/SCF38OAeQ=
Date:   Sat, 27 Apr 2019 14:44:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.37
Message-ID: <20190427124419.GA12710@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.37 kernel.

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

 Makefile                                             |    5=20
 arch/arm64/include/asm/futex.h                       |    2=20
 arch/x86/crypto/poly1305-avx2-x86_64.S               |   14=20
 arch/x86/crypto/poly1305-sse2-x86_64.S               |   22 -
 arch/x86/events/amd/core.c                           |   35 +-
 arch/x86/events/intel/core.c                         |    2=20
 arch/x86/events/perf_event.h                         |   38 +-
 arch/x86/kernel/cpu/bugs.c                           |    6=20
 arch/x86/kernel/kprobes/core.c                       |   26 +
 arch/x86/kernel/process.c                            |    8=20
 arch/x86/kvm/emulate.c                               |   21 -
 arch/x86/kvm/svm.c                                   |   22 +
 crypto/testmgr.h                                     |   44 ++
 drivers/acpi/nfit/core.c                             |   63 ++-
 drivers/acpi/nfit/nfit.h                             |   11=20
 drivers/char/ipmi/ipmi_msghandler.c                  |   19 +
 drivers/char/tpm/eventlog/tpm2.c                     |    4=20
 drivers/char/tpm/tpm_i2c_atmel.c                     |    4=20
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c              |    1=20
 drivers/gpu/drm/ttm/ttm_page_alloc.c                 |    5=20
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c             |    3=20
 drivers/iio/accel/kxcjk-1013.c                       |    2=20
 drivers/iio/adc/ad_sigma_delta.c                     |    1=20
 drivers/iio/adc/at91_adc.c                           |   28 +
 drivers/iio/chemical/bme680.h                        |    6=20
 drivers/iio/chemical/bme680_core.c                   |   54 ++-
 drivers/iio/chemical/bme680_i2c.c                    |   21 -
 drivers/iio/chemical/bme680_spi.c                    |  115 ++++---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c |    7=20
 drivers/iio/dac/mcp4725.c                            |    1=20
 drivers/iio/gyro/bmg160_core.c                       |    6=20
 drivers/iio/gyro/mpu3050-core.c                      |    8=20
 drivers/iio/industrialio-buffer.c                    |    5=20
 drivers/iio/industrialio-core.c                      |    4=20
 drivers/input/mouse/elan_i2c_core.c                  |   25 +
 drivers/mmc/host/sdhci-esdhc-imx.c                   |   12=20
 drivers/mmc/host/sdhci.c                             |   79 +++-
 drivers/mmc/host/sdhci.h                             |   11=20
 drivers/net/bonding/bond_main.c                      |    6=20
 drivers/net/ethernet/cavium/thunder/nicvf_main.c     |   22 +
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c   |   61 +--
 drivers/net/ethernet/netronome/nfp/flower/action.c   |    3=20
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h     |    3=20
 drivers/net/ethernet/netronome/nfp/flower/match.c    |   14=20
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
 drivers/staging/most/core.c                          |    2=20
 drivers/tty/serial/sh-sci.c                          |    6=20
 drivers/tty/vt/vt.c                                  |    3=20
 drivers/vhost/vhost.c                                |    6=20
 fs/cifs/cifsglob.h                                   |    2=20
 fs/cifs/file.c                                       |   30 +
 fs/cifs/misc.c                                       |   25 +
 fs/cifs/smb2misc.c                                   |    6=20
 fs/cifs/smb2ops.c                                    |    2=20
 fs/cifs/smb2pdu.c                                    |    6=20
 fs/proc/task_mmu.c                                   |   18 +
 fs/userfaultfd.c                                     |    9=20
 include/linux/kprobes.h                              |    1=20
 include/linux/netdevice.h                            |    3=20
 include/linux/sched/mm.h                             |   21 +
 include/net/inet_frag.h                              |   16 -
 include/net/ipv6_frag.h                              |   11=20
 include/net/tls.h                                    |    2=20
 kernel/kprobes.c                                     |    6=20
 kernel/locking/lockdep.c                             |    3=20
 kernel/sched/fair.c                                  |   25 +
 kernel/sysctl.c                                      |    3=20
 kernel/time/sched_clock.c                            |    4=20
 kernel/time/tick-common.c                            |    2=20
 kernel/time/timekeeping.h                            |    7=20
 kernel/trace/ftrace.c                                |    6=20
 mm/mmap.c                                            |    7=20
 mm/percpu.c                                          |    8=20
 mm/vmstat.c                                          |    5=20
 net/atm/lec.c                                        |    6=20
 net/bridge/br_input.c                                |   23 -
 net/bridge/br_multicast.c                            |    4=20
 net/core/dev.c                                       |   16 -
 net/core/failover.c                                  |    6=20
 net/core/skbuff.c                                    |   10=20
 net/ipv4/fou.c                                       |    4=20
 net/ipv4/inet_fragment.c                             |  293 ++++++++++++++=
++++
 net/ipv4/ip_fragment.c                               |  302 ++------------=
-----
 net/ipv4/route.c                                     |   16 -
 net/ipv4/tcp_input.c                                 |   10=20
 net/ipv6/netfilter/nf_conntrack_reasm.c              |  260 ++++----------=
--
 net/ipv6/reassembly.c                                |  240 ++++-----------
 net/ipv6/route.c                                     |    4=20
 net/mac80211/driver-ops.h                            |    3=20
 net/sched/sch_cake.c                                 |   57 +--
 net/tipc/name_table.c                                |    3=20
 scripts/mod/file2alias.c                             |  149 +++------
 security/device_cgroup.c                             |    2=20
 sound/core/info.c                                    |   12=20
 sound/core/init.c                                    |   18 -
 sound/pci/hda/patch_realtek.c                        |    6=20
 sound/soc/rockchip/rockchip_pcm.c                    |    3=20
 tools/include/linux/bitops.h                         |    7=20
 tools/include/linux/bits.h                           |   26 +
 tools/perf/check-headers.sh                          |    1=20
 109 files changed, 1507 insertions(+), 1155 deletions(-)

Adrian Hunter (3):
      mmc: sdhci: Fix data command CRC error handling
      mmc: sdhci: Rename SDHCI_ACMD12_ERR and SDHCI_INT_ACMD12ERR
      mmc: sdhci: Handle auto-command errors

Alex Deucher (1):
      drm/amdgpu/gmc9: fix VM_L2_CNTL3 programming

Andi Kleen (1):
      x86/cpu/bugs: Use __initconst for 'const' init data

Andrea Arcangeli (1):
      coredump: fix race condition between mmget_not_zero()/get_task_mm() a=
nd core dumping

Arnaldo Carvalho de Melo (1):
      tools include: Adopt linux/bits.h

Aurelien Aptel (1):
      CIFS: keep FileInfo handle live during oplock break

Chang-An Chen (1):
      timers/sched_clock: Prevent generic sched_clock wrap caused by tick_f=
reeze()

Christian Gromm (1):
      staging: most: core: use device description as name

Christian K=F6nig (1):
      drm/ttm: fix out-of-bounds read in ttm_put_pages() v2

Corey Minyard (1):
      ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_=
barrier

Dan Williams (4):
      nfit/ars: Remove ars_start_flags
      nfit/ars: Introduce scrub_flags
      nfit/ars: Allow root to busy-poll the ARS state machine
      nfit/ars: Avoid stale ARS results

Dragos Bogdan (1):
      iio: ad_sigma_delta: select channel when reading register

Eric Biggers (1):
      crypto: x86/poly1305 - fix overflow during partial reduction

Eric Dumazet (2):
      tcp: tcp_grow_window() needs to respect tcp_space()
      ipv4: ensure rcu_read_lock() in ipv4_link_failure()

Fabrice Gasnier (1):
      iio: core: fix a possible circular locking dependency

Felix Fietkau (1):
      mac80211: do not call driver wake_tx_queue op during reconfig

Geert Uytterhoeven (2):
      serial: sh-sci: Fix HSCIF RX sampling point adjustment
      serial: sh-sci: Fix HSCIF RX sampling point calculation

Georg Ottinger (1):
      iio: adc: at91: disable adc channel interrupt in timeout case

Greg Kroah-Hartman (2):
      Revert "locking/lockdep: Add debug_locks check in __lock_downgrade()"
      Linux 4.19.37

Gustavo A. R. Silva (1):
      net: atm: Fix potential Spectre v1 vulnerabilities

Gwendal Grignou (1):
      iio: cros_ec: Fix the maths for gyro scale calculation

Hangbin Liu (1):
      team: set slave to promisc if team is already in promisc mode

Hoang Le (1):
      tipc: missing entries in name table of publications

Hui Wang (1):
      ALSA: hda/realtek - add two more pin configuration sets to quirk table

Ian Abbott (4):
      staging: comedi: vmk80xx: Fix use of uninitialized semaphore
      staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
      staging: comedi: ni_usb6501: Fix use of uninitialized mutex
      staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Jaesoo Lee (1):
      scsi: core: set result when the command cannot be dispatched

Jakub Kicinski (1):
      net/tls: prevent bad memory access in tls_is_sk_tx_device_offloaded()

Jann Horn (1):
      device_cgroup: fix RCU imbalance in error case

Jarkko Sakkinen (1):
      tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

Jason Wang (1):
      vhost: reject zero size iova range

Jean-Francois Dagenais (1):
      iio: dac: mcp4725: add missing powerdown bits in store eeprom

Jonathan Lemon (1):
      route: Avoid crash from dereferencing NULL rt->from

KT Liao (1):
      Input: elan_i2c - add hardware ID for multiple Lenovo laptops

Kan Liang (1):
      perf/x86: Fix incorrect PEBS_REGS

Katsuhiro Suzuki (1):
      ASoC: rockchip: add missing INTERLEAVED PCM attribute

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

Mike Looijmans (3):
      iio/gyro/bmg160: Use millidegrees for temperature scale
      iio:chemical:bme680: Fix, report temperature in millidegrees
      iio:chemical:bme680: Fix SPI read interface

Mikulas Patocka (1):
      vt: fix cursor when clearing the screen

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

Pieter Jansen van Vuuren (2):
      nfp: flower: replace CFI with vlan present
      nfp: flower: remove vlan CFI bit from push vlan action

Ronnie Sahlberg (1):
      cifs: fix handle leak in smb2_query_symlink()

Sabrina Dubroca (1):
      bonding: fix event handling for stacked bonds

Saeed Mahameed (2):
      net/mlx5: FPGA, tls, hold rcu read lock a bit longer
      net/mlx5: FPGA, tls, idr remove on flow delete

Saurav Kashyap (1):
      Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"

Sean Christopherson (1):
      KVM: x86: Don't clear EFER during SMM transitions for 32-bit vCPU

Sergey Larin (1):
      iio: gyro: mpu3050: fix chip ID reading

Si-Wei Liu (1):
      failover: allow name change on IFF_UP slave interfaces

Stephen Suryaputra (1):
      ipv4: recompile ip options in ipv4_link_failure

Suthikulpanit, Suravee (1):
      Revert "svm: Fix AVIC incomplete IPI emulation"

Takashi Iwai (2):
      ALSA: core: Fix card races between register and disconnect
      ALSA: info: Fix racy addition/deletion of nodes

Thomas Gleixner (1):
      x86/speculation: Prevent deadlock on ssb_state::lock

Toke H=F8iland-J=F8rgensen (3):
      sch_cake: Use tc_skb_protocol() helper for getting packet protocol
      sch_cake: Make sure we can write the IP header before changing DSCP b=
its
      sch_cake: Simplify logic in cake_select_tin()

Vijayakumar Durai (1):
      rt2x00: do not increment sequence number while re-transmitting

Vitaly Kuznetsov (1):
      KVM: x86: svm: make sure NMI is injected after nmi_singlestep

Will Deacon (1):
      kernel/sysctl.c: fix out-of-bounds access when setting file-max

Yue Haibing (1):
      tpm: Fix the type of the return value in calc_tpm2_event_size()

Yuya Kusakabe (1):
      net: Fix missing meta data in skb with vlan packet

ZhangXiaoxu (2):
      cifs: Fix use-after-free in SMB2_write
      cifs: Fix use-after-free in SMB2_read

he, bo (1):
      io: accel: kxcjk1013: restore the range after resume.


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlzETqMACgkQONu9yGCS
aT6VTg/7B3L1wKpfIHD14iXFn21hoDZB4wwFyyudiNbqf/1C/mC7RHroJCyBK4Qv
wLJfTcMa7FYCCB7nW2vzzBMhLDl8Hi/y3BX4KESTM97LD9akDaiY7WqG6LWBUbz0
dI4XGtnmKYElqbfb7M/l3utKwsxKPqoKFcAEaKgyhtgi5tyeJrEGMp5qYDMai98U
eroonUxKbg2hiEaMn8BrYX+nqK3bBybQ+muPAak9ktNzJhI+4zS9aQERR1sSz6sP
aDseNMy8jpVW9XtbStJgJXLQriEw+0ObOXLHjLGEpocEW311Jwhjs7XBHjt2yjyc
PcxjqtqoG9IhZ26mZvccRgy8BPfnYgaXQYrt5arYLUVgnNBF7sJn118XcWbPV/0n
WghYSAdFC64fKadGbgqxasFnuOlvRSHcX+hqDLFFO8xGGTbQx0TbIv8D8NnDV6TL
gUCNQyE1+NkNGjAke5CU4htXl6cfeHwsjz5U6d6YFBLaz6XPMJZlaWMpbepCJyTk
NPbXnIB+hRtzntmriguKQFAruCwEK17GZY9oLXj/3MltFhEyfamS5uGUs5iWVDdW
fUgjDYBjMfRP1wp+j5n8SuW2EYb9n985SyvxbHK7B2qrAu2n0pp+r+IKxWJGSHq8
ipK5RNDrKaDAMkzGJsdyibm+L8bYI7JtGxUFpL77rrYZvzmoDyw=
=FctB
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
