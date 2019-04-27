Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63376C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB922087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556368911;
	bh=7+06MUu5vzGtGXuYIgpPQD6WTxJd2xSW3/jnXseZ/FY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FQcmHQfyIalYKkh2cRQlOPKeDTHcFiiwl4V+boMGIVeWtn5RUHdCl9W4++52SUPst
	 hc4cYTzz4u6GBD3inxlyYPGH7QTDEaLJKfX2F40ikvwitIqxsYdnUUGEy8/xWqOEqX
	 Oka4WoInhBZOtIYXHr0O/Mj6uL3f4zABDqCQnOLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfD0Mlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0Mlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:41:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FF72087F;
        Sat, 27 Apr 2019 12:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556368907;
        bh=7+06MUu5vzGtGXuYIgpPQD6WTxJd2xSW3/jnXseZ/FY=;
        h=Date:From:To:Cc:Subject:From;
        b=zo0ekMlxEJXD/lDb6rh1ZYkrBQq/M1FfkeYQoAQdHpIT9xSqF+MXDJlhT3vWP36Ou
         Z6d3sS1oa25pMkeSNJX9wWM9DqYa9CMG5DVq6plIlUeP/42xa2SEARQV/hv1UnVr6h
         dIp1Hcc1bo992jNv/bRhbJuZiZOIRAw5j20r/NcU=
Date:   Sat, 27 Apr 2019 14:41:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.139
Message-ID: <20190427124145.GA32684@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.139 kernel.

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

 Documentation/arm/kernel_mode_neon.txt            |    4 -
 Makefile                                          |    2=20
 arch/arm/kernel/unwind.c                          |   14 +++---
 arch/arm/lib/Makefile                             |    2=20
 arch/arm/lib/xor-neon.c                           |    2=20
 arch/arm/plat-samsung/Kconfig                     |    2=20
 arch/arm64/include/asm/futex.h                    |   14 +++---
 arch/x86/include/asm/xen/hypercall.h              |    3 +
 arch/x86/kernel/cpu/cyrix.c                       |   14 +++---
 arch/x86/kernel/hpet.c                            |    2=20
 arch/x86/kernel/kprobes/core.c                    |   26 ++++++++++++
 arch/x86/kernel/vmlinux.lds.S                     |    2=20
 arch/xtensa/kernel/stacktrace.c                   |    6 ++
 block/bio.c                                       |    5 +-
 drivers/acpi/sbs.c                                |    8 ++-
 drivers/cdrom/cdrom.c                             |    7 +--
 drivers/char/Kconfig                              |    2=20
 drivers/char/hpet.c                               |    2=20
 drivers/char/hw_random/virtio-rng.c               |    2=20
 drivers/char/tpm/tpm_i2c_atmel.c                  |   10 ++++
 drivers/crypto/amcc/crypto4xx_alg.c               |    3 -
 drivers/crypto/amcc/crypto4xx_core.c              |    9 ++++
 drivers/dma/imx-dma.c                             |    2=20
 drivers/dma/tegra20-apb-dma.c                     |    5 +-
 drivers/gpu/drm/drm_dp_mst_topology.c             |    1=20
 drivers/i2c/i2c-core.c                            |   12 ++---
 drivers/iio/adc/ad_sigma_delta.c                  |    1=20
 drivers/iio/adc/at91_adc.c                        |   28 +++++++------
 drivers/infiniband/hw/mlx4/alias_GUID.c           |    2=20
 drivers/infiniband/hw/mlx4/cm.c                   |    2=20
 drivers/iommu/dmar.c                              |    2=20
 drivers/iommu/intel-iommu.c                       |    3 +
 drivers/leds/leds-lp55xx-common.c                 |    4 -
 drivers/md/bcache/sysfs.c                         |   17 ++++++-
 drivers/md/bcache/sysfs.h                         |   13 ++++--
 drivers/md/dm-thin.c                              |   13 ++++++
 drivers/media/i2c/soc_camera/mt9m111.c            |    2=20
 drivers/media/platform/s5p-jpeg/jpeg-core.c       |   19 +++++---
 drivers/mmc/host/davinci_mmc.c                    |    2=20
 drivers/mmc/host/omap.c                           |    2=20
 drivers/net/bonding/bond_main.c                   |    6 ++
 drivers/net/ethernet/intel/e1000e/netdev.c        |    4 -
 drivers/net/usb/qmi_wwan.c                        |    1=20
 drivers/net/wireless/rsi/rsi_common.h             |    1=20
 drivers/net/wireless/ti/wlcore/main.c             |    7 ++-
 drivers/pci/quirks.c                              |    2=20
 drivers/scsi/megaraid/megaraid_sas_base.c         |    1=20
 drivers/scsi/scsi_scan.c                          |    6 +-
 drivers/staging/comedi/drivers/ni_usb6501.c       |    4 -
 drivers/staging/comedi/drivers/vmk80xx.c          |    8 +--
 drivers/thermal/int340x_thermal/int3400_thermal.c |    7 +--
 drivers/tty/Kconfig                               |   23 ++++++++++
 drivers/tty/serial/xilinx_uartps.c                |    2=20
 drivers/tty/tty_buffer.c                          |    2=20
 drivers/tty/tty_io.c                              |    3 +
 drivers/tty/tty_ldisc.c                           |   47 +++++++++++++++++=
