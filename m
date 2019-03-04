Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE3AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0B2208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687874;
	bh=zIyd05UpyJiRbzeXYgJDV/7vgkZC3nNArcJPcucvoOQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yYaA9x6lpGdefK1EHWOqSZxhpDsLUDRTEnwxJ/JlbjR3ToIYk6fsVTQQ2h5BPXlmk
	 i2ky506r4tC5SXKu1sSgN1H5FEuQLe8ZNYcG7n6vNuDdiDMrtYUNXew/1qxyoSe7oj
	 oYqdeAIbVD/SbWeWxm582mNAXcn2t9Jnarb9g/Kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbfCDIYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfCDIYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:24:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C78520863;
        Mon,  4 Mar 2019 08:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687868;
        bh=zIyd05UpyJiRbzeXYgJDV/7vgkZC3nNArcJPcucvoOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Epvtercd0wukyeBprNOgKPOVvf24mrq4lYqFiPAawhj+9YeWV+CXr6IgZ0EGTkoM3
         BMBuPFnow2Dc8IgaaWW81Jf+QstmOSJlXkqlQ4RKYIAf6oDi1ClFecBPKs77RcKGM2
         zllLpTZXbqrX49luCrcQkQ6YvRbITGkyDjCDu7j4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/52] 4.14.105-stable review
Date:   Mon,  4 Mar 2019 09:21:58 +0100
Message-Id: <20190304081617.159014799@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.105-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.105-rc1
X-KernelTest-Deadline: 2019-03-06T08:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.105 release.
There are 52 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar  6 08:15:55 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.105-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.105-rc1

Andy Lutomirski <luto@kernel.org>
    x86/uaccess: Don't leak the AC flag into __put_user() value evaluation

Paul Burton <paul.burton@mips.com>
    MIPS: eBPF: Fix icache flush end address

Michael Clark <michaeljclark@mac.com>
    MIPS: fix truncation in __cmpxchg_small for short values

Jann Horn <jannh@google.com>
    mm: enforce min addr even if capable() in expand_downwards()

BOUGH CHEN <haibo.chen@nxp.com>
    mmc: sdhci-esdhc-imx: correct the fix of ERR004536

Takeshi Saito <takeshi.saito.xv@renesas.com>
    mmc: tmio: fix access width of Block Count Register

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    mmc: tmio_mmc_core: don't claim spurious interrupts

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    mmc: spi: Fix card detection during probe

Seth Forshee <seth.forshee@canonical.com>
    powerpc: Always initialize input array when calling epapr_hypercall()

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

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix ethtool change hash key error

Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
    net: altera_tse: fix connect_local_phy error path

Varun Prakash <varun@chelsio.com>
    scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Tejun Heo <tj@kernel.org>
    writeback: synchronize sync(2) against cgroup writeback membership switches

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    direct-io: allow direct writes to empty inodes

Liam Mark <lmark@codeaurora.org>
    staging: android: ion: Support cpu access during dma_buf_detach

Tomonori Sakita <tomonori.sakita@sord.co.jp>
    serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling

Kenneth Feng <kenneth.feng@amd.com>
    drm/amd/powerplay: OD setting fix on Vega10

Xie Yongji <xieyongji@baidu.com>
    locking/rwsem: Fix (possible) missed wakeup

Peter Zijlstra <peterz@infradead.org>
    futex: Fix (possible) missed wakeup

Prateek Sood <prsood@codeaurora.org>
    sched/wait: Fix rcuwait_wake_up() ordering

Bob Copeland <me@bobcopeland.com>
    mac80211: fix miscounting of ttl-dropped frames

Nathan Chancellor <natechancellor@gmail.com>
    staging: rtl8723bs: Fix build error with Clang when inlining is disabled

Aaron Hill <aa1ronham@gmail.com>
    drivers: thermal: int340x_thermal: Fix sysfs race condition

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: fix __ffs return value to avoid build warnings

Geert Uytterhoeven <geert+renesas@glider.be>
    selftests: gpio-mockup-chardev: Check asprintf() for error

Fathi Boudra <fathi.boudra@linaro.org>
    selftests: seccomp: use LDLIBS instead of LDFLAGS

