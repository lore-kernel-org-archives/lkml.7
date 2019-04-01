Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AE621473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139776;
	bh=2I9uDZhXz+7rv1z9emCXziEpgygA/eUa0gwQ3pmsg1w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sZDHXVA6nVB/p/J+PRNJDH+jrEg08LIOTsHcQtoXXu068rPAUQ8pxwhKcU3W3yL0/
	 Aj6jJ0tpI61OHZEPkNqOdcJmVLKeqAOYXvqqb9tYkJk843GRBvthldphYtUDPAjiF+
	 /4njtqx791B1lT0k3e4cwuiFefsMbvSqSaKhlE20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbfDAR3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732938AbfDAR3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D4720880;
        Mon,  1 Apr 2019 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139771;
        bh=2I9uDZhXz+7rv1z9emCXziEpgygA/eUa0gwQ3pmsg1w=;
        h=From:To:Cc:Subject:Date:From;
        b=C/HLnDQ0pHluTn/GivI9sCRzCL25B3FkZXdCtwKAE6l+l8pV3HLtl7NHMtVJcAb7i
         Z8fhuBemqGA/AfYx1oVB3OXPB3HOFkGKcQO0Uxh6tHgdhSzcW/Iv+6MopsvkzeB/ve
         uxfdpM0gxVMvkrtM4PRtcY2JrZvvu9mtOc2oJvlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/131] 4.4.178-stable review
Date:   Mon,  1 Apr 2019 19:01:10 +0200
Message-Id: <20190401170051.645954551@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.178-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.178-rc1
X-KernelTest-Deadline: 2019-04-03T17:01+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.178 release.
There are 131 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Apr  3 16:59:39 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.178-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.178-rc1

Geert Uytterhoeven <geert@linux-m68k.org>
    stm class: Hide STM-specific options if STM is disabled

Mathieu Poirier <mathieu.poirier@linaro.org>
    coresight: removing bind/unbind options from sysfs

Eric Biggers <ebiggers@google.com>
    arm64: support keyctl() system call in 32-bit mode

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "USB: core: only clean up what we allocated"

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix port resume done detection for SS ports with LPM enabled

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: Reject device ioctls from processes other than the VM's creator

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix TSC slip

Axel Lin <axel.lin@ingics.com>
    gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

YueHaibing <yuehaibing@huawei.com>
    fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Wentao Wang <witallwang@gmail.com>
    Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc

Bjørn Mork <bjorn@mork.no>
    USB: serial: option: add Olicard 600

Mans Rullgard <mans@mansr.com>
    USB: serial: option: set driver_info for SIM5218 and compatibles

Lin Yi <teroincn@163.com>
    USB: serial: mos7720: fix mos_parport refcount imbalance on error path

George McCollister <george.mccollister@gmail.com>
    USB: serial: ftdi_sio: add additional NovaTech products

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: cp210x: add new device id

Hoan Nguyen An <na-hoan@jinso.co.jp>
    serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Aditya Pakki <pakki001@umn.edu>
    serial: max310x: Fix to avoid potential NULL pointer dereference

Malcolm Priestley <tvboxspy@gmail.com>
    staging: vt6655: Fix interrupt race condition on device start up.

Malcolm Priestley <tvboxspy@gmail.com>
    staging: vt6655: Remove vif check from vnt_interrupt

Kangjie Lu <kjlu@umn.edu>
    tty: atmel_serial: fix a potential NULL pointer dereference

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix scsi_eh host reset with port_forced ERP for non-NPIV FCP devices

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix rport unblock if deleted SCSI devices on Scsi_Host

Bart Van Assche <bvanassche@acm.org>
    scsi: sd: Fix a race between closing an sd device and sd I/O

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Don't suspend stream in unrecoverable PCM state

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix possible OOB access in PCM oss plugins

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: seq: oss: Fix Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: rawmidi: Fix potential Spectre v1 vulnerability

Ravindra Lokhande <rlokhande@nvidia.com>
    ALSA: compress: add support for 32bit calls in a 64bit kernel

Kohji Okuno <okuno.kohji@jp.panasonic.com>
    ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected time

Andrea Righi <andrea.righi@canonical.com>
    btrfs: raid56: properly unmap parity page in finish_parity_scrub()

Josef Bacik <josef@toxicpanda.com>
    btrfs: remove WARN_ON in log_dir_items

