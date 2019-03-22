Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE67C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466B421925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfCVWvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:51:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfCVWvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:51:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMp8L0759346
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:51:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMp6MN759342;
        Fri, 22 Mar 2019 15:51:06 -0700
Date:   Fri, 22 Mar 2019 15:51:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-9039de4034775f4420bf01fa879f8c04b3cd6bba@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        daniel.lezcano@linaro.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          yuehaibing@huawei.com, tglx@linutronix.de,
          daniel.lezcano@linaro.org
In-Reply-To: <20190322144359.19516-1-yuehaibing@huawei.com>
References: <20190322144359.19516-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/mips-gic-timer: Make
 gic_compare_irqaction static
Git-Commit-ID: 9039de4034775f4420bf01fa879f8c04b3cd6bba
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

Commit-ID:  9039de4034775f4420bf01fa879f8c04b3cd6bba
Gitweb:     https://git.kernel.org/tip/9039de4034775f4420bf01fa879f8c04b3cd6bba
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Fri, 22 Mar 2019 22:43:59 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 22:59:33 +0100

clocksource/drivers/mips-gic-timer: Make gic_compare_irqaction static

Fix sparse warning:

drivers/clocksource/mips-gic-timer.c:70:18: warning:
 symbol 'gic_compare_irqaction' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <daniel.lezcano@linaro.org>
Link: https://lkml.kernel.org/r/20190322144359.19516-1-yuehaibing@huawei.com

---
 drivers/clocksource/mips-gic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 54f8a331b53a..37671a5d4ed9 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -67,7 +67,7 @@ static irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-struct irqaction gic_compare_irqaction = {
+static struct irqaction gic_compare_irqaction = {
 	.handler = gic_compare_interrupt,
 	.percpu_dev_id = &gic_clockevent_device,
 	.flags = IRQF_PERCPU | IRQF_TIMER,
