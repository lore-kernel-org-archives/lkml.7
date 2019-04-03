Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38283C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BEB2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554280878;
	bh=SV1WQ2OxBvdZVFDRT2GvfLT3f/mSI0Gq09A0IuUIJVo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=q3LtCXqxqszXrEYWoU4bP5rolM5vy6pRc2woNbDxM6hxqKy6GujH+N32IJqaMvxm9
	 twiraos3UDkXDltCDByoXhhTS8e+mI+RCtuzYoBtTUAJ9c0vAIozvba64LVDOU4z4V
	 sZ9e8bG/H94W4peazD5ik2Gpe6cXGXXItNq6GIxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfDCIlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDCIlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:41:15 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0704206B7;
        Wed,  3 Apr 2019 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554280874;
        bh=SV1WQ2OxBvdZVFDRT2GvfLT3f/mSI0Gq09A0IuUIJVo=;
        h=Date:From:To:Cc:Subject:From;
        b=hdwYLIYikKQbUrc8kvLmYSBTWn68X9yLGCJR/aPxsDFgAsbgBDfg/MYl8G30MWWIp
         BsrHiTvhEfXD7fNXkjtj0MjGJe+VMSbLzVtjJkc2lPFC/H2GMQDYqr6E2m30pBtlGx
         4ggS2EPBc0jTl2SKhzOcKATUT8erE6Pbp+P8T5ww=
