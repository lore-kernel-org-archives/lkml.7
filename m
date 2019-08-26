Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE5DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FD3206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfHZWwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:52:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41444 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfHZWwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:52:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2NqO-0006lp-2X; Tue, 27 Aug 2019 00:52:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AE0DB1C0DDA;
        Tue, 27 Aug 2019 00:52:11 +0200 (CEST)
Date:   Mon, 26 Aug 2019 22:52:11 -0000
From:   tip-bot2 for Maxime Ripard <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: sun4i: Add missing compatibles
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156685993160.1290.792915852568412167.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bca4e08426e48d1f59b9bb7a8835b08140525828
Gitweb:        https://git.kernel.org/tip/bca4e08426e48d1f59b9bb7a8835b08140525828
Author:        Maxime Ripard <maxime.ripard@bootlin.com>
AuthorDate:    Mon, 22 Jul 2019 10:12:21 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Aug 2019 00:31:39 +02:00

clocksource: sun4i: Add missing compatibles

Newer Allwinner SoCs have different number of interrupts, let's add
different compatibles for all of them to deal with this properly.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun4i.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 65f38f6..0ba8155 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -219,5 +219,9 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(sun8i_a23, "allwinner,sun8i-a23-timer",
+		 sun4i_timer_init);
+TIMER_OF_DECLARE(sun8i_v3s, "allwinner,sun8i-v3s-timer",
+		 sun4i_timer_init);
 TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
 		       sun4i_timer_init);
