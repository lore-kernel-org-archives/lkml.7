Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132C1C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E674E218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfGDJfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:35:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54286 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfGDJfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:35:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7CFF200D8D;
        Thu,  4 Jul 2019 11:35:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D0589200F81;
        Thu,  4 Jul 2019 11:35:02 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F0E5B402C0;
        Thu,  4 Jul 2019 17:34:53 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, ping.bai@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Date:   Thu,  4 Jul 2019 17:25:59 +0800
Message-Id: <20190704092600.38015-1-Anson.Huang@nxp.com>
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
New patch.
---
 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index 13e0951..bc24c45 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -7,7 +7,7 @@ controller binding usage.
 Required properties:
 - compatible:
 	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
-	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
+	- For i.MX8MQ/i.MX8MM SoCs should be "fsl,imx8mq-src", "syscon"
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain SRC interrupt
@@ -47,4 +47,4 @@ Example:
 
 For list of all valid reset indices see
 <dt-bindings/reset/imx7-reset.h> for i.MX7 and
-<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ/i.MX8MM
-- 
2.7.4

