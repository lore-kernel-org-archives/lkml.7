Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17063C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66412173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563418972;
	bh=UspguK9HjyrMWRzzboIjoZnAS1sWtnoRYP6IonOYPpM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cctz4WXM7ihKDpA7/nQXgu5U9nl3g7ey4G1/9woYgp/ewN1xwqhcoLXZoB0kS5dvb
	 9pDc955+8KBX5mWRmNddpBnTgxmQlLilziRtQkj9al202bAZhxVIrAXR3aQ0SJAN7z
	 wNJlIsH2mPWzj0Lho3iISf/8H2NPNfaivwPLdw1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbfGRDCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfGRDCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:02:50 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846D32173E;
        Thu, 18 Jul 2019 03:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563418968;
        bh=UspguK9HjyrMWRzzboIjoZnAS1sWtnoRYP6IonOYPpM=;
        h=From:To:Cc:Subject:Date:From;
        b=QKB9wTSReWGx0+fkOw1IcyOEPZ7ndk51Nij7FzIi9mbi5iNkO7WDmUMtWS8bIOvnb
         6qkGPgoFlGFAV3pnKBykuNG/DfPZOdf7ip8tUigjqNVmKDbZvqcSxGKEvE7ae8Z3ks
         0AGqsTBjOZRvRo1d8Dy8mHdoyJ4Faub9/p/M/dMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 5.2 00/21] 5.2.2-stable review
Date:   Thu, 18 Jul 2019 12:01:18 +0900
Message-Id: <20190718030030.456918453@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.2.2-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.2-rc1
X-KernelTest-Deadline: 2019-07-20T03:00+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.2.2 release.
There are 21 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat 20 Jul 2019 02:59:27 AM UTC.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.2-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.2.2-rc1

Jiri Slaby <jslaby@suse.cz>
    x86/entry/32: Fix ENDPROC of common_spurious

Haren Myneni <haren@linux.vnet.ibm.com>
    crypto/NX: Set receive window credits to max number of CRBs in RxFIFO

Christophe Leroy <christophe.leroy@c-s.fr>
    crypto: talitos - fix hash on SEC1.

Christophe Leroy <christophe.leroy@c-s.fr>
    crypto: talitos - move struct talitos_edesc into talitos.h

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qdio: don't touch the dsci in tiqdio_add_input_queues()

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qdio: (re-)initialize tiqdio list entries

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390: fix stfle zero padding

Philipp Rudo <prudo@linux.ibm.com>
    s390/ipl: Fix detection of has_secure attribute

Arnd Bergmann <arnd@arndb.de>
    ARC: hide unused function unw_hdr_alloc

Thomas Gleixner <tglx@linutronix.de>
    x86/irq: Seperate unused system vectors from spurious entry again

Thomas Gleixner <tglx@linutronix.de>
    x86/irq: Handle spurious interrupt after shutdown gracefully

Thomas Gleixner <tglx@linutronix.de>
    x86/ioapic: Implement irq_get_irqchip_state() callback

Thomas Gleixner <tglx@linutronix.de>
    genirq: Add optional hardware synchronization for shutdown

Thomas Gleixner <tglx@linutronix.de>
    genirq: Fix misleading synchronize_irq() documentation

Thomas Gleixner <tglx@linutronix.de>
    genirq: Delay deactivation in free_irq()

Sven Van Asbroeck <thesven73@gmail.com>
    firmware: improve LSM/IMA security behaviour

James Morse <james.morse@arm.com>
    drivers: base: cacheinfo: Ensure cpu hotplug work is done before Intel RDT

Masahiro Yamada <yamada.masahiro@socionext.com>
    nilfs2: do not use unexported cpu_to_le32()/le32_to_cpu() in uapi header

Cole Rogers <colerogers@disroot.org>
    Input: synaptics - enable SMBUS on T480 thinkpad trackpad

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    e1000e: start network tx queue only when link is up

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    Revert "e1000e: fix cyclic resets at link up with active tx"


-------------

Diffstat:

 Makefile                                   |  4 +-
 arch/arc/kernel/unwind.c                   |  9 ++-
 arch/s390/include/asm/facility.h           | 21 ++++---
 arch/s390/include/asm/sclp.h               |  1 -
 arch/s390/kernel/ipl.c                     |  7 +--
 arch/x86/entry/entry_32.S                  | 24 ++++++++
 arch/x86/entry/entry_64.S                  | 30 +++++++--
 arch/x86/include/asm/hw_irq.h              |  5 +-
 arch/x86/kernel/apic/apic.c                | 33 ++++++----
 arch/x86/kernel/apic/io_apic.c             | 46 ++++++++++++++
 arch/x86/kernel/apic/vector.c              |  4 +-
 arch/x86/kernel/idt.c                      |  3 +-
 arch/x86/kernel/irq.c                      |  2 +-
 drivers/base/cacheinfo.c                   |  3 +-
 drivers/base/firmware_loader/fallback.c    |  2 +-
 drivers/crypto/nx/nx-842-powernv.c         |  8 ++-
 drivers/crypto/talitos.c                   | 99 +++++++++++++-----------------
 drivers/crypto/talitos.h                   | 30 +++++++++
 drivers/input/mouse/synaptics.c            |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 21 ++++---
 drivers/s390/char/sclp_early.c             |  1 -
 drivers/s390/cio/qdio_setup.c              |  2 +
 drivers/s390/cio/qdio_thinint.c            |  5 +-
 include/linux/cpuhotplug.h                 |  1 +
 include/uapi/linux/nilfs2_ondisk.h         | 24 ++++----
 kernel/irq/autoprobe.c                     |  6 +-
 kernel/irq/chip.c                          |  6 ++
 kernel/irq/cpuhotplug.c                    |  2 +-
 kernel/irq/internals.h                     |  5 ++
 kernel/irq/manage.c                        | 90 ++++++++++++++++++++-------
 30 files changed, 342 insertions(+), 153 deletions(-)


