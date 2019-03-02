Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280B9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E9920838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="cGmcsUYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCBXhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:37:05 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35930 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfCBXhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551569820; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1C/GNtGg/oeT1OC5eTZ5EGM5rnZSDQ7pL2Lkjq8+hf0=;
        b=cGmcsUYoDhi8qhmG7lbdxR98AZ5WptttB7A1fYfuk/orzXqD3m5m1k/VRhvTl8FnVozhGf
        nGPriTyJVRPFelnnrF69d9sHTWNb3cC35/3iLFCy0252gLEwEEpYCbFQLVGNI4gpi9k+tP
        Ud+rrm7iKMtgiv62H25UOv/5mEzgMfQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v10 24/27] MIPS: CI20: defconfig: enable OST driver
Date:   Sat,  2 Mar 2019 20:34:10 -0300
Message-Id: <20190302233413.14813-25-paul@crapouillou.net>
In-Reply-To: <20190302233413.14813-1-paul@crapouillou.net>
References: <20190302233413.14813-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OST driver provides a clocksource and sched_clock that are much more
accurate than the default ones.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
         v5: New patch
    
         v6: No change
    
         v7: No change
    
         v8: No change
    
         v9: No change
    
         v10: No change

 arch/mips/configs/ci20_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index 412800d5d7e0..2f101c7c1749 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -105,6 +105,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_JZ4740=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_JZ4780=y
+CONFIG_INGENIC_OST=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
 CONFIG_EXT4_FS=y
-- 
2.11.0