Silvio Cesare <silvio.cesare@gmail.com>
    ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Silvio Cesare <silvio.cesare@gmail.com>
    ASoC: dapm: change snprintf to scnprintf for possible overflow

Srinivas Ramana <sramana@codeaurora.org>
    genirq: Make sure the initial affinity is not empty

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

Yizhuo <yzhai003@ucr.edu>
    ASoC: Variable "val" in function rt274_i2c_probe() could be uninitialized

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: compress: prevent potential divide by zero bugs

Rander Wang <rander.wang@linux.intel.com>
    ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Kristian H. Kristensen <hoegsberg@gmail.com>
    drm/msm: Unblock writer if reader closes file

John Garry <john.garry@huawei.com>
    scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached

Jose Abreu <Jose.Abreu@synopsys.com>
    net: stmmac: Disable ACS Feature for GMAC >= 4

Florian Fainelli <f.fainelli@gmail.com>
    net: stmmac: Fix reception of Broadcom switches tags

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "loop: Fold __loop_release into loop_release"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "loop: Get rid of loop_index_mutex"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()"


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arc/include/asm/bitops.h                      |  6 +--
 arch/mips/kernel/cmpxchg.c                         |  3 +-
 arch/mips/net/ebpf_jit.c                           |  2 +-
 arch/powerpc/include/asm/epapr_hcalls.h            | 12 +++---
 arch/x86/include/asm/uaccess.h                     |  7 ++--
 arch/x86/kvm/svm.c                                 | 27 ++++++-------
 drivers/block/loop.c                               | 47 ++++++++++++----------
 drivers/clk/clk-versaclock5.c                      |  4 +-
 .../amd/powerplay/hwmgr/vega10_processpptables.c   | 22 +++++++++-
 drivers/gpu/drm/msm/msm_rd.c                       |  7 +++-
 drivers/mmc/host/mmc_spi.c                         |  1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  9 +++--
 drivers/mmc/host/tmio_mmc.h                        |  5 +++
 drivers/mmc/host/tmio_mmc_core.c                   | 17 +++++---
 drivers/net/ethernet/altera/altera_tse_main.c      |  4 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |  2 -
 drivers/net/ethernet/stmicro/stmmac/common.h       |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  3 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   | 12 +++++-
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    | 15 ++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  5 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  9 ++++-
 drivers/net/hyperv/rndis_filter.c                  | 25 +++++++++---
 drivers/net/usb/asix_devices.c                     |  9 ++++-
 drivers/scsi/csiostor/csio_attr.c                  |  2 +-
 drivers/scsi/libsas/sas_expander.c                 |  2 +
 drivers/staging/android/ion/ion.c                  |  2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h      |  6 +--
 .../int340x_thermal/processor_thermal_device.c     | 30 +++++++-------
 drivers/tty/serial/fsl_lpuart.c                    |  2 +-
 drivers/usb/dwc3/gadget.c                          |  3 ++
 drivers/usb/gadget/function/f_sourcesink.c         |  2 +-
 fs/direct-io.c                                     |  5 ++-
 fs/fs-writeback.c                                  | 40 +++++++++++++++++-
 include/linux/backing-dev-defs.h                   |  1 +
 include/linux/if_arp.h                             |  1 +
 kernel/exit.c                                      |  2 +-
 kernel/futex.c                                     | 13 +++---
 kernel/irq/manage.c                                |  3 ++
 kernel/locking/rwsem-xadd.c                        | 11 ++++-
 mm/backing-dev.c                                   |  1 +
 mm/mmap.c                                          |  7 ++--
 net/mac80211/cfg.c                                 |  4 ++
 net/mac80211/rx.c                                  |  6 ++-
 net/wireless/reg.c                                 |  4 +-
 sound/core/compress_offload.c                      |  3 +-
 sound/soc/codecs/rt274.c                           |  5 ++-
 sound/soc/fsl/imx-audmux.c                         | 24 +++++------
 sound/soc/intel/boards/broadwell.c                 |  2 +-
 sound/soc/intel/boards/haswell.c                   |  2 +-
 sound/soc/soc-dapm.c                               | 10 ++---
 tools/testing/selftests/gpio/gpio-mockup-chardev.c |  9 +++--
 tools/testing/selftests/seccomp/Makefile           |  2 +-
 56 files changed, 314 insertions(+), 152 deletions(-)


