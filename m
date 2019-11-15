Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A249AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AD620740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfKOJoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:44:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKOJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:43:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVY8Q-0004Sz-1V; Fri, 15 Nov 2019 10:43:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B66821C08AC;
        Fri, 15 Nov 2019 10:43:21 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:43:21 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/pci: Remove #ifdef __KERNEL__ guard from <asm/pci.h>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113071836.21041-4-hch@lst.de>
References: <20191113071836.21041-4-hch@lst.de>
MIME-Version: 1.0
Message-ID: <157381100119.29467.13434467993345423920.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b52b0c4fc977901c243756e191f3fc686725b7d9
Gitweb:        https://git.kernel.org/tip/b52b0c4fc977901c243756e191f3fc686725b7d9
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Wed, 13 Nov 2019 08:18:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 10:37:14 +01:00

x86/pci: Remove #ifdef __KERNEL__ guard from <asm/pci.h>

pci.h is not a UAPI header, so the __KERNEL__ ifdef is rather pointless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191113071836.21041-4-hch@lst.de
---
 arch/x86/include/asm/pci.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index d9e28aa..90d0731 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -12,8 +12,6 @@
 #include <asm/pat.h>
 #include <asm/x86_init.h>
 
-#ifdef __KERNEL__
-
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
@@ -118,7 +116,6 @@ void native_restore_msi_irqs(struct pci_dev *dev);
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
 #endif
-#endif  /* __KERNEL__ */
 
 /* generic pci stuff */
 #include <asm-generic/pci.h>
