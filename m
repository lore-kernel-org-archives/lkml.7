Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9E3C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BBE20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfDOPJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:09:29 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46779 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfDOPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:09:25 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 134F34000F;
        Mon, 15 Apr 2019 15:09:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 8/9] clocksource/drivers/timer-atmel-tcb: tc_clksrc_suspend() can be static
Date:   Mon, 15 Apr 2019 17:08:55 +0200
Message-Id: <20190415150856.9384-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415150856.9384-1-alexandre.belloni@bootlin.com>
References: <20190415150856.9384-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <lkp@intel.com>

Statisticize tc_clksrc_suspend and tc_clksrc_resume.

Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/timer-atmel-tcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 9de8c10ab546..6ed31f9def7e 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -66,7 +66,7 @@ static u64 tc_get_cycles32(struct clocksource *cs)
 	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
-void tc_clksrc_suspend(struct clocksource *cs)
+static void tc_clksrc_suspend(struct clocksource *cs)
 {
 	int i;
 
@@ -81,7 +81,7 @@ void tc_clksrc_suspend(struct clocksource *cs)
 	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
 }
 
-void tc_clksrc_resume(struct clocksource *cs)
+static void tc_clksrc_resume(struct clocksource *cs)
 {
 	int i;
 
-- 
2.20.1

