Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D76CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC8D21655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437918AbfJXHP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:15:29 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:56770 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437885AbfJXHP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:15:27 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x9O7E52w080302;
        Thu, 24 Oct 2019 15:14:07 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        masonccyang@mxic.com.tw
Subject: [PATCH v4 2/2] dt-bindings: mtd: Document Macronix NAND device bindings
Date:   Thu, 24 Oct 2019 15:40:07 +0800
Message-Id: <1571902807-10388-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw>
References: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com x9O7E52w080302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Macronix NAND device.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/mtd/nand-macronix.txt        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-macronix.txt

diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.txt b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
new file mode 100644
index 0000000..cb60358
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
@@ -0,0 +1,20 @@
+Macronix NANDs Device Tree Bindings
+-----------------------------------
+
+Macronix NANDs support randomizer operation for user data scrambled,
+which can be enabled with a SET_FEATURE. The penalty of randomizer
+is subpage accesses prohibited. By adding a new specific property
+in children nodes to enable randomizer function.
+
+Required NAND chip properties in children mode:
+- randomizer enable: should be "mxic,enable-randomizer-otp"
+
+Example:
+
+	nand: nand-controller@unit-address {
+
+		nand@0 {
+			reg = <0>;
+			mxic,enable-randomizer-otp;
+		};
+	};
-- 
1.9.1

