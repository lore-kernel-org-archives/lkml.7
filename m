Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF0CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5AF20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688848;
	bh=Or2NkjRHfl0KUZ53O7YVffuR0whyUcnOPYqcVNco/d4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SXJSMNyIVUf6Gg3stk/0eF+dAsv+Il2CtREV5XoPsQDSuJ8wAGZVq9FDUa2gM7UAZ
	 sbRDbkQsuoSOguBC7KWkq0uvfO3e5pf64+3u9QHAEVsJUsyJ+hEcaDa1VuvbtU1vnf
	 JmFyEOHeh6m3E1fRRrSTNP8VksBbt1S8aL/CpfDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfCDIkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfCDIcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AEC21019;
        Mon,  4 Mar 2019 08:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688350;
        bh=Or2NkjRHfl0KUZ53O7YVffuR0whyUcnOPYqcVNco/d4=;
        h=From:To:Cc:Subject:Date:From;
        b=sKHp+IwutuNdZup9+Kw3WAkivb5PyeqxukG5x7wUZC0S9xr+bqOgSMuFWIWa2/rqH
         +FS62bs4RZWAtYpK0Bx/7nFqbV1FOArRw+mTEeKq5QZpVcCE1M7s2wK6iwWPXpxljV
         Luwyo471N+f2S28iBDoX/vDwaBj1iszI5/tB22ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.20 00/88] 4.20.14-stable review
Date:   Mon,  4 Mar 2019 09:21:43 +0100
Message-Id: <20190304081630.610632175@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.14-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.20.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.20.14-rc1
X-KernelTest-Deadline: 2019-03-06T08:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.20.14 release.
There are 88 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar  6 08:16:03 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.14-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.20.14-rc1

Andy Lutomirski <luto@kernel.org>
    x86/uaccess: Don't leak the AC flag into __put_user() value evaluation

Paul Burton <paul.burton@mips.com>
    MIPS: eBPF: Fix icache flush end address

Marc Gonzalez <marc.w.gonzalez@free.fr>
    arm64: dts: qcom: msm8998: Extend TZ reserved memory area

Hannes Reinecke <hare@suse.de>
    scsi: aic94xx: fix calls to dma_set_mask_and_coherent()

Hannes Reinecke <hare@suse.de>
    scsi: 3w-9xxx: fix calls to dma_set_mask_and_coherent()

Hannes Reinecke <hare@suse.de>
    scsi: csiostor: fix calls to dma_set_mask_and_coherent()

Hannes Reinecke <hare@suse.de>
    scsi: 3w-sas: fix calls to dma_set_mask_and_coherent()

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    MIPS: fix memory setup for platforms with PHYS_OFFSET != 0

Jonas Gorski <jonas.gorski@gmail.com>
    MIPS: BCM63XX: provide DMA masks for ethernet devices

Michael Clark <michaeljclark@mac.com>
    MIPS: fix truncation in __cmpxchg_small for short values

Gilad Ben-Yossef <gilad@benyossef.com>
    crypto: ccree - add missing inline qualifier

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: fix races and page leaks during migration

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm: Block fb changes for async plane updates

Jann Horn <jannh@google.com>
    mm: enforce min addr even if capable() in expand_downwards()

BOUGH CHEN <haibo.chen@nxp.com>
    mmc: sdhci-esdhc-imx: correct the fix of ERR004536

Alamy Liu <alamy.liu@gmail.com>
    mmc: cqhci: Fix a tiny potential memory leak on error condition

Alamy Liu <alamy.liu@gmail.com>
    mmc: cqhci: fix space allocated for transfer descriptor

Ritesh Harjani <riteshh@codeaurora.org>
    mmc: core: Fix NULL ptr crash from mmc_should_fail_request

Takeshi Saito <takeshi.saito.xv@renesas.com>
    mmc: tmio: fix access width of Block Count Register

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    mmc: tmio_mmc_core: don't claim spurious interrupts

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    mmc: spi: Fix card detection during probe

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: selftests: check returned evmcs version range

