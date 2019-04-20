Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C03C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F7420883
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555770645;
	bh=ZjqFnwvcuNzEFW6HDqwMojnS5ymTQ568p0gGuMgxtJA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ti1SJzMjLJk4jxIcBlhKIb3OC89GPsixKlX6VVc1psdCNhpKIM2HnGxcvF3xMTTVO
	 XPOFxu2MWNSy6uSY1vXwAyvX5eTwnesUE/hsF7JOICCc1CwHHXpQQk2kTrQpBAaRrw
	 vnI1OKv4QZpZlNJxLNRV7TJ5a204RJgP0YCSY8nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfDTOao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTOao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:30:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24EB32087F;
        Sat, 20 Apr 2019 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555770642;
        bh=ZjqFnwvcuNzEFW6HDqwMojnS5ymTQ568p0gGuMgxtJA=;
        h=Date:From:To:Cc:Subject:From;
        b=hPiWIr8eF86wK3eBTwv1hQGTM2Q9z2NtPFrKsZ3rhvmEORTewedjZyv14JACFVTaC
         fVOUbj7dOIlfB6l7QY18GYZ+Ov9eHjVJOEx8Fr0gbmNzMVoPa0/oo3pTCUdd/aS30Z
         B6QAVj0vVvbc+xpv8z21fmRfzASUnU6Eu2fxfrzk=
Date:   Sat, 20 Apr 2019 16:30:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.170
Message-ID: <20190420143039.GA10511@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.170 kernel.

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

 Makefile                                          |    2=20
 arch/arc/kernel/head.S                            |    1=20
 arch/arc/kernel/setup.c                           |    8=20
 arch/arm/crypto/sha256-armv4.pl                   |    3=20
 arch/arm/crypto/sha256-core.S_shipped             |    3=20
 arch/arm/crypto/sha512-armv4.pl                   |    3=20
 arch/arm/crypto/sha512-core.S_shipped             |    3=20
 arch/arm/kernel/patch.c                           |    6=20
 arch/arm/plat-samsung/Kconfig                     |    2=20
 arch/x86/kernel/cpu/cyrix.c                       |   14=20
 arch/x86/kernel/hpet.c                            |    2=20
 arch/x86/kernel/hw_breakpoint.c                   |    1=20
 drivers/acpi/sbs.c                                |    8=20
 drivers/char/tpm/tpm_crb.c                        |   22=20
 drivers/gpio/gpio-pxa.c                           |    6=20
 drivers/hid/i2c-hid/Makefile                      |    3=20
 drivers/hid/i2c-hid/i2c-hid-core.c                | 1359 +++++++++++++++++=
+++++
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c          |  376 ++++++
 drivers/hid/i2c-hid/i2c-hid.c                     | 1339 -----------------=
----
 drivers/hid/i2c-hid/i2c-hid.h                     |   20=20
 drivers/infiniband/hw/mlx4/alias_GUID.c           |    2=20
 drivers/iommu/dmar.c                              |    2=20
 drivers/iommu/intel-iommu.c                       |    3=20
 drivers/irqchip/irq-mbigen.c                      |    3=20
 drivers/misc/lkdtm.h                              |    2=20
 drivers/misc/lkdtm_core.c                         |    2=20
 drivers/misc/lkdtm_perms.c                        |   18=20
 drivers/mmc/host/davinci_mmc.c                    |    2=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   10=20
 drivers/net/wireless/rsi/rsi_common.h             |    1=20
 drivers/soc/tegra/pmc.c                           |    8=20
 drivers/thermal/int340x_thermal/int3400_thermal.c |   21=20
 drivers/tty/serial/xilinx_uartps.c                |    2=20
 fs/9p/v9fs.c                                      |   21=20
 fs/9p/v9fs.h                                      |    1=20
 fs/9p/vfs_dir.c                                   |    8=20
 fs/9p/vfs_file.c                                  |    6=20
 fs/cifs/inode.c                                   |   67 -
 fs/cifs/smb2maperror.c                            |    3=20
 fs/ext4/ioctl.c                                   |    7=20
 fs/ext4/resize.c                                  |   17=20
 fs/f2fs/super.c                                   |   34=20
 include/linux/atalk.h                             |   20=20
 include/linux/swap.h                              |    4=20
 kernel/events/core.c                              |    2=20
 kernel/hung_task.c                                |   30=20
 lib/div64.c                                       |    4=20
 net/9p/protocol.c                                 |    3=20
 net/appletalk/atalk_proc.c                        |    2=20
 net/appletalk/ddp.c                               |   37=20
 net/appletalk/sysctl_net_atalk.c                  |    5=20
 sound/drivers/opl3/opl3_voice.h                   |    2=20
 sound/isa/sb/sb8.c                                |    4=20
 sound/pci/echoaudio/echoaudio.c                   |    5=20
 tools/perf/Documentation/perf-config.txt          |    2=20
 tools/perf/builtin-top.c                          |    5=20
 tools/perf/tests/evsel-tp-sched.c                 |    1=20
 tools/perf/tests/openat-syscall-all-cpus.c        |    4=20
 tools/perf/util/build-id.c                        |    1=20
 tools/perf/util/config.c                          |    3=20
 tools/perf/util/evsel.c                           |    1=20
 tools/perf/util/hist.c                            |    4=20
 tools/perf/util/parse-events.c                    |    1=20
 tools/power/x86/turbostat/turbostat.c             |    3=20
 64 files changed, 2112 insertions(+), 1452 deletions(-)

Aditya Pakki (1):
      x86/hpet: Prevent potential NULL pointer dereference

