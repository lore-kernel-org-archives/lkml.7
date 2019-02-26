Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5F8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3958420645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfCESIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:34 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:24953 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbfCESIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:31 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 7D/5E-26211-C1BBE7C5; Tue, 05 Mar 2019 18:08:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRWlGSWpSXmKPExsVy8IPnUV3p3XU
  xBlOe2FhMffiEzeLblQ4mi8u75rA5MHvsnHWX3WPTqk42j8+b5AKYo1gz85LyKxJYM1p//GQs
  WMZXsXLDAdYGxkk8XYxcHEIC6xglljXMYO9i5ARyKiQezDnPBGLzCiRLTN7ZDWZzCjhKHOxdx
  wpR4yDRePsvG4jNJmAoMe/Ne0YQm0VAVeLH2UksILawgJfEx58fwGaKCHhItG7fwAxiMwvESp
  yft5QFYr6gxMmZT1gg4hISB1+8AKrhAJqvJbH8WCRIWELAXmL6+6tgYQkBfYnGY7EQYUOJ77O
  +sUDY5hK3Vz9gncAoOAvJ0FlIhi5gZFrFaJFUlJmeUZKbmJmja2hgoGtoaKRraGmia2RkqpdY
  pZuol1qqW55aXKJrqJdYXqxXXJmbnJOil5dasokRGOApBYce7mA8tzz9EKMkB5OSKG/nrroYI
  b6k/JTKjMTijPii0pzU4kOMMhwcShK8DiA5waLU9NSKtMwcYKzBpCU4eJREeMtB0rzFBYm5xZ
  npEKlTjLocpxc+nMssxJKXn5cqJc57aidQkQBIUUZpHtwIWNxfYpSVEuZlZGBgEOIpSC3KzSx
  BlX/FKM7BqCTMWw2yiiczrwRu0yugI5iAjvh8uRrkiJJEhJRUA2P0ip/SkZdfiUg6WcanfT/2
  x2O7acpb27tdZQdmedVs3X5g0YKUeb7M7Bdf6eZMS5qzIl/6ZybbspaMx5Nff3o068+f3YwV/
  p4qpzhqbMQOsbzoXa1/wWsRP5P9kx1uJRI7hbdWnq6ZuMRD8eTbK+sya55sOOa4arFFmBTbfG
  P752l+1fH71V8qsRRnJBpqMRcVJwIASHtx+/YCAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!8
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30218 invoked from network); 5 Mar 2019 18:08:27 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:27 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:26 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 382AB3FC11; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <62744c91911e8b7f9b5dadc1bbc278f69c499330.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:38:56 +0000
Subject: [PATCH 07/13] regulator: ltc3676: Fix notifier mutex lock warning
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

Fixes: 37b918a034fe ("regulator: Add LTC3676 support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/ltc3676.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 71fd0f2..cd0f112 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -338,17 +338,23 @@ static irqreturn_t ltc3676_isr(int irq, void *dev_id)
 	if (irqstat & LTC3676_IRQSTAT_THERMAL_WARN) {
 		dev_warn(dev, "Over-temperature Warning\n");
 		event = REGULATOR_EVENT_OVER_TEMP;
-		for (i = 0; i < LTC3676_NUM_REGULATORS; i++)
+		for (i = 0; i < LTC3676_NUM_REGULATORS; i++) {
+			regulator_lock(ltc3676->regulators[i]);
 			regulator_notifier_call_chain(ltc3676->regulators[i],
 						      event, NULL);
+			regulator_unlock(ltc3676->regulators[i]);
+		}
 	}
 
 	if (irqstat & LTC3676_IRQSTAT_UNDERVOLT_WARN) {
 		dev_info(dev, "Undervoltage Warning\n");
 		event = REGULATOR_EVENT_UNDER_VOLTAGE;
-		for (i = 0; i < LTC3676_NUM_REGULATORS; i++)
+		for (i = 0; i < LTC3676_NUM_REGULATORS; i++) {
+			regulator_lock(ltc3676->regulators[i]);
 			regulator_notifier_call_chain(ltc3676->regulators[i],
 						      event, NULL);
+			regulator_unlock(ltc3676->regulators[i]);
+		}
 	}
 
 	/* Clear warning condition */
-- 
1.9.3