Finn Thain <fthain@telegraphics.com.au>
    mac8390: Fix mmio access size probe

Xin Long <lucien.xin@gmail.com>
    sctp: get sctphdr by offset in sctp_compute_cksum

Zhiqiang Liu <liuzhiqiang26@huawei.com>
    vxlan: Don't call gro_cells_destroy() before device is unregistered

Eric Dumazet <edumazet@google.com>
    tcp: do not use ipv6 header for ipv4 flow

Maxime Chevallier <maxime.chevallier@bootlin.com>
    packets: Always register packet sk in the same order

David S. Miller <davem@davemloft.net>
    Add hlist_add_tail_rcu() (Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net)

Eric Dumazet <edumazet@google.com>
    net: rose: fix a possible stack overflow

Christoph Paasch <cpaasch@apple.com>
    net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Bjorn Helgaas <bhelgaas@google.com>
    mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Eric Dumazet <edumazet@google.com>
    dccp: do not use ipv6 header for ipv4 flow

Bhadram Varka <vbhadram@nvidia.com>
    stmmac: copy unicast mac address to MAC registers

Johannes Berg <johannes.berg@intel.com>
    cfg80211: size various nl80211 messages correctly

Chaotian Jing <chaotian.jing@mediatek.com>
    mmc: mmc: fix switch timeout issue caused by jiffies precision

Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
    arm64: kconfig: drop CONFIG_RTC_LIB dependency

Christoffer Dall <christoffer.dall@linaro.org>
    video: fbdev: Set pixclock = 0 in goldfishfb

Lianwei Wang <lianwei.wang@gmail.com>
    cpu/hotplug: Handle unbalanced hotplug enable/disable

Xerox Lin <xerox_lin@htc.com>
    usb: gadget: rndis: free response queue during REMOTE_NDIS_RESET_MSG

Winter Wang <wente.wang@nxp.com>
    usb: gadget: configfs: add mutex lock before unregister gadget

Hannes Frederic Sowa <hannes@stressinduktion.org>
    ipv6: fix endianness error in icmpv6_err

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Fix stm device initialization order

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Do not leak the chrdev in error path

James Morse <james.morse@arm.com>
    PM / Hibernate: Call flush_icache_range() on pages restored in-place

James Morse <james.morse@arm.com>
    arm64: kernel: Include _AC definition in page.h

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    perf/ring_buffer: Refuse to begin AUX transaction after rb->aux_mmap_count drops

Jeff Mahoney <jeffm@suse.com>
    mac80211: fix "warning: ‘target_metric’ may be used uninitialized"

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64/kernel: fix incorrect EL0 check in inv_entry macro

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    ARM: 8510/1: rework ARM_CPU_SUSPEND dependencies

Greg Hackmann <ghackmann@google.com>
    staging: goldfish: audio: fix compiliation on arm

Rajmal Menariya <rajmal.menariya@spreadtrum.com>
    staging: ion: Set minimum carveout heap allocation order to PAGE_SHIFT

Rom Lemarchand <romlem@android.com>
    staging: ashmem: Add missing include

Laura Abbott <lauraa@codeaurora.org>
    staging: ashmem: Avoid deadlock with mmap/shrink

Mark Rutland <mark.rutland@arm.com>
    asm-generic: Fix local variable shadow in __set_fixmap_offset

Eric Long <eric.long@linaro.org>
    coresight: etm4x: Check every parameter used by dma_xx_coherent.

Eric Long <eric.long@linaro.org>
    coresight: "DEVICE_ATTR_RO" should defined as static.

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Fix a race in unlinking

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Fix unbalanced module/device refcounting

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Guard output assignment against concurrency

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Fix unlocking braino in the error path

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Support devices with multiple instances

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Prevent user-controllable allocations

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Fix link list locking

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Fix locking in unbinding policy path

Mathieu Poirier <mathieu.poirier@linaro.org>
    coresight: remove csdev's link from topology

Mathieu Poirier <mathieu.poirier@linaro.org>
    coresight: release reference taken by 'bus_find_device()'

Mathieu Poirier <mathieu.poirier@linaro.org>
    coresight: coresight_unregister() function cleanup

Mathieu Poirier <mathieu.poirier@linaro.org>
    coresight: fixing lockdep error