Date:   Wed, 3 Apr 2019 10:40:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.178
Message-ID: <20190403084010.GA22553@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.4.178 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/virtual/kvm/api.txt                       |   16 +
 Makefile                                                |    2 
 arch/arm/Kconfig                                        |    6 
 arch/arm/mach-imx/cpuidle-imx6q.c                       |   27 +-
 arch/arm/mm/mmu.c                                       |    2 
 arch/arm64/Kconfig                                      |    5 
 arch/arm64/include/asm/page.h                           |    2 
 arch/arm64/include/asm/shmparam.h                       |    2 
 arch/arm64/kernel/entry.S                               |    2 
 arch/arm64/kernel/image.h                               |   40 ++--
 arch/arm64/kernel/traps.c                               |    8 
 arch/arm64/mm/fault.c                                   |   33 ++-
 arch/mips/include/asm/jump_label.h                      |    8 
 arch/mips/loongson64/lemote-2f/irq.c                    |    2 
 arch/x86/Kconfig                                        |    8 
 drivers/extcon/extcon-usb-gpio.c                        |    3 
 drivers/firmware/efi/libstub/Makefile                   |    4 
 drivers/gpio/gpio-adnp.c                                |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                      |   12 -
 drivers/hid/hid-sensor-hub.c                            |    3 
 drivers/hwtracing/coresight/coresight-etb10.c           |   11 -
 drivers/hwtracing/coresight/coresight-etm3x.c           |   13 -
 drivers/hwtracing/coresight/coresight-etm4x.c           |   15 -
 drivers/hwtracing/coresight/coresight-funnel.c          |   10 -
 drivers/hwtracing/coresight/coresight-replicator-qcom.c |   11 -
 drivers/hwtracing/coresight/coresight-replicator.c      |   16 -
 drivers/hwtracing/coresight/coresight-tmc.c             |   19 --
 drivers/hwtracing/coresight/coresight-tpiu.c            |   10 -
 drivers/hwtracing/coresight/coresight.c                 |   55 +++++
 drivers/hwtracing/coresight/of_coresight.c              |    2 
 drivers/hwtracing/stm/Kconfig                           |    4 
 drivers/hwtracing/stm/core.c                            |  148 ++++++++++++----
 drivers/hwtracing/stm/policy.c                          |   25 ++
 drivers/hwtracing/stm/stm.h                             |    2 
 drivers/isdn/hardware/mISDN/hfcmulti.c                  |    3 
 drivers/media/usb/uvc/uvc_ctrl.c                        |    2 
 drivers/media/v4l2-core/v4l2-ctrls.c                    |    2 
 drivers/mmc/card/block.c                                |   10 -
 drivers/mmc/core/core.c                                 |   10 -
 drivers/mmc/core/debugfs.c                              |    2 
 drivers/mmc/core/mmc.c                                  |   16 +
 drivers/mmc/core/mmc_ops.c                              |    2 
 drivers/mmc/core/pwrseq_simple.c                        |   22 +-
 drivers/mmc/host/pxamci.c                               |    2 
 drivers/mmc/host/tmio_mmc_pio.c                         |    8 
 drivers/net/ethernet/8390/mac8390.c                     |   19 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       |   16 +
 drivers/net/vxlan.c                                     |    4 
 drivers/net/wireless/ath/ath10k/wmi.c                   |    2 
 drivers/rtc/rtc-lib.c                                   |    6 
 drivers/s390/scsi/zfcp_erp.c                            |   17 +
 drivers/s390/scsi/zfcp_ext.h                            |    2 
 drivers/s390/scsi/zfcp_scsi.c                           |    4 
 drivers/scsi/sd.c                                       |   19 +-
 drivers/staging/android/ashmem.c                        |    4 
 drivers/staging/android/ion/ion_carveout_heap.c         |    2 
 drivers/staging/android/sync.c                          |    6 
 drivers/staging/android/uapi/ashmem.h                   |    1 
 drivers/staging/goldfish/goldfish_audio.c               |    1 
 drivers/staging/vt6655/device_main.c                    |   11 -
 drivers/tty/serial/atmel_serial.c                       |    4 
 drivers/tty/serial/kgdboc.c                             |    4 
 drivers/tty/serial/max310x.c                            |    2 
 drivers/tty/serial/sh-sci.c                             |   12 -
 drivers/tty/serial/sprd_serial.c                        |    6 
 drivers/usb/dwc3/gadget.c                               |    6 
 drivers/usb/gadget/composite.c                          |    2 
 drivers/usb/gadget/configfs.c                           |    2 
 drivers/usb/gadget/function/rndis.c                     |    6 
 drivers/usb/gadget/function/u_serial.c                  |    7 
 drivers/usb/host/xhci-ring.c                            |    9 
 drivers/usb/host/xhci.h                                 |    1 
 drivers/usb/renesas_usbhs/mod_gadget.c                  |    5 
 drivers/usb/serial/cp210x.c                             |    1 
 drivers/usb/serial/ftdi_sio.c                           |    2 
 drivers/usb/serial/ftdi_sio_ids.h                       |    4 
 drivers/usb/serial/mos7720.c                            |    4 
 drivers/usb/serial/option.c                             |   13 -
 drivers/video/fbdev/goldfishfb.c                        |    2 
 fs/btrfs/raid56.c                                       |    3 
 fs/btrfs/tree-log.c                                     |   11 -
 fs/dcache.c                                             |   10 -
 fs/ext4/ext4_jbd2.h                                     |    2 
 fs/ext4/file.c                                          |    2 
 fs/ext4/indirect.c                                      |   12 -
 fs/inode.c                                              |    6 
 fs/proc/proc_sysctl.c                                   |    3 
 fs/udf/truncate.c                                       |    3 
 include/asm-generic/fixmap.h                            |   12 -
 include/linux/rculist.h                                 |   36 +++
 include/linux/vmstat.h                                  |    2 
 include/net/inet_connection_sock.h                      |    5 
 include/net/sctp/checksum.h                             |    2 
 include/net/sock.h                                      |    6 
 kernel/cpu.c                                            |   11 -
 kernel/events/ring_buffer.c                             |   47 ++---
 kernel/futex.c                                          |    4 
 kernel/locking/lockdep.c                                |    3 
 kernel/power/swap.c                                     |   18 +
 kernel/sched/fair.c                                     |   38 +++-
 kernel/sched/idle.c                                     |    1 
 lib/int_sqrt.c                                          |    3 
 mm/rmap.c                                               |    2 
 mm/vmstat.c                                             |   69 ++++---
 net/bluetooth/l2cap_core.c                              |   83 +++++---
 net/dccp/ipv4.c                                         |    8 
 net/dccp/ipv6.c                                         |    6 
 net/ipv4/inet_diag.c                                    |   21 +-
 net/ipv4/tcp_input.c                                    |    8 
 net/ipv6/icmp.c                                         |    2 
 net/ipv6/tcp_ipv6.c                                     |    8 
 net/mac80211/mesh_hwmp.c                                |    2 
 net/packet/af_packet.c                                  |    4 
 net/rose/rose_subr.c                                    |   21 +-
 net/wireless/nl80211.c                                  |   16 -
 scripts/setlocalversion                                 |    2 
 sound/core/compress_offload.c                           |   13 +
 sound/core/oss/pcm_oss.c                                |   43 ++--
 sound/core/pcm_native.c                                 |    9 
 sound/core/rawmidi.c                                    |    2 
 sound/core/seq/oss/seq_oss_synth.c                      |    7 
 sound/pci/hda/hda_codec.c                               |   57 +++++-
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c     |   20 --
 virt/kvm/kvm_main.c                                     |    3 
 124 files changed, 934 insertions(+), 529 deletions(-)