Ben Gardon <bgardon@google.com>
    kvm: selftests: Fix region overlap check in kvm_util

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: nSVM: clear events pending from svm_complete_interrupts() when exiting to L1

Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
    svm: Fix AVIC incomplete IPI emulation

Chaitanya Tata <chaitanya.tata@bluwirelesstechnology.com>
    cfg80211: extend range deviation for DMG

Mathieu Malaterre <malat@debian.org>
    mac80211: Add attribute aligned(2) to struct 'action'

Balaji Pothunoori <bpothuno@codeaurora.org>
    mac80211: don't initiate TDLS connection if station is not associated to AP

Thomas Falcon <tlfalcon@linux.ibm.com>
    ibmveth: Do not process frames after calling napi_reschedule

Maciej Żenczykowski <maze@google.com>
    net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP

Zhang Run <zhang.run@zte.com.cn>
    net: usb: asix: ax88772_bind return error when hw_reset fail

Arnd Bergmann <arnd@arndb.de>
    drm/msm: avoid unused function warning

Douglas Anderson <dianders@chromium.org>
    drm/msm: Fix A6XX support for opp-level

Colin Ian King <colin.king@canonical.com>
    cifs: fix memory leak of an allocated cifs_ntsd structure

Hannes Reinecke <hare@suse.de>
    nvme-multipath: drop optimization for static ANA group IDs

Sagi Grimberg <sagi@grimberg.me>
    nvme-rdma: fix timeout handler

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix hash key value reset after other ops

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Refactor assignments of struct netvsc_device_info

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix ethtool change hash key error

Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
    net: altera_tse: fix connect_local_phy error path

Varun Prakash <varun@chelsio.com>
    scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Ewan D. Milne <emilne@redhat.com>
    scsi: lpfc: nvmet: avoid hang / use-after-free when destroying targetport

Ewan D. Milne <emilne@redhat.com>
    scsi: lpfc: nvme: avoid hang / use-after-free when destroying localport

Tejun Heo <tj@kernel.org>
    writeback: synchronize sync(2) against cgroup writeback membership switches

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    direct-io: allow direct writes to empty inodes

Liam Mark <lmark@codeaurora.org>
    staging: android: ion: Support cpu access during dma_buf_detach

Priit Laes <priit.laes@paf.com>
    drm/sun4i: hdmi: Fix usage of TMDS clock

Tomonori Sakita <tomonori.sakita@sord.co.jp>
    serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling

Matthias Kaehlcke <mka@chromium.org>
    tty: serial: qcom_geni_serial: Allow mctrl when flow control is disabled

Kenneth Feng <kenneth.feng@amd.com>
    drm/amd/powerplay: OD setting fix on Vega10

Xie Yongji <xieyongji@baidu.com>
    locking/rwsem: Fix (possible) missed wakeup

Peter Zijlstra <peterz@infradead.org>
    futex: Fix (possible) missed wakeup

Peter Zijlstra <peterz@infradead.org>
    sched/wake_q: Fix wakeup ordering for wake_q

Prateek Sood <prsood@codeaurora.org>
    sched/wait: Fix rcuwait_wake_up() ordering

Bob Copeland <me@bobcopeland.com>
    mac80211: fix miscounting of ttl-dropped frames

Nathan Chancellor <natechancellor@gmail.com>
    staging: rtl8723bs: Fix build error with Clang when inlining is disabled

Aaron Hill <aa1ronham@gmail.com>
    drivers: thermal: int340x_thermal: Fix sysfs race condition

Vineet Gupta <vgupta@synopsys.com>
    ARC: show_regs: lockdep: avoid page allocator...

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: fix __ffs return value to avoid build warnings

Yang Yingliang <yangyingliang@huawei.com>
    irqchip/gic-v3-mbi: Fix uninitialized mbi_lock

Geert Uytterhoeven <geert+renesas@glider.be>
    selftests: gpio-mockup-chardev: Check asprintf() for error

Fathi Boudra <fathi.boudra@linaro.org>
    selftests: seccomp: use LDLIBS instead of LDFLAGS

Alban Bedel <albeu@free.fr>
    phy: ath79-usb: Fix the main reset name to match the DT binding

Alban Bedel <albeu@free.fr>
    phy: ath79-usb: Fix the power on error path