Tahsin Erdogan <tahsin@google.com>
    writeback: initialize inode members that track writeback history

Ulf Hansson <ulf.hansson@linaro.org>
    Revert "mmc: block: don't use parameter prefix if built as module"

Eric Dumazet <edumazet@google.com>
    net: diag: support v4mapped sockets in inet_diag_find_one_icsk()

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    perf: Synchronously free aux pages in case of allocation failure

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: hide __efistub_ aliases from kallsyms

Nicolas Pitre <nicolas.pitre@linaro.org>
    hid-sensor-hub.c: fix wrong do_div() usage

Christoph Lameter <cl@linux.com>
    vmstat: make vmstat_updater deferrable again and shut down on idle

Dmitry Torokhov <dtor@chromium.org>
    android: unconditionally remove callbacks in sync_fence_free()

Jungseung Lee <js07.lee@samsung.com>
    ARM: 8494/1: mm: Enable PXN when running non-LPAE kernel on LPAE processor

Arnd Bergmann <arnd@arndb.de>
    ARM: 8458/1: bL_switcher: add GIC dependency

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi: stub: define DISABLE_BRANCH_PROFILING for all architectures

Yury Norov <ynorov@caviumnetworks.com>
    arm64: fix COMPAT_SHMLBA definition for large pages

Colin Cross <ccross@android.com>
    mmc: block: Allow more than 8 partitions per card

Yuyang Du <yuyang.du@intel.com>
    sched/fair: Fix new task's load avg removed from source CPU in wake_up_new_task()

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt

Arnd Bergmann <arnd@arndb.de>
    ath10k: avoid possible string overflow

Baolin Wang <baolin.wang@linaro.org>
    rtc: Fix overflow when converting time64_t to rtc_time

Andrey Konovalov <andreyknvl@google.com>
    USB: core: only clean up what we allocated

Peter Zijlstra <peterz@infradead.org>
    lib/int_sqrt: optimize small argument

Lanqing Liu <lanqing.liu@spreadtrum.com>
    serial: sprd: clear timeout interrupt only rather than all interrupts

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: renesas_usbhs: gadget: fix unused-but-set-variable warning

Qiao Zhou <qiaozhou@asrmicro.com>
    arm64: traps: disable irq in die()

Al Viro <viro@ZenIV.linux.org.uk>
    Hang/soft lockup in d_invalidate with simultaneous calls

Wei Qiao <wei.qiao@spreadtrum.com>
    serial: sprd: adjust TIMEOUT to a big value

Eric Dumazet <edumazet@google.com>
    tcp/dccp: drop SYN packets if accept queue is full

Baolin Wang <baolin.wang@linaro.org>
    usb: gadget: Add the gserial port checking in gs_start_tx()

Peter Chen <peter.chen@nxp.com>
    usb: gadget: composite: fix dereference after null check coverify warning

Wolfram Sang <wsa@the-dreams.de>
    kbuild: setlocalversion: print error to STDERR

Roger Quadros <rogerq@ti.com>
    extcon: usb-gpio: Don't miss event during suspend/resume

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    mm/rmap: replace BUG_ON(anon_vma->degree) with VM_WARN_ON

Dong Aisheng <aisheng.dong@nxp.com>
    mmc: core: fix using wrong io voltage if mmc_select_hs200 fails

James Morse <james.morse@arm.com>
    arm64: mm: Add trace_irqflags annotations to do_debug_exception()

Roger Quadros <rogerq@ti.com>
    usb: dwc3: gadget: Fix suspend/resume during device mode

Russell King <rmk+kernel@arm.linux.org.uk>
    mmc: core: shut up "voltage-ranges unspecified" pr_info()

Wolfram Sang <wsa+renesas@sang-engineering.com>
    mmc: sanitize 'bus width' in debug output

Wolfram Sang <wsa+renesas@sang-engineering.com>
    mmc: make MAN_BKOPS_EN message a debug

Chuanxiao Dong <chuanxiao.dong@intel.com>
    mmc: debugfs: Add a restriction to mmc debugfs clock setting

Martin Fuzzey <mfuzzey@parkeon.com>
    mmc: pwrseq_simple: Make reset-gpios optional to match doc

Hui Wang <hui.wang@canonical.com>
    ALSA: hda - Enforces runtime_resume after S3 and S4 for each codec

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Record the current power state before suspend/resume calls

