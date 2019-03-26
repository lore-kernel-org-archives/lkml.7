Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDEDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18C520863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581911;
	bh=vPr1tHv3mVQdGyqBvba++cfCZRc6rVaa/NYRqFdWPMY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yk8A+evl8v4apcG8Q9j6oT2pRetGJcPK0fxet5+3IJEoqOiIcFQT9HLkUwaLq/ifS
	 6aJT9ATYCkkBpPwf6hmLdB05hWO5rqlDtBKk6aixpO2pBtMw9xoXKOsv50t/IVqJLA
	 Iqfoxil2simQYL0Pf7OPgXO3gqGVsMZtGxrpSUJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfCZGbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfCZGbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:31:45 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C4A20857;
        Tue, 26 Mar 2019 06:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581904;
        bh=vPr1tHv3mVQdGyqBvba++cfCZRc6rVaa/NYRqFdWPMY=;
        h=From:To:Cc:Subject:Date:From;
        b=uspLq/dLniXl34FI0e4z/hlml1BIPf3yAFs1ILz+yaQf1bJnOyhlQSdS1CQUKoQTJ
         jOxah/wacbcVzAffywu5mF86zd4whQzAUKcENyz3RpMuKThfqNmGWhmQAgwlev39R4
         vHYQe0g3b3giPiN9JtpHZx4yXYgItjewNFqs8XLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/30] 4.9.166-stable review
Date:   Tue, 26 Mar 2019 15:29:39 +0900
Message-Id: <20190326042607.558087893@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.166-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.166-rc1
X-KernelTest-Deadline: 2019-03-28T04:26+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.166 release.
There are 30 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 28 04:25:51 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.166-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.166-rc1

Arnd Bergmann <arnd@arndb.de>
    ath10k: avoid possible string overflow

Baolin Wang <baolin.wang@linaro.org>
    power: supply: charger-manager: Fix incorrect return value

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.

Baolin Wang <baolin.wang@linaro.org>
    rtc: Fix overflow when converting time64_t to rtc_time

kehuanlin <chgokhl@gmail.com>
    scsi: ufs: fix wrong command type of UTRD for UFSHCI v2.1

Andrey Konovalov <andreyknvl@google.com>
    USB: core: only clean up what we allocated

Peter Zijlstra <peterz@infradead.org>
    lib/int_sqrt: optimize small argument

Lanqing Liu <lanqing.liu@spreadtrum.com>
    serial: sprd: clear timeout interrupt only rather than all interrupts

Qiao Zhou <qiaozhou@asrmicro.com>
    arm64: traps: disable irq in die()

Al Viro <viro@ZenIV.linux.org.uk>
    Hang/soft lockup in d_invalidate with simultaneous calls

Wei Qiao <wei.qiao@spreadtrum.com>
    serial: sprd: adjust TIMEOUT to a big value

Eric Dumazet <edumazet@google.com>
    tcp/dccp: drop SYN packets if accept queue is full

Hui Wang <hui.wang@canonical.com>
    ALSA: hda - Enforces runtime_resume after S3 and S4 for each codec

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Record the current power state before suspend/resume calls

Waiman Long <longman@redhat.com>
    locking/lockdep: Add debug_locks check in __lock_downgrade()

Myungho Jung <mhjungk@gmail.com>
    Bluetooth: Fix decrementing reference count twice in releasing socket

Hans Verkuil <hverkuil@xs4all.nl>
    media: v4l2-ctrls.c/uvc: zero v4l2_event

zhangyi (F) <yi.zhang@huawei.com>
    ext4: brelse all indirect buffer in ext4_ind_remove_space()

Lukas Czerner <lczerner@redhat.com>
    ext4: fix data corruption caused by unaligned direct AIO

Jiufei Xue <jiufei.xue@linux.alibaba.com>
    ext4: fix NULL pointer dereference while journal is aborted

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Move objtool_file struct off the stack

Chen Jie <chenjie6@huawei.com>
    futex: Ensure that futex address is aligned in handle_futex_death()

Archer Yan <ayan@wavecomp.com>
    MIPS: Fix kernel crash for R6 in jump label branch function

Yasha Cherikovsky <yasha.che3@gmail.com>
    MIPS: Ensure ELF appended dtb is relocated

Yifeng Li <tomli@tomli.me>
    mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqaction.

Jan Kara <jack@suse.cz>
    udf: Fix crash on IO error during truncate

Ilya Dryomov <idryomov@gmail.com>
    libceph: wait for latest osdmap in ceph_monc_blacklist_add()

Stanislaw Gruszka <sgruszka@redhat.com>
    iommu/amd: fix sg->dma_address for sg->offset bigger than PAGE_SIZE

Thomas Zimmermann <tzimmermann@suse.de>
    drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Arnd Bergmann <arnd@arndb.de>
    mmc: pxamci: fix enum type confusion


-------------

Diffstat:

 Makefile                               |  4 +--
 arch/arm64/kernel/traps.c              |  8 +++--
 arch/mips/include/asm/jump_label.h     |  8 ++---
 arch/mips/kernel/vmlinux.lds.S         | 12 ++++---
 arch/mips/loongson64/lemote-2f/irq.c   |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c     | 12 ++-----
 drivers/iommu/amd_iommu.c              |  7 ++++-
 drivers/media/usb/uvc/uvc_ctrl.c       |  2 +-
 drivers/media/v4l2-core/v4l2-ctrls.c   |  2 +-
 drivers/mmc/host/pxamci.c              |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c  |  2 +-
 drivers/power/supply/charger-manager.c |  3 +-
 drivers/rtc/rtc-lib.c                  |  6 ++--
 drivers/scsi/ufs/ufshcd.c              | 14 +++++----
 drivers/tty/serial/sprd_serial.c       |  6 ++--
 drivers/usb/core/config.c              |  9 ++++--
 drivers/video/backlight/pwm_bl.c       |  9 +++---
 fs/dcache.c                            | 10 +++---
 fs/ext4/ext4_jbd2.h                    |  2 +-
 fs/ext4/file.c                         |  2 +-
 fs/ext4/indirect.c                     | 12 ++++---
 fs/udf/truncate.c                      |  3 ++
 include/linux/ceph/libceph.h           |  2 ++
 include/net/inet_connection_sock.h     |  5 ---
 kernel/futex.c                         |  4 +++
 kernel/locking/lockdep.c               |  3 ++
 lib/int_sqrt.c                         |  3 ++
 net/bluetooth/hci_sock.c               |  3 +-
 net/ceph/ceph_common.c                 | 18 ++++++++++-
 net/ceph/mon_client.c                  |  9 ++++++
 net/dccp/ipv4.c                        |  8 +----
 net/dccp/ipv6.c                        |  2 +-
 net/ipv4/tcp_input.c                   |  8 +----
 sound/pci/hda/hda_codec.c              | 57 ++++++++++++++++++++++++++++++++--
 tools/objtool/check.c                  |  3 +-
 35 files changed, 175 insertions(+), 87 deletions(-)


