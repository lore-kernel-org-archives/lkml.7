Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F886C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E762064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551864221;
	bh=sgs5BTKAAQd34lrdHkc3d8zLCm5Z+FE4IQHiOm04nZs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2Z6FDrAFcWzm3r4eVGYpHz2DOugVI6+Rws4DIKh2yOvdQZmsO1GUdncBlYDLOswdD
	 4Sc4jhZ7BSYCkhdPOJksU8G4oG5DmIK7UKa3CadYsR52/zgszHjJ5G28b+cqV9ClB6
	 X1c6UtMGxI2l8hl3ApqMuy8nAbsM2gPexO/nORVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfCFJXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbfCFJXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:23:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B692064A;
        Wed,  6 Mar 2019 09:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551864218;
        bh=sgs5BTKAAQd34lrdHkc3d8zLCm5Z+FE4IQHiOm04nZs=;
        h=Date:From:To:Cc:Subject:From;
        b=v9T7u356AykgNF4f0G98Z6z4Xfnmzd0BRMTVHtwO2wjxP2RJ2obR7RyjFoco7eom/
         LYJHrBBXUUfSla6zIPTDw5G6ZDgFSAnfmmOi1xCAaZ45kJ2n4rUOOu/Hi/FObqk8dq
         9p2HRhgdJCpgUEFcEy23/1i9T1PKs2vKl7zK+sn8=
Date:   Wed, 6 Mar 2019 10:23:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.105
Message-ID: <20190306092335.GA29330@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.105 kernel.

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

 Makefile                                                     |    2=20
 arch/arc/include/asm/bitops.h                                |    6 -
 arch/mips/kernel/cmpxchg.c                                   |    3=20
 arch/mips/net/ebpf_jit.c                                     |    2=20
 arch/powerpc/include/asm/epapr_hcalls.h                      |   12 +-
 arch/x86/include/asm/uaccess.h                               |    7 -
 arch/x86/kvm/svm.c                                           |   27 ++----
 drivers/block/loop.c                                         |   47 +++++-=
-----
 drivers/clk/clk-versaclock5.c                                |    4=20
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c |   22 ++++-
 drivers/gpu/drm/msm/msm_rd.c                                 |    7 +
 drivers/mmc/host/mmc_spi.c                                   |    1=20
 drivers/mmc/host/renesas_sdhi_sys_dmac.c                     |    1=20
 drivers/mmc/host/sdhci-esdhc-imx.c                           |    9 +-
 drivers/mmc/host/tmio_mmc.h                                  |    5 +
 drivers/mmc/host/tmio_mmc_core.c                             |   17 ++-
 drivers/net/ethernet/altera/altera_tse_main.c                |    4=20
 drivers/net/ethernet/ibm/ibmveth.c                           |    2=20
 drivers/net/ethernet/stmicro/stmmac/common.h                 |    2=20
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c            |    3=20
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c         |   12 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c          |   15 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h                 |    2=20
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c            |    5 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c            |    9 +-
 drivers/net/hyperv/rndis_filter.c                            |   25 ++++-
 drivers/net/usb/asix_devices.c                               |    9 +-
 drivers/scsi/csiostor/csio_attr.c                            |    2=20
 drivers/scsi/libsas/sas_expander.c                           |    2=20
 drivers/staging/android/ion/ion.c                            |    2=20
 drivers/staging/rtl8723bs/include/ieee80211.h                |    6 -
 drivers/thermal/int340x_thermal/processor_thermal_device.c   |   30 +++----
 drivers/tty/serial/fsl_lpuart.c                              |    2=20
 drivers/usb/dwc3/gadget.c                                    |    3=20
 drivers/usb/gadget/function/f_sourcesink.c                   |    2=20
 fs/direct-io.c                                               |    5 -
 fs/fs-writeback.c                                            |   40 ++++++=
++-
 include/linux/backing-dev-defs.h                             |    1=20
 include/linux/if_arp.h                                       |    1=20
 kernel/exit.c                                                |    2=20
 kernel/futex.c                                               |   13 +--
 kernel/irq/manage.c                                          |    3=20
 kernel/locking/rwsem-xadd.c                                  |   11 ++
 mm/backing-dev.c                                             |    1=20
 mm/mmap.c                                                    |    7 -
 net/mac80211/cfg.c                                           |    4=20
 net/mac80211/rx.c                                            |    6 -
 net/wireless/reg.c                                           |    4=20
 sound/core/compress_offload.c                                |    3=20
 sound/soc/codecs/rt274.c                                     |    5 -
 sound/soc/fsl/imx-audmux.c                                   |   24 ++---
 sound/soc/intel/boards/broadwell.c                           |    2=20
 sound/soc/intel/boards/haswell.c                             |    2=20
 sound/soc/soc-dapm.c                                         |   10 +-
 tools/testing/selftests/gpio/gpio-mockup-chardev.c           |    9 +-
 tools/testing/selftests/seccomp/Makefile                     |    2=20
 56 files changed, 313 insertions(+), 151 deletions(-)

Aaron Hill (1):
      drivers: thermal: int340x_thermal: Fix sysfs race condition

Andy Lutomirski (1):
      x86/uaccess: Don't leak the AC flag into __put_user() value evaluation

Atsushi Nemoto (1):
      net: altera_tse: fix connect_local_phy error path

BOUGH CHEN (1):
      mmc: sdhci-esdhc-imx: correct the fix of ERR004536

Balaji Pothunoori (1):
      mac80211: don't initiate TDLS connection if station is not associated=
 to AP

