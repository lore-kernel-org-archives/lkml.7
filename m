Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393E7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113942084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfDJIsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:48:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44879 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfDJIsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:48:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3A8m9Te700123
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Apr 2019 01:48:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3A8m83T700120;
        Wed, 10 Apr 2019 01:48:08 -0700
Date:   Wed, 10 Apr 2019 01:48:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-a5881bea88616e3aacf521dbdbe0e323257aaba1@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, hch@lst.de, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hch@lst.de, torvalds@linux-foundation.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190410080220.21705-2-hch@lst.de>
References: <20190410080220.21705-2-hch@lst.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/Kconfig: Remove the unused X86_DMA_REMAP
 KConfig symbol
Git-Commit-ID: a5881bea88616e3aacf521dbdbe0e323257aaba1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a5881bea88616e3aacf521dbdbe0e323257aaba1
Gitweb:     https://git.kernel.org/tip/a5881bea88616e3aacf521dbdbe0e323257aaba1
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Wed, 10 Apr 2019 10:02:19 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:17:24 +0200

x86/Kconfig: Remove the unused X86_DMA_REMAP KConfig symbol

Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190410080220.21705-2-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1f9b3cf437c..7f93e013e6db 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -704,7 +704,6 @@ config STA2X11
 	depends on X86_32_NON_STANDARD && PCI
 	select ARCH_HAS_PHYS_TO_DMA
 	select X86_DEV_DMA_OPS
-	select X86_DMA_REMAP
 	select SWIOTLB
 	select MFD_STA2X11
 	select GPIOLIB
@@ -2886,10 +2885,6 @@ config X86_DEV_DMA_OPS
 	bool
 	depends on X86_64 || STA2X11
 
-config X86_DMA_REMAP
-	bool
-	depends on STA2X11
-
 config HAVE_GENERIC_GUP
 	def_bool y
 
