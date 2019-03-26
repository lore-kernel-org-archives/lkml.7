Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B822086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582173;
	bh=t8mtjP5AI6yJLwc66jglwououCPKKzDW0kE2XmFcwn8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nms9K5EpAP4WBntcWswFm9sgLkbcRRW2KS0Wl/KKu0XhFihekevaNYzAp3fM0TrCp
	 KTPVRBqqxdd6PsgSi1ityeJZ2TaFGEGCJtxTHjnjBQ2kVGcp0sCcTEp9qaPGcmVzxt
	 FA/2g/klWD74q1KHL8vdGE5AG6VCMBaaucORh2QA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfCZGgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731786AbfCZGgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:36:10 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F6F20823;
        Tue, 26 Mar 2019 06:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582169;
        bh=t8mtjP5AI6yJLwc66jglwououCPKKzDW0kE2XmFcwn8=;
        h=From:To:Cc:Subject:Date:From;
        b=rwXYLCIR0D7OZpXAu6EkddTjn8rUhQHWtIckC2P9T/PuYpuizFlF4JTh3+muT9+W9
         jrCjvxwBYbwptuH/lbGozmk2xL7270IBl0TOBPTg8JuaT1PQh96HFSnfGi+X4qW6p9
         F3CTNtT/dSbMFSUuep7JZFO36CM92jSub/yDUIVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/45] 4.19.32-stable review
Date:   Tue, 26 Mar 2019 15:29:43 +0900
Message-Id: <20190326042702.565683325@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.32-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.32-rc1
X-KernelTest-Deadline: 2019-03-28T04:27+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.32 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 28 04:26:41 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.32-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.32-rc1

Baolin Wang <baolin.wang@linaro.org>
    power: supply: charger-manager: Fix incorrect return value

Hui Wang <hui.wang@canonical.com>
    ALSA: hda - Enforces runtime_resume after S3 and S4 for each codec

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Record the current power state before suspend/resume calls

Vlastimil Babka <vbabka@suse.cz>
    mm, mempolicy: fix uninit memory access

Waiman Long <longman@redhat.com>
    locking/lockdep: Add debug_locks check in __lock_downgrade()

Jann Horn <jannh@google.com>
    x86/unwind: Add hardcoded ORC entry for NULL

Jann Horn <jannh@google.com>
    x86/unwind: Handle NULL pointer calls better in frame unwinder

Dongli Zhang <dongli.zhang@oracle.com>
    loop: access lo_backing_file only when the loop device is Lo_bound

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: remove BUGPRINT messages

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to avoid deadlock of atomic file operations

Myungho Jung <mhjungk@gmail.com>
    RDMA/cma: Rollback source IP address if failing to acquire device

Chris Wilson <chris@chris-wilson.co.uk>
    drm: Reorder set_property_atomic to avoid returning with an active ww_ctx

Kefeng Wang <wangkefeng.wang@huawei.com>
    Bluetooth: hci_ldisc: Postpone HCI_UART_PROTO_READY bit set in hci_uart_set_proto()

Jeremy Cline <jcline@redhat.com>
    Bluetooth: hci_ldisc: Initialize hci_dev before open()

Myungho Jung <mhjungk@gmail.com>
    Bluetooth: Fix decrementing reference count twice in releasing socket

Myungho Jung <mhjungk@gmail.com>
    Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in h4_recv_buf()

Hans Verkuil <hverkuil@xs4all.nl>
    media: v4l2-ctrls.c/uvc: zero v4l2_event

zhangyi (F) <yi.zhang@huawei.com>
    ext4: brelse all indirect buffer in ext4_ind_remove_space()

Lukas Czerner <lczerner@redhat.com>
    ext4: fix data corruption caused by unaligned direct AIO

Jiufei Xue <jiufei.xue@linux.alibaba.com>
    ext4: fix NULL pointer dereference while journal is aborted

Takashi Iwai <tiwai@suse.de>
    ALSA: ac97: Fix of-node refcount unbalance

Arnd Bergmann <arnd@arndb.de>
    ALSA: hda/ca0132 - make pci_iounmap() call conditional

Ville Syrjälä <ville.syrjala@linux.intel.com>
    ALSA: x86: Fix runtime PM for hdmi-lpe-audio