Bo He (1):
      usb: dwc3: gadget: synchronize_irq dwc irq in suspend

Bob Copeland (1):
      mac80211: fix miscounting of ttl-dropped frames

Chaitanya Tata (1):
      cfg80211: extend range deviation for DMG

Dan Carpenter (3):
      ALSA: compress: prevent potential divide by zero bugs
      thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
      usb: gadget: Potential NULL dereference on allocation error

Ernesto A. Fern=C3=A1ndez (1):
      direct-io: allow direct writes to empty inodes

Eugeniy Paltsev (1):
      ARC: fix __ffs return value to avoid build warnings

Fathi Boudra (1):
      selftests: seccomp: use LDLIBS instead of LDFLAGS

Florian Fainelli (1):
      net: stmmac: Fix reception of Broadcom switches tags

Geert Uytterhoeven (1):
      selftests: gpio-mockup-chardev: Check asprintf() for error

Greg Kroah-Hartman (4):
      Revert "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_contro=
l_ioctl()"
      Revert "loop: Get rid of loop_index_mutex"
      Revert "loop: Fold __loop_release into loop_release"
      Linux 4.14.105

Haiyang Zhang (1):
      hv_netvsc: Fix ethtool change hash key error

Jann Horn (1):
      mm: enforce min addr even if capable() in expand_downwards()

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attac=
hed

Jonathan Neusch=C3=A4fer (1):
      mmc: spi: Fix card detection during probe

Jose Abreu (1):
      net: stmmac: Disable ACS Feature for GMAC >=3D 4

Kenneth Feng (1):
      drm/amd/powerplay: OD setting fix on Vega10

Kristian H. Kristensen (1):
      drm/msm: Unblock writer if reader closes file

Liam Mark (1):
      staging: android: ion: Support cpu access during dma_buf_detach

Maciej =C5=BBenczykowski (1):
      net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP

Marek Vasut (1):
      clk: vc5: Abort clock configuration without upstream clock

Mathieu Malaterre (1):
      mac80211: Add attribute aligned(2) to struct 'action'

Michael Clark (1):
      MIPS: fix truncation in __cmpxchg_small for short values

Nathan Chancellor (1):
      staging: rtl8723bs: Fix build error with Clang when inlining is disab=
led

Paul Burton (1):
      MIPS: eBPF: Fix icache flush end address

Peter Zijlstra (1):
      futex: Fix (possible) missed wakeup

Prateek Sood (1):
      sched/wait: Fix rcuwait_wake_up() ordering

Rander Wang (1):
      ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Sergei Shtylyov (1):
      mmc: tmio_mmc_core: don't claim spurious interrupts

Seth Forshee (1):
      powerpc: Always initialize input array when calling epapr_hypercall()

Silvio Cesare (2):
      ASoC: dapm: change snprintf to scnprintf for possible overflow
      ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Srinivas Ramana (1):
      genirq: Make sure the initial affinity is not empty

Suravee Suthikulpanit (1):
      svm: Fix AVIC incomplete IPI emulation

Takeshi Saito (1):
      mmc: tmio: fix access width of Block Count Register

Tejun Heo (1):
      writeback: synchronize sync(2) against cgroup writeback membership sw=
itches

Thomas Falcon (1):
      ibmveth: Do not process frames after calling napi_reschedule

Tomonori Sakita (1):
      serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampli=
ng

Varun Prakash (1):
      scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Vitaly Kuznetsov (1):
      KVM: nSVM: clear events pending from svm_complete_interrupts() when e=
xiting to L1

Xie Yongji (1):
      locking/rwsem: Fix (possible) missed wakeup

Yizhuo (1):
      ASoC: Variable "val" in function rt274_i2c_probe() could be uninitial=
ized

Zeng Tao (1):
      usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

Zhang Run (1):
      net: usb: asix: ax88772_bind return error when hw_reset fail


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlx/kZcACgkQONu9yGCS
aT4gyA//fTyaHImluSj2Q/NmJC63ewoLfNYtpLhrH6vqpXfynnN9FI4fJe8Oqg2V
2hs3XapbAJpY1/6SbRf5tRuAkbFuTIWsWrxdZ80LD/XiSJ2nbVn+87P39vksL1cd
OfkxbovrHYt8pPOIDGR4BdGS8W1S7suf0D3EsFhTsPEL0AFFaxD3x9FymwRPV+ML
OE5tqUlM0I7SA93pTQn1FhMLo5vYLvkNq/up1r4FzYQOgLTTqwcwsKJK2ta/389e
yNlUCxRZrueuJOtAWXpz8JYgoZiNSlgde+uO/mAxpJyYVg1ID2c04E7owW+D0cFz
SJ9tAWYF4jFyPu3BrVzGj9QrTN+soQ2knIXjWhBUjmJj48t1n+gcRMXvWZCMByGQ
t0vaASifiSTvCAbQvsU8Sxz/V2fodl+SCicaCcCJVKl3PFML1UJf2cyx500nDnpd
fR9sAqsB9pw5sLe0mzRfu1zhIqc7eTh3Tm5IvbVRSNm2AC9LJkJsUxoS/kbBrcJ2
dizzJ0u1HJrSOfNkyVauXy6D9rSbp19x+qaoSYGX02nZjw3x3kLzE45WdQOBR8SK
gLLps1n4oHGV6m2nZDMvaJ25s9CZInlM/twcHXTEtE/eER96YIZZMq2xIM8r7opT
lJotsBctLVOqsm8kG8eOqwOBgWGTCVStKb6ca7ecM8ASrLLWfr0=
=YMGs
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