Ard Biesheuvel (2):
      crypto: sha256/arm - fix crash bug in Thumb2 build
      crypto: sha512/arm - fix crash bug in Thumb2 build

Arnaldo Carvalho de Melo (1):
      perf evsel: Free evsel->counts in perf_evsel__exit()

Arnd Bergmann (2):
      mmc: davinci: remove extraneous __init annotation
      appletalk: Fix compile regression

Bartlomiej Zolnierkiewicz (1):
      ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos plat=
forms

Changbin Du (7):
      perf config: Fix an error in the config template documentation
      perf config: Fix a memory leak in collect_config()
      perf build-id: Fix memory leak in print_sdt_events()
      perf top: Fix error handling in cmd_top()
      perf hist: Add missing map__put() in error case
      perf tests: Fix a memory leak of cpu_map object in the openat_syscall=
_event_on_all_cpus test
      perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Chao Yu (1):
      f2fs: fix to do sanity check with current segment number

Christophe Leroy (1):
      lkdtm: Add tests for NULL pointer dereference

Colin Ian King (1):
      ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and =
declaration

Darrick J. Wong (1):
      ext4: prohibit fstrim in norecovery mode

David Arcari (1):
      tools/power turbostat: return the exit status of a command

Dinu-Razvan Chis-Serban (1):
      9p locks: add mount option for lock retry interval

Dmitry Osipenko (1):
      soc/tegra: pmc: Drop locking from tegra_powergate_is_powered()

Eugeniy Paltsev (1):
      ARC: u-boot args: check that magic number is correct

Gertjan Halkes (1):
      9p: do not trust pdu content for stat item size

Greg Kroah-Hartman (1):
      Linux 4.9.170

Jack Morgenstein (1):
      IB/mlx4: Fix race condition between catas error reset and aliasguid f=
lows

Jarkko Sakkinen (1):
      tpm/tpm_crb: Avoid unaligned reads in crb_recv()

Jianguo Chen (1):
      irqchip/mbigen: Don't clear eventid when freeing an MSI

Julia Cartwright (1):
      iommu/dmar: Fix buffer overflow during PCI bus notification

Julian Sax (1):
      HID: i2c-hid: override HID descriptors for certain devices

Kangjie Lu (2):
      ALSA: echoaudio: add a check for ioremap_nocache
      ALSA: sb8: add a check for request_region

Lars Persson (1):
      net: stmmac: Set dma ring length before enabling the DMA

Lu Baolu (1):
      iommu/vt-d: Check capability before disabling protected memory

Lukas Czerner (2):
      ext4: add missing brelse() in add_new_gdb_meta_bg()
      ext4: report real fs size after failed resize

Matthew Garrett (2):
      thermal/int340x_thermal: Add additional UUIDs
      thermal/int340x_thermal: fix mode setting

Matthew Whitehead (1):
      x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Michal Simek (1):
      serial: uartps: console_setup() can't be placed to init section

Nathan Chancellor (1):
      x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() r=
eturn an error

Pi-Hsun Shih (1):
      include/linux/swap.h: use offsetof() instead of custom __swapoffset m=
acro

Robert Jarzmik (1):
      gpio: pxa: handle corner case of unprobed device

Ronald Tschal=E4r (1):
      ACPI / SBS: Fix GPE storm on recent MacBookPro's

Siva Rebbagondla (1):
      rsi: improve kernel thread handling to fix kernel panic

Stanislaw Gruszka (1):
      lib/div64.c: off by one in shift

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Steve French (2):
      fix incorrect error code mapping for OBJECTID_NOT_FOUND
      cifs: fallback to older infolevels on findfirst queryinfo retry

Vitaly Kuznetsov (1):
      kernel: hung_task.c: disable on suspend

Yang Shi (1):
      ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t

YueHaibing (1):
      appletalk: Fix use-after-free in atalk_proc_exit


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly7LQ0ACgkQONu9yGCS
aT6H3w/+JBNtOzs/r3NwRq/8O8Fo3sOrcnDe6Ag1zrOIj4Hb/lnTMqRIAumMLHTu
rvMxDdKjLqwl3LKh2oDsyxdX4W0HMfelyun7E81O/YLqIFvxKRdyA0xKosGbmBin
6krrxJTa3MTB439pgbXOeWiq6HvkPaGW8jEcoAt6xTHxQAHfMA9nxt2KqhRt87E4
frcTK7ReE+YDqu0eb9GzUcE3JEuQMgzAWrgBQw2zpNAzZ9cqMMtGfcTsxC9OdiZk
fw4UZkpXxfuavpQfCi7AgyJB8EjGylIfMbuMEqy/p5pgONIbiml9Uk6XMEZhC8La
XT7cjfLGIwA61DY2bE+ekkXz+QqIvsM0C3LOU4TxURH4OLfXqAAiRWSBR6+3gjMz
CCLjJDK5dEGEzyVe87FoNgjL9UXBFp1I6/uMgslA4z1iEcJVlpTNRhx+adRHoo5i
eJ4IvPl9+2OZk/0wO37DKcKu7ICsqgsOkTVkkqlxgMuAy1WxD5IHWLFJCh89qGDq
ybJVrb4AXUrYSV1Z2aF1PhwV+6uUX6NAOxB74h4X4Y0rXDQzf/bSGf9cl7k2CxQl
xlhSxm7oCPkqsK/HaYHTWexrTPoekaEmKXHUnl4xOGzjjScozHBLUJmRA2bjsWUx
/tJLeDQaNthRqROkC5r17NqLJ0g2e/YMHaV6aRZx931M80z+8gQ=
=U8p6
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
