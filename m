Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BCEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA19C20645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfCESIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:36 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:24953 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730872AbfCESIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:32 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 22/6E-26211-C1BBE7C5; Tue, 05 Mar 2019 18:08:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRWlGSWpSXmKPExsVy8IPnUV2Z3XU
  xBjsWS1hMffiEzeLblQ4mi8u75rA5MHvsnHWX3WPTqk42j8+b5AKYo1gz85LyKxJYMzadqirY
  zVtxfUc3ewPjdO4uRi4OIYF1jBJXzu1g72LkBHIqJJY2LmYBsXkFkiVevTkPFucUcJQ42LuOF
  aLGQaLx9l82EJtNwFBi3pv3jCA2i4CqxO8Vv8FsYQEviXvvL4PViAh4SLRu38AMYjMLxEqcn7
  cUar6gxMmZT1gg4hISB1+8AKrhAJqvJbH8WCRIWELAXmL6+6tgYQkBfYnGY7EQYUOJ77O+sUD
  Y5hK3Vz9gncAoOAvJ0FlIhi5gZFrFaJFUlJmeUZKbmJmja2hgoGtoaKRraAnEFuZ6iVW6iXqp
  pbrlqcUluoZ6ieXFesWVuck5KXp5qSWbGIHhnVJwYPcOxvdd6YcYJTmYlER5O3fVxQjxJeWnV
  GYkFmfEF5XmpBYfYpTh4FCS4HUAyQkWpaanVqRl5gAjDSYtwcGjJMJbDpLmLS5IzC3OTIdInW
  LU5Ti98OFcZiGWvPy8VClx3lM7gYoEQIoySvPgRsCi/hKjrJQwLyMDA4MQT0FqUW5mCar8K0Z
  xDkYlYd5qkFU8mXklcJteAR3BBHTE58vVIEeUJCKkpBoYj1hpHVIJdhDV9jsdNm/y/y7bBZ0r
  9BKtq9dXc+29+OJUWGtxRtV8MX5nv/7pR9pyJe7Zm5iuVdG8x9OdeuHUxwcvrTyjuTTF+mPSJ
  YJ+rdlgI7LAuOSL1x3m1gZP7s6T6leSL6VrMKvpLUiUVYn8wGqlXjRlJW/Wlj/G+VN6pQKUbn
  lNLVdiKc5INNRiLipOBAAk7tZM9QIAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!10
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30277 invoked from network); 5 Mar 2019 18:08:28 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:28 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:27 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 3FDFE3FC14; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <0e0ffab52b8defcccf8b64ac3f0badbc9dacfcda.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:46:55 +0000
Subject: [PATCH 10/13] regulator: pv88090: Fix notifier mutex lock warning
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

Fixes: c90456e36d9c ("regulator: pv88090: new regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/pv88090-regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index 7a0c159..b4ff646 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -274,9 +274,11 @@ static irqreturn_t pv88090_irq_handler(int irq, void *data)
 	if (reg_val & PV88090_E_VDD_FLT) {
 		for (i = 0; i < PV88090_MAX_REGULATORS; i++) {
 			if (chip->rdev[i] != NULL) {
+			        regulator_lock(chip->rdev[i]);
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_UNDER_VOLTAGE,
 					NULL);
+			        regulator_unlock(chip->rdev[i]);
 			}
 		}
 
@@ -291,9 +293,11 @@ static irqreturn_t pv88090_irq_handler(int irq, void *data)
 	if (reg_val & PV88090_E_OVER_TEMP) {
 		for (i = 0; i < PV88090_MAX_REGULATORS; i++) {
 			if (chip->rdev[i] != NULL) {
+			        regulator_lock(chip->rdev[i]);
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_OVER_TEMP,
 					NULL);
+			        regulator_unlock(chip->rdev[i]);
 			}
 		}
 
-- 
1.9.3