Alison Schofield <alison.schofield@intel.com>
    selftests/vm/gup_benchmark.c: match gup struct to kernel

Silvio Cesare <silvio.cesare@gmail.com>
    ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Silvio Cesare <silvio.cesare@gmail.com>
    ASoC: dapm: change snprintf to scnprintf for possible overflow

Shuming Fan <shumingf@realtek.com>
    ASoC: rt5682: Fix PLL source register definitions

Peng Hao <peng.hao2@zte.com.cn>
    x86/mm/mem_encrypt: Fix erroneous sizeof()

Srinivas Ramana <sramana@codeaurora.org>
    genirq: Make sure the initial affinity is not empty

Alexandre Belloni <alexandre.belloni@bootlin.com>
    selftests: rtc: rtctest: add alarm test on minute boundary

Alexandre Belloni <alexandre.belloni@bootlin.com>
    selftests: rtc: rtctest: fix alarm tests

Mark Brown <broonie@kernel.org>
    ASoC: core: Make snd_soc_find_component() more robust

Kai-Heng Feng <kai.heng.feng@canonical.com>
    HID: i2c-hid: Disable runtime PM on Goodix touchpad

Dan Carpenter <dan.carpenter@oracle.com>
    usb: gadget: Potential NULL dereference on allocation error

Zeng Tao <prime.zeng@hisilicon.com>
    usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

Bo He <bo.he@intel.com>
    usb: dwc3: gadget: synchronize_irq dwc irq in suspend

Dan Carpenter <dan.carpenter@oracle.com>
    thermal: int340x_thermal: Fix a NULL vs IS_ERR() check

Marek Vasut <marek.vasut@gmail.com>
    clk: vc5: Abort clock configuration without upstream clock

Lubomir Rintel <lkundrak@v3.sk>
    clk: sysfs: fix invalid JSON in clk_dump

Dan Carpenter <dan.carpenter@oracle.com>
    clk: tegra: dfll: Fix a potential Oop in remove()

Yizhuo <yzhai003@ucr.edu>
    ASoC: Variable "val" in function rt274_i2c_probe() could be uninitialized

Shuming Fan <shumingf@realtek.com>
    ASoC: rt5682: Fix recording no sound issue

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: compress: prevent potential divide by zero bugs

Rander Wang <rander.wang@linux.intel.com>
    ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Kristian H. Kristensen <hoegsberg@gmail.com>
    drm/msm: Unblock writer if reader closes file

John Garry <john.garry@huawei.com>
    scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached

