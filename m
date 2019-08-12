Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBEFC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494D020820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfHLKMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:12:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55986 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbfHLKMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:12:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 931BD1A02B0;
        Mon, 12 Aug 2019 12:12:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F5F21A011B;
        Mon, 12 Aug 2019 12:11:59 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F18CF402F0;
        Mon, 12 Aug 2019 18:11:52 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
Subject: [v1 2/3] dt/bindings: clk: Add DT bindings for LS1028A Display output interface
Date:   Mon, 12 Aug 2019 18:02:16 +0800
Message-Id: <20190812100216.34459-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings documentmation for the Clock of the LS1028A Display
output interface.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 .../devicetree/bindings/clock/fsl,plldig.txt  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,plldig.txt

diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.txt b/Documentation/devicetree/bindings/clock/fsl,plldig.txt
new file mode 100644
index 000000000000..29c5a6117809
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,plldig.txt
@@ -0,0 +1,26 @@
+NXP QorIQ Layerscape LS1028A Display output interface Clock
+===========================================================
+
+Required properties:
+    - compatible: shall contain "fsl,ls1028a-plldig"
+    - reg: Physical base address and size of the block registers
+    - #clock-cells: shall contain 1.
+    - clocks: a phandle + clock-specifier pairs, here should be
+    specify the reference clock of the system
+
+
+Example:
+
+/ {
+        ...
+
+        dpclk: clock-controller@f1f0000 {
+                compatible = "fsl,ls1028a-plldig";
+                reg = <0x0 0xf1f0000 0x0 0xffff>;
+                #clock-cells = <1>;
+                clocks = <&osc_27m>;
+        };
+
+        ...
+};
+
-- 
2.17.1

