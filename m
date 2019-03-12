Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6586FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7012087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414514;
	bh=8Er/q6RLrvRzwL2y5b3rvjllV3tW7jNNbPxdsO3RGvM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0YqA4lwrQ6L4ccyK2AW36fSch3ZV9uyWdb4VzlzPtFkoxX0rXHot7hnUh9xP+6vcq
	 q5wH/asHLoepm76yxDeBuTWwf6wvlUwCXMaW0y05BpZoTDq/XuyLuCUIGF7cfD2wU9
	 cPr7+15o4QU8RoT7GxOZfu7LTz98jrP+cxl5HUTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfCLSPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfCLRLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:22 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4EE62083D;
        Tue, 12 Mar 2019 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410680;
        bh=8Er/q6RLrvRzwL2y5b3rvjllV3tW7jNNbPxdsO3RGvM=;
        h=From:To:Cc:Subject:Date:From;
        b=11rqvnN+QQjiHiND1bue/rMDF1nPUFc62a7iHqtS5ouPKB9rgPsfWeG4lYGk9LsgZ
         7MUINVXzkfg2hAgXlOjW9/vVOxnadMabits8JlZZz4tV3+rXUOTN/W99f4UqkERBGg
         6crajrg+prP4XjRhnyY0RP+p/RTQvp6FxFXLE+y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 5.0 00/25] 5.0.2-stable review
Date:   Tue, 12 Mar 2019 10:08:38 -0700
Message-Id: <20190312170403.643852550@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.0.2-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.0.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.0.2-rc1
X-KernelTest-Deadline: 2019-03-14T17:04+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.0.2 release.
There are 25 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 14 17:03:43 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.2-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.0.2-rc1

Peter Zijlstra (Intel) <peterz@infradead.org>
    perf/x86/intel: Implement support for TSX Force Abort

Peter Zijlstra (Intel) <peterz@infradead.org>
    x86: Add TSX Force Abort CPUID/MSR

Peter Zijlstra (Intel) <peterz@infradead.org>
    perf/x86/intel: Generalize dynamic constraint creation

Peter Zijlstra (Intel) <peterz@infradead.org>
    perf/x86/intel: Make cpuc allocations consistent

Daniel F. Dickinson <cshored@thecshore.com>
    ath9k: Avoid OF no-EEPROM quirks without qca,no-eeprom

Jackie Liu <liuyun01@kylinos.cn>
    scripts/gdb: replace flags (MS_xyz -> SB_xyz)

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: compressed_pages should not be accessed again after freed

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: keep corrupted fs from crashing kernel in erofs_namei()

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix missed wakeups in find_insert_glock

Jakub Sitnicki <jakub@cloudflare.com>
    bpf: Stop the psock parser before canceling its work

Mika Westerberg <mika.westerberg@linux.intel.com>
    Revert "PCI/PME: Implement runtime PM callbacks"

Sean Young <sean@mess.org>
    media: Revert "media: rc: some events are dropped by userspace"

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    drm: disable uncached DMA optimization for ARM and arm64

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Fix max voltage for buck8 regulator on Odroid XU3/XU4

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3

Alistair Strachan <astrachan@google.com>
    arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"

Jan Kiszka <jan.kiszka@siemens.com>
    arm64: dts: hikey: Give wifi some time after power-on

Jan Kiszka <jan.kiszka@siemens.com>
    arm64: dts: zcu100-revC: Give wifi some time after power-on

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    x86/PCI: Fixup RTIT_BAR of Intel Denverton Trace Hub

Gustavo A. R. Silva <gustavo@embeddedor.com>
    scsi: aacraid: Fix missing break in switch statement

Gustavo A. R. Silva <gustavo@embeddedor.com>
    iscsi_ibft: Fix missing break in switch statement

Vincent Batts <vbatts@hashbangbash.com>
    Input: elan_i2c - add id for touchpad found in Lenovo s21e-20

Jason Gerecke <jason.gerecke@wacom.com>
    Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Alistair Strachan <astrachan@google.com>
    media: uvcvideo: Fix 'type' check leading to overflow


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/arm/boot/dts/exynos3250.dtsi                 |   3 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi   |  13 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi     |   2 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts    |   2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts |   1 +
 arch/x86/events/core.c                            |  13 +-
 arch/x86/events/intel/core.c                      | 154 +++++++++++++-----
 arch/x86/events/perf_event.h                      |  17 +-
 arch/x86/include/asm/cpufeatures.h                |   1 +
 arch/x86/include/asm/msr-index.h                  |   6 +
 arch/x86/pci/fixup.c                              |  16 ++
 drivers/firmware/iscsi_ibft.c                     |   1 +
 drivers/input/mouse/elan_i2c_core.c               |   1 +
 drivers/input/tablet/wacom_serial4.c              |   2 +
 drivers/media/rc/rc-main.c                        |  13 +-
 drivers/media/usb/uvc/uvc_driver.c                |  14 +-
 drivers/net/wireless/ath/ath9k/init.c             |   6 +-
 drivers/pci/pcie/pme.c                            |  27 ----
 drivers/scsi/aacraid/commsup.c                    |   5 +-
 drivers/staging/erofs/namei.c                     | 183 ++++++++++++----------
 drivers/staging/erofs/unzip_vle.c                 |  38 ++---
 drivers/staging/erofs/unzip_vle.h                 |   3 +-
 drivers/staging/erofs/unzip_vle_lz4.c             |  19 +--
 fs/gfs2/glock.c                                   |   2 +-
 include/drm/drm_cache.h                           |  18 +++
 net/core/skmsg.c                                  |   1 +
 scripts/gdb/linux/constants.py.in                 |  12 +-
 scripts/gdb/linux/proc.py                         |  12 +-
 29 files changed, 366 insertions(+), 223 deletions(-)