Waiman Long <longman@redhat.com>
    locking/lockdep: Add debug_locks check in __lock_downgrade()

Hans Verkuil <hverkuil@xs4all.nl>
    media: v4l2-ctrls.c/uvc: zero v4l2_event

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    mmc: tmio_mmc_core: don't claim spurious interrupts

zhangyi (F) <yi.zhang@huawei.com>
    ext4: brelse all indirect buffer in ext4_ind_remove_space()

Lukas Czerner <lczerner@redhat.com>
    ext4: fix data corruption caused by unaligned direct AIO

Jiufei Xue <jiufei.xue@linux.alibaba.com>
    ext4: fix NULL pointer dereference while journal is aborted

Chen Jie <chenjie6@huawei.com>
    futex: Ensure that futex address is aligned in handle_futex_death()

Archer Yan <ayan@wavecomp.com>
    MIPS: Fix kernel crash for R6 in jump label branch function

Yifeng Li <tomli@tomli.me>
    mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqaction.

Jan Kara <jack@suse.cz>
    udf: Fix crash on IO error during truncate

Thomas Zimmermann <tzimmermann@suse.de>
    drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Arnd Bergmann <arnd@arndb.de>
    mmc: pxamci: fix enum type confusion


-------------

Diffstat:

 Documentation/virtual/kvm/api.txt                  |  16 ++-
 Makefile                                           |   4 +-
 arch/arm/Kconfig                                   |   6 +-
 arch/arm/mach-imx/cpuidle-imx6q.c                  |  27 ++--
 arch/arm/mm/mmu.c                                  |   2 +-
 arch/arm64/Kconfig                                 |   5 +-
 arch/arm64/include/asm/page.h                      |   2 +
 arch/arm64/include/asm/shmparam.h                  |   2 +-
 arch/arm64/kernel/entry.S                          |   2 +-
 arch/arm64/kernel/image.h                          |  40 +++---
 arch/arm64/kernel/traps.c                          |   8 +-
 arch/arm64/mm/fault.c                              |  33 +++--
 arch/mips/include/asm/jump_label.h                 |   8 +-
 arch/mips/loongson64/lemote-2f/irq.c               |   2 +-
 arch/x86/Kconfig                                   |   8 +-
 drivers/extcon/extcon-usb-gpio.c                   |   3 +
 drivers/firmware/efi/libstub/Makefile              |   4 +-
 drivers/gpio/gpio-adnp.c                           |   6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |  12 +-
 drivers/hid/hid-sensor-hub.c                       |   3 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  11 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |  13 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  15 +--
 drivers/hwtracing/coresight/coresight-funnel.c     |  10 +-
 .../coresight/coresight-replicator-qcom.c          |  11 +-
 drivers/hwtracing/coresight/coresight-replicator.c |  16 +--
 drivers/hwtracing/coresight/coresight-tmc.c        |  19 +--
 drivers/hwtracing/coresight/coresight-tpiu.c       |  10 +-
 drivers/hwtracing/coresight/coresight.c            |  55 +++++++-
 drivers/hwtracing/coresight/of_coresight.c         |   2 +-
 drivers/hwtracing/stm/Kconfig                      |   4 +
 drivers/hwtracing/stm/core.c                       | 148 ++++++++++++++++-----
 drivers/hwtracing/stm/policy.c                     |  25 +++-
 drivers/hwtracing/stm/stm.h                        |   2 +
 drivers/isdn/hardware/mISDN/hfcmulti.c             |   3 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |   2 +-
 drivers/media/v4l2-core/v4l2-ctrls.c               |   2 +-
 drivers/mmc/card/block.c                           |  10 +-
 drivers/mmc/core/core.c                            |  10 +-
 drivers/mmc/core/debugfs.c                         |   2 +-
 drivers/mmc/core/mmc.c                             |  16 ++-
 drivers/mmc/core/mmc_ops.c                         |   2 +-
 drivers/mmc/core/pwrseq_simple.c                   |  22 +--
 drivers/mmc/host/pxamci.c                          |   2 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |   8 +-
 drivers/net/ethernet/8390/mac8390.c                |  19 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  16 ++-
 drivers/net/vxlan.c                                |   4 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   2 +-
 drivers/rtc/rtc-lib.c                              |   6 +-
 drivers/s390/scsi/zfcp_erp.c                       |  17 +++
 drivers/s390/scsi/zfcp_ext.h                       |   2 +
 drivers/s390/scsi/zfcp_scsi.c                      |   4 +
 drivers/scsi/sd.c                                  |  19 ++-
 drivers/staging/android/ashmem.c                   |   4 +-
 drivers/staging/android/ion/ion_carveout_heap.c    |   2 +-
 drivers/staging/android/sync.c                     |   6 +-
 drivers/staging/android/uapi/ashmem.h              |   1 +
 drivers/staging/goldfish/goldfish_audio.c          |   1 +
 drivers/staging/vt6655/device_main.c               |  11 +-
 drivers/tty/serial/atmel_serial.c                  |   4 +
 drivers/tty/serial/kgdboc.c                        |   4 +-
 drivers/tty/serial/max310x.c                       |   2 +
 drivers/tty/serial/sh-sci.c                        |  12 +-
 drivers/tty/serial/sprd_serial.c                   |   6 +-
 drivers/usb/dwc3/gadget.c                          |   6 +
 drivers/usb/gadget/composite.c                     |   2 +
 drivers/usb/gadget/configfs.c                      |   2 +
 drivers/usb/gadget/function/rndis.c                |   6 +
 drivers/usb/gadget/function/u_serial.c             |   7 +-
 drivers/usb/host/xhci-ring.c                       |   9 +-
 drivers/usb/host/xhci.h                            |   1 +
 drivers/usb/renesas_usbhs/mod_gadget.c             |   5 +-
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   4 +-
 drivers/usb/serial/mos7720.c                       |   4 +-
 drivers/usb/serial/option.c                        |  13 +-
 drivers/video/fbdev/goldfishfb.c                   |   2 +-
 fs/btrfs/raid56.c                                  |   3 +-
 fs/btrfs/tree-log.c                                |  11 +-
 fs/dcache.c                                        |  10 +-
 fs/ext4/ext4_jbd2.h                                |   2 +-
 fs/ext4/file.c                                     |   2 +-
 fs/ext4/indirect.c                                 |  12 +-
 fs/inode.c                                         |   6 +
 fs/proc/proc_sysctl.c                              |   3 +-
 fs/udf/truncate.c                                  |   3 +
 include/asm-generic/fixmap.h                       |  12 +-
 include/linux/rculist.h                            |  36 +++++
 include/linux/vmstat.h                             |   2 +
 include/net/inet_connection_sock.h                 |   5 -
 include/net/sctp/checksum.h                        |   2 +-
 include/net/sock.h                                 |   6 +
 kernel/cpu.c                                       |  11 +-
 kernel/events/ring_buffer.c                        |  47 ++++---
 kernel/futex.c                                     |   4 +
 kernel/locking/lockdep.c                           |   3 +
 kernel/power/swap.c                                |  18 +++
 kernel/sched/fair.c                                |  38 ++++--
 kernel/sched/idle.c                                |   1 +
 lib/int_sqrt.c                                     |   3 +
 mm/rmap.c                                          |   2 +-
 mm/vmstat.c                                        |  69 ++++++----
 net/bluetooth/l2cap_core.c                         |  83 +++++++-----
 net/dccp/ipv4.c                                    |   8 +-
 net/dccp/ipv6.c                                    |   6 +-
 net/ipv4/inet_diag.c                               |  21 ++-
 net/ipv4/tcp_input.c                               |   8 +-
 net/ipv6/icmp.c                                    |   2 +-
 net/ipv6/tcp_ipv6.c                                |   8 +-
 net/mac80211/mesh_hwmp.c                           |   2 +-
 net/packet/af_packet.c                             |   4 +-
 net/rose/rose_subr.c                               |  21 +--
 net/wireless/nl80211.c                             |  16 +--
 scripts/setlocalversion                            |   2 +-
 sound/core/compress_offload.c                      |  13 ++
 sound/core/oss/pcm_oss.c                           |  43 +++---
 sound/core/pcm_native.c                            |   9 +-
 sound/core/rawmidi.c                               |   2 +
 sound/core/seq/oss/seq_oss_synth.c                 |   7 +-
 sound/pci/hda/hda_codec.c                          |  57 +++++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  20 ++-
 virt/kvm/kvm_main.c                                |   3 +
 124 files changed, 935 insertions(+), 530 deletions(-)