+++++
 drivers/video/fbdev/core/fbmem.c                  |    3 +
 fs/9p/v9fs.c                                      |   21 +++++++++
 fs/9p/v9fs.h                                      |    1=20
 fs/9p/vfs_dir.c                                   |    8 +--
 fs/9p/vfs_file.c                                  |    6 ++
 fs/binfmt_elf.c                                   |    2=20
 fs/buffer.c                                       |    7 +++
 fs/cifs/cifs_dfs_ref.c                            |    4 -
 fs/cifs/connect.c                                 |    5 ++
 fs/cifs/smb1ops.c                                 |    2=20
 fs/cifs/smb2maperror.c                            |    3 -
 fs/ext4/indirect.c                                |   47 ++++++++++-------=
-----
 fs/ext4/resize.c                                  |    6 ++
 fs/ocfs2/cluster/nodemanager.c                    |   14 +++---
 include/linux/atalk.h                             |   20 +++++++--
 include/linux/kprobes.h                           |    1=20
 include/linux/ring_buffer.h                       |    2=20
 include/linux/string.h                            |    5 +-
 include/linux/swap.h                              |    4 -
 include/net/net_namespace.h                       |    2=20
 include/net/netns/hash.h                          |   15 -------
 kernel/events/core.c                              |    2=20
 kernel/kprobes.c                                  |    6 --
 kernel/sched/fair.c                               |   31 +++++++++++++-
 kernel/sysctl.c                                   |    4 +
 kernel/trace/ring_buffer.c                        |    5 +-
 kernel/trace/trace.c                              |    6 +-
 kernel/trace/trace_kdb.c                          |    6 +-
 lib/bsearch.c                                     |    2=20
 lib/div64.c                                       |    4 -
 lib/raid6/Makefile                                |    2=20
 lib/string.c                                      |   20 +++++++++
 mm/cma.c                                          |    4 +
 mm/slab.c                                         |   17 ++++---
 mm/vmalloc.c                                      |    6 ++
 net/9p/protocol.c                                 |    3 -
 net/appletalk/atalk_proc.c                        |    2=20
 net/appletalk/ddp.c                               |   37 ++++++++++++++---
 net/appletalk/sysctl_net_atalk.c                  |    5 +-
 net/bridge/br_multicast.c                         |    4 +
 net/core/ethtool.c                                |   29 ++++++++-----
 net/core/net_namespace.c                          |    1=20
 net/ipv4/route.c                                  |   20 ++++++++-
 net/ipv4/tcp_input.c                              |   10 ++--
 net/ipv6/ip6_output.c                             |    3 +
 net/ipv6/ip6_tunnel.c                             |    4 -
 net/openvswitch/flow_netlink.c                    |    4 -
 net/sctp/protocol.c                               |    1=20
 security/device_cgroup.c                          |    2=20
 sound/core/init.c                                 |   18 ++++----
 sound/core/pcm_native.c                           |    8 +++
 sound/core/seq/seq_clientmgr.c                    |    6 +-
 sound/drivers/opl3/opl3_voice.h                   |    2=20
 sound/isa/sb/sb8.c                                |    4 +
 sound/pci/echoaudio/echoaudio.c                   |    5 ++
 sound/soc/fsl/fsl_esai.c                          |   47 +++++++++++++++++=
-----
 sound/soc/fsl/imx-sgtl5000.c                      |    1=20
 tools/lib/traceevent/event-parse.c                |    2=20
 tools/perf/builtin-top.c                          |    5 +-
 tools/perf/tests/evsel-tp-sched.c                 |    1=20
 tools/power/x86/turbostat/turbostat.c             |    3 +
 117 files changed, 662 insertions(+), 253 deletions(-)

Aaro Koskinen (1):
      mmc: omap: fix the maximum timeout setting

Aditya Pakki (1):
      x86/hpet: Prevent potential NULL pointer dereference

Akinobu Mita (1):
      media: mt9m111: set initial frame size other than 0x0

Amit Klein (1):
      inet: update the IP ID generation algorithm to higher standards.

Anders Roxell (1):
      dmaengine: imx-dma: fix warning comparison of distinct pointer types

