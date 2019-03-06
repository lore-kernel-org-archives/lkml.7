Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C55BC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A112064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551864244;
	bh=VuPQoj5fHFkTK+mn3E/qYxvHLlpCe9lSNsZpS3oYuUs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gksRA7N2iNXCQW2LzMK60skyJWIuuwgP69Ut8b+PcvnFh8O1I1GMQxegt+2UqTup2
	 X8OP1x6PVkyNQn6t4fmp+43aAab9Mt/reqkwkvMNQbFNUAzZcJJaAHhr7Ajia9fMBN
	 yODH4E7ogqiqLRFljxyPTX5AF1aqDs67YNERKS9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfCFJYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:24:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfCFJYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:24:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47A882064A;
        Wed,  6 Mar 2019 09:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551864240;
        bh=VuPQoj5fHFkTK+mn3E/qYxvHLlpCe9lSNsZpS3oYuUs=;
        h=Date:From:To:Cc:Subject:From;
        b=F93wF9nqfkVHliRxbC4pCp6ocxy5t7O9MHGQBOSMy1gxNqoW5GRlNc4Hrv4BbboMf
         M3LVeIOMh0j3MBvQca8MclR0cA8NiQ6iG1YgnIHsrnV/hk6gz3bVqVLiBEirtPpCaF
         F5LczPVDHCs8/je57SYlo5QPHrwSAn1aNRvMNz1c=
Date:   Wed, 6 Mar 2019 10:23:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.27
Message-ID: <20190306092358.GA29410@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.27 kernel.

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

 Makefile                                                     |    2=20
 arch/arc/include/asm/bitops.h                                |    6=20
 arch/arc/kernel/troubleshoot.c                               |   26 --
 arch/mips/bcm63xx/dev-enet.c                                 |    8=20
 arch/mips/kernel/cmpxchg.c                                   |    3=20
 arch/mips/net/ebpf_jit.c                                     |    2=20
 arch/x86/include/asm/uaccess.h                               |    7=20
 arch/x86/kernel/apic/vector.c                                |    9=20
 arch/x86/kvm/svm.c                                           |   27 --
 arch/x86/mm/mem_encrypt_identity.c                           |    4=20
 drivers/clk/clk-versaclock5.c                                |    4=20
 drivers/clk/clk.c                                            |    2=20
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c                   |    4=20
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c |   22 +
 drivers/gpu/drm/drm_atomic_helper.c                          |    9=20
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                        |    2=20
 drivers/gpu/drm/msm/msm_rd.c                                 |    7=20
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                       |    4=20
 drivers/irqchip/irq-gic-v3-mbi.c                             |    2=20
 drivers/mmc/core/core.c                                      |    2=20
 drivers/mmc/host/cqhci.c                                     |   13 -
 drivers/mmc/host/mmc_spi.c                                   |    1=20
 drivers/mmc/host/renesas_sdhi_sys_dmac.c                     |    1=20
 drivers/mmc/host/sdhci-esdhc-imx.c                           |    9=20
 drivers/mmc/host/tmio_mmc.h                                  |    5=20
 drivers/mmc/host/tmio_mmc_core.c                             |   17 -
 drivers/net/ethernet/altera/altera_tse_main.c                |    4=20
 drivers/net/ethernet/ibm/ibmveth.c                           |    2=20
 drivers/net/hyperv/hyperv_net.h                              |   10=20
 drivers/net/hyperv/netvsc.c                                  |    2=20
 drivers/net/hyperv/netvsc_drv.c                              |  139 ++++++=
+----
 drivers/net/hyperv/rndis_filter.c                            |   34 ++
 drivers/net/usb/asix_devices.c                               |    9=20
 drivers/nvme/host/multipath.c                                |    3=20
 drivers/nvme/host/rdma.c                                     |   26 +-
 drivers/phy/qualcomm/phy-ath79-usb.c                         |    4=20
 drivers/scsi/csiostor/csio_attr.c                            |    2=20
 drivers/scsi/libsas/sas_expander.c                           |    2=20
 drivers/scsi/lpfc/lpfc_nvme.c                                |   16 -
 drivers/scsi/lpfc/lpfc_nvme.h                                |    2=20
 drivers/scsi/lpfc/lpfc_nvmet.c                               |    8=20
 drivers/scsi/lpfc/lpfc_nvmet.h                               |    2=20
 drivers/staging/android/ion/ion.c                            |    2=20
 drivers/staging/rtl8723bs/include/ieee80211.h                |    6=20
 drivers/thermal/int340x_thermal/processor_thermal_device.c   |   30 +-
 drivers/tty/serial/fsl_lpuart.c                              |    2=20
 drivers/tty/serial/qcom_geni_serial.c                        |    4=20
 drivers/usb/dwc3/gadget.c                                    |    3=20
 drivers/usb/gadget/function/f_sourcesink.c                   |    2=20
 fs/direct-io.c                                               |    5=20
 fs/fs-writeback.c                                            |   40 +++
 fs/hugetlbfs/inode.c                                         |   12=20
 include/linux/backing-dev-defs.h                             |    1=20
 include/linux/if_arp.h                                       |    1=20
 include/linux/irq.h                                          |    3=20
 kernel/exit.c                                                |    2=20
 kernel/futex.c                                               |   13 -
 kernel/irq/manage.c                                          |    3=20
 kernel/irq/matrix.c                                          |  114 ++++++=
