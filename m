Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7094C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7D2214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404011AbfFKGb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:31:59 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44710 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403759AbfFKGb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:31:58 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AD20200210;
        Tue, 11 Jun 2019 08:31:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F3F7C200033;
        Tue, 11 Jun 2019 08:31:48 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D4E91402CA;
        Tue, 11 Jun 2019 14:31:39 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        aisheng.dong@nxp.com, ulf.hansson@linaro.org, peng.fan@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] rtc: imx-sc: Make compatible string more generic
Date:   Tue, 11 Jun 2019 14:33:32 +0800
Message-Id: <20190611063333.48501-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611063333.48501-1-Anson.Huang@nxp.com>
References: <20190611063333.48501-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX system controller RTC driver can support all i.MX SoCs
with system controller inside, this patch makes the compatible
string more generic to support other i.MX SoCs with system
controller inside, such as i.MX8QM etc..

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/rtc/rtc-imx-sc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index c933045..38ef3ca 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -178,7 +178,7 @@ static int imx_sc_rtc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_sc_dt_ids[] = {
-	{ .compatible = "fsl,imx8qxp-sc-rtc", },
+	{ .compatible = "fsl,imx-sc-rtc", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, imx_sc_dt_ids);
-- 
2.7.4

