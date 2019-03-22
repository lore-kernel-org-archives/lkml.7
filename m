Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22643C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA699218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NddShRAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCVN5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:57:07 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:52475 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfCVN5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:57:07 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x2MDu8XK002607;
        Fri, 22 Mar 2019 22:56:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x2MDu8XK002607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553262969;
        bh=++TgGeP3ojHfTuINDKOJCTcM4XokKy619mv2TsBDv6o=;
        h=From:To:Cc:Subject:Date:From;
        b=NddShRAQ7A5ki/2aKvQTyEE1zEkyb5j1V0ZT1ITrZFXYN9cMtu9Gh0pMdd1FT/ycJ
         bgjGiXyMYdXlKwFWe2P6ucHtFWI5sXUDrspPFCOxfEK8OUiNGCrQuX+puSqhP1lzJl
         OCwvoyO4rXpD/2cL27VyQZjxBiSsS40HUG9mGj93lNp+e3wt95jVTWKBP9XadOmbM8
         rhq6XQm+fg7aQxuPqk0jrZ2RpbUVcP+mHhoIQ9YzGnwbDJNrbkm/JCfSQzKQYMe9uT
         pzuEojIcpw/ETI+MUEykK78qvgEZS0eARznQdJ1j/4pdPM+2nZJKhWS6eB7EyXQuni
         SOxqTVJdekfVQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: remove unused <asm/limits.h>
Date:   Fri, 22 Mar 2019 22:55:49 +0900
Message-Id: <1553262949-17766-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one includes this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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

