Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F2C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 22:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC6E21019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 22:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfHQWrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 18:47:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52818 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfHQWrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 18:47:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 893F120068D;
        Sun, 18 Aug 2019 00:47:00 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A39612000C7;
        Sun, 18 Aug 2019 00:46:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D24C140314;
        Sun, 18 Aug 2019 06:46:42 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 3/6] cpufreq: Use imx-cpufreq-dt for i.MX8MN's speed grading
Date:   Sat, 17 Aug 2019 18:28:17 -0400
Message-Id: <1566080900-2539-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566080900-2539-1-git-send-email-Anson.Huang@nxp.com>
References: <1566080900-2539-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8MN to blacklist, so that imx-cpufreq-dt driver can handle
speed grading bits just like other i.MX8M SoCs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ec2057d..febcec8 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -109,6 +109,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "fsl,imx7d", },
 	{ .compatible = "fsl,imx8mq", },
 	{ .compatible = "fsl,imx8mm", },
+	{ .compatible = "fsl,imx8mn", },
 
 	{ .compatible = "marvell,armadaxp", },
 
-- 
2.7.4

