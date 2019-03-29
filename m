Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E166BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75942173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XUe8qOAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfC2Pws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:52:48 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:20947 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfC2Pws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:52:48 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x2TFq3l5007988;
        Sat, 30 Mar 2019 00:52:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x2TFq3l5007988
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553874723;
        bh=YIwtGIZIvshZvkyp0XZ9Fh8vpr+y+IN6y3VGZ1h28/A=;
        h=From:To:Cc:Subject:Date:From;
        b=XUe8qOAg2l3Ld/uCtVusL+zvWQxM8w9EgC+5PL90IUbB56Nl2hrWBjsZj8cfYYgCV
         /baA3s5RWaPMgAA/cFey+K/Ix5G4N/IS2vEGbTg1LG/7JkqlGLDOPVzRhV6BlJxZw5
         dw2xp8h+PVyMwddOl82zb7BPrx8iN1RXrhGvO+I/HY8kvV5OLBueZTpjg8ShD0nvLb
         f9/8u6PQuY0tk6VT9HRKW8Ze9j8pseFVCh5sn53tpKakPNIMTI5NvKvFdJ7HyT0AA/
         ZKPvKf25lrFqLzfj4pBJlVRpK4ghH5BW5bzDm4P87WMVFU4FBVrcPtbbzJhAv8tKdT
         pGDo/fc1RyniA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: remove unused <asm/limits.h>
Date:   Sat, 30 Mar 2019 00:52:00 +0900
Message-Id: <1553874720-7655-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one includes this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: 5.1-rc2


 arch/arm/include/asm/limits.h | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 arch/arm/include/asm/limits.h

diff --git a/arch/arm/include/asm/limits.h b/arch/arm/include/asm/limits.h
deleted file mode 100644
index ab15937..0000000
--- a/arch/arm/include/asm/limits.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_PIPE_H
-#define __ASM_PIPE_H
-
-#ifndef PAGE_SIZE
-#include <asm/page.h>
-#endif
-
-#define PIPE_BUF	PAGE_SIZE
-
-#endif
-
-- 
2.7.4