---
 kernel/locking/rwsem-xadd.c                                  |   11=20
 kernel/sched/core.c                                          |    7=20
 mm/backing-dev.c                                             |    1=20
 mm/hugetlb.c                                                 |   16 +
 mm/migrate.c                                                 |   11=20
 mm/mmap.c                                                    |    7=20
 net/mac80211/cfg.c                                           |    4=20
 net/mac80211/rx.c                                            |    6=20
 net/mac80211/tx.c                                            |    4=20
 net/wireless/reg.c                                           |    4=20
 sound/core/compress_offload.c                                |    3=20
 sound/soc/codecs/rt274.c                                     |    5=20
 sound/soc/codecs/rt5682.h                                    |   24 -
 sound/soc/fsl/imx-audmux.c                                   |   24 -
 sound/soc/intel/boards/broadwell.c                           |    2=20
 sound/soc/intel/boards/haswell.c                             |    2=20
 sound/soc/soc-dapm.c                                         |   10=20
 tools/testing/selftests/gpio/gpio-mockup-chardev.c           |    9=20
 tools/testing/selftests/kvm/lib/kvm_util.c                   |    9=20
 tools/testing/selftests/rtc/rtctest.c                        |  109 ++++++=
++
 tools/testing/selftests/seccomp/Makefile                     |    2=20
 tools/testing/selftests/vm/gup_benchmark.c                   |    1=20
 81 files changed, 687 insertions(+), 290 deletions(-)

Aaron Hill (1):
      drivers: thermal: int340x_thermal: Fix sysfs race condition

Alamy Liu (2):
      mmc: cqhci: fix space allocated for transfer descriptor
      mmc: cqhci: Fix a tiny potential memory leak on error condition

Alban Bedel (2):
      phy: ath79-usb: Fix the power on error path
      phy: ath79-usb: Fix the main reset name to match the DT binding

Alexandre Belloni (2):
      selftests: rtc: rtctest: fix alarm tests
      selftests: rtc: rtctest: add alarm test on minute boundary

Alison Schofield (1):
      selftests/vm/gup_benchmark.c: match gup struct to kernel

Andy Lutomirski (1):
      x86/uaccess: Don't leak the AC flag into __put_user() value evaluation

Atsushi Nemoto (1):
      net: altera_tse: fix connect_local_phy error path

BOUGH CHEN (1):
      mmc: sdhci-esdhc-imx: correct the fix of ERR004536

Balaji Pothunoori (1):
      mac80211: don't initiate TDLS connection if station is not associated=
 to AP

Ben Gardon (1):
      kvm: selftests: Fix region overlap check in kvm_util

Bo He (1):
      usb: dwc3: gadget: synchronize_irq dwc irq in suspend

Bob Copeland (1):
      mac80211: fix miscounting of ttl-dropped frames

Chaitanya Tata (1):
      cfg80211: extend range deviation for DMG

Dan Carpenter (4):
      ALSA: compress: prevent potential divide by zero bugs
      clk: tegra: dfll: Fix a potential Oop in remove()
      thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
      usb: gadget: Potential NULL dereference on allocation error

Dou Liyang (2):
      irq/matrix: Split out the CPU selection code into a helper
      irq/matrix: Spread managed interrupts on allocation

Douglas Anderson (1):
      drm/msm: Fix A6XX support for opp-level

Ernesto A. Fern=C3=A1ndez (1):
      direct-io: allow direct writes to empty inodes

Eugeniy Paltsev (1):
      ARC: fix __ffs return value to avoid build warnings

Ewan D. Milne (2):
      scsi: lpfc: nvme: avoid hang / use-after-free when destroying localpo=
rt
      scsi: lpfc: nvmet: avoid hang / use-after-free when destroying target=
port

Fathi Boudra (1):
      selftests: seccomp: use LDLIBS instead of LDFLAGS

Geert Uytterhoeven (1):
      selftests: gpio-mockup-chardev: Check asprintf() for error

Greg Kroah-Hartman (1):
      Linux 4.19.27

Haiyang Zhang (3):
      hv_netvsc: Fix ethtool change hash key error
      hv_netvsc: Refactor assignments of struct netvsc_device_info
      hv_netvsc: Fix hash key value reset after other ops

Hannes Reinecke (1):
      nvme-multipath: drop optimization for static ANA group IDs

Jann Horn (1):
      mm: enforce min addr even if capable() in expand_downwards()

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attac=
hed

