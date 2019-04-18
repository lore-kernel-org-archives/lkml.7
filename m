Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA082C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9201421850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbfDRGlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:41:32 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.130]:43749 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbfDRGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:41:31 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.eu-west-1.aws.symcld.net id D4/8E-23848-81C18BC5; Thu, 18 Apr 2019 06:41:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsVy8MN7XV1xmR0
  xBhMeGltMffiEzWL+kXOsFk3fVzNbfLvSwWRxedccNoul1y8yWbTuPcLuwO6xZt4aRo+ds+6y
  e2xa1cnm8XmTXABLFGtmXlJ+RQJrxoWvIQVnOCu2ff/O2sC4ib2LkYtDSGAto8SqzmmsXYycQ
  E6FxMkVv9hBbF4BF4k530+AxdkETCQ2HdnDCGKzCKhKvPz2jQXEFhawk1j7exMziC0ikC1xd9
  lJsKHMAlsYJXZtmMgGMUhQ4uTMJ2ANzAISEgdfvGCGWKYn0T15HtgCCQF7ienvrzJD2PoSL79
  uZIKwDSW+z4JYJiFgLjHzzx2oGmuJ6x9msU1gFJiFZMUsJCsWMDKtYrRIKspMzyjJTczM0TU0
  MNA1NDTSNTIw0jU0MtFLrNJN1kst1S1PLS7RNdRLLC/WK67MTc5J0ctLLdnECAz/lIJTNTsYp
  3enH2KU5GBSEuUtEd0RI8SXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCt1sKKCdYlJqeWpGWmQOMRJ
  i0BAePkgjvPJA0b3FBYm5xZjpE6hSjopQ472aQhABIIqM0D64NFv2XGGWlhHkZGRgYhHgKUot
  yM0tQ5V8xinMwKgnzHgKZwpOZVwI3/RXQYiagxVN0VoMsLklESEk1MM4WuFu+sNu6hbnlxwtf
  znsdps9Td3f7HfKUuOnGs/6Rm1B2/ZfdYTr+G1dMmjS3IY+fU+/LVlfNG80HbvmeFfre1XMmM
  UfO1Wv3ZKvuvSvCb88uS+5Wl577IbT1nsK/R2+kJ+9PUzPJ7/ksv//ZC77AFeXv98zLnq4hoK
  9t+mnjlrsszSKfjZVYijMSDbWYi4oTAT2VIv/5AgAA
X-Env-Sender: eric.jeong.opensource@diasemi.com
X-Msg-Ref: server-19.tower-302.messagelabs.com!1555569687!6616895!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28235 invoked from network); 18 Apr 2019 06:41:27 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-19.tower-302.messagelabs.com with AES128-SHA256 encrypted SMTP; 18 Apr 2019 06:41:27 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Apr 2019 08:41:26 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22095)      id
 B9FD05F7FC; Thu, 18 Apr 2019 15:41:24 +0900 (KST)
Message-ID: <cover.1555567784.git.eric.jeong.opensource@diasemi.com>
From:   Eric Jeong <eric.jeong.opensource@diasemi.com>
Date:   Thu, 18 Apr 2019 15:09:44 +0900
Subject: [PATCH V2 0/3]  slg51000: regulator driver submission
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: NB-EX-CASHUB01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 18.04.2019 02:42:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds support for the Dialog SLG51000 regulator device.

In this patch set the following is provided:

[PATCH V2 1/3] MAINTAINERS file update for SLG51000
[PATCH V2 2/3] SLG51000 DT binding
[PATCH V2 3/3] SLG51000 regulator driver

This patch applies against linux-next and next-20190417 

Thank you,
Eric Jeong, Dialog Semiconductor Ltd.

Eric Jeong (3):
  MAINTAINERS: slg51000 updates to the Dialog Semiconductor search
    terms
  dt-bindings: regulator: add document bindings for slg51000
  regulator: slg51000: add slg51000 regulator driver

 .../devicetree/bindings/regulator/slg51000.txt     |   88 ++++
 MAINTAINERS                                        |    2 +
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/slg51000-regulator.c             |  528 ++++++++++++++++++++
 drivers/regulator/slg51000-regulator.h             |  505 +++++++++++++++++++
 6 files changed, 1133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/slg51000.txt
 create mode 100644 drivers/regulator/slg51000-regulator.c
 create mode 100644 drivers/regulator/slg51000-regulator.h

-- 
end-of-patch for PATCH V2

