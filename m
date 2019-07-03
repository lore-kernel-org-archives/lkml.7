Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A41C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6187521880
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfGCGx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 02:53:29 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:63191 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCGx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:53:28 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x636rBC5005738;
        Wed, 3 Jul 2019 14:53:13 +0800 (GMT-8)
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
Subject: [PATCH v5 2/2] dt-bindings: mtd: Document Macronix raw NAND controller bindings
Date:   Wed,  3 Jul 2019 15:15:44 +0800
Message-Id: <1562138144-2212-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562138144-2212-1-git-send-email-masonccyang@mxic.com.tw>
References: <1562138144-2212-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x636rBC5005738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Macronix raw NAND controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 Documentation/devicetree/bindings/mtd/mxic-nand.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
new file mode 100644
index 0000000..ddd7660
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
@@ -0,0 +1,20 @@
+Macronix Raw NAND Controller Device Tree Bindings
+-------------------------------------------------
+
+Required properties:
+- compatible: should be "macronix,nand-controller"
+- reg: should contain 1 entrie for the registers
+- interrupts: interrupt line connected to this raw NAND controller
+- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
+- clocks: should contain 3 phandles for the "ps_clk", "send_clk" and
+	 "send_dly_clk" clocks
+
+Example:
+
+	nand: mxic-nfc@43c30000 {
+		compatible = "macronix,nand-controller";
+		reg = <0x43c30000 0x10000>;
+		reg-names = "regs";
+		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
+		clock-names = "send_clk", "send_dly_clk", "ps_clk";
+	};
-- 
1.9.1

