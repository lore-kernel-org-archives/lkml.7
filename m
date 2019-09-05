Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E097C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7A206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="BmgP4miI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390028AbfIEOro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:47:44 -0400
Received: from forward103o.mail.yandex.net ([37.140.190.177]:41127 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728590AbfIEOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:47:43 -0400
Received: from mxback21o.mail.yandex.net (mxback21o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::72])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 17D315F80109;
        Thu,  5 Sep 2019 17:47:40 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback21o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id RXxb7sP3sd-lea8L3Fo;
        Thu, 05 Sep 2019 17:47:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1567694860;
        bh=FdtimVAnimymVC9IKfwuCkfBdT5hXMFAMSeE9mEwj4g=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=BmgP4miILRJD4/OPEostq7TsBrdBpy28YLpaa9J1Q9AwM55j/YOWb7ID2h/0L2o95
         7ph3ZfxsVMpPvfooSHwgltTSxCw19wQMHrUF8MSHfWDH/c7tWJZl16xpM7PMZtV3aS
         AFBWZwm0pYJbo0hI3lmMMaZ5L5zIdZbIzlim7wSk=
Authentication-Results: mxback21o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id zkoybIaMjG-lXxWpCVw;
        Thu, 05 Sep 2019 17:47:38 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     chenhc@lemote.com, paul.burton@mips.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 18/19] MAINTAINERS: Add new pathes to LOONGSON64 ARCHITECTURE
Date:   Thu,  5 Sep 2019 22:43:15 +0800
Message-Id: <20190905144316.12527-19-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
References: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place newly submited irqchip drivers and devicetree support under
MIPS/LOONGSON64 ARCHITECTURE.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2ad16902d70..836b21baeb20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10755,9 +10755,12 @@ MIPS/LOONGSON64 ARCHITECTURE
 M:	Huacai Chen <chenhc@lemote.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	arch/mips/boot/dts/loongson/
 F:	arch/mips/loongson64/
 F:	arch/mips/include/asm/mach-loongson64/
 F:	drivers/platform/mips/cpu_hwmon.c
+F:	drivers/irqchip/irq-ls3-*
+F:	Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-*
 F:	drivers/*/*loongson3*
 F:	drivers/*/*/*loongson3*
 
-- 
2.22.0

