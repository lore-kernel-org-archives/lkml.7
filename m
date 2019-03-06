Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE9C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973BB2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551864304;
	bh=xye9EOhf3xiPhC8XQKbzqSvt282z+RSWMRStDDGxZVI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wNEiqQrbrTZ0RgMa8eI8S3pnBe8CxFVTV1Ly33NT5q9iYh/a4SxU4N+kbu27fxtfj
	 By4C339C80SjvDbsJwBKd18W3I6m7eXe72ghWXJTryDlS9bQoOqURY2Vb+eT+vqLWO
	 1VcKJngbrlCagqftNK4Wr5n3+b+eGTq7YHQg7hsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfCFJZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:25:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbfCFJZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:25:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA3720828;
        Wed,  6 Mar 2019 09:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551864301;
        bh=xye9EOhf3xiPhC8XQKbzqSvt282z+RSWMRStDDGxZVI=;
        h=Date:From:To:Cc:Subject:From;
        b=xBi44h+vWVRCE58xbLkiXvYviR65apbXrq6UJcu7RAzsTP4YfRXtMKeVu5lCq1znx
         yTXmQpwJj9NudxwfhGb58AYnPDlbatU4Phu2dFDMA6x7Fpz6AvBIeLgvySBooK+S1U
         tTSwv9vpX0jFEv8Ys3nHFSAdX5k3YdWSN8OGz2vc=
Date:   Wed, 6 Mar 2019 10:24:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.14
Message-ID: <20190306092459.GA29636@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.14 kernel.

All users of the 4.20 kernel series must upgrade.

The updated 4.20.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.20.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                     |    2=20
 arch/arc/include/asm/bitops.h                                |    6=20
 arch/arc/kernel/troubleshoot.c                               |   26 --
 arch/arm64/boot/dts/qcom/msm8998.dtsi                        |    2=20
 arch/mips/bcm63xx/dev-enet.c                                 |    8=20
 arch/mips/kernel/cmpxchg.c                                   |    3=20
 arch/mips/kernel/setup.c                                     |    3=20
 arch/mips/net/ebpf_jit.c                                     |    2=20
 arch/x86/include/asm/uaccess.h                               |    7=20
 arch/x86/kvm/svm.c                                           |   27 --
 arch/x86/mm/mem_encrypt_identity.c                           |    4=20
 drivers/clk/clk-versaclock5.c                                |    4=20
 drivers/clk/clk.c                                            |    2=20
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c                   |    4=20
 drivers/crypto/ccree/cc_pm.h                                 |    2=20
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c |   22 +
 drivers/gpu/drm/drm_atomic_helper.c                          |    9=20
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                        |    2=20
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                    |   26 +-
 drivers/gpu/drm/msm/msm_rd.c                                 |    7=20
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                       |    4=20
 drivers/hid/hid-ids.h                                        |    3=20
 drivers/hid/i2c-hid/i2c-hid-core.c                           |    2=20
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
 drivers/scsi/3w-9xxx.c                                       |   14 -
 drivers/scsi/3w-sas.c                                        |   12=20
 drivers/scsi/aic94xx/aic94xx_init.c                          |    8=20
 drivers/scsi/csiostor/csio_attr.c                            |    2=20
 drivers/scsi/csiostor/csio_init.c                            |    7=20
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
 fs/cifs/smb2pdu.c                                            |    8=20
 fs/direct-io.c                                               |    5=20
 fs/fs-writeback.c                                            |   40 +++
 fs/hugetlbfs/inode.c                                         |   12=20
 include/linux/backing-dev-defs.h                             |    1=20
 include/linux/if_arp.h                                       |    1=20
 kernel/exit.c                                                |    2=20
 kernel/futex.c                                               |   13 -
 kernel/irq/manage.c                                          |    3=20
 kernel/irq/matrix.c                                          |   34 ++
 kernel/locking/rwsem-xadd.c                                  |   11=20
 kernel/sched/core.c                                          |    7=20
 mm/backing-dev.c                                             |    1=20
 mm/hugetlb.c                                                 |   16 +
 mm/migrate.c                                                 |   11=20
 mm/mmap.c                                                    |    7=20
 net/mac80211/cfg.c                                           |    4=20
 net/mac80211/rx.c                                            |    6=20
 net/wireless/reg.c                                           |    4=20
 sound/core/compress_offload.c                                |    3=20
 sound/soc/codecs/rt274.c                                     |    5=20
 sound/soc/codecs/rt5682.c                                    |    1=20
 sound/soc/codecs/rt5682.h                                    |   24 -
 sound/soc/fsl/imx-audmux.c                                   |   24 -
 sound/soc/intel/boards/broadwell.c                           |    2=20
 sound/soc/intel/boards/haswell.c                             |    2=20
 sound/soc/soc-core.c                                         |    2=20
 sound/soc/soc-dapm.c                                         |   10=20
 tools/testing/selftests/gpio/gpio-mockup-chardev.c           |    9=20
 tools/testing/selftests/kvm/lib/kvm_util.c                   |    9=20
 tools/testing/selftests/kvm/x86_64/evmcs_test.c              |    6=20
 tools/testing/selftests/rtc/rtctest.c                        |  109 ++++++=