Steve French <stfrench@microsoft.com>
    SMB3: Fix SMB3.1.1 guest mounts to Samba

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    irqchip/gic-v3-its: Fix comparison logic in lpi_range_cmp

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Move objtool_file struct off the stack

Adrian Hunter <adrian.hunter@intel.com>
    perf probe: Fix getting the kernel map

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: allow guest mounts to work for smb3.11

Chen Jie <chenjie6@huawei.com>
    futex: Ensure that futex address is aligned in handle_futex_death()

Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
    scsi: ibmvscsi: Fix empty event pool access during host removal

Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
    scsi: ibmvscsi: Protect ibmvscsi_head from concurrent modificaiton

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038

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

Deepak Rawat <drawat@vmware.com>
    drm/vmwgfx: Return 0 when gmrid::get_node runs out of ID's

Thomas Zimmermann <tzimmermann@suse.de>
    drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Wolfram Sang <wsa+renesas@sang-engineering.com>
    mmc: renesas_sdhi: limit block count to 16 bit for old revisions

Alexander Shiyan <shc_work@mail.ru>
    mmc: mxcmmc: "Revert mmc: mxcmmc: handle highmem pages"

Arnd Bergmann <arnd@arndb.de>
    mmc: pxamci: fix enum type confusion

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-motu: use 'version' field of unit directory to identify model

Jaroslav Kysela <perex@perex.cz>
    ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist


-------------

Diffstat:

 Makefile                                      |   4 +-
 arch/mips/include/asm/jump_label.h            |   8 +-
 arch/mips/kernel/vmlinux.lds.S                |  12 ++-
 arch/mips/loongson64/lemote-2f/irq.c          |   2 +-
 arch/powerpc/include/asm/vdso_datapage.h      |   8 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S     |   4 +-
 arch/x86/include/asm/unwind.h                 |   6 ++
 arch/x86/kernel/unwind_frame.c                |  25 ++++-
 arch/x86/kernel/unwind_orc.c                  |  17 ++++
 drivers/block/loop.c                          |   2 +-
 drivers/bluetooth/h4_recv.h                   |   4 +
 drivers/bluetooth/hci_h4.c                    |   4 +
 drivers/bluetooth/hci_ldisc.c                 |  24 +++--
 drivers/gpu/drm/drm_mode_object.c             |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c            |  12 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |   2 +-
 drivers/infiniband/core/cma.c                 |  13 ++-
 drivers/iommu/amd_iommu.c                     |   7 +-
 drivers/irqchip/irq-gic-v3-its.c              |   2 +-
 drivers/media/usb/uvc/uvc_ctrl.c              |   2 +-
 drivers/media/v4l2-core/v4l2-ctrls.c          |   2 +-
 drivers/mmc/host/mxcmmc.c                     |  16 +---
 drivers/mmc/host/pxamci.c                     |   2 +-
 drivers/mmc/host/renesas_sdhi_core.c          |   8 +-
 drivers/power/supply/charger-manager.c        |   3 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c              |  23 ++++-
 fs/cifs/smb2pdu.c                             |  11 ++-
 fs/ext4/ext4_jbd2.h                           |   2 +-
 fs/ext4/file.c                                |   2 +-
 fs/ext4/indirect.c                            |  12 ++-
 fs/f2fs/segment.c                             |  43 ++++++---
 fs/udf/truncate.c                             |   3 +
 include/linux/ceph/libceph.h                  |   2 +
 kernel/futex.c                                |   4 +
 kernel/locking/lockdep.c                      |   3 +
 mm/mempolicy.c                                |   2 +-
 net/bluetooth/hci_sock.c                      |   3 +-
 net/bridge/netfilter/ebtables.c               | 131 ++++++++------------------
 net/ceph/ceph_common.c                        |  18 +++-
 net/ceph/mon_client.c                         |   9 ++
 sound/ac97/bus.c                              |   2 +-
 sound/firewire/motu/motu.c                    |  20 ++--
 sound/pci/hda/hda_codec.c                     |  57 ++++++++++-
 sound/pci/hda/hda_intel.c                     |   6 +-
 sound/pci/hda/patch_ca0132.c                  |   2 +-
 sound/x86/intel_hdmi_audio.c                  |   1 -
 tools/objtool/check.c                         |   3 +-
 tools/perf/util/probe-event.c                 |   6 +-
 48 files changed, 355 insertions(+), 204 deletions(-)


