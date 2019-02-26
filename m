Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5952620645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfCESI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:58 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:19702 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730889AbfCESIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:34 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 82/3D-18573-D1BBE7C5; Tue, 05 Mar 2019 18:08:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRWlGSWpSXmKPExsVy8IPnUV3Z3XU
  xBo8ei1lMffiEzeLblQ4mi8u75rBZfH6/n9WBxWPnrLvsHptWdbJ5TJ/zn9Hj8ya5AJYo1sy8
  pPyKBNaM3TMWMhas5axYNX8XUwNjO0cXIxeHkMA6Rokr53awdzFyAjkVEj2tX9m6GDk4eAWSJ
  Za0m4OEOQUcJQ72rmOFKHGQaLz9lw3EZhMwlJj35j0jiM0ioCrx5OVLsDHCAr4Sy/9MZgaxRQ
  Q8JFq3b2AG2cUs0Mcosfn8BbBmXgFBiZMzn7CA2MwCEhIHX7xgBtkrJKAlsfxYJEhYQsBeYvr
  7q2BhCQF9icZjsRBhQ4nvs76xQNjmErdXP2CdwCg4C8nQWUiGLmBkWsVonlSUmZ5RkpuYmaNr
  aGCga2hopGtoaaxrYqyXWKWbqJdaqlueWlyia6iXWF6sV1yZm5yTopeXWrKJERjyKQUHtXcwP
  lmefohRkoNJSZS3c1ddjBBfUn5KZUZicUZ8UWlOavEhRhkODiUJXgeQnGBRanpqRVpmDjD6YN
  ISHDxKIrzlIGne4oLE3OLMdIjUKUZdjtMLH85lFmLJy89LlRLnPbUTqEgApCijNA9uBCwRXGK
  UlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzFsNsoonM68EbtMroCOYgI74fLka5IiSRISUVANj
  6n8lrve7p81R3/xqCT9rwmmvgnrrv8bnO98rf3CpE0q00YoPP7KMfdnyY982KRnwispuuBuwK
  zb89POnOSxu5g+THrtH6XPqTfywPVD+j3ydeNGUPU2fT8iePfzO0cryp+5yMUe3IwWuwZdufF
  CceGv6qQWevFv6/jQF3ffXV59zsFBoeWKZEktxRqKhFnNRcSIA68fRr/8CAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!14
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30353 invoked from network); 5 Mar 2019 18:08:29 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:29 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:27 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 477323FC17; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <f2a9f1b5ced38ac25303fbe746022f00b8b17ce7.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:54:01 +0000
Subject: [PATCH 13/13] regulator: wm831x ldo: Fix notifier mutex lock warning
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cirrus Patches <patches@opensource.cirrus.com>
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

Fixes: d1c6b4fe668b ("regulator: Add WM831x LDO support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/wm831x-ldo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index e4a6f88..fcd038e 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -51,9 +51,11 @@ static irqreturn_t wm831x_ldo_uv_irq(int irq, void *data)
 {
 	struct wm831x_ldo *ldo = data;
 
+	regulator_lock(ldo->regulator);
 	regulator_notifier_call_chain(ldo->regulator,
 				      REGULATOR_EVENT_UNDER_VOLTAGE,
 				      NULL);
+	regulator_unlock(ldo->regulator);
 
 	return IRQ_HANDLED;
 }
-- 
1.9.3

