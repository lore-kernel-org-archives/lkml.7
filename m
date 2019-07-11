Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604D1C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3493A20844
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfGKCqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 22:46:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38880 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfGKCqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 22:46:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93A93200E89;
        Thu, 11 Jul 2019 04:46:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C9697200E7E;
        Thu, 11 Jul 2019 04:46:22 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 78632402DB;
        Thu, 11 Jul 2019 10:46:15 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] dt-bindings: imx-ocotp: Add i.MX8MN compatible
Date:   Thu, 11 Jul 2019 10:37:13 +0800
Message-Id: <20190711023714.16000-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add compatible for i.MX8MN and add i.MX8MM/i.MX8MN to the description.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 96ffd06..904dadf 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -2,7 +2,7 @@ Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
 i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-i.MX7D/S, i.MX7ULP and i.MX8MQ SoCs.
+i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM and i.MX8MN SoCs.
 
 Required properties:
 - compatible: should be one of
@@ -16,6 +16,7 @@ Required properties:
 	"fsl,imx7ulp-ocotp" (i.MX7ULP),
 	"fsl,imx8mq-ocotp" (i.MX8MQ),
 	"fsl,imx8mm-ocotp" (i.MX8MM),
+	"fsl,imx8mn-ocotp" (i.MX8MN),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.7.4