++
 tools/testing/selftests/seccomp/Makefile                     |    2=20
 tools/testing/selftests/vm/gup_benchmark.c                   |    1=20
 92 files changed, 693 insertions(+), 284 deletions(-)

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

Arnd Bergmann (1):
      drm/msm: avoid unused function warning

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

Colin Ian King (1):
      cifs: fix memory leak of an allocated cifs_ntsd structure

Dan Carpenter (4):
      ALSA: compress: prevent potential divide by zero bugs
      clk: tegra: dfll: Fix a potential Oop in remove()
      thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
      usb: gadget: Potential NULL dereference on allocation error

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

Gilad Ben-Yossef (1):
      crypto: ccree - add missing inline qualifier

Greg Kroah-Hartman (1):
      Linux 4.20.14

Haiyang Zhang (3):
      hv_netvsc: Fix ethtool change hash key error
      hv_netvsc: Refactor assignments of struct netvsc_device_info
      hv_netvsc: Fix hash key value reset after other ops

Hannes Reinecke (5):
      nvme-multipath: drop optimization for static ANA group IDs
      scsi: 3w-sas: fix calls to dma_set_mask_and_coherent()
      scsi: csiostor: fix calls to dma_set_mask_and_coherent()
      scsi: 3w-9xxx: fix calls to dma_set_mask_and_coherent()
      scsi: aic94xx: fix calls to dma_set_mask_and_coherent()

Jann Horn (1):
      mm: enforce min addr even if capable() in expand_downwards()

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attac=
hed

Jonas Gorski (1):
      MIPS: BCM63XX: provide DMA masks for ethernet devices

Jonathan Neusch=C3=A4fer (1):
      mmc: spi: Fix card detection during probe

Kai-Heng Feng (1):
      HID: i2c-hid: Disable runtime PM on Goodix touchpad

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

Marc Gonzalez (1):
      arm64: dts: qcom: msm8998: Extend TZ reserved memory area

Marek Vasut (1):
      clk: vc5: Abort clock configuration without upstream clock

Mark Brown (1):
      ASoC: core: Make snd_soc_find_component() more robust

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

Shuming Fan (2):
      ASoC: rt5682: Fix recording no sound issue
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

Thomas Bogendoerfer (1):
      MIPS: fix memory setup for platforms with PHYS_OFFSET !=3D 0

Thomas Falcon (1):
      ibmveth: Do not process frames after calling napi_reschedule

Tomonori Sakita (1):
      serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampli=
ng

Varun Prakash (1):
      scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Vineet Gupta (1):
      ARC: show_regs: lockdep: avoid page allocator...

Vitaly Kuznetsov (2):
      KVM: nSVM: clear events pending from svm_complete_interrupts() when e=
xiting to L1
      KVM: selftests: check returned evmcs version range

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


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlx/keoACgkQONu9yGCS
aT7EPBAAjnXkJ8rlxULMR+fCdPy9ERKCLX7sb3ruqrrRSdLPuihfhlZDd9LQ+H72
tDzgvjEuU9+Mrh5G7IDwNeO4yGUkxZUJzq1u7GwYtFTuVVilunDwqxt+lczAzxBv
UZwbYW5CLDvC98k+6YCqUo1rH38juvmRGT7XCDu9hZ8upKjGnTn65zpUhNNRKryP
u5gqyW4OEaPYgaN3YsVU5nhH4zfXAjd9g4yCJmSJixuPJxbRIf4m5KE0PHR+tK/u
L574/KAvTqEMhKcMZI4q3qUDzZ8BN5LdI5nmV8DayMlO4DgvzGOo19iCUqU7IMG0
SAvYjpnu8MB8koYQ5MdsR7HH9035VAirAI+wSQ1vrogZ5P7b6m8wpXBRKAmPCHsu
F0aN3qW4wrlTQK5RbmfmGHSG5oVZMdoDdcaEAfmNG3VgdsoWWvQY6hO9vctokedZ
YfyfAMHxmps+f0Ikcmy+HJf9GGgerjG6Uft0ruj+o9+IrpNJayMOax1EBn754Z+d
EYEiN2MoY19wKiz9LuG+IwwjBLoeBx7ucEtEBzAxdXqbZbh1PAUY5i21tCWsbwGA
FB+R8ORMcOa2wSxWcIBm5tdWaSYohLxqi4MvXhpRXm2D0z3XbYAFoBaz20t3OGxo
OAcfJcPb483sbo3DTN97MphY43E8H2vmZenRBqgSCX6t8JiZ5uM=
=sdpQ
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