Aditya Pakki (1):
      serial: max310x: Fix to avoid potential NULL pointer dereference

Adrian Hunter (1):
      perf intel-pt: Fix TSC slip

Al Viro (1):
      Hang/soft lockup in d_invalidate with simultaneous calls

Alexander Shishkin (12):
      perf: Synchronously free aux pages in case of allocation failure
      stm class: Fix locking in unbinding policy path
      stm class: Fix link list locking
      stm class: Prevent user-controllable allocations
      stm class: Support devices with multiple instances
      stm class: Fix unlocking braino in the error path
      stm class: Guard output assignment against concurrency
      stm class: Fix unbalanced module/device refcounting
      stm class: Fix a race in unlinking
      perf/ring_buffer: Refuse to begin AUX transaction after rb->aux_mmap_count drops
      stm class: Do not leak the chrdev in error path
      stm class: Fix stm device initialization order

Andrea Righi (1):
      btrfs: raid56: properly unmap parity page in finish_parity_scrub()

Andrey Konovalov (1):
      USB: core: only clean up what we allocated

Archer Yan (1):
      MIPS: Fix kernel crash for R6 in jump label branch function

Ard Biesheuvel (3):
      efi: stub: define DISABLE_BRANCH_PROFILING for all architectures
      arm64: hide __efistub_ aliases from kallsyms
      arm64/kernel: fix incorrect EL0 check in inv_entry macro

Arnd Bergmann (3):
      mmc: pxamci: fix enum type confusion
      ath10k: avoid possible string overflow
      ARM: 8458/1: bL_switcher: add GIC dependency

Axel Lin (1):
      gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

Baolin Wang (2):
      usb: gadget: Add the gserial port checking in gs_start_tx()
      rtc: Fix overflow when converting time64_t to rtc_time

Bart Van Assche (1):
      scsi: sd: Fix a race between closing an sd device and sd I/O

Bhadram Varka (1):
      stmmac: copy unicast mac address to MAC registers

Bjorn Helgaas (1):
      mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Bjørn Mork (1):
      USB: serial: option: add Olicard 600

Chaotian Jing (1):
      mmc: mmc: fix switch timeout issue caused by jiffies precision

Chen Jie (1):
      futex: Ensure that futex address is aligned in handle_futex_death()

Christoffer Dall (1):
      video: fbdev: Set pixclock = 0 in goldfishfb

Christoph Lameter (1):
      vmstat: make vmstat_updater deferrable again and shut down on idle

Christoph Paasch (1):
      net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Chuanxiao Dong (1):
      mmc: debugfs: Add a restriction to mmc debugfs clock setting

