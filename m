Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE98C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC59E20645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfCESJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:09:21 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:23902 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfCESIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:31 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id C0/C0-19701-B1BBE7C5; Tue, 05 Mar 2019 18:08:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRWlGSWpSXmKPExsVy8IPnUV3p3XU
  xBovO8FtMffiEzeLblQ4mi8u75rA5MHvsnHWX3WPTqk42j8+b5AKYo1gz85LyKxJYM56uuM5S
  8IerYlP/daYGxp2cXYxcHEIC6xglvr97x9zFyAnkVEg8mLSABcTmFUiWOPjuLTuIzSngKHGwd
  x0rRI2DROPtv2wgNpuAocS8N+8Zuxg5OFgEVCUOHsgGCQsLeEq8+NUKViIi4CHRun0D2HhmgV
  iJ8/OWQo0XlDg58wkLRFxC4uCLF8wgY4QEtCSWH4sECUsI2EtMf38VLCwhoC/ReCwWImwo8X3
  WNxYI21zi9uoHrBMYBWchGToLydAFjEyrGC2SijLTM0pyEzNzdA0NDHQNDY10DS2B2MJcL7FK
  N1EvtVS3PLW4RNdQL7G8WK+4Mjc5J0UvL7VkEyMwvFMKDuzewfi+K/0QoyQHk5Iob+euuhghv
  qT8lMqMxOKM+KLSnNTiQ4wyHBxKErwOIDnBotT01Iq0zBxgpMGkJTh4lER4y0HSvMUFibnFme
  kQqVOMuhynFz6cyyzEkpeflyolzntqJ1CRAEhRRmke3AhY1F9ilJUS5mVkYGAQ4ilILcrNLEG
  Vf8UozsGoJMxbDbKKJzOvBG7TK6AjmICO+Hy5GuSIkkSElFQDY3A7x5GioLdd/74+OPbikEz7
  QdN9Z//O2veU+efvqfMZFhXJur9c0ab48+xVh1Vq4otninboxcZWfJwdvjeX+4BzgZFhldveV
  zWXo4x8FEU3vXg6735KC0tTxbGW3XG7twWLFzdNfWrRviDzkV6Z2x7Jyd6V3D7LNc5P6TkeKC
  2T/GHhQaUpB5VYijMSDbWYi4oTAXl/yxT1AgAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!4
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30154 invoked from network); 5 Mar 2019 18:08:27 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:27 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:25 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 2E08C3FBEC; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <1215fdadbb4fceb0a500102dbcc69df79e685875.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:23:02 +0000
Subject: [PATCH 03/13] regulator: da9063: Fix notifier mutex lock warning
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

Fixes: 69ca3e58d178 ("regulator: da9063: Add Dialog DA9063 voltage regulators support.")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/da9063-regulator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 8cbcd2a..d3ea73a 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -615,9 +615,12 @@ static irqreturn_t da9063_ldo_lim_event(int irq, void *data)
 		if (regl->info->oc_event.reg != DA9063_REG_STATUS_D)
 			continue;
 
-		if (BIT(regl->info->oc_event.lsb) & bits)
+		if (BIT(regl->info->oc_event.lsb) & bits) {
+		        regulator_lock(regl->rdev);
 			regulator_notifier_call_chain(regl->rdev,
 					REGULATOR_EVENT_OVER_CURRENT, NULL);
+		        regulator_unlock(regl->rdev);
+		}
 	}
 
 	return IRQ_HANDLED;
-- 
1.9.3

