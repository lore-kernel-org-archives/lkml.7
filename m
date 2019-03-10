Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDE6C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A012087C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfCJLdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 07:33:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfCJLdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 07:33:53 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h2wiF-00006K-Ei; Sun, 10 Mar 2019 12:33:51 +0100
Subject: [GIT pull] timer fix for 5.1
Message-ID: <155221755097.13878.12825399479786913123.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
Date:   Sun, 10 Mar 2019 12:33:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus


A single fix to prevent a unmet dependencies warning in Kconfig.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      time: Make VIRT_CPU_ACCOUNTING_GEN depend on GENERIC_CLOCKEVENTS


 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index c9386a365eea..acbde4ef2395 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -382,6 +382,7 @@ config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
 	depends on HAVE_CONTEXT_TRACKING
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
+	depends on GENERIC_CLOCKEVENTS
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING
 	help

