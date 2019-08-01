Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16812C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AFB20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfHADbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:31:10 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:29265 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbfHADbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:31:09 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x713UuOW087114;
        Thu, 1 Aug 2019 11:30:58 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, marek.vasut@gmail.com,
        bbrezillon@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        juliensu@mxic.com.tw, paul.burton@mips.com, liang.yang@amlogic.com,
        lee.jones@linaro.org, masonccyang@mxic.com.tw,
        anders.roxell@linaro.org, christophe.kerello@st.com,
        paul@crapouillou.net, devicetree@vger.kernel.org
Subject: [PATCH v6 2/2] dt-bindings: mtd: Document Macronix raw NAND controller bindings
Date:   Thu,  1 Aug 2019 11:55:10 +0800
Message-Id: <1564631710-30276-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564631710-30276-1-git-send-email-masonccyang@mxic.com.tw>
References: <1564631710-30276-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com x713UuOW087114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Macronix raw NAND controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 Documentation/devicetree/bindings/mtd/mxic-nand.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
new file mode 100644
index 0000000..de37d60
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
@@ -0,0 +1,19 @@
+Macronix Raw NAND Controller Device Tree Bindings
+-------------------------------------------------
+
+Required properties:
+- compatible: should be "mxicy,multi-itfc-v009-nand-morph"
+- reg: should contain 1 entry for the registers
+- interrupts: interrupt line connected to this raw NAND controller
+- clock-names: should contain "ps", "send" and "send_dly"
+- clocks: should contain 3 phandles for the "ps", "send" and
+	 "send_dly" clocks
+
+Example:
+
+	nand: nand-controller@43c30000 {
+		compatible = "mxicy,multi-itfc-v009-nand-morph";
+		reg = <0x43c30000 0x10000>;
+		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
+		clock-names = "send", "send_dly", "ps";
+	};
-- 
1.9.1

