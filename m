Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93B1C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A949220673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfFNQRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:17:22 -0400
Received: from foss.arm.com ([217.140.110.172]:37330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNQRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:17:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E495128;
        Fri, 14 Jun 2019 09:17:20 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A76A73F694;
        Fri, 14 Jun 2019 09:17:18 -0700 (PDT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, arm-soc <arm@kernel.org>
Subject: [PATCH] MAINTAINERS: Update my email address to use @kernel.org
Date:   Fri, 14 Jun 2019 17:17:07 +0100
Message-Id: <20190614161707.24380-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My @arm.com address will stop working at the end of August, so update to
my @kernel.org address where you'll still be able to reach me.

When I say "stop working" I really mean "will go to my line manager", so
send patches there at your peril because they may reply with roadmaps
and spreadsheets. You have been warned.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: arm-soc <arm@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Unless Linus wants to pick this up directly, I can include it in the
arm64 pull request next week. Just thought I'd send it out now as an
'FYI' for the people on CC.

 .mailmap    |  1 +
 MAINTAINERS | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/.mailmap b/.mailmap
index 07a777f9d687..6b06a19e5033 100644
--- a/.mailmap
+++ b/.mailmap
@@ -238,6 +238,7 @@ Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
 Takashi YOSHII <takashi.yoshii.zj@renesas.com>
+Will Deacon <will@kernel.org> <will.deacon@arm.com>
 Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
 Yusuke Goda <goda.yusuke@renesas.com>
 Gustavo Padovan <gustavo@las.ic.unicamp.br>
diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..651545fc87ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1233,7 +1233,7 @@ F:	arch/arm/lib/floppydma.S
 F:	arch/arm/include/asm/floppy.h
 
 ARM PMU PROFILING AND DEBUGGING
-M:	Will Deacon <will.deacon@arm.com>
+M:	Will Deacon <will@kernel.org>
 M:	Mark Rutland <mark.rutland@arm.com>
 S:	Maintained
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -1305,7 +1305,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
 F:	drivers/irqchip/irq-vic.c
 
 ARM SMMU DRIVERS
-M:	Will Deacon <will.deacon@arm.com>
+M:	Will Deacon <will@kernel.org>
 R:	Robin Murphy <robin.murphy@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -2539,7 +2539,7 @@ F:	drivers/i2c/busses/i2c-xiic.c
 
 ARM64 PORT (AARCH64 ARCHITECTURE)
 M:	Catalin Marinas <catalin.marinas@arm.com>
-M:	Will Deacon <will.deacon@arm.com>
+M:	Will Deacon <will@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 S:	Maintained
@@ -2723,7 +2723,7 @@ S:	Maintained
 F:	drivers/net/wireless/atmel/atmel*
 
 ATOMIC INFRASTRUCTURE
-M:	Will Deacon <will.deacon@arm.com>
+M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 R:	Boqun Feng <boqun.feng@gmail.com>
 L:	linux-kernel@vger.kernel.org
@@ -9110,7 +9110,7 @@ F:	drivers/misc/lkdtm/*
 LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
 M:	Alan Stern <stern@rowland.harvard.edu>
 M:	Andrea Parri <andrea.parri@amarulasolutions.com>
-M:	Will Deacon <will.deacon@arm.com>
+M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
 M:	Nicholas Piggin <npiggin@gmail.com>
@@ -9218,7 +9218,7 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
 LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
-M:	Will Deacon <will.deacon@arm.com>
+M:	Will Deacon <will@kernel.org>
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 S:	Maintained
@@ -10539,7 +10539,7 @@ F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
 
 MMU GATHER AND TLB INVALIDATION
-M:	Will Deacon <will.deacon@arm.com>
+M:	Will Deacon <will@kernel.org>
 M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Nick Piggin <npiggin@gmail.com>
@@ -12029,7 +12029,7 @@ S:	Maintained
 F:	drivers/pci/controller/dwc/*layerscape*
 
 PCI DRIVER FOR GENERIC OF HOSTS
-M:	Will Deacon <will.deacon@arm.com>
+M:	Will Deacon <will@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.11.0

