Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E1CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4D9206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfDZVrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:47:53 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43915 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfDZVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:47:39 -0400
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8D637240007;
        Fri, 26 Apr 2019 21:47:36 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Romain Izard <romain.izard.pro@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 7/9] clocksource/drivers/tcb_clksrc: Rename the file for consistency
Date:   Fri, 26 Apr 2019 23:47:16 +0200
Message-Id: <20190426214718.13470-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426214718.13470-1-alexandre.belloni@bootlin.com>
References: <20190426214718.13470-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of consistency, let's rename the file to a name similar
to other file names in this directory.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/Makefile                            | 2 +-
 drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index be6e0fbc7489..923b9b60c909 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_TIMER_OF)		+= timer-of.o
 obj-$(CONFIG_TIMER_PROBE)	+= timer-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
-obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
+obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= timer-atmel-tcb.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= timer-cs5535.o
diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/timer-atmel-tcb.c
similarity index 100%
rename from drivers/clocksource/tcb_clksrc.c
rename to drivers/clocksource/timer-atmel-tcb.c
-- 
2.20.1

