Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF4C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85EB2073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfKOJoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:44:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42937 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfKOJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:43:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVY8Q-0004T4-IY; Fri, 15 Nov 2019 10:43:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3AE751C18B4;
        Fri, 15 Nov 2019 10:43:22 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:43:21 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/pci: Remove pci_64.h
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113071836.21041-3-hch@lst.de>
References: <20191113071836.21041-3-hch@lst.de>
MIME-Version: 1.0
Message-ID: <157381100181.29467.6264266348455981055.tip-bot2@tip-bot2>
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

Commit-ID:     948fdcf94289b15f86ce8206abd92a3f7d12360a
Gitweb:        https://git.kernel.org/tip/948fdcf94289b15f86ce8206abd92a3f7d12360a
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Wed, 13 Nov 2019 08:18:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 10:36:59 +01:00

x86/pci: Remove pci_64.h

This file only contains external declarations for two non-existing
function pointers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191113071836.21041-3-hch@lst.de

---
 arch/x86/include/asm/pci.h    |  4 ----
 arch/x86/include/asm/pci_64.h | 14 --------------
 2 files changed, 18 deletions(-)
 delete mode 100644 arch/x86/include/asm/pci_64.h

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index e662f98..d9e28aa 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -120,10 +120,6 @@ void native_restore_msi_irqs(struct pci_dev *dev);
 #endif
 #endif  /* __KERNEL__ */
 
-#ifdef CONFIG_X86_64
-#include <asm/pci_64.h>
-#endif
-
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
diff --git a/arch/x86/include/asm/pci_64.h b/arch/x86/include/asm/pci_64.h
deleted file mode 100644
index 4e1aef5..0000000
--- a/arch/x86/include/asm/pci_64.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_PCI_64_H
-#define _ASM_X86_PCI_64_H
-
-#ifdef __KERNEL__
-
-extern int (*pci_config_read)(int seg, int bus, int dev, int fn,
-			      int reg, int len, u32 *value);
-extern int (*pci_config_write)(int seg, int bus, int dev, int fn,
-			       int reg, int len, u32 value);
-
-#endif /* __KERNEL__ */
-
-#endif /* _ASM_X86_PCI_64_H */