Andre Przywara (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Andrea Righi (2):
      kprobes: Prohibit probing on bsearch()
      openvswitch: fix flow actions reallocation

Arnd Bergmann (2):
      mmc: davinci: remove extraneous __init annotation
      appletalk: Fix compile regression

Bartlomiej Zolnierkiewicz (1):
      ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos plat=
forms

Ben Dooks (1):
      dmaengine: tegra: avoid overflow of byte tracking

Benjamin Block (1):
      scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c

Bj=F8rn Mork (1):
      qmi_wwan: add Olicard 600

Buland Singh (1):
      hpet: Fix missing '=3D' character in the __setup() code of hpet_mmap_=
enable

Carlos Maiolino (1):
      fs: fix guard_bio_eod to check for real EOD errors

Changbin Du (2):
      perf top: Fix error handling in cmd_top()
      perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Christian Brauner (1):
      sysctl: handle overflow for file-max

Christian Lamparter (1):
      crypto: crypto4xx - properly set IV after de- and encrypt

Colin Ian King (1):
      ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and =
declaration

Coly Li (3):
      bcache: fix input overflow to cache set sysfs file io_error_halflife
      bcache: fix input overflow to sequential_cutoff
      bcache: improve sysfs_strtoul_clamp()

Dan Carpenter (1):
      xen: Prevent buffer overflow in privcmd ioctl

David Arcari (1):
      tools/power turbostat: return the exit status of a command

David Tolnay (1):
      hwrng: virtio - Avoid repeated init of completion

Dinu-Razvan Chis-Serban (1):
      9p locks: add mount option for lock retry interval

Douglas Anderson (1):
      tracing: kdb: Fix ftdump to not sleep

Dragos Bogdan (1):
      iio: ad_sigma_delta: select channel when reading register

Eric Dumazet (3):
      netns: provide pure entropy for net_hash_mix()
      ipv4: ensure rcu_read_lock() in ipv4_link_failure()
      tcp: tcp_grow_window() needs to respect tcp_space()

Florian Fainelli (1):
      e1000e: Fix -Wformat-truncation warnings

Georg Ottinger (1):
      iio: adc: at91: disable adc channel interrupt in timeout case

Gertjan Halkes (1):
      9p: do not trust pdu content for stat item size

Greg Kroah-Hartman (3):
      tty: mark Siemens R3964 line discipline as BROKEN
      tty: ldisc: add sysctl to prevent autoloading of ldiscs
      Linux 3.18.139

Guenter Roeck (1):
      cdrom: Fix race condition in cdrom_sysctl_register

H=E5kon Bugge (1):
      IB/mlx4: Increase the timeout for CM cache

Ian Abbott (3):
      staging: comedi: vmk80xx: Fix use of uninitialized semaphore
      staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
      staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Jack Morgenstein (1):
      IB/mlx4: Fix race condition between catas error reset and aliasguid f=
lows

Jann Horn (1):
      device_cgroup: fix RCU imbalance in error case

Jarkko Sakkinen (1):
      tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

Jason Cai (Xiang Feng) (1):
      dm thin: add sanity checks to thin-pool and external snapshot creation

Jason Yan (1):
      scsi: megaraid_sas: return error when create DMA pool failed

Jeremy Compostella (1):
      i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA

Jia Guo (1):
      ocfs2: fix a panic problem caused by o2cb_ctl

Julia Cartwright (1):
      iommu/dmar: Fix buffer overflow during PCI bus notification

J=E9r=F4me Glisse (1):
      block: do not leak memory in bio_copy_user_iov()

Kangjie Lu (2):
      ALSA: echoaudio: add a check for ioremap_nocache
      ALSA: sb8: add a check for request_region

Li RongQing (1):
      net: ethtool: not call vzalloc for zero sized memory request

Linus Torvalds (1):
      binfmt_elf: switch to new creds when switching to new mm

Louis Taylor (1):
      cifs: use correct format characters

Lu Baolu (1):
      iommu/vt-d: Check capability before disabling protected memory

Lukas Czerner (1):
      ext4: report real fs size after failed resize

Manfred Schlaegl (2):
      fbdev: fbmem: fix memory access if logo is bigger than the screen
      tty: increase the default flip buffer limit to 2*640K

Masami Hiramatsu (2):
      x86/kprobes: Verify stack frame on kretprobe
      kprobes: Fix error check when reusing optimized probes

Matthew Garrett (1):
      thermal/int340x_thermal: fix mode setting

Matthew Whitehead (1):
      x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Max Filippov (1):
      xtensa: fix return_address

Mel Gorman (1):
      sched/fair: Do not re-read ->h_load_next during hierarchical load cal=
culation

Michal Kazior (1):
      leds: lp55xx: fix null deref on firmware load failure

Michal Simek (1):
      serial: uartps: console_setup() can't be placed to init section

Nathan Chancellor (2):
      ARM: 8833/1: Ensure that NEON code always compiles with Clang
      arm64: futex: Restore oldval initialization to work around buggy comp=
ilers

Nick Desaulniers (1):
      lib/string.c: implement a basic bcmp

Nikolay Aleksandrov (1):
      net: bridge: multicast: use rcu to access port list from br_multicast=
_start_querier

Pawe? Chmiel (1):
      media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Peng Fan (1):
      mm/cma.c: cma_declare_contiguous: correct err handling

Phil Auld (1):
      sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup

Pi-Hsun Shih (1):
      include/linux/swap.h: use offsetof() instead of custom __swapoffset m=
acro

Qian Cai (1):
      mm/slab.c: kmemleak no scan alien caches

Rafael =C1vila de Esp=EDndola (1):
      x86/build: Mark per-CPU symbols as absolute explicitly for LLD

Ranjani Sridharan (1):
      ALSA: PCM: check if ops are defined before suspending PCM

Ronald Tschal=E4r (1):
      ACPI / SBS: Fix GPE storm on recent MacBookPro's

S.j. Wang (1):
      ASoC: fsl_esai: fix channel swap issue when stream starts

Sabrina Dubroca (1):
      bonding: fix event handling for stacked bonds

Sebastian Andrzej Siewior (1):
      ARM: 8840/1: use a raw_spinlock_t in unwind

Sheena Mira-ato (1):
      ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Siva Rebbagondla (1):
      rsi: improve kernel thread handling to fix kernel panic

Stanislaw Gruszka (1):
      lib/div64.c: off by one in shift

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Stephen Suryaputra (1):
      ipv4: recompile ip options in ipv4_link_failure

Steve French (1):
      fix incorrect error code mapping for OBJECTID_NOT_FOUND

Takashi Iwai (1):
      ALSA: core: Fix card races between register and disconnect

Tejun Heo (1):
      string: drop __must_check from strscpy() and restore strscpy() usages=
 in cgroup

Tony Jones (1):
      tools lib traceevent: Fix buffer overflow in arg_eval

Uladzislau Rezki (Sony) (1):
      mm/vmalloc.c: fix kernel BUG at mm/vmalloc.c:512!

Ville Syrj=E4l=E4 (1):
      drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Wen Yang (1):
      SoC: imx-sgtl5000: add missing put_device()

Will Deacon (2):
      arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value
      kernel/sysctl.c: fix out-of-bounds access when setting file-max

Xin Long (1):
      sctp: initialize _pad of sockaddr_in before copying to user memory

Yao Liu (1):
      cifs: Fix NULL pointer dereference of devname

YueHaibing (1):
      appletalk: Fix use-after-free in atalk_proc_exit

Zubin Mithra (1):
      ALSA: seq: Fix OOB-reads from strlcpy

Zumeng Chen (1):
      wlcore: Fix memory leak in case wl12xx_fetch_firmware failure

zhangyi (F) (1):
      ext4: cleanup bh release code in ext4_ind_remove_space()


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlzETgYACgkQONu9yGCS
aT4AfA//ZI7NM95rLBbGSupSu4jDsfxmmE+Fq43pl5oBugJe7chYXoCF7uFF5+sH
EY1EoHtk4RExyQacyNgu3S/hkhemv+jgYr0+WopJd+kLwvBsS+Ti8okUwt6PZOKR
0GXJz4Xj2By3nupjeYuQFHu9miSYnA1ttVvS3iJiUL8+n4wY3GdofTAUJamK9Kuy
wmyLxx889yqnkvqeqCOGN/HNFDC5N7VLsYixxuJDk8kSFPNfEmxLxyXJvzQ0VSkd
c9Qsx5MluxeGO4rm6jL8V6ZMeTc0lD4M/4BN71TckCS2qy8y6pmbZ7WG1sYBjg+F
P3IN0uQJchUHgoBew2bMrd20rvZyR6SqL4ytKgzOXqkZRoFKiF1jaNsRPCDCmIjH
a3W/IMIkjvr0ClO8gL5NChHypUsqsyF0JzbNL6/lRoNdZboHQsLBEJLED9Eze+iA
YvmLnH0MNMF5ubyScnzZJMp54krpCQOtH9clu7oZXRUdG9WicE0Skkmz/KJqZySq
6s4L4W9oPbRiIZdkkFi7xqMxZfKJSfvmb+qhHXKnKVWKGWnmjqcW9nLF5oVyhpT+
94rKhoUPnr24LHopXgxLdxoP/RYbckl04++SL6Y35IqwXvPwjx9Qsq7kxrcTrQs4
oXMXWJovGrACgJUfYi/gp8hVOplrDxMAWIS/ob06+2EcH0ZIczE=
=zvWn
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
