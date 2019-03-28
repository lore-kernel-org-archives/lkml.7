Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD118C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D53B2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfC1XWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:22:03 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:60187 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727658AbfC1XWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:22:03 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x2SMha3K032165;
        Fri, 29 Mar 2019 00:43:36 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 34E7C63000; Fri, 29 Mar 2019 01:13:33 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     joe@perches.com, avifishman70@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        brendanhiggins@google.com, tali.perry1@gmail.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] MAINTAINERS: fix bad pattern in ARM/NUVOTON NPCM
Date:   Fri, 29 Mar 2019 01:12:22 +0200
Message-Id: <20190328231317.330699-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the process of upstreaming architecture support for ARM/NUVOTON NPCM
include/dt-bindings/clock/nuvoton,npcm7xx-clks.h was renamed
include/dt-bindings/clock/nuvoton,npcm7xx-clock.h without updating
MAINTAINERS. This updates the MAINTAINERS pattern to match the new name
of this file.

Fixes: 6a498e06ba22 ("MAINTAINERS: Add entry for the Nuvoton NPCM architecture")
Reported-by: Joe Perches <joe@xxxxxxxxxxx>
Signed-off-by: Brendan Higgins <brendanhiggins@xxxxxxxxxx>
Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..8b305d2f2a8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1900,7 +1900,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/arm/mach-npcm/
 F:	arch/arm/boot/dts/nuvoton-npcm*
-F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
+F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 F:	drivers/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*/*npcm*
-- 
2.14.1

