Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010C120842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfCESJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:09:14 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:11250 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730854AbfCESIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:32 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 96/2D-18573-C1BBE7C5; Tue, 05 Mar 2019 18:08:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRWlGSWpSXmKPExsVy8IPnUV2Z3XU
  xBkcX8VpMffiEzeLblQ4mi8u75rA5MHvsnHWX3WPTqk42j8+b5AKYo1gz85LyKxJYMy7N6Gcs
  mM9bMf3NfPYGxuncXYxcHEIC6xglljXMYO9i5ARyKiT2P2pmBrF5BZIl/i7eARbnFHCUONi7j
  hWixkGi8fZfNhCbTcBQYt6b94wgNouAqsTi1hksILawgJfEjx/9YHNEBDwkWrdvALOZBWIlzs
  9bygIxX1Di5MwnLBBxCYmDL14A1XAAzdeSWH4sEiQsIWAvMf39VbCwhIC+ROOxWIiwocT3Wd9
  YIGxzidurH7BOYBSchWToLCRDFzAyrWK0SCrKTM8oyU3MzNE1NDDQNTQ00jW0NNY1MjbRS6zS
  TdRLLdUtTy0u0TXUSywv1iuuzE3OSdHLSy3ZxAgM8JSCg692MO5akX6IUZKDSUmUt3NXXYwQX
  1J+SmVGYnFGfFFpTmrxIUYZDg4lCV4HkJxgUWp6akVaZg4w1mDSEhw8SiK85SBp3uKCxNzizH
  SI1ClGXY7TCx/OZRZiycvPS5US5z21E6hIAKQoozQPbgQs7i8xykoJ8zIyMDAI8RSkFuVmlqD
  Kv2IU52BUEuatBlnFk5lXArfpFdARTEBHfL5cDXJESSJCSqqBMb9z+b9npvHKx7/a/zn3NH6l
  FEuB7KSZTAufLPU1vaFn6yTOMGfZo+M77/zosZMUWFJuqbXbpkd/+qtOxc8W8vqfgySFxAWXc
  Mq+0eC1n9F0tzp/U1XQgYpm47rHC+9emLmhyNHvuvSFWZO73ZbsEf7fuXKl6trXG/7ZbfPX/r
  yCO6v0ajCTjhJLcUaioRZzUXEiAI0B9Rr2AgAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!9
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30236 invoked from network); 5 Mar 2019 18:08:28 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:28 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:26 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 3AC633FC12; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <2f9f4986527b5c9784b4ad19f0b07543be6f97d5.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:42:50 +0000
Subject: [PATCH 08/13] regulator: pv88060: Fix notifier mutex lock warning
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

Fixes: f307a7e9b7af ("regulator: pv88060: new regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/pv88060-regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index a944605..000c349 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -276,9 +276,11 @@ static irqreturn_t pv88060_irq_handler(int irq, void *data)
 	if (reg_val & PV88060_E_VDD_FLT) {
 		for (i = 0; i < PV88060_MAX_REGULATORS; i++) {
 			if (chip->rdev[i] != NULL) {
+				regulator_lock(chip->rdev[i]);
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_UNDER_VOLTAGE,
 					NULL);
+				regulator_unlock(chip->rdev[i]);
 			}
 		}
 
@@ -293,9 +295,11 @@ static irqreturn_t pv88060_irq_handler(int irq, void *data)
 	if (reg_val & PV88060_E_OVER_TEMP) {
 		for (i = 0; i < PV88060_MAX_REGULATORS; i++) {
 			if (chip->rdev[i] != NULL) {
+				regulator_lock(chip->rdev[i]);
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_OVER_TEMP,
 					NULL);
+				regulator_unlock(chip->rdev[i]);
 			}
 		}
 
-- 
1.9.3

