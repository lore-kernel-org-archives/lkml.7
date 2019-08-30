Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5752186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="H9GaTT4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfH3Efd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:35:33 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:44023 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbfH3Efc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:35:32 -0400
Received: from mxback21j.mail.yandex.net (mxback21j.mail.yandex.net [IPv6:2a02:6b8:0:1619::221])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 682F5F2054B;
        Fri, 30 Aug 2019 07:35:30 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback21j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id zPP7Q29Vb1-ZUcKoO5S;
        Fri, 30 Aug 2019 07:35:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1567139730;
        bh=AeLVvDOQmHy6G47IkTrmzDnQl83QFttkNmeUEWRztaA=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=H9GaTT4i9BlBWXLv+KSd8HaeiRpOgs/7aAK5ZKBJ+gYNpu2Vm/MWx8VzBPrsUdzAm
         TP9OFU0Wf5nszTkBssJnUbCaS/UMEPHoHv6y/FSidDvQLFTsrMRUXcZ7of2DSTIamI
         /hj1X2a2T3DWcAr0GAu3OQTmfcZDh9OxwaOnk1R4=
Authentication-Results: mxback21j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id vFuwVxmDwr-ZKDG1LNL;
        Fri, 30 Aug 2019 07:35:28 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     chenhc@lemote.com, paul.burton@mips.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v1 17/18] MAINTAINERS: Add new pathes to LOONGSON64 ARCHITECTURE
Date:   Fri, 30 Aug 2019 12:32:31 +0800
Message-Id: <20190830043232.20191-12-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190830043232.20191-1-jiaxun.yang@flygoat.com>
References: <20190830043232.20191-1-jiaxun.yang@flygoat.com>
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
index d5d4fed632e6..242970af939c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10760,9 +10760,12 @@ MIPS/LOONGSON64 ARCHITECTURE
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

