Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255512171F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfCESIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:32 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:11250 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbfCESIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:30 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id F8/1D-18573-B1BBE7C5; Tue, 05 Mar 2019 18:08:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRWlGSWpSXmKPExsVy8IPnUV2p3XU
  xBt8vG1tMffiEzeLblQ4mi8u75rA5MHvsnHWX3WPTqk42j8+b5AKYo1gz85LyKxJYM37MXcZW
  cJWzYt/XD4wNjLs5uhi5OIQE1jFKfH/3jrmLkRPIqZBYtvQdE4jNK5AssfDIE0YQm1PAUeJg7
  zpWiBoHicbbf9lAbDYBQ4l5b94D1XBwsAioSjy4GwYSFhbwlNh5finYSBEBD4nW7RvAbGaBWI
  nz85ayQIwXlDg58wkLRFxC4uCLF8wgY4QEtCSWH4sECUsI2EtMf38VLCwhoC/ReCwWImwo8X3
  WNxYI21zi9uoHrBMYBWchGToLydAFjEyrGM2TijLTM0pyEzNzdA0NDHQNDY10DS2NdU3N9RKr
  dBP1Ukt1y1OLS3QN9RLLi/WKK3OTc1L08lJLNjECgzul4KDlDsZTy9MPMUpyMCmJ8vZ11cUI8
  SXlp1RmJBZnxBeV5qQWH2KU4eBQkuB12AWUEyxKTU+tSMvMAcYZTFqCg0dJhFd8J1Cat7ggMb
  c4Mx0idYpRl+P0wodzmYVY8vLzUqXEeU+BFAmAFGWU5sGNgMX8JUZZKWFeRgYGBiGegtSi3Mw
  SVPlXjOIcjErCvCwgU3gy80rgNr0COoIJ6IjPl6tBjihJREhJNTB6+Mspcs9eptcUXuT96JCt
  grh70aUNU3scBbdr1BqcvrYnevJFlboJNy7dfLtx9rctu+9wNRsHGwR32NyN6Gbdf0lTpqH+r
  Gje0ksbz5jaNcdfn293udp5QuCtJQeeT7zQvUGzcvZ26VfmSmeNnh57anbE947f28VyfD3u9/
  NO5pWudi/O3tClxFKckWioxVxUnAgAU699t/QCAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!2
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30120 invoked from network); 5 Mar 2019 18:08:26 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:26 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:25 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 2942C3FAF4; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <8c6986eee295d5859c8267f0228f7508a22bd4fd.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 14:59:59 +0000
Subject: [PATCH 01/13] regulator: da9055: Fix notifier mutex lock warning
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

Fixes: f6130be652d0 ("regulator: DA9055 regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/da9055-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 588c3d24..acba42d 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -515,8 +515,10 @@ static irqreturn_t da9055_ldo5_6_oc_irq(int irq, void *data)
 {
 	struct da9055_regulator *regulator = data;
 
+	regulator_lock(regulator->rdev);
 	regulator_notifier_call_chain(regulator->rdev,
 				      REGULATOR_EVENT_OVER_CURRENT, NULL);
+	regulator_unlock(regulator->rdev);
 
 	return IRQ_HANDLED;
 }
-- 
1.9.3

