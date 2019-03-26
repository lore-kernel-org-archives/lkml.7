Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4CB20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="y8MNvoZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfCZCNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:13:47 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:65270 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbfCZCNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:13:47 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x2Q2DY2J005994;
        Tue, 26 Mar 2019 11:13:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x2Q2DY2J005994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553566415;
        bh=21/vQiGcgv3WlflwAMtbWIMHIRd6Wly2A3Unif2G9XM=;
        h=From:To:Cc:Subject:Date:From;
        b=y8MNvoZ5nqifr1p9MsIHhsYrkpsKBI2+081+F/IjPFpbxAij+iJJaX3eh/uzuMh00
         vzdwgmD8MDjy1xoEMhvyNU0WUa75TbFwsTYE6CJvaEzpQv1orS+JRj5+oNKmfV6ORt
         H/M36UX8e0mG68SXC42GWbTl92TGL1lcIrVL/hFO9gpRc6mJ/zBXlo7zcv7ZyKrkN+
         7OyV5EV8cZBFlNF5LB24gQFGyw9DCPvDgsezFBV0fnBLa5fJkPWAy5B98y5F/9u3Fe
         vl6kDm0L8CEFRvsaO4ghp/LtlE/U8TK3PIyONpyBY4NAr1yTyzd4XFW59hHw0Qolmc
         qYDcVyq/s/XBg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] MAINTAINERS: fix the file path of uniphier-mdmac.c
Date:   Tue, 26 Mar 2019 11:13:29 +0900
Message-Id: <1553566409-23873-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern drivers/dmaengine/uniphier-mdmac.c has no match in the
source tree.

The correct path is drivers/dma/uniphier-mdmac.c

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d2..bfb1557 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2356,7 +2356,7 @@ F:	arch/arm/mm/cache-uniphier.c
 F:	arch/arm64/boot/dts/socionext/uniphier*
 F:	drivers/bus/uniphier-system-bus.c
 F:	drivers/clk/uniphier/
-F:	drivers/dmaengine/uniphier-mdmac.c
+F:	drivers/dma/uniphier-mdmac.c
 F:	drivers/gpio/gpio-uniphier.c
 F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/irqchip/irq-uniphier-aidet.c
-- 
2.7.4

