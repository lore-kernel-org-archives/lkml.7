Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D600BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF87420645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbfCESI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:58 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:23902 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbfCESId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:33 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 2D/C0-19701-C1BBE7C5; Tue, 05 Mar 2019 18:08:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRWlGSWpSXmKPExsVy8IPnUV2Z3XU
  xBhOeqVhMffiEzeLblQ4mi8u75rA5MHvsnHWX3WPTqk42j8+b5AKYo1gz85LyKxJYM573PmQs
  2M1bseDld8YGxuncXYxcHEIC6xglrpzbwd7FyAnkVEj0TO1nArF5BZIllt/6xgJicwo4ShzsX
  ccKUeMg0Xj7LxuIzSZgKDHvzXtGEJtFQFWicfEfoF4ODmEBL4npD2VAwiICHhKt2zcwg9jMAr
  ES5+ctZYEYLyhxcuYTFoi4hMTBFy+YQVqFBLQklh+LBAlLCNhLTH9/FSwsIaAv0XgsFiJsKPF
  9FsRhEgLmErdXP2CdwCg4C8nQWUiGLmBkWsVokVSUmZ5RkpuYmaNraGCga2hopGtoCcQW5nqJ
  VbqJeqmluuWpxSW6hnqJ5cV6xZW5yTkpenmpJZsYgeGdUnBg9w7G913phxglOZiURHk7d9XFC
  PEl5adUZiQWZ8QXleakFh9ilOHgUJLgdQDJCRalpqdWpGXmACMNJi3BwaMkwlsOkuYtLkjMLc
  5Mh0idYtTlOL3w4VxmIZa8/LxUKXHeUzuBigRAijJK8+BGwKL+EqOslDAvIwMDgxBPQWpRbmY
  JqvwrRnEORiVh3mqQVTyZeSVwm14BHcEEdMTny9UgR5QkIqSkGhg5FRS31f7eaur3XuCru71T
  230Zc105UZECYem6NQlF2on/3OdyRZv7G4pPa6iv+DPn+hI+C8uZqlLz72jfqtCfeTvueM28a
  O60gu9Ldv6JZLXjVnG2TE9rvFLxLTbe5ZhAWnNs1rq6g1nsrFbb49ZvF/ErNJ+w3GKfonjwgr
  MH389IEq5VUGIpzkg01GIuKk4EACDNLIP1AgAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!11
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30295 invoked from network); 5 Mar 2019 18:08:28 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:28 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:27 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 3D5353FC13; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <5e20135242879861f22f5cb5fcba0cb481e754cc.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:44:54 +0000
Subject: [PATCH 09/13] regulator: pv88080: Fix notifier mutex lock warning
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

Fixes: 99cf3af5e2d5 ("regulator: pv88080: new regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/pv88080-regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 9a08cb2..d99f1b9 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -384,9 +384,11 @@ static irqreturn_t pv88080_irq_handler(int irq, void *data)
 	if (reg_val & PV88080_E_VDD_FLT) {
 		for (i = 0; i < PV88080_MAX_REGULATORS; i++) {
 			if (chip->rdev[i] != NULL) {
+			        regulator_lock(chip->rdev[i]);
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_UNDER_VOLTAGE,
 					NULL);
+			        regulator_unlock(chip->rdev[i]);
 			}
 		}
 
@@ -401,9 +403,11 @@ static irqreturn_t pv88080_irq_handler(int irq, void *data)
 	if (reg_val & PV88080_E_OVER_TEMP) {
 		for (i = 0; i < PV88080_MAX_REGULATORS; i++) {
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

