Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB54C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F011B20848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgAGS6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:58:05 -0500
Received: from lists.gateworks.com ([108.161.130.12]:46795 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgAGS6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:58:04 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1iou3G-0006Mw-Fq; Tue, 07 Jan 2020 18:58:02 +0000
From:   Robert Jones <rjones@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH v6 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana i.MX6DL/Q compatibles
Date:   Tue,  7 Jan 2020 10:57:49 -0800
Message-Id: <20200107185753.28308-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20200107185753.28308-1-rjones@gateworks.com>
References: <20200107185753.28308-1-rjones@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible enum entries for Gateworks Ventana boards.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f79683a..9f73bef 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -154,6 +154,43 @@ properties:
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
           - const: fsl,imx6dl
 
+      - description: i.MX6DL or i.MX6Q Gateworks Ventana Boards
+        items:
+          - enum:
+              - gw,imx6dl-gw51xx
+              - gw,imx6dl-gw52xx
+              - gw,imx6dl-gw53xx
+              - gw,imx6dl-gw54xx
+              - gw,imx6dl-gw551x
+              - gw,imx6dl-gw552x
+              - gw,imx6dl-gw553x
+              - gw,imx6dl-gw560x
+              - gw,imx6dl-gw5903
+              - gw,imx6dl-gw5904
+              - gw,imx6dl-gw5907
+              - gw,imx6dl-gw5910
+              - gw,imx6dl-gw5912
+              - gw,imx6dl-gw5913
+              - gw,imx6q-gw51xx
+              - gw,imx6q-gw52xx
+              - gw,imx6q-gw53xx
+              - gw,imx6q-gw5400-a
+              - gw,imx6q-gw54xx
+              - gw,imx6q-gw551x
+              - gw,imx6q-gw552x
+              - gw,imx6q-gw553x
+              - gw,imx6q-gw560x
+              - gw,imx6q-gw5903
+              - gw,imx6q-gw5904
+              - gw,imx6q-gw5907
+              - gw,imx6q-gw5910
+              - gw,imx6q-gw5912
+              - gw,imx6q-gw5913
+          - const: gw,ventana
+          - enum:
+            - fsl,imx6dl
+            - fsl,imx6q
+
       - description: i.MX6SL based Boards
         items:
           - enum:
-- 
2.9.2

