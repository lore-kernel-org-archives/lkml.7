Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C2C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF83222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rcHrQoFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKMHSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:18:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKMHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LBfhvwrVf8cuOUZVaIE/AfpnWYjpIvr7hEg74Z43hjs=; b=rcHrQoFw/njkahsk2tsBRYwVoE
        IlVJVX8W/mwHwPGfZwhJsPctRXw2YaUsTVXzBGN6+bvGGKp50sAOghOwAhYrdOblZ8+AQ4HxiqKTv
        9sLHHYN8iOdvtutsYd4WEZovL4qywYx8rH1B6pC3In6fde/aWDvrKGh0X9NyQ/uFcMwqx7h2kYOzG
        te7wVo9su8Fu+8HNkmQ18Wvdoz0OtOf3i2P+VEl8KKTdrUqMaeGkpV2U2rlrLJjQMvvgz9+5kkb2r
        Tx31ZTXNOw7Yu/dzA5zsTAKv24mvhqsJkcplp+vQLlaxKqKPo/QjI+TtbnJzVwri6EprLq7qEwzbg
        MEaS6agA==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUmvL-0008BK-Jq; Wed, 13 Nov 2019 07:18:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] x86/pci: Remove pci_64.h
Date:   Wed, 13 Nov 2019 08:18:35 +0100
Message-Id: <20191113071836.21041-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113071836.21041-1-hch@lst.de>
References: <20191113071836.21041-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file only contains external declarations for two non-existing
function pointers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pci.h    |  4 ----
 arch/x86/include/asm/pci_64.h | 14 --------------
 2 files changed, 18 deletions(-)
 delete mode 100644 arch/x86/include/asm/pci_64.h

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index e662f987dfa2..d9e28aad2738 100644
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
index 4e1aef506aa5..000000000000
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
-- 
2.20.1

