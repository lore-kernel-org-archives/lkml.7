Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E762C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6F820645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfCESJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:09:34 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:21484 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbfCESIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:31 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 8F/57-04122-C1BBE7C5; Tue, 05 Mar 2019 18:08:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRWlGSWpSXmKPExsVy8IPnUV3p3XU
  xBj+nGFlMffiEzeLblQ4mi8u75rA5MHvsnHWX3WPTqk42j8+b5AKYo1gz85LyKxJYM5q3rmIu
  eMFbcXDBHrYGxkPcXYxcHEIC6xglljXMYO9i5ARyKiS+dX9mBLF5BZIlfp5qAYtzCjhKHOxdx
  wpR4yDRePsvG4jNJmAoMe/Ne7B6FgFViT83LoHVCAt4SezpXs0EYosIeEi0bt/ADGIzC8RKnJ
  +3lAVivqDEyZlPWCDiEhIHX7wAquEAmq8lsfxYJEhYQsBeYvr7q2BhCQF9icZjsRBhQ4nvs76
  xQNjmErdXP2CdwCg4C8nQWUiGLmBkWsVokVSUmZ5RkpuYmaNraGCga2hopGtoCcQW5nqJVbqJ
  eqmluuWpxSW6hnqJ5cV6xZW5yTkpenmpJZsYgQGeUnBg9w7G913phxglOZiURHk7d9XFCPEl5
  adUZiQWZ8QXleakFh9ilOHgUJLgdQDJCRalpqdWpGXmAGMNJi3BwaMkwlsOkuYtLkjMLc5Mh0
  idYtTlOL3w4VxmIZa8/LxUKXHeUzuBigRAijJK8+BGwOL+EqOslDAvIwMDgxBPQWpRbmYJqvw
  rRnEORiVh3mqQVTyZeSVwm14BHcEEdMTny9UgR5QkIqSkGhjrZj/ZpvfQ5d7TO/PS4o5ejTm8
  In9TUhOrujmTYcf96L7125L6Ji6u+XHdwfaPfyP7L465tU3nBcVTUh4nz/L9/X1F4p0Jao+vK
  7LFS2zZxxwUx/Xz093zf+YvPawcJKqgtWFzSeOhlDK2ZSXPhdOkjt3z5A/beYyXvd/xeo3i53
  9bwp22/IpQYinOSDTUYi4qTgQAdJhUa/YCAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!7
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30202 invoked from network); 5 Mar 2019 18:08:27 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:27 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:26 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 3599E3FC10; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <d1c5bb5537d506e086bd31fc8fc011083ca4f73d.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:35:35 +0000
Subject: [PATCH 06/13] regulator: ltc3589: Fix notifier mutex lock warning
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

Fixes: 3eb2c7ecb7ea ("regulator: Add LTC3589 support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/ltc3589.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 63f724f..75089b0 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -419,16 +419,22 @@ static irqreturn_t ltc3589_isr(int irq, void *dev_id)
 
 	if (irqstat & LTC3589_IRQSTAT_THERMAL_WARN) {
 		event = REGULATOR_EVENT_OVER_TEMP;
-		for (i = 0; i < LTC3589_NUM_REGULATORS; i++)
+		for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
+		        regulator_lock(ltc3589->regulators[i]);
 			regulator_notifier_call_chain(ltc3589->regulators[i],
 						      event, NULL);
+		        regulator_unlock(ltc3589->regulators[i]);
+		}
 	}
 
 	if (irqstat & LTC3589_IRQSTAT_UNDERVOLT_WARN) {
 		event = REGULATOR_EVENT_UNDER_VOLTAGE;
-		for (i = 0; i < LTC3589_NUM_REGULATORS; i++)
+		for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
+		        regulator_lock(ltc3589->regulators[i]);
 			regulator_notifier_call_chain(ltc3589->regulators[i],
 						      event, NULL);
+		        regulator_unlock(ltc3589->regulators[i]);
+		}
 	}
 
 	/* Clear warning condition */
-- 
1.9.3