Long Li <longli@microsoft.com>
    genirq/matrix: Improve target CPU selection for managed interrupts.


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/include/asm/bitops.h                      |   6 +-
 arch/arc/kernel/troubleshoot.c                     |  26 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |   2 +-
 arch/mips/bcm63xx/dev-enet.c                       |   8 ++
 arch/mips/kernel/cmpxchg.c                         |   3 +-
 arch/mips/kernel/setup.c                           |   3 +-
 arch/mips/net/ebpf_jit.c                           |   2 +-
 arch/x86/include/asm/uaccess.h                     |   7 +-
 arch/x86/kvm/svm.c                                 |  27 ++--
 arch/x86/mm/mem_encrypt_identity.c                 |   4 +-
 drivers/clk/clk-versaclock5.c                      |   4 +-
 drivers/clk/clk.c                                  |   2 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |   4 +-
 drivers/crypto/ccree/cc_pm.h                       |   2 +-
 .../amd/powerplay/hwmgr/vega10_processpptables.c   |  22 +++-
 drivers/gpu/drm/drm_atomic_helper.c                |   9 ++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  26 ++--
 drivers/gpu/drm/msm/msm_rd.c                       |   7 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   4 +
 drivers/hid/hid-ids.h                              |   3 +
 drivers/hid/i2c-hid/i2c-hid-core.c                 |   2 +
 drivers/irqchip/irq-gic-v3-mbi.c                   |   2 +-
 drivers/mmc/core/core.c                            |   2 +-
 drivers/mmc/host/cqhci.c                           |  13 +-
 drivers/mmc/host/mmc_spi.c                         |   1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   9 +-
 drivers/mmc/host/tmio_mmc.h                        |   5 +
 drivers/mmc/host/tmio_mmc_core.c                   |  17 ++-
 drivers/net/ethernet/altera/altera_tse_main.c      |   4 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |   2 -
 drivers/net/hyperv/hyperv_net.h                    |  10 +-
 drivers/net/hyperv/netvsc.c                        |   2 +-
 drivers/net/hyperv/netvsc_drv.c                    | 139 +++++++++++++--------
 drivers/net/hyperv/rndis_filter.c                  |  34 +++--
 drivers/net/usb/asix_devices.c                     |   9 +-
 drivers/nvme/host/multipath.c                      |   3 +-
 drivers/nvme/host/rdma.c                           |  26 ++--
 drivers/phy/qualcomm/phy-ath79-usb.c               |   4 +-
 drivers/scsi/3w-9xxx.c                             |  14 ++-
 drivers/scsi/3w-sas.c                              |  12 +-
 drivers/scsi/aic94xx/aic94xx_init.c                |   8 +-
 drivers/scsi/csiostor/csio_attr.c                  |   2 +-
 drivers/scsi/csiostor/csio_init.c                  |   7 +-
 drivers/scsi/libsas/sas_expander.c                 |   2 +
 drivers/scsi/lpfc/lpfc_nvme.c                      |  16 +--
 drivers/scsi/lpfc/lpfc_nvme.h                      |   2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |   8 +-
 drivers/scsi/lpfc/lpfc_nvmet.h                     |   2 +-
 drivers/staging/android/ion/ion.c                  |   2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h      |   6 +-
 .../int340x_thermal/processor_thermal_device.c     |  30 ++---
 drivers/tty/serial/fsl_lpuart.c                    |   2 +-
 drivers/tty/serial/qcom_geni_serial.c              |   4 +-
 drivers/usb/dwc3/gadget.c                          |   3 +
 drivers/usb/gadget/function/f_sourcesink.c         |   2 +-
 fs/cifs/smb2pdu.c                                  |   8 ++
 fs/direct-io.c                                     |   5 +-
 fs/fs-writeback.c                                  |  40 +++++-
 fs/hugetlbfs/inode.c                               |  12 ++
 include/linux/backing-dev-defs.h                   |   1 +
 include/linux/if_arp.h                             |   1 +
 kernel/exit.c                                      |   2 +-
 kernel/futex.c                                     |  13 +-
 kernel/irq/manage.c                                |   3 +
 kernel/irq/matrix.c                                |  34 ++++-
 kernel/locking/rwsem-xadd.c                        |  11 +-
 kernel/sched/core.c                                |   7 +-
 mm/backing-dev.c                                   |   1 +
 mm/hugetlb.c                                       |  16 ++-
 mm/migrate.c                                       |  11 ++
 mm/mmap.c                                          |   7 +-
 net/mac80211/cfg.c                                 |   4 +
 net/mac80211/rx.c                                  |   6 +-
 net/wireless/reg.c                                 |   4 +-
 sound/core/compress_offload.c                      |   3 +-
 sound/soc/codecs/rt274.c                           |   5 +-
 sound/soc/codecs/rt5682.c                          |   1 +
 sound/soc/codecs/rt5682.h                          |  24 ++--
 sound/soc/fsl/imx-audmux.c                         |  24 ++--
 sound/soc/intel/boards/broadwell.c                 |   2 +-
 sound/soc/intel/boards/haswell.c                   |   2 +-
 sound/soc/soc-core.c                               |   2 +-
 sound/soc/soc-dapm.c                               |  10 +-
 tools/testing/selftests/gpio/gpio-mockup-chardev.c |   9 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |   9 +-
 tools/testing/selftests/kvm/x86_64/evmcs_test.c    |   6 +
 tools/testing/selftests/rtc/rtctest.c              | 109 +++++++++++++++-
 tools/testing/selftests/seccomp/Makefile           |   2 +-
 tools/testing/selftests/vm/gup_benchmark.c         |   1 +
 92 files changed, 694 insertions(+), 285 deletions(-)


