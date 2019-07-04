Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D7AC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849C921882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfGDJx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:53:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54726 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbfGDJx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:53:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7D1A2001B6;
        Thu,  4 Jul 2019 11:53:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CEEB62005A0;
        Thu,  4 Jul 2019 11:53:17 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 08E22402DF;
        Thu,  4 Jul 2019 17:53:08 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, ping.bai@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Date:   Thu,  4 Jul 2019 17:44:15 +0800
Message-Id: <20190704094416.4757-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MM can reuse i.MX8MQ's reset driver, update the compatible
property and related info to support i.MX8MM.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- Add separate line for i.MX8MM in case anything different later for i.MX8MM.
---
 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index 13e0951..c2489e4 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible:
 	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
 	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
+	- For i.MX8MM SoCs should be "fsl,imx8mm-src", "fsl,imx8mq-src", "syscon"
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain SRC interrupt
@@ -46,5 +47,6 @@ Example:
 
 
 For list of all valid reset indices see
-<dt-bindings/reset/imx7-reset.h> for i.MX7 and
-<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
+<dt-bindings/reset/imx7-reset.h> for i.MX7,
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ and
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MM
-- 
2.7.4