Jonas Gorski (1):
      MIPS: BCM63XX: provide DMA masks for ethernet devices

Jonathan Neusch=C3=A4fer (1):
      mmc: spi: Fix card detection during probe

Kenneth Feng (1):
      drm/amd/powerplay: OD setting fix on Vega10

Kristian H. Kristensen (1):
      drm/msm: Unblock writer if reader closes file

Liam Mark (1):
      staging: android: ion: Support cpu access during dma_buf_detach

Long Li (1):
      genirq/matrix: Improve target CPU selection for managed interrupts.

Lubomir Rintel (1):
      clk: sysfs: fix invalid JSON in clk_dump

Maciej =C5=BBenczykowski (1):
      net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP

Marek Vasut (1):
      clk: vc5: Abort clock configuration without upstream clock

Mathieu Malaterre (1):
      mac80211: Add attribute aligned(2) to struct 'action'

Matthias Kaehlcke (1):
      tty: serial: qcom_geni_serial: Allow mctrl when flow control is disab=
led

Michael Clark (1):
      MIPS: fix truncation in __cmpxchg_small for short values

Mike Kravetz (1):
      hugetlbfs: fix races and page leaks during migration

Nathan Chancellor (1):
      staging: rtl8723bs: Fix build error with Clang when inlining is disab=
led

Nicholas Kazlauskas (1):
      drm: Block fb changes for async plane updates

Paul Burton (1):
      MIPS: eBPF: Fix icache flush end address

Peng Hao (1):
      x86/mm/mem_encrypt: Fix erroneous sizeof()

Peter Zijlstra (2):
      sched/wake_q: Fix wakeup ordering for wake_q
      futex: Fix (possible) missed wakeup

Prateek Sood (1):
      sched/wait: Fix rcuwait_wake_up() ordering

Priit Laes (1):
      drm/sun4i: hdmi: Fix usage of TMDS clock

Rander Wang (1):
      ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Ritesh Harjani (1):
      mmc: core: Fix NULL ptr crash from mmc_should_fail_request

Sagi Grimberg (1):
      nvme-rdma: fix timeout handler

Sergei Shtylyov (1):
      mmc: tmio_mmc_core: don't claim spurious interrupts

Shuming Fan (1):
      ASoC: rt5682: Fix PLL source register definitions

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

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      mac80211: Change default tx_sk_pacing_shift to 7

Tomonori Sakita (1):
      serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampli=
ng

Varun Prakash (1):
      scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Vineet Gupta (1):
      ARC: show_regs: lockdep: avoid page allocator...

Vitaly Kuznetsov (1):
      KVM: nSVM: clear events pending from svm_complete_interrupts() when e=
xiting to L1

Xie Yongji (1):
      locking/rwsem: Fix (possible) missed wakeup

Yang Yingliang (1):
      irqchip/gic-v3-mbi: Fix uninitialized mbi_lock

Yizhuo (1):
      ASoC: Variable "val" in function rt274_i2c_probe() could be uninitial=
ized

Zeng Tao (1):
      usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

Zhang Run (1):
      net: usb: asix: ax88772_bind return error when hw_reset fail


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlx/ka4ACgkQONu9yGCS
aT7NPA/9FKT0uAMvcQNcOn4w1W+/myyRDw7bO0RjWDkUHT61aeswf0EUac8kt525
E5v/iTtWJ9Bc3Rlrzc0AshXGu+ZBNAxlI5Wefqe+fupEBZMv6WQxwMk7cB+k4Lm4
x1kXHn2+H1P8G/qy1OzgZTlSpOhfKqV9NzxRf2jxY2surd3bs8phoPDo132yd9Re
5NKDytBlmU6PbM7kDuWX9pdvNBDBEf32NR1yd5pn0rfUIc//AkZ747cS7pQLcWZG
UrDj+2lxE9HIoszIdriOOFbhXnAFwIn4tVBguF5xDjjCYycdhxvLyB3r/OLJWbsm
C0nQsw1k+Cw2m0t2iOxYeYH7E4hOYes2hDafRIj/uvI+veRG1+MSkSIT+3Bg6WM/
vlzW7vS8aV/Bo3qmNTLfQGCB3p0bNIX1p9QTX0LNwpLwASglo0BEaT5GZ9VBFiOt
te1sekYEfHhPmN2Wt2o4KxR8ml9/POfU8w+cZ52xPR7G/V4M0xUETXMCO3DIrwih
h5zIZy5q2JYbkRYy2HaOU7ENUgiUP1MDfEOPuP6QFx3xsKMfTpIR7xVxhn/6jvmQ
ViTar5yQa6+0PTRkW76qlOruWtYDPKdxolmvZkAAvbQ4qzmTLDdaaMJz798DLnR3
Cu/EjFuhOaLtfDAVe370AG12QgxofRhh0Z2/sNgUO0+yPvxCAK4=
=qlmW
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