Colin Cross (1):
      mmc: block: Allow more than 8 partitions per card

David S. Miller (1):
      Add hlist_add_tail_rcu() (Merge git://git.kernel.org/.../davem/net)

Dmitry Torokhov (1):
      android: unconditionally remove callbacks in sync_fence_free()

Dong Aisheng (1):
      mmc: core: fix using wrong io voltage if mmc_select_hs200 fails

Eric Biggers (1):
      arm64: support keyctl() system call in 32-bit mode

Eric Dumazet (5):
      tcp/dccp: drop SYN packets if accept queue is full
      net: diag: support v4mapped sockets in inet_diag_find_one_icsk()
      dccp: do not use ipv6 header for ipv4 flow
      net: rose: fix a possible stack overflow
      tcp: do not use ipv6 header for ipv4 flow

Eric Long (2):
      coresight: "DEVICE_ATTR_RO" should defined as static.
      coresight: etm4x: Check every parameter used by dma_xx_coherent.

Ezequiel Garcia (1):
      arm64: kconfig: drop CONFIG_RTC_LIB dependency

Finn Thain (1):
      mac8390: Fix mmio access size probe

Geert Uytterhoeven (1):
      stm class: Hide STM-specific options if STM is disabled

George McCollister (1):
      USB: serial: ftdi_sio: add additional NovaTech products

Greg Hackmann (1):
      staging: goldfish: audio: fix compiliation on arm

Greg Kroah-Hartman (3):
      USB: serial: cp210x: add new device id
      Revert "USB: core: only clean up what we allocated"
      Linux 4.4.178

Gustavo A. R. Silva (2):
      ALSA: rawmidi: Fix potential Spectre v1 vulnerability
      ALSA: seq: oss: Fix Spectre v1 vulnerability

Hannes Frederic Sowa (1):
      ipv6: fix endianness error in icmpv6_err

Hans Verkuil (1):
      media: v4l2-ctrls.c/uvc: zero v4l2_event

Hoan Nguyen An (1):
      serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Hui Wang (1):
      ALSA: hda - Enforces runtime_resume after S3 and S4 for each codec

James Morse (3):
      arm64: mm: Add trace_irqflags annotations to do_debug_exception()
      arm64: kernel: Include _AC definition in page.h
      PM / Hibernate: Call flush_icache_range() on pages restored in-place

Jan Kara (1):
      udf: Fix crash on IO error during truncate

Jeff Mahoney (1):
      mac80211: fix "warning: ‘target_metric’ may be used uninitialized"

Jiufei Xue (1):
      ext4: fix NULL pointer dereference while journal is aborted

Johannes Berg (1):
      cfg80211: size various nl80211 messages correctly

Josef Bacik (1):
      btrfs: remove WARN_ON in log_dir_items

Jungseung Lee (1):
      ARM: 8494/1: mm: Enable PXN when running non-LPAE kernel on LPAE processor

Kangjie Lu (1):
      tty: atmel_serial: fix a potential NULL pointer dereference

Kohji Okuno (1):
      ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected time

Konstantin Khlebnikov (1):
      mm/rmap: replace BUG_ON(anon_vma->degree) with VM_WARN_ON

Lanqing Liu (1):
      serial: sprd: clear timeout interrupt only rather than all interrupts

Laura Abbott (1):
      staging: ashmem: Avoid deadlock with mmap/shrink

Lianwei Wang (1):
      cpu/hotplug: Handle unbalanced hotplug enable/disable

Lin Yi (1):
      USB: serial: mos7720: fix mos_parport refcount imbalance on error path

Lorenzo Pieralisi (1):
      ARM: 8510/1: rework ARM_CPU_SUSPEND dependencies

Lukas Czerner (1):
      ext4: fix data corruption caused by unaligned direct AIO

Malcolm Priestley (2):
      staging: vt6655: Remove vif check from vnt_interrupt
      staging: vt6655: Fix interrupt race condition on device start up.

Mans Rullgard (1):
      USB: serial: option: set driver_info for SIM5218 and compatibles

Marcel Holtmann (2):
      Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt
      Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Mark Rutland (1):
      asm-generic: Fix local variable shadow in __set_fixmap_offset

Martin Fuzzey (1):
      mmc: pwrseq_simple: Make reset-gpios optional to match doc

Mathias Nyman (1):
      xhci: Fix port resume done detection for SS ports with LPM enabled

Mathieu Poirier (5):
      coresight: fixing lockdep error
      coresight: coresight_unregister() function cleanup
      coresight: release reference taken by 'bus_find_device()'
      coresight: remove csdev's link from topology
      coresight: removing bind/unbind options from sysfs

Maxime Chevallier (1):
      packets: Always register packet sk in the same order

Nicolas Pitre (1):
      hid-sensor-hub.c: fix wrong do_div() usage

Peter Chen (1):
      usb: gadget: composite: fix dereference after null check coverify warning

Peter Zijlstra (1):
      lib/int_sqrt: optimize small argument

Qiao Zhou (1):
      arm64: traps: disable irq in die()

Rajmal Menariya (1):
      staging: ion: Set minimum carveout heap allocation order to PAGE_SHIFT

Ravindra Lokhande (1):
      ALSA: compress: add support for 32bit calls in a 64bit kernel

Roger Quadros (2):
      usb: dwc3: gadget: Fix suspend/resume during device mode
      extcon: usb-gpio: Don't miss event during suspend/resume

Rom Lemarchand (1):
      staging: ashmem: Add missing include

Russell King (1):
      mmc: core: shut up "voltage-ranges unspecified" pr_info()

Sean Christopherson (1):
      KVM: Reject device ioctls from processes other than the VM's creator

Sergei Shtylyov (1):
      mmc: tmio_mmc_core: don't claim spurious interrupts

Steffen Maier (2):
      scsi: zfcp: fix rport unblock if deleted SCSI devices on Scsi_Host
      scsi: zfcp: fix scsi_eh host reset with port_forced ERP for non-NPIV FCP devices

Tahsin Erdogan (1):
      writeback: initialize inode members that track writeback history

Takashi Iwai (3):
      ALSA: hda - Record the current power state before suspend/resume calls
      ALSA: pcm: Fix possible OOB access in PCM oss plugins
      ALSA: pcm: Don't suspend stream in unrecoverable PCM state

Thomas Gleixner (1):
      x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y

Thomas Zimmermann (1):
      drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Ulf Hansson (1):
      Revert "mmc: block: don't use parameter prefix if built as module"

Waiman Long (1):
      locking/lockdep: Add debug_locks check in __lock_downgrade()

Wei Qiao (1):
      serial: sprd: adjust TIMEOUT to a big value

Wentao Wang (1):
      Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc

Winter Wang (1):
      usb: gadget: configfs: add mutex lock before unregister gadget

Wolfram Sang (3):
      mmc: make MAN_BKOPS_EN message a debug
      mmc: sanitize 'bus width' in debug output
      kbuild: setlocalversion: print error to STDERR

Xerox Lin (1):
      usb: gadget: rndis: free response queue during REMOTE_NDIS_RESET_MSG

Xin Long (1):
      sctp: get sctphdr by offset in sctp_compute_cksum

Yifeng Li (1):
      mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqaction.

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: gadget: fix unused-but-set-variable warning

YueHaibing (1):
      fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Yury Norov (1):
      arm64: fix COMPAT_SHMLBA definition for large pages

Yuyang Du (1):
      sched/fair: Fix new task's load avg removed from source CPU in wake_up_new_task()

Zhiqiang Liu (1):
      vxlan: Don't call gro_cells_destroy() before device is unregistered

zhangyi (F) (1):
      ext4: brelse all indirect buffer in ext4_ind_remove_space()

