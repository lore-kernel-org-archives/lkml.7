Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80001C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A15820645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfCESIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:31 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:20553 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbfCESIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:30 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 5F/B0-19701-B1BBE7C5; Tue, 05 Mar 2019 18:08:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRWlGSWpSXmKPExsVy8IPnUV3p3XU
  xBj1PmCymPnzCZvHtSgeTxeVdc9gcmD12zrrL7rFpVSebx+dNcgHMUayZeUn5FQmsGft6igue
  cFbM+b6AuYFxH0cXIxeHkMA6Ronv794xdzFyAjkVEvNvHGIBsXkFkiV2fP3PCGJzCjhKHOxdx
  wpR4yDRePsvG4jNJmAoMe/Ne7AaFgFViYWPNoLFhQU8JTYf7mIHsUUEPCRat28Am88sECtxft
  5SqPmCEidnPmGBiEtIHHzxAqiGA2i+lsTyY5EgYQkBe4np76+ChSUE9CUaj8VChA0lvs/6xgJ
  hm0vcXv2AdQKj4CwkQ2chGbqAkWkVo3lSUWZ6RkluYmaOrqGBga6hoZGuoaWxrqm5XmKVbqJe
  aqlueWpxia6hXmJ5sV5xZW5yTopeXmrJJkZgcKcUHLTcwXhqefohRkkOJiVR3r6uuhghvqT8l
  MqMxOKM+KLSnNTiQ4wyHBxKErwOu4BygkWp6akVaZk5wDiDSUtw8CiJ8IrvBErzFhck5hZnpk
  OkTjHqcpxe+HAusxBLXn5eqpQ47ymQIgGQoozSPLgRsJi/xCgrJczLyMDAIMRTkFqUm1mCKv+
  KUZyDUUmYlwVkCk9mXgncpldARzABHfH5cjXIESWJCCmpBkbJuxcrNP/GP5L5kuXFLndy5nxm
  fc0XK6OtF/iJ3eX4dHXKwpvMnBHis9dpCZ/ROCV2s01cPkxswambTk7NXz2nrD7swKOis+i++
  tY5ITLHNZ7E/Ih9GPaQ50v7Ue5mwZdsb458DZvauFY173Z7e2f2ej+fMKWHmoc38mvzTdpwbl
  mDtO3vGjYlluKMREMt5qLiRABXxaEh9AIAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!3
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30137 invoked from network); 5 Mar 2019 18:08:27 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:27 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:25 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 2B7343FBE8; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <0181de94266385cfffe1c2cd0c199f1c49ca6b7b.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:19:34 +0000
Subject: [PATCH 02/13] regulator: da9062: Fix notifier mutex lock warning
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 05/03/2019 17:23:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: 4068e5182ada ("regulator: da9062: DA9062 regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/da9062-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 34a70d9..5224304 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -974,8 +974,10 @@ static irqreturn_t da9062_ldo_lim_event(int irq, void *data)
 			continue;
 
 		if (BIT(regl->info->oc_event.lsb) & bits) {
+			regulator_lock(regl->rdev);
 			regulator_notifier_call_chain(regl->rdev,
 					REGULATOR_EVENT_OVER_CURRENT, NULL);
+			regulator_unlock(regl->rdev);
 			handled = IRQ_HANDLED;
 		}
 	}
-- 
1.9.3

