Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21694C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57AC20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140524;
	bh=YDMmVM0yk6IFMq1fe8kyYEhEX7TYibPN0zGurEwyypY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FKVkNZbC4Ak5ZgbaWFdL/vtGzF5AVJQ9L+iNweyuVq2Bj+/7T5eJ2+fC8ct9qXQ5z
	 W8DLZTClKmm6fYyT7nTsaqTDYxInbpqcxqXF7LpeWeiOQJxn43LSXeKh2G2fGNdbiB
	 o1f4CCZtwqB7Xart1TY+EjAsXhHD4rk/nwLGihK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbfDARha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388162AbfDARhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E49F20896;
        Mon,  1 Apr 2019 17:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140240;
        bh=YDMmVM0yk6IFMq1fe8kyYEhEX7TYibPN0zGurEwyypY=;
        h=From:To:Cc:Subject:Date:From;
        b=tBAlD8ujT26duBw3d2R9KPkWLbKvqI9adQA+ZXFO21juZgea1CPsB7mEraz0H0cLS
         ScAyEoxrFtI4wB6c4e44sS2DL7TVPRWAFa/G0Xy7/7heeqRjSgQZ1n5gwuC9vZVpff
         X3MSKEkE5uyhf3qsoiwoLia+bj8s1ePYfgkqC3tI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/50] 3.18.138-stable review
Date:   Mon,  1 Apr 2019 19:02:43 +0200
Message-Id: <20190401170041.257273804@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.138-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.138-rc1
X-KernelTest-Deadline: 2019-04-03T17:00+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.138 release.
There are 50 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Apr  3 16:59:36 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.138-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.138-rc1

Eric Biggers <ebiggers@google.com>
    arm64: support keyctl() system call in 32-bit mode

Kohji Okuno <okuno.kohji@jp.panasonic.com>
    ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected time

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix port resume done detection for SS ports with LPM enabled

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: Reject device ioctls from processes other than the VM's creator

Axel Lin <axel.lin@ingics.com>
    gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

YueHaibing <yuehaibing@huawei.com>
    fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Wentao Wang <witallwang@gmail.com>
    Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc

Lin Yi <teroincn@163.com>
    USB: serial: mos7720: fix mos_parport refcount imbalance on error path

George McCollister <george.mccollister@gmail.com>
    USB: serial: ftdi_sio: add additional NovaTech products

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: cp210x: add new device id

Aditya Pakki <pakki001@umn.edu>
    serial: max310x: Fix to avoid potential NULL pointer dereference

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix scsi_eh host reset with port_forced ERP for non-NPIV FCP devices

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Don't suspend stream in unrecoverable PCM state

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix possible OOB access in PCM oss plugins

Finn Thain <fthain@telegraphics.com.au>
    mac8390: Fix mmio access size probe

Xin Long <lucien.xin@gmail.com>
    sctp: get sctphdr by offset in sctp_compute_cksum

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

Johannes Berg <johannes.berg@intel.com>
    cfg80211: size various nl80211 messages correctly

Chaotian Jing <chaotian.jing@mediatek.com>
    mmc: mmc: fix switch timeout issue caused by jiffies precision

Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
    arm64: kconfig: drop CONFIG_RTC_LIB dependency

Christoffer Dall <christoffer.dall@linaro.org>
    video: fbdev: Set pixclock = 0 in goldfishfb

Winter Wang <wente.wang@nxp.com>
    usb: gadget: configfs: add mutex lock before unregister gadget

Hannes Frederic Sowa <hannes@stressinduktion.org>
    ipv6: fix endianness error in icmpv6_err

James Morse <james.morse@arm.com>
    arm64: kernel: Include _AC definition in page.h

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

Dmitry Torokhov <dtor@chromium.org>
    android: unconditionally remove callbacks in sync_fence_free()

Arnd Bergmann <arnd@arndb.de>
    ARM: 8458/1: bL_switcher: add GIC dependency

