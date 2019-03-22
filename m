Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD35C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90B321841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfCVWui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:50:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfCVWui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:50:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMoRl4759049
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:50:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMoQ4U759046;
        Fri, 22 Mar 2019 15:50:26 -0700
Date:   Fri, 22 Mar 2019 15:50:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-008258d995a637c77c10a5d087d134eed49a6572@git.kernel.org>
Cc:     hpa@zytor.com, daniel.lezcano@linaro.org, yuehaibing@huawei.com,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, yuehaibing@huawei.com, daniel.lezcano@linaro.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20190322144302.6704-1-yuehaibing@huawei.com>
References: <20190322144302.6704-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/timer-ti-dm: Make
 omap_dm_timer_set_load_start() static
Git-Commit-ID: 008258d995a637c77c10a5d087d134eed49a6572
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

Commit-ID:  008258d995a637c77c10a5d087d134eed49a6572
Gitweb:     https://git.kernel.org/tip/008258d995a637c77c10a5d087d134eed49a6572
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Fri, 22 Mar 2019 22:43:02 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 22:59:33 +0100

clocksource/drivers/timer-ti-dm: Make omap_dm_timer_set_load_start() static

Fix sparse warning:

drivers/clocksource/timer-ti-dm.c:589:5: warning:
 symbol 'omap_dm_timer_set_load_start' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <daniel.lezcano@linaro.org>
Link: https://lkml.kernel.org/r/20190322144302.6704-1-yuehaibing@huawei.com

---
 drivers/clocksource/timer-ti-dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index c364027638e1..3352da6ed61f 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -586,8 +586,8 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 }
 
 /* Optimized set_load which removes costly spin wait in timer_start */
-int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
-                            unsigned int load)
+static int omap_dm_timer_set_load_start(struct omap_dm_timer *timer,
+					int autoreload, unsigned int load)
 {
 	u32 l;
 
