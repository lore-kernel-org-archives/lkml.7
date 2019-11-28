Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BA7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C67320880
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIBQKkwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK1WkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:40:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1WkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 17:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8s4OV8QdxGuKeWypyj3UNsLPvMPu6eIU4B1rnNMiCVk=; b=UIBQKkwYlA9v9WMMmXJQwIW3o
        ul8DnxLBsDJcre9bnLzGrSbi3mx4Hrc9IwLNHl7BmkY3gOMJsrwqpHYRy7bj6oh9QnSNjd5sRPbfe
        7GwbMXtP1MLrFuWld0bcdKHTX8az7ijTNuN2Ix0Z7xx+2dmWbXcVx9SAhkAPsTIHWe1jfD3l/Ip40
        QuvBSD53+5bYSoo5afxJImzsvt0m1moQSXnjWNtw2/s3Wr8iQdYmYnnnLaiP8vQkvzgm6aoC0Nexh
        zNGfjcjuyytb51YVH3guxoPn2C/V6yKfLLV7qI+nyXFbez6nI9bpxWqW4I1XNAzY7ED2Bd5+i7a1y
        FeyKGkpxg==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaSSW-0000OZ-D3; Thu, 28 Nov 2019 22:40:24 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Guo Ren <guoren@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] clocksource: minor Kconfig help text fixes
Message-ID: <87922baa-223a-345d-38ac-be5a94d15b34@infradead.org>
Date:   Thu, 28 Nov 2019 14:40:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Minor cleanups in Kconfig help text:

- End a sentence with a period.
- Fix verb grammar.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 drivers/clocksource/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-54.orig/drivers/clocksource/Kconfig
+++ lnx-54/drivers/clocksource/Kconfig
@@ -312,7 +312,7 @@ config ARC_TIMERS_64BIT
 	depends on ARC_TIMERS
 	select TIMER_OF
 	help
-	  This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP)
+	  This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP).
 	  RTC is implemented inside the core, while GFRC sits outside the core in
 	  ARConnect IP block. Driver automatically picks one of them for clocksource
 	  as appropriate.
@@ -666,7 +666,7 @@ config CSKY_MP_TIMER
 	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
 	  system.
 	  csky,mptimer is not only used in SMP system, it also could be used
-	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
+	  single core system. It's not a mmio reg and it uses mtcr/mfcr instruction.
 
 config GX6605S_TIMER
 	bool "Gx6605s SOC system timer driver" if COMPILE_TEST