Yury Norov <ynorov@caviumnetworks.com>
    arm64: fix COMPAT_SHMLBA definition for large pages

Colin Cross <ccross@android.com>
    mmc: block: Allow more than 8 partitions per card

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt

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

Jan Kara <jack@suse.cz>
    udf: Fix crash on IO error during truncate


-------------

Diffstat:

 Documentation/virtual/kvm/api.txt               | 16 +++--
 Makefile                                        |  4 +-
 arch/arm/Kconfig                                |  6 +-
 arch/arm/mach-imx/cpuidle-imx6q.c               | 27 +++-----
 arch/arm64/Kconfig                              |  5 +-
 arch/arm64/include/asm/page.h                   |  2 +
 arch/arm64/include/asm/shmparam.h               |  2 +-
 arch/arm64/kernel/entry.S                       |  2 +-
 drivers/gpio/gpio-adnp.c                        |  6 +-
 drivers/isdn/hardware/mISDN/hfcmulti.c          |  3 +-
 drivers/media/usb/uvc/uvc_ctrl.c                |  2 +-
 drivers/media/v4l2-core/v4l2-ctrls.c            |  2 +-
 drivers/mmc/card/block.c                        |  7 +--
 drivers/mmc/core/mmc_ops.c                      |  2 +-
 drivers/mmc/host/tmio_mmc_pio.c                 |  8 +--
 drivers/net/ethernet/8390/mac8390.c             | 19 +++---
 drivers/s390/scsi/zfcp_erp.c                    | 14 +++++
 drivers/s390/scsi/zfcp_ext.h                    |  2 +
 drivers/s390/scsi/zfcp_scsi.c                   |  4 ++
 drivers/staging/android/ashmem.c                |  4 +-
 drivers/staging/android/ion/ion_carveout_heap.c |  2 +-
 drivers/staging/android/sync.c                  |  6 +-
 drivers/staging/android/uapi/ashmem.h           |  1 +
 drivers/staging/goldfish/goldfish_audio.c       |  1 +
 drivers/tty/serial/kgdboc.c                     |  4 +-
 drivers/tty/serial/max310x.c                    |  2 +
 drivers/usb/gadget/configfs.c                   |  2 +
 drivers/usb/host/xhci-ring.c                    |  9 ++-
 drivers/usb/host/xhci.h                         |  1 +
 drivers/usb/serial/cp210x.c                     |  1 +
 drivers/usb/serial/ftdi_sio.c                   |  2 +
 drivers/usb/serial/ftdi_sio_ids.h               |  4 +-
 drivers/usb/serial/mos7720.c                    |  4 +-
 drivers/video/fbdev/goldfishfb.c                |  2 +-
 fs/ext4/ext4_jbd2.h                             |  2 +-
 fs/ext4/file.c                                  |  2 +-
 fs/ext4/indirect.c                              | 12 ++--
 fs/proc/proc_sysctl.c                           |  3 +-
 fs/udf/truncate.c                               |  3 +
 include/asm-generic/fixmap.h                    | 12 ++--
 include/linux/rculist.h                         | 36 +++++++++++
 include/net/sctp/checksum.h                     |  2 +-
 include/net/sock.h                              |  6 ++
 kernel/futex.c                                  |  4 ++
 net/bluetooth/l2cap_core.c                      | 83 ++++++++++++++++---------
 net/dccp/ipv6.c                                 |  4 +-
 net/ipv6/icmp.c                                 |  2 +-
 net/ipv6/tcp_ipv6.c                             |  8 +--
 net/packet/af_packet.c                          |  4 +-
 net/rose/rose_subr.c                            | 21 ++++---
 net/wireless/nl80211.c                          | 16 ++---
 sound/core/oss/pcm_oss.c                        | 43 ++++++-------
 sound/core/pcm_native.c                         |  9 ++-
 virt/kvm/kvm_main.c                             |  3 +
 54 files changed, 293 insertions(+), 160 deletions(-)


