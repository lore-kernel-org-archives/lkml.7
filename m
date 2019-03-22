Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EBDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1218621841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfCVWt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:49:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41675 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:49:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMn5RL758835
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:49:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMn4kD758832;
        Fri, 22 Mar 2019 15:49:04 -0700
Date:   Fri, 22 Mar 2019 15:49:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-d18a7408d7be0f34a120d99051ed5187d9727728@git.kernel.org>
Cc:     yuehaibing@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel.lezcano@linaro.org, mingo@kernel.org, shc_work@mail.ru,
        hpa@zytor.com
Reply-To: tglx@linutronix.de, yuehaibing@huawei.com, hpa@zytor.com,
          mingo@kernel.org, shc_work@mail.ru, daniel.lezcano@linaro.org,
          linux-kernel@vger.kernel.org,
          linux-arm-kernel@lists.infradead.org
In-Reply-To: <20190322143708.12716-1-yuehaibing@huawei.com>
References: <20190322143708.12716-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/clps711x: Make
 clps711x_clksrc_init() static
Git-Commit-ID: d18a7408d7be0f34a120d99051ed5187d9727728
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d18a7408d7be0f34a120d99051ed5187d9727728
Gitweb:     https://git.kernel.org/tip/d18a7408d7be0f34a120d99051ed5187d9727728
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Fri, 22 Mar 2019 22:37:08 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 22:59:32 +0100

clocksource/drivers/clps711x: Make clps711x_clksrc_init() static

Fix sparse warning:

drivers/clocksource/clps711x-timer.c:96:13: warning:
 symbol 'clps711x_clksrc_init' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <daniel.lezcano@linaro.org>
Cc: <shc_work@mail.ru>
Cc: <linux-arm-kernel@lists.infradead.org>
Link: https://lkml.kernel.org/r/20190322143708.12716-1-yuehaibing@huawei.com

---
 drivers/clocksource/clps711x-timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index a8dd80576c95..cdc251524f5e 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -93,8 +93,9 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 			   "clps711x-timer", clkevt);
 }
 
-void __init clps711x_clksrc_init(void __iomem *tc1_base, void __iomem *tc2_base,
-				 unsigned int irq)
+static void __init clps711x_clksrc_init(void __iomem *tc1_base,
+					void __iomem *tc2_base,
+					unsigned int irq)
 {
 	struct clk *tc1 = clk_get_sys("clps711x-timer.0", NULL);
 	struct clk *tc2 = clk_get_sys("clps711x-timer.1", NULL);
