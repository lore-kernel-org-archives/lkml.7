Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED682C47401
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2650120CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="uzskY4CC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbfIEOog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:44:36 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:51257 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729806AbfIEOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:44:35 -0400
Received: from mxback13o.mail.yandex.net (mxback13o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::64])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id CAE0842012B8;
        Thu,  5 Sep 2019 17:44:31 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback13o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id EfSvaFNDef-iVHiA9Hm;
        Thu, 05 Sep 2019 17:44:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1567694671;
        bh=sG7BgDIr8p+HYZulZslQuEeDufhWrupg4Wh8iBL4A9s=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=uzskY4CC7NeOC5lHaiRucDLJpj38N7azTn7eke+gSbwFZFKcZ9vHnvBLOYAGuGI5c
         ktuhdRHK98WUZMqMqVzNSzSQCH3TeqrJE20FgrigSxCgeblEiBkY+qpVD7FgSNXEjz
         4TIUC0Q62KigQll9R6zMSlCCult2LL844HAMUvnI=
Authentication-Results: mxback13o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id zkoybIaMjG-iJxWVVor;
        Thu, 05 Sep 2019 17:44:29 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     chenhc@lemote.com, paul.burton@mips.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 03/19] MAINTAINERS: Fix entries for new loongson64 path
Date:   Thu,  5 Sep 2019 22:43:00 +0800
Message-Id: <20190905144316.12527-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
References: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we sepreated the code of loongson2ef/loongson3a, they can
now have their own entries.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..b2ad16902d70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10742,17 +10742,16 @@ F:	arch/mips/include/asm/mach-loongson32/
 F:	drivers/*/*loongson1*
 F:	drivers/*/*/*loongson1*
 
-MIPS/LOONGSON2 ARCHITECTURE
+MIPS/LOONGSON2E/F ARCHITECTURE
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-F:	arch/mips/loongson64/fuloong-2e/
-F:	arch/mips/loongson64/lemote-2f/
-F:	arch/mips/include/asm/mach-loongson64/
+F:	arch/mips/loongson2ef/
+F:	arch/mips/include/asm/mach-loongson2ef/
 F:	drivers/*/*loongson2*
 F:	drivers/*/*/*loongson2*
 
-MIPS/LOONGSON3 ARCHITECTURE
+MIPS/LOONGSON64 ARCHITECTURE
 M:	Huacai Chen <chenhc@lemote.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-- 
2.22.0

