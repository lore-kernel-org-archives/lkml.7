Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC13EC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBD320644
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WhEx4Llm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfGWLdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:33:21 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:18690 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGWLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:33:21 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x6NBWt04011714;
        Tue, 23 Jul 2019 20:32:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x6NBWt04011714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563881576;
        bh=U9G1sqgaI9eBqZZ/ibWdYn6wyolh8UQqV/1EGpHeVKk=;
        h=From:To:Cc:Subject:Date:From;
        b=WhEx4Llm5GThJ59mIjdpgE2bPlUMC4EZcg7e77CHlpks2hdf5kXS6Q5RL/9AQ8PjJ
         ticuqdFNXkaBN3+e+nsy+F+UeQ+4/sjZ/4TizRT/z8k0hV1IUcApjOT5vxJq0NNzEm
         OX6AcsOyG08WgkNRBq10shc1mO6qPbyQaoMTsqNpEPCNw/+dBskPKSblMJtGfABqQs
         MzFd6PT+1ZdRgKVbRDrm6lSVhgieMpfjdpIO/iwJF3g2HQq+vgEApO6nmzesL0JILl
         lSVYzQI4h84rze+AX2bBF29gPmBybgb0NwUdLuqa5sYP+h7v46hXmwbZbOkupoN861
         cW/T4Z8nz4nPQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: remove unneeded uapi asm-generic wrappers
Date:   Tue, 23 Jul 2019 20:32:52 +0900
Message-Id: <20190723113252.14900-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are listed in include/uapi/asm-generic/Kbuild, so Kbuild will
automatically generate them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/ia64/include/uapi/asm/errno.h  | 2 --
 arch/ia64/include/uapi/asm/ioctl.h  | 2 --
 arch/ia64/include/uapi/asm/ioctls.h | 7 -------
 3 files changed, 11 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/errno.h
 delete mode 100644 arch/ia64/include/uapi/asm/ioctl.h
 delete mode 100644 arch/ia64/include/uapi/asm/ioctls.h

diff --git a/arch/ia64/include/uapi/asm/errno.h b/arch/ia64/include/uapi/asm/errno.h
deleted file mode 100644
index 9addba592646..000000000000
--- a/arch/ia64/include/uapi/asm/errno.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/errno.h>
diff --git a/arch/ia64/include/uapi/asm/ioctl.h b/arch/ia64/include/uapi/asm/ioctl.h
deleted file mode 100644
index b809c4566e5f..000000000000
--- a/arch/ia64/include/uapi/asm/ioctl.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/ioctl.h>
diff --git a/arch/ia64/include/uapi/asm/ioctls.h b/arch/ia64/include/uapi/asm/ioctls.h
deleted file mode 100644
index b86001940209..000000000000
--- a/arch/ia64/include/uapi/asm/ioctls.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_IOCTLS_H
-#define _ASM_IA64_IOCTLS_H
-
-#include <asm-generic/ioctls.h>
-
-#endif /* _ASM_IA64_IOCTLS_H */
-- 
2.17.1

