Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036A1C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D923A20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgAHPog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:44:36 -0500
Received: from lists.gateworks.com ([108.161.130.12]:49053 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgAHPoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:44:34 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1ipDVY-0007s2-Ll; Wed, 08 Jan 2020 15:44:32 +0000
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
Subject: [PATCH v7 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana i.MX6DL/Q compatibles
Date:   Wed,  8 Jan 2020 07:44:20 -0800
Message-Id: <20200108154424.15736-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20200108154424.15736-1-rjones@gateworks.com>
References: <20200108154424.15736-1-rjones@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible enum entries for Gateworks Ventana boards.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f79683a..aa51f45 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -128,6 +128,27 @@ properties:
               - variscite,dt6customboard
           - const: fsl,imx6q
 
+      - description: i.MX6Q Gateworks Ventana Boards
+        items:
+          - enum:
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
+          - const: fsl,imx6q
+
       - description: i.MX6QP based Boards
         items:
           - enum:
@@ -154,6 +175,26 @@ properties:
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
           - const: fsl,imx6dl
 
+      - description: i.MX6DL Gateworks Ventana Boards
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
+          - const: gw,ventana
+          - const: fsl,imx6dl
+
       - description: i.MX6SL based Boards
         items:
           - enum:
-- 
2.9.2

